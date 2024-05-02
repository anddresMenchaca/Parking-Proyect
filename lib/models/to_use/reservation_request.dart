class Reserva {
  String id;
  DateTime date;
  DateTime dateArrive;
  DateTime dateOut;
  String model;
  String plate;
  String status;
  double total;
  String typeVehicle;

  Reserva({
    required this.id,
    required this.date,
    required this.dateArrive,
    required this.dateOut,
    required this.model,
    required this.plate,
    required this.status,
    required this.total,
    required this.typeVehicle,
  });
}