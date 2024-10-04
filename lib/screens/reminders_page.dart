import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import 'package:intl/intl.dart';

class RemindersPage extends StatefulWidget {
  const RemindersPage({super.key});

  @override
  State<RemindersPage> createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  List<Map<String, dynamic>> _recordatorios = [];

  @override
  void initState() {
    super.initState();
    _loadRecordatorios();
  }

  void _loadRecordatorios() async {
    final recordatorios = await DatabaseHelper.instance.getRecordatorios();
    setState(() {
      _recordatorios = recordatorios;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recordatorios'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: _recordatorios.length,
        itemBuilder: (context, index) {
          final recordatorio = _recordatorios[index];
          final eventDateTime = DateTime.parse('${recordatorio['fecha']} ${recordatorio['hora']}');
          final timeUntil = eventDateTime.difference(DateTime.now());

          return _buildReminderCard(
            recordatorio['titulo'],
            '${recordatorio['fecha']} ${recordatorio['hora']}',
            Icons.event,
            Colors.deepPurple,
            timeUntil,
            recordatorio['descripcion'],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aquí podrías navegar a la página de calendario para agregar un nuevo recordatorio
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildReminderCard(
      String title, String time, IconData icon, Color color, Duration timeUntil, String description) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(time),
            Text(description),
          ],
        ),
        trailing: Text(
          _formatTimeUntil(timeUntil),
          style: TextStyle(
            color: timeUntil.isNegative ? Colors.red : Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
}
