import 'package:flutter/material.dart';
import '../Model/carona_model.dart'; // Atualize para o arquivo onde Carona está definido

class CaronaProvider with ChangeNotifier {
  List<Carona> _offeredRides = [];

  List<Carona> get offeredRides => _offeredRides;

  void addCarona(Carona carona) {
    _offeredRides.add(carona);
    notifyListeners(); // Notifica os ouvintes sobre a mudança
  }

  void updateCarona(int index, Carona carona) {
    _offeredRides[index] = carona;
    notifyListeners();
  }

  void removeCarona(int index) {
    _offeredRides.removeAt(index);
    notifyListeners();
  }
}
