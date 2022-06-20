import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';



class NoiseTest {
  late int carNumber;
  late String driverName;
  late String coDriverName;
  late String carMake;
  late String carModel;
  late String rallyCategory;
  late double soundTest1;
  late double soundTest1compliance;
  late double soundTest2;
  late double soundTest2compliance;
  late double soundTest3;
  late double soundTest3compliance;
  late String submittedBy;
  late Timestamp timestamp;

  NoiseTest.fromMap(Map<String, dynamic> map) {
    carNumber = map['Car Number'];
    driverName = map['Driver Name'];
    coDriverName = map['Co-Driver Name'];
    carMake = map['Car Make'];
    carModel = map['Car Model'];
    rallyCategory = map['Rally Category'];
    soundTest1 = map['Sound Test 1 (0.5m)'];
    soundTest1compliance = map['Sound Test 1 Compliance'];
    soundTest2 = map['Sound Test 2 (2m)'];
    soundTest2compliance = map['Sound Test 2 Compliance'];
    soundTest3 = map['Sound Test 3 (5m)'];
    soundTest3compliance = map['Sound Test 3 Compliance'];
    submittedBy = map['submitted by'];
    timestamp = map['timestamp'];
  }
}