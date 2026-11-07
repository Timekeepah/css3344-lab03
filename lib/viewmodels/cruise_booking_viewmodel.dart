import 'package:flutter/material.dart';
import '../models/cruise_destination.dart';

class CruiseBookingViewModel extends ChangeNotifier {
  // 1. Destination data (pure data model)
  final CruiseDestination destination = const CruiseDestination(
    name: 'Rajang River Express Cruise',
    location: 'Sibu Waterfront, Sarawak',
    description:
        "Experience the heart of Sibu along Malaysia's longest river, the Rajang. "
        'Cruise past historic temples, timber hubs, and traditional waterfront settlements '
        'while experiencing authentic Sarawakian hospitality.',
    imagePath: 'assets/images/sibu_river.jpg',
    landmarkTag: 'Sibu Esplanade Landmark',
    initialRating: 42,
  );

  // 2. Dynamic star rating counter state
  late int _rating;
  bool _isFavorited = false;

  int get rating => _rating;
  bool get isFavorited => _isFavorited;

  // 3. Visit date state
  DateTime _selectedDate = DateTime(2026, 11, 15);
  DateTime get selectedDate => _selectedDate;

  String get formattedDate {
    final day = _selectedDate.day.toString().padLeft(2, '0');
    final month = _selectedDate.month.toString().padLeft(2, '0');
    final year = _selectedDate.year.toString();
    return '$day/$month/$year';
  }

  // 4. Cruise package selection state
  final List<String> packageOptions = const [
    'Express Boat',
    'Private River Cruise',
    'Sunset Cruise',
    'Sunrise Cruise',
    'Rural Cruise',
    'SMI Park Cruise',
  ];

  late String _selectedPackage;
  String get selectedPackage => _selectedPackage;

  // 5. Theme toggle state (Light / Dark mode)
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  CruiseBookingViewModel() {
    _rating = destination.initialRating;
    _selectedPackage = packageOptions.first;
  }

  // Methods to update state and notify UI
  void toggleRating() {
    if (_isFavorited) {
      _rating -= 1;
      _isFavorited = false;
    } else {
      _rating += 1;
      _isFavorited = true;
    }
    notifyListeners();
  }

  void updateDate(DateTime newDate) {
    _selectedDate = newDate;
    notifyListeners();
  }

  void updatePackage(String newPackage) {
    if (packageOptions.contains(newPackage)) {
      _selectedPackage = newPackage;
      notifyListeners();
    }
  }

  void toggleTheme(bool isDark) {
    _isDarkMode = isDark;
    notifyListeners();
  }
}
