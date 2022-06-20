
import 'dart:collection';

import 'package:flutter/material.dart';

import '../models/noise_test_model.dart';


class NoiseTestNotifier extends ChangeNotifier {
  late List<NoiseTest> _noiseTests = [];
  late NoiseTest _currentnoiseTest;

  UnmodifiableListView<NoiseTest> get noiseTests =>
      UnmodifiableListView(_noiseTests);

  NoiseTest get currentnoiseTest => _currentnoiseTest;

  set noiseTests(List<NoiseTest> value) {
    _noiseTests = value;
    notifyListeners();
  }

  set currentnoiseTest(NoiseTest value) {
    _currentnoiseTest = value;
    notifyListeners();
  }




}
