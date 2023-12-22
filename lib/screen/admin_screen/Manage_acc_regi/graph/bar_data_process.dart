// ignore_for_file: constant_identifier_names

import 'package:admin_app_xem_tro/models/bar.dart';
import 'package:admin_app_xem_tro/models/users.dart';

enum DayOfWeek {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday,
}

enum Month {
  January,
  February,
  March,
  April,
  May,
  June,
  July,
  August,
  September,
  October,
  November,
  December,
}

class BarChartDataProcessor {
  static BarDataWeek calculateBarDataWeek(
      List<User> weeklyUserRegistrations, int user, int landlord) {
    return BarDataWeek(
      monUserAmount: calculateTotalUserCountForDay(
          weeklyUserRegistrations, DayOfWeek.Monday, user),
      monLandlordAmount: calculateTotalLandlordCountForDay(
          weeklyUserRegistrations, DayOfWeek.Monday, landlord),
      tueUserAmount: calculateTotalUserCountForDay(
          weeklyUserRegistrations, DayOfWeek.Tuesday, user),
      tueLandlordAmount: calculateTotalLandlordCountForDay(
          weeklyUserRegistrations, DayOfWeek.Tuesday, landlord),
      wedUserAmount: calculateTotalUserCountForDay(
          weeklyUserRegistrations, DayOfWeek.Wednesday, user),
      wedLandlordAmount: calculateTotalLandlordCountForDay(
          weeklyUserRegistrations, DayOfWeek.Wednesday, landlord),
      thurUserAmount: calculateTotalUserCountForDay(
          weeklyUserRegistrations, DayOfWeek.Thursday, user),
      thurLandlordAmount: calculateTotalLandlordCountForDay(
          weeklyUserRegistrations, DayOfWeek.Thursday, landlord),
      friUserAmount: calculateTotalUserCountForDay(
          weeklyUserRegistrations, DayOfWeek.Friday, user),
      friLandlordAmount: calculateTotalLandlordCountForDay(
          weeklyUserRegistrations, DayOfWeek.Friday, landlord),
      satUserAmount: calculateTotalUserCountForDay(
          weeklyUserRegistrations, DayOfWeek.Saturday, user),
      satLandlordAmount: calculateTotalLandlordCountForDay(
          weeklyUserRegistrations, DayOfWeek.Saturday, landlord),
      sunUserAmount: calculateTotalUserCountForDay(
          weeklyUserRegistrations, DayOfWeek.Sunday, user),
      sunLandlordAmount: calculateTotalLandlordCountForDay(
          weeklyUserRegistrations, DayOfWeek.Sunday, landlord),
    );
  }

  static BarDataMonth calculateBarDataMonth(
      List<User> monthlyUserRegistrations, int user, int landlord) {
    return BarDataMonth(
      janUserAmount: calculateTotalUserCountForMonth(
        monthlyUserRegistrations,
        Month.January,
        user,
      ),
      janLandlordAmount: calculateTotalLandlordCountForMonth(
        monthlyUserRegistrations,
        Month.January,
        landlord,
      ),
      febUserAmount: calculateTotalUserCountForMonth(
        monthlyUserRegistrations,
        Month.February,
        user,
      ),
      febLandlordAmount: calculateTotalLandlordCountForMonth(
        monthlyUserRegistrations,
        Month.February,
        landlord,
      ),
      marUserAmount: calculateTotalUserCountForMonth(
        monthlyUserRegistrations,
        Month.March,
        user,
      ),
      marLandlordAmount: calculateTotalLandlordCountForMonth(
        monthlyUserRegistrations,
        Month.March,
        landlord,
      ),
      aprUserAmount: calculateTotalUserCountForMonth(
        monthlyUserRegistrations,
        Month.April,
        user,
      ),
      aprLandlordAmount: calculateTotalLandlordCountForMonth(
        monthlyUserRegistrations,
        Month.April,
        landlord,
      ),
      mayUserAmount: calculateTotalUserCountForMonth(
        monthlyUserRegistrations,
        Month.May,
        user,
      ),
      mayLandlordAmount: calculateTotalLandlordCountForMonth(
        monthlyUserRegistrations,
        Month.May,
        landlord,
      ),
      junUserAmount: calculateTotalUserCountForMonth(
        monthlyUserRegistrations,
        Month.June,
        user,
      ),
      junLandlordAmount: calculateTotalLandlordCountForMonth(
        monthlyUserRegistrations,
        Month.June,
        landlord,
      ),
      julUserAmount: calculateTotalUserCountForMonth(
        monthlyUserRegistrations,
        Month.July,
        user,
      ),
      julLandlordAmount: calculateTotalLandlordCountForMonth(
        monthlyUserRegistrations,
        Month.July,
        landlord,
      ),
      augUserAmount: calculateTotalUserCountForMonth(
        monthlyUserRegistrations,
        Month.August,
        user,
      ),
      augLandlordAmount: calculateTotalLandlordCountForMonth(
        monthlyUserRegistrations,
        Month.August,
        landlord,
      ),
      sepUserAmount: calculateTotalUserCountForMonth(
        monthlyUserRegistrations,
        Month.September,
        user,
      ),
      sepLandlordAmount: calculateTotalLandlordCountForMonth(
        monthlyUserRegistrations,
        Month.September,
        landlord,
      ),
      octUserAmount: calculateTotalUserCountForMonth(
        monthlyUserRegistrations,
        Month.October,
        user,
      ),
      octLandlordAmount: calculateTotalLandlordCountForMonth(
        monthlyUserRegistrations,
        Month.October,
        landlord,
      ),
      novUserAmount: calculateTotalUserCountForMonth(
        monthlyUserRegistrations,
        Month.November,
        user,
      ),
      novLandlordAmount: calculateTotalLandlordCountForMonth(
        monthlyUserRegistrations,
        Month.November,
        landlord,
      ),
      decUserAmount: calculateTotalUserCountForMonth(
        monthlyUserRegistrations,
        Month.December,
        user,
      ),
      decLandlordAmount: calculateTotalLandlordCountForMonth(
        monthlyUserRegistrations,
        Month.December,
        landlord,
      ),
    );
  }

  static double calculateTotalUserCountForDay(
      List<User> users, DayOfWeek day, int userRole) {
    return users
        .where((user) =>
            user.createAt.weekday == day.index + 1 && user.role == userRole)
        .length
        .toDouble();
  }

  static double calculateTotalLandlordCountForDay(
      List<User> users, DayOfWeek day, int landlordRole) {
    return users
        .where((user) =>
            user.createAt.weekday == day.index + 1 && user.role == landlordRole)
        .length
        .toDouble();
  }

  static double calculateTotalUserCountForMonth(
      List<User> users, Month month, int userRole) {
    return users
        .where((user) =>
            user.createAt.month == month.index + 1 && user.role == userRole)
        .length
        .toDouble();
  }

  static double calculateTotalLandlordCountForMonth(
      List<User> users, Month month, int landlordRole) {
    return users
        .where((user) =>
            user.createAt.month == month.index + 1 && user.role == landlordRole)
        .length
        .toDouble();
  }
}
