// pin_service.dart
import 'package:shared_preferences/shared_preferences.dart';

class PinService {
  final  correctPin = "1234";
  static const String _pinEnabledKey = 'pin_enabled';

  Future<void> savePin(String pin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(correctPin, pin);
    await prefs.setBool(_pinEnabledKey, true);
  }

  Future<void> removePin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(correctPin);
    await prefs.setBool(_pinEnabledKey, false);
  }

  Future<String?> getPin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(correctPin);
  }

  Future<bool> isPinEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_pinEnabledKey) ?? false;
  }

  Future<bool> verifyPin(String pin) async {
    return pin == correctPin;
  }
}
