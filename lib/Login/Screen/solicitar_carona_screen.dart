import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Model/carona_model.dart';
import '../Services/carona_provider.dart';
import '../Widget/bottom_navigation_bar.dart';
import 'chat_screen.dart';

class SolicitarCaronaScreen extends StatefulWidget {
  @override
  _SolicitarCaronaScreenState createState() => _SolicitarCaronaScreenState();
}

class _SolicitarCaronaScreenState extends State<SolicitarCaronaScreen> {
  int _selectedIndex = 0;
  int _expandedCardIndex = -1; // Controla o índice do card expandido

  List<Map<String, dynamic>> caronas = [
    {
      'origem': 'Shopping Aricanduva',
      'destino': 'Rua Tombu',
      'motorista': 'Maria',
      'horario': '10:00',
      'foto': 'images/profile1.jpg',
      'rating': 4.5,
      'imagemrota': 'images/imagemrota1.png',
    },
    {
      'origem': 'Rua Tombu',
      'destino': 'Rua Olga Silveira Campor',
      'motorista': 'João',
      'horario': '11:00',
      'foto': 'images/profile2.jpg',
      'rating': 4.8,
      'imagemrota': 'images/imagemrota2.png',
    },
    {
      'origem': 'Rua Tombu',
      'destino': 'Avenida Paulista',
      'motorista': 'Ana',
      'horario': '12:00',
      'foto': 'images/profile3.jpg',
      'rating': 4.2,
      'imagemrota': 'images/imagemrota3.png',
    },
    {
      'origem': 'Metro Itaquera',
      'destino': 'Shopping Aricanduva',
      'motorista': 'Paulo',
      'horario': '13:00',
      'foto': 'images/profile4.jpg',
      'rating': 4.9,
      'imagemrota': 'images/imagemrota4.png',
    },
    {
      'origem': 'Parque do Carmo',
      'destino': 'Metro Carrão',
      'motorista': 'Raquel',
      'horario': '14:00',
      'foto': 'images/profile5.jpg',
      'rating': 4.3,
      'imagemrota': 'images/imagemrota5.png',
    },
    {
      'origem': 'Metro Tatuapé',
      'destino': 'Shopping Aricanduva',
      'motorista': 'Ana',
      'horario': '15:00',
      'foto': 'images/profile1.jpg',
      'rating': 4.7,
      'imagemrota': 'images/imagemrota6.png',
    }
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Função para expandir e mostrar detalhes do card
  void _expandCard(int index) {
    setState(() {
      _expandedCardIndex = _expandedCardIndex == index ? -1 : index;
    });
  }

  void _reservarCarona(BuildContext context, int index) {
    final caronaData = caronas[index];
    final motoristaNome = caronaData['motorista'] ??
        'Nome não disponível'; // Fornece um valor padrão

    final carona = Carona(
      departureLocation: caronaData['origem'],
      destinationLocation: caronaData['destino'],
      dateTime: DateTime.parse('2024-09-19 ${caronaData['horario']}'),
      motoristaNome: motoristaNome,
      profileImageUrl: caronaData['foto'], // Passa o nome do motorista
    );

    // Adiciona a carona à lista de reservadas
    Provider.of<CaronaProvider>(context, listen: false).reserveCarona(carona);

    // Exibe uma confirmação de reserva
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Carona reservada com sucesso!')),
    );
  }

  void _entrarEmContato(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ChatScreen(motorista: caronas[index]['motorista']),
      ),
    );
  }

  Widget _buildRatingStars(double rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.yellow,
          size: 18,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Solicitar Carona'),
        backgroundColor: const Color(0xFF3cc4ef),
      ),
      body: ListView.builder(
        itemCount: caronas.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(caronas[index]['foto']),
                    radius: 30,
                  ),
                  title: Text(
                      '${caronas[index]['origem']} ➡️ ${caronas[index]['destino']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Motorista: ${caronas[index]['motorista']}'),
                      SizedBox(height: 5),
                      _buildRatingStars(caronas[index]['rating']),
                      Text('Horário: ${caronas[index]['horario']}'),
                    ],
                  ),
                  onTap: () => _expandCard(index),
                ),
                if (_expandedCardIndex == index)
                  Column(
                    children: [
                      Container(
                        height: 200,
                        child: Image.asset(
                          caronas[index]['imagemrota'],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () => _reservarCarona(context, index),
                              child: Text(
                                'Reservar',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF3cc4ef),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () => _entrarEmContato(index),
                              child: Text(
                                'Entrar em contato',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF3cc4ef),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: const Color(0xFF3cc4ef),
        ),
        child: MyBottomNavigationBar(
          currentIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }
}
