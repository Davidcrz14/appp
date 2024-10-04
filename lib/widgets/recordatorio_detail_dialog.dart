import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class RecordatorioDetailDialog extends StatelessWidget {
  final Map<String, dynamic> recordatorio;
  final Function onDelete;

  const RecordatorioDetailDialog({
    super.key,
    required this.recordatorio,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(recordatorio['titulo']),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Fecha: ${recordatorio['fecha']}'),
          Text('Hora: ${recordatorio['hora']}'),
          Text('Descripción: ${recordatorio['descripcion']}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cerrar'),
        ),
        TextButton(
          onPressed: () async {
            await DatabaseHelper.instance.deleteRecordatorio(recordatorio['id']);
            onDelete();
            Navigator.of(context).pop();
          },
          child: const Text('Borrar', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
