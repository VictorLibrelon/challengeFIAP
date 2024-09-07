import 'package:flutter/material.dart';
import '../Model/carona_model.dart'; // Atualize para o arquivo onde Carona está definido

class CaronaCard extends StatelessWidget {
  final Carona carona;
  final void Function() onEdit;
  final void Function() onDelete;

  const CaronaCard({
    Key? key,
    required this.carona,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 5, // Adiciona sombra para destacar o card
      child: ListTile(
        contentPadding: EdgeInsets.all(12.0), // Adiciona preenchimento ao redor do conteúdo
        leading: CircleAvatar(
          backgroundImage: AssetImage('images/profile.png'), // Substitua com a imagem do usuário
        ),
        title: Text(
          'Carona para ${carona.destinationLocation}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4), // Espaço entre o título e o subtítulo
            Text(
                'Saída: ${carona.dateTime.hour}:${carona.dateTime.minute.toString().padLeft(2, '0')}'),
            Text(
                'Data: ${carona.dateTime.day}/${carona.dateTime.month}/${carona.dateTime.year}'),
            SizedBox(height: 8), // Espaço entre os detalhes e a avaliação
            Row(
              children: [
                Icon(Icons.star, color: Colors.yellow, size: 20),
                Icon(Icons.star, color: Colors.yellow, size: 20),
                Icon(Icons.star, color: Colors.yellow, size: 20),
                Icon(Icons.star, color: Colors.yellow, size: 20),
                Icon(Icons.star_border, size: 20),
              ],
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
