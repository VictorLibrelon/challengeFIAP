import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Widget/bottom_navigation_bar.dart';
import '../Model/carona_model.dart';
import '../Widget/caona_card.dart';
import '../Services/carona_provider.dart';
import '../Widget/carona_reservada.dart';
import '../Widget/edit_carona_form.dart';

class ReservasScreen extends StatefulWidget {
  @override
  _ReservasScreenState createState() => _ReservasScreenState();
}

class _ReservasScreenState extends State<ReservasScreen> {
  int _selectedIndex = 1;
  final int initialStaticRidesCount = 5;

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
      appBar: AppBar(
        title: const Text('Reservas'),
        backgroundColor: const Color(0xFF3cc4ef),
      ),
      body: Consumer<CaronaProvider>(
        builder: (context, caronaProvider, child) {
          int totalRides =
              initialStaticRidesCount + caronaProvider.offeredRides.length;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Quantidade de Caronas Oferecidas: $totalRides',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                // Caronas Estáticas
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
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: Column(
                    children: [
                      CaronaReservada(
                        imageUrl: 'images/profile5.jpg',
                        userName: 'Jessica Ramos',
                        rating: 4.2,
                        departurePoint: 'Penha',
                        departureTime: '16:00h',
                        destination: 'Aeroposto Guarulhos',
                      ),
                    ],
                  ),
                ),
                // Caronas Dinâmicas Oferecidas pelo Usuário
                caronaProvider.offeredRides.isEmpty
                    ? Center(
                        child: Text(
                          'Nenhuma Carona Oferecida',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: caronaProvider.offeredRides.length,
                        itemBuilder: (context, index) {
                          Carona carona = caronaProvider.offeredRides[index];
                          return CaronaOferecida(
                            imageUrl: 'images/profile.jpg',
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
                        },
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
