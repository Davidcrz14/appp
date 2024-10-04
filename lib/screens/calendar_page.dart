import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../database/database_helper.dart';
import '../widgets/recordatorio_detail_dialog.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<Map<String, dynamic>> _selectedEvents = [];
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _loadEvents();
  }

  void _loadEvents() async {
    if (_selectedDay != null) {
      final events = await DatabaseHelper.instance.getRecordatoriosPorFecha(
        DateFormat('yyyy-MM-dd').format(_selectedDay!),
      );
      setState(() {
        _selectedEvents = events;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2021, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              _loadEvents();
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              selectedDecoration: const BoxDecoration(
                color: Colors.deepPurple,
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: _selectedEvents.isEmpty
                ? const Center(child: Text('No hay eventos para este día'))
                : ListView.builder(
                    itemCount: _selectedEvents.length,
                    itemBuilder: (context, index) {
                      final event = _selectedEvents[index];
                      final eventDateTime =
                          DateTime.parse('${event['fecha']} ${event['hora']}');
                      final timeUntil =
                          eventDateTime.difference(DateTime.now());
                      return ListTile(
                        title: Text(event['titulo']),
                        subtitle:
                            Text('${event['hora']} - ${event['descripcion']}'),
                        trailing: Text(_formatTimeUntil(timeUntil)),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => RecordatorioDetailDialog(
                              recordatorio: event,
                              onDelete: () {
                                _loadEvents();
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: FloatingActionButton(
          onPressed: _showAddEventDialog,
          backgroundColor: Colors.deepPurple,
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  String _formatTimeUntil(Duration duration) {
    if (duration.isNegative) {
      return 'Pasado';
    } else if (duration.inDays > 0) {
      return 'En ${duration.inDays} días';
    } else if (duration.inHours > 0) {
      return 'En ${duration.inHours} horas';
    } else if (duration.inMinutes > 0) {
      return 'En ${duration.inMinutes} minutos';
    } else {
      return 'Ahora';
    }
  }

  void _showAddEventDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Agregar Recordatorio'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Título'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final TimeOfDay? time = await showTimePicker(
                    context: context,
                    initialTime: _selectedTime,
                    builder: (BuildContext context, Widget? child) {
                      return MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(alwaysUse24HourFormat: true),
                        child: child!,
                      );
                    },
                  );
                  if (time != null) {
                    setState(() {
                      _selectedTime = time;
                    });
                  }
                },
                child: Text(_selectedTime.format(context)),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              final newEvent = {
                'titulo': titleController.text,
                'descripcion': descriptionController.text,
                'fecha': DateFormat('yyyy-MM-dd').format(_selectedDay!),
                'hora':
                    '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}',
              };
              await DatabaseHelper.instance.insertRecordatorio(newEvent);
              Navigator.pop(context);
              _loadEvents();
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}
