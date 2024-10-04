import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias Contables'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildNewsCard(
            context,
            'Gobierno Nacional expidió el Decreto 938 de 2021',
            'El Gobierno Nacional modificó el marco técnico de las Normas de Información Financiera para el Grupo 1, alineándose con las actualizaciones internacionales del IASB. Este decreto incluye cambios en la clasificación de pasivos y la reforma de la tasa de interés de referencia.',
            Icons.policy,
            Colors.blue,
          ),
          _buildNewsCard(
            context,
            'Nuevo reglamento de retención en la fuente y el impuesto de renta',
            'El Decreto 2231 de 2023 introduce cambios en la declaración del impuesto sobre la renta y la retención en la fuente para personas naturales. Se destacan las nuevas deducciones por dependientes económicos y los aportes voluntarios a pensiones.',
            Icons.description,
            Colors.green,
          ),
          _buildNewsCard(
            context,
            'Actualización del Anexo Técnico de Información Financiera',
            'Mediante el Decreto 938 de 2021, se incorporaron mejoras anuales a las Normas NIIF 2018–2020 y la Reforma de la Tasa de Interés de Referencia-Fase 2, afectando el Grupo 1 del Decreto Único Reglamentario 2420 de 2015.',
            Icons.update,
            Colors.orange,
          ),
          _buildNewsCard(
            context,
            'Nuevas reglas para la retención en la fuente sobre rentas de trabajo',
            'A partir del 22 de diciembre de 2023, la retención en la fuente sobre rentas de trabajo se rige por nuevas reglas establecidas en el Decreto 2231 de 2023, buscando simplificar el proceso y hacerlo más equitativo para los trabajadores independientes.',
            Icons.work,
            Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildNewsCard(BuildContext context, String title, String content,
      IconData icon, Color color) {
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
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  _showFullNews(context, title, content);
                },
                child: const Text('Leer más'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFullNews(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Text(content),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
