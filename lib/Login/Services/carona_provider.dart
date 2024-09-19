import 'package:flutter/material.dart';
import '../Model/carona_model.dart'; // Atualize para o arquivo onde Carona está definido

class CaronaProvider with ChangeNotifier {
  List<Carona> _offeredRides = [];
  List<Carona> _reservedRides = []; // Nova lista para caronas reservadas

  // Getter para caronas oferecidas
  List<Carona> get offeredRides => _offeredRides;

  // Getter para caronas reservadas
  List<Carona> get reservedRides => _reservedRides;

  // Adicionar carona oferecida
  void addCarona(Carona carona) {
    _offeredRides.add(carona);
    notifyListeners(); // Notifica os ouvintes sobre a mudança
  }

  // Atualizar carona oferecida
  void updateCarona(int index, Carona carona) {
    _offeredRides[index] = carona;
    notifyListeners();
  }

  // Remover carona oferecida
  void removeCarona(int index) {
    _offeredRides.removeAt(index);
    notifyListeners();
  }

  // Adicionar carona reservada
  void reserveCarona(Carona carona) {
    _reservedRides.add(carona);
    notifyListeners(); // Notifica os ouvintes sobre a mudança
  }

  // Cancelar reserva de carona
  void cancelReservedCarona(int index) {
    _reservedRides.removeAt(index);
    notifyListeners();
  }
}
