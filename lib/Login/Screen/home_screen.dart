import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Model/carona_model.dart';
import '../Services/carona_provider.dart';
import '../Widget/bottom_navigation_bar.dart';
import '../Widget/caona_card.dart';
import '../Widget/carona_reservada.dart';
import '../Widget/edit_carona_form.dart';
import '../Widget/image_carousel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> imgList = [
    'images/img1.png',
    'images/img2.png',
    'images/img3.png',
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _editCarona(BuildContext context, Carona carona, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditCaronaForm(
          carona: carona,
          onEdit: (Carona editedCarona) {
            Provider.of<CaronaProvider>(context, listen: false)
                .updateCarona(index, editedCarona);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem de Perfil
            Container(
              color: Color(0xFF3cc4ef), // Cor de fundo azul
              padding: EdgeInsets.only(top: 80.0, bottom: 20.0),
              child: Center(
                child: CircleAvatar(
                  radius: 80.0,
                  backgroundImage: AssetImage('images/profile.png'),
                ),
              ),
            ),

            // Carrossel de Imagens
            ImageCarousel(imgList: imgList),

            // Sessão de Caronas Oferecidas
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Caronas Oferecidas',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Consumer<CaronaProvider>(
                builder: (context, caronaProvider, child) {
                  if (caronaProvider.offeredRides.isEmpty) {
                    // Exibe a mensagem se não houver caronas oferecidas
                    return Center(
                      child: Text(
                        'Nenhuma Carona Oferecida',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  } else {
                    // Exibe as caronas oferecidas
                    return Column(
                      children: caronaProvider.offeredRides.map((carona) {
                        int index = caronaProvider.offeredRides.indexOf(carona);
                        return CaronaOferecida(
                          imageUrl: 'images/profile.png',
                          userName: 'Victor Librelon',
                          rating: 4.5,
                          departurePoint: carona.departureLocation,
                          departureTime:
                              '${carona.dateTime.hour}:${carona.dateTime.minute.toString().padLeft(2, '0')}',
                          destination: carona.destinationLocation,
                          onEdit: () {
                            _editCarona(context, carona, index);
                          },
                          onDelete: () {
                            caronaProvider.removeCarona(index);
                          },
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ),

            // Sessão de Caronas Reservadas
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Caronas Reservadas',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Column(
                children: [
                  CaronaReservada(
                    imageUrl: 'images/profile1.jpg',
                    userName: 'Rafaely Hara',
                    rating: 4.2,
                    departurePoint: 'Estação',
                    departureTime: '16:00h',
                    destination: 'Centro',
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Column(
                children: [
                  CaronaReservada(
                    imageUrl: 'images/profile2.jpg',
                    userName: 'David Mariano',
                    rating: 4.2,
                    departurePoint: 'Rua Tombu',
                    departureTime: '16:00h',
                    destination: 'Shopping',
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Column(
                children: [
                  CaronaReservada(
                    imageUrl: 'images/profile3.jpg',
                    userName: 'Tania Hara',
                    rating: 4.2,
                    departurePoint: 'Metro Itaquera',
                    departureTime: '16:00h',
                    destination: 'Fiap Lins de Vasconcelo',
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Column(
                children: [
                  CaronaReservada(
                    imageUrl: 'images/profile4.jpg',
                    userName: 'Lucas Avila',
                    rating: 4.2,
                    departurePoint: 'Avanade',
                    departureTime: '16:00h',
                    destination: 'Tatuapé',
                  ),
                ],
              ),
            ),

            // Sessão de Pontos com Ícone de Presente
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.card_giftcard, size: 50, color: Colors.blue),
                    Text(
                      'Você tem 200 pontos!',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
