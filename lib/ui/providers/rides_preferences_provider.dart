import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';
import 'package:week_3_blabla_project/repository/ride_preferences_repository.dart';

class RidesPreferencesProvider extends ChangeNotifier {
  RidePreference? _currentPreference;
  List<RidePreference> _pastPreferences = [];
  final RidePreferencesRepository repository;

  RidesPreferencesProvider({required this.repository}) {
    _pastPreferences = repository.getPastPreferences();
  }

  RidePreference? get currentPreference => _currentPreference;

  List<RidePreference> get pastPreferences => _pastPreferences.reversed.toList(); // Ensure this getter exists

  void setCurrentPreference(RidePreference pref) {
    if (_currentPreference == pref) return;

    _currentPreference = pref;
    _addPreference(pref);
    notifyListeners();
  }

  void addPastPreference(RidePreference preference) {
    _pastPreferences.remove(preference);
    _pastPreferences.insert(0, preference);
    notifyListeners();
  }

  void _addPreference(RidePreference preference) {
    _pastPreferences.remove(preference);
    _pastPreferences.insert(0, preference);
  }
}