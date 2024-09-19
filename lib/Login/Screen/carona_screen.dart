import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Services/carona_provider.dart' as carona_provider;
import '../Widget/bottom_navigation_bar.dart';
import '../Widget/caona_card.dart';
import '../Widget/edit_carona_form.dart';
import '../Model/carona_model.dart';
import '../Widget/offer_ride_form.dart';

class CaronaScreen extends StatefulWidget {
  @override
  _CaronaScreenState createState() => _CaronaScreenState();
}

class _CaronaScreenState extends State<CaronaScreen> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addOfferedRide(
    String departureLocation,
    String destinationLocation,
    DateTime dateTime,
  ) {
    final caronaProvider =
        Provider.of<carona_provider.CaronaProvider>(context, listen: false);
    caronaProvider.addCarona(Carona(
      departureLocation: departureLocation,
      destinationLocation: destinationLocation,
      dateTime: dateTime,
      motoristaNome: 'Victor Librelon',
      profileImageUrl: 'images/profile.png',
    ));
  }

  void _editCarona(BuildContext context, Carona carona, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditCaronaForm(
          carona: carona,
          onEdit: (Carona editedCarona) {
            Provider.of<carona_provider.CaronaProvider>(context, listen: false)
                .updateCarona(index, editedCarona);
          },
        );
      },
    );
  }

  void _showOfferRideDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Oferecer uma Carona'),
          content: OfferRideForm(onOffer: _addOfferedRide),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carona'),
        backgroundColor: Color(0xFF3cc4ef),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showOfferRideDialog,
          ),
        ],
      ),
      body: Consumer<carona_provider.CaronaProvider>(
        builder: (context, caronaProvider, child) {
          return caronaProvider.offeredRides.isEmpty
              ? Center(
                  child: Text(
                    'Nenhuma Carona Oferecida',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
              : ListView(
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
