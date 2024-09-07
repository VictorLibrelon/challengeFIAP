import 'package:flutter/material.dart';

class CaronaOferecida extends StatelessWidget {
  final String imageUrl;
  final String userName;
  final double rating;
  final String departurePoint;
  final String departureTime;
  final String destination;
  final VoidCallback onEdit;   // Callback para o botão de editar
  final VoidCallback onDelete; // Callback para o botão de excluir

  const CaronaOferecida({
    Key? key,
    required this.imageUrl,
    required this.userName,
    required this.rating,
    required this.departurePoint,
    required this.departureTime,
    required this.destination,
    required this.onEdit,   // Inicializa o callback de editar
    required this.onDelete, // Inicializa o callback de excluir
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(imageUrl),
        ),
        title: Text(userName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRatingStars(rating),
            SizedBox(height: 4.0),
            Text('Ponto de saída: $departurePoint'),
            Text('Hora: $departureTime'),
            Text('Destino: $destination'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: onEdit,  // Chama a função de editar
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: onDelete,  // Chama a função de excluir
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingStars(double rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating.ceil() ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 16.0,
        );
      }),
    );
  }
}
