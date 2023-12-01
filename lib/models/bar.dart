import 'package:admin_app_xem_tro/screen/admin_screen/Manage_acc_regi/graph/individual_bart.dart';

class BarDataWeek {
  late double sunAmount;
  late double monAmount;
  late double tueAmount;
  late double wedAmount;
  late double thurAmount;
  late double friAmount;
  late double satAmount;

  BarDataWeek({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount,
  });
  BarDataWeek.empty()
      : sunAmount = 0,
        monAmount = 0,
        tueAmount = 0,
        wedAmount = 0,
        thurAmount = 0,
        friAmount = 0,
        satAmount = 0;

  List<IndividualBar> barData = [];

  void initializeBarDataWeek() {
    barData = [
      IndividualBar(x: 0, y: sunAmount),
      IndividualBar(x: 1, y: monAmount),
      IndividualBar(x: 2, y: tueAmount),
      IndividualBar(x: 3, y: wedAmount),
      IndividualBar(x: 4, y: thurAmount),
      IndividualBar(x: 5, y: friAmount),
      IndividualBar(x: 6, y: satAmount),
    ];
  }
}

class BarDataMonth {
  late double janAmount;
  late double febAmount;
  late double marAmount;
  late double aprAmount;
  late double mayAmount;
  late double junAmount;
  late double julAmount;
  late double augAmount;
  late double sepAmount;
  late double octAmount;
  late double novAmount;
  late double decAmount;

  BarDataMonth({
    required this.janAmount,
    required this.febAmount,
    required this.marAmount,
    required this.aprAmount,
    required this.mayAmount,
    required this.junAmount,
    required this.julAmount,
    required this.augAmount,
    required this.sepAmount,
    required this.octAmount,
    required this.novAmount,
    required this.decAmount,
  });

  BarDataMonth.empty()
      : janAmount = 0,
        febAmount = 0,
        marAmount = 0,
        aprAmount = 0,
        mayAmount = 0,
        junAmount = 0,
        julAmount = 0,
        augAmount = 0,
        sepAmount = 0,
        octAmount = 0,
        novAmount = 0,
        decAmount = 0;

  List<IndividualBar> barData = [];
  void initializeBarDataMonth() {
    barData = [
      IndividualBar(x: 0, y: janAmount),
      IndividualBar(x: 1, y: febAmount),
      IndividualBar(x: 2, y: marAmount),
      IndividualBar(x: 3, y: aprAmount),
      IndividualBar(x: 4, y: mayAmount),
      IndividualBar(x: 5, y: junAmount),
      IndividualBar(x: 6, y: julAmount),
      IndividualBar(x: 7, y: augAmount),
      IndividualBar(x: 8, y: sepAmount),
      IndividualBar(x: 9, y: octAmount),
      IndividualBar(x: 10, y: novAmount),
      IndividualBar(x: 11, y: decAmount),
    ];
  }
}
