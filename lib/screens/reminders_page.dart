import 'package:flutter/material.dart';

class RemindersPage extends StatelessWidget {
  const RemindersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recordatorios'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildReminderCard(
            'JAHM te envió un mensaje',
            'Hace 5 minutos',
            Icons.message,
            Colors.blue,
          ),
          _buildReminderCard(
            'DavC tu patrón',
            'Hace 30 minutos',
            Icons.work,
            Colors.orange,
          ),
          _buildReminderCard(
            'Juan Zuñiga es una loli',
            'Hace 1 hora',
            Icons.child_care,
            Colors.pink,
          ),
          _buildReminderCard(
            'Diego es gay',
            'En 2 horas',
            Icons.color_lens,
            Colors.purple,
          ),
          _buildReminderCard(
            'JAHM y Juan se casaron',
            'Mañana',
            Icons.favorite,
            Colors.red,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aquí iría la lógica para agregar un nuevo recordatorio
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildReminderCard(
      String title, String time, IconData icon, Color color) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(time),
        trailing: PopupMenuButton<String>(
          onSelected: (String result) {
            // Aquí iría la lógica para manejar las opciones
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'edit',
              child: Text('Editar'),
            ),
            const PopupMenuItem<String>(
              value: 'delete',
              child: Text('Eliminar'),
            ),
          ],
        ),
      ),
    );
  }
}
