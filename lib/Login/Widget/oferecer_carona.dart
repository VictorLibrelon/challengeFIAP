import 'package:flutter/material.dart';

class OfferRideDialog extends StatefulWidget {
  final Function(String departureLocation, String destinationLocation, DateTime dateTime) onOffer;

  const OfferRideDialog({Key? key, required this.onOffer}) : super(key: key);

  @override
  _OfferRideDialogState createState() => _OfferRideDialogState();
}

class _OfferRideDialogState extends State<OfferRideDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _departureLocation;
  late String _destinationLocation;
  late TimeOfDay _time;
  late DateTime _date;

  @override
  void initState() {
    super.initState();
    _time = TimeOfDay.now();
    _date = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Oferecer uma Carona'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Local de Partida'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, informe o local de partida';
                }
                return null;
              },
              onChanged: (value) {
                _departureLocation = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Local de Destino'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, informe o local de destino';
                }
                return null;
              },
              onChanged: (value) {
                _destinationLocation = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Data'),
              keyboardType: TextInputType.datetime,
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: _date,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null && pickedDate != _date) {
                  setState(() {
                    _date = pickedDate;
                  });
                }
              },
              controller: TextEditingController(
                text: '${_date.day}/${_date.month}/${_date.year}',
              ),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Hora'),
              keyboardType: TextInputType.datetime,
              readOnly: true,
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: _time,
                );
                if (pickedTime != null && pickedTime != _time) {
                  setState(() {
                    _time = pickedTime;
                  });
                }
              },
              controller: TextEditingController(
                text: '${_time.format(context)}',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF3cc4ef), // Cor de fundo do botão
          ),
          child: Text('Oferecer'),
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              widget.onOffer(_departureLocation, _destinationLocation, DateTime(_date.year, _date.month, _date.day, _time.hour, _time.minute));
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
