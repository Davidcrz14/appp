import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias Contables'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildNewsCard(
            'Nuevas regulaciones fiscales para 2024',
            'El gobierno ha anunciado cambios importantes en la legislación fiscal que entrarán en vigor el próximo año...',
            Icons.policy,
            Colors.blue,
          ),
          _buildNewsCard(
            'Actualización de software contable',
            'La última versión de ContaSync incluye nuevas funcionalidades para facilitar el cierre fiscal...',
            Icons.update,
            Colors.green,
          ),
          _buildNewsCard(
            'Conferencia anual de contadores',
            'No te pierdas el evento más importante del año para profesionales de la contabilidad...',
            Icons.event,
            Colors.orange,
          ),
          _buildNewsCard(
            'Cambios en la declaración de IVA',
            'A partir del próximo trimestre, el formato de declaración de IVA sufrirá modificaciones...',
            Icons.description,
            Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildNewsCard(String title, String content, IconData icon, Color color) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: color,
                  child: Icon(icon, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              content,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Aquí iría la lógica para ver la noticia completa
                },
                child: const Text('Leer más'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
