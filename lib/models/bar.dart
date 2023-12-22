import 'package:admin_app_xem_tro/screen/admin_screen/Manage_acc_regi/graph/individual_bart.dart';

class BarDataWeek {
  late double monUserAmount;
  late double tueUserAmount;
  late double wedUserAmount;
  late double thurUserAmount;
  late double friUserAmount;
  late double satUserAmount;
  late double sunUserAmount;
  late double monLandlordAmount;
  late double tueLandlordAmount;
  late double wedLandlordAmount;
  late double thurLandlordAmount;
  late double friLandlordAmount;
  late double satLandlordAmount;
  late double sunLandlordAmount;

  BarDataWeek({
    required this.monUserAmount,
    required this.tueUserAmount,
    required this.wedUserAmount,
    required this.thurUserAmount,
    required this.friUserAmount,
    required this.satUserAmount,
    required this.sunUserAmount,
    required this.monLandlordAmount,
    required this.tueLandlordAmount,
    required this.wedLandlordAmount,
    required this.thurLandlordAmount,
    required this.friLandlordAmount,
    required this.satLandlordAmount,
    required this.sunLandlordAmount,
  });
  BarDataWeek.empty()
      : monUserAmount = 0,
        monLandlordAmount = 0,
        tueUserAmount = 0,
        tueLandlordAmount = 0,
        wedUserAmount = 0,
        wedLandlordAmount = 0,
        thurUserAmount = 0,
        thurLandlordAmount = 0,
        friUserAmount = 0,
        friLandlordAmount = 0,
        satUserAmount = 0,
        satLandlordAmount = 0,
        sunUserAmount = 0,
        sunLandlordAmount = 0;

  List<IndividualBar> barData = [];

  void initializeBarDataWeek() {
    barData = [
      IndividualBar(x: 0, yUsers: monUserAmount, yLandlords: monLandlordAmount),
      IndividualBar(x: 1, yUsers: tueUserAmount, yLandlords: tueLandlordAmount),
      IndividualBar(x: 2, yUsers: wedUserAmount, yLandlords: wedLandlordAmount),
      IndividualBar(
          x: 3, yUsers: thurUserAmount, yLandlords: thurLandlordAmount),
      IndividualBar(x: 4, yUsers: friUserAmount, yLandlords: friLandlordAmount),
      IndividualBar(x: 5, yUsers: satUserAmount, yLandlords: satLandlordAmount),
      IndividualBar(x: 6, yUsers: sunUserAmount, yLandlords: satLandlordAmount),
    ];
  }
}

class BarDataMonth {
  late double janUserAmount;
  late double janLandlordAmount;
  late double febUserAmount;
  late double febLandlordAmount;
  late double marUserAmount;
  late double marLandlordAmount;
  late double aprUserAmount;
  late double aprLandlordAmount;
  late double mayUserAmount;
  late double mayLandlordAmount;
  late double junUserAmount;
  late double junLandlordAmount;
  late double julUserAmount;
  late double julLandlordAmount;
  late double augUserAmount;
  late double augLandlordAmount;
  late double sepUserAmount;
  late double sepLandlordAmount;
  late double octUserAmount;
  late double octLandlordAmount;
  late double novUserAmount;
  late double novLandlordAmount;
  late double decUserAmount;
  late double decLandlordAmount;

  BarDataMonth({
    required this.janUserAmount,
    required this.janLandlordAmount,
    required this.febUserAmount,
    required this.febLandlordAmount,
    required this.marUserAmount,
    required this.marLandlordAmount,
    required this.aprUserAmount,
    required this.aprLandlordAmount,
    required this.mayUserAmount,
    required this.mayLandlordAmount,
    required this.junUserAmount,
    required this.junLandlordAmount,
    required this.julUserAmount,
    required this.julLandlordAmount,
    required this.augUserAmount,
    required this.augLandlordAmount,
    required this.sepUserAmount,
    required this.sepLandlordAmount,
    required this.octUserAmount,
    required this.octLandlordAmount,
    required this.novUserAmount,
    required this.novLandlordAmount,
    required this.decUserAmount,
    required this.decLandlordAmount,
  });

  BarDataMonth.empty()
      : janUserAmount = 0,
        janLandlordAmount = 0,
        febUserAmount = 0,
        febLandlordAmount = 0,
        marUserAmount = 0,
        marLandlordAmount = 0,
        aprUserAmount = 0,
        aprLandlordAmount = 0,
        mayUserAmount = 0,
        mayLandlordAmount = 0,
        junUserAmount = 0,
        junLandlordAmount = 0,
        julUserAmount = 0,
        julLandlordAmount = 0,
        augUserAmount = 0,
        augLandlordAmount = 0,
        sepUserAmount = 0,
        sepLandlordAmount = 0,
        octUserAmount = 0,
        octLandlordAmount = 0,
        novUserAmount = 0,
        novLandlordAmount = 0,
        decUserAmount = 0,
        decLandlordAmount = 0;

  List<IndividualBar> barData = [];

  void initializeBarDataMonth() {
    barData = [
      IndividualBar(x: 0, yUsers: janUserAmount, yLandlords: janLandlordAmount),
      IndividualBar(x: 1, yUsers: febUserAmount, yLandlords: febLandlordAmount),
      IndividualBar(x: 2, yUsers: marUserAmount, yLandlords: marLandlordAmount),
      IndividualBar(x: 3, yUsers: aprUserAmount, yLandlords: aprLandlordAmount),
      IndividualBar(x: 4, yUsers: mayUserAmount, yLandlords: mayLandlordAmount),
      IndividualBar(x: 5, yUsers: junUserAmount, yLandlords: junLandlordAmount),
      IndividualBar(x: 6, yUsers: julUserAmount, yLandlords: julLandlordAmount),
      IndividualBar(x: 7, yUsers: augUserAmount, yLandlords: augLandlordAmount),
      IndividualBar(x: 8, yUsers: sepUserAmount, yLandlords: sepLandlordAmount),
      IndividualBar(x: 9, yUsers: octUserAmount, yLandlords: octLandlordAmount),
      IndividualBar(
          x: 10, yUsers: novUserAmount, yLandlords: novLandlordAmount),
      IndividualBar(
          x: 11, yUsers: decUserAmount, yLandlords: decLandlordAmount),
    ];
  }
}
