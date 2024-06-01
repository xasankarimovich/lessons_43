import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/styles.dart';
import 'home_screen.dart';

class Onboarding extends StatefulWidget {
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<String> onBackgroundChanged;
  final ValueChanged<String> onLanguageChanged;
  final ValueChanged<Color> onColorChanged;
  final Function(Color, double) onTextChanged;

  const Onboarding({
    super.key,
    required this.onThemeChanged,
    required this.onBackgroundChanged,
    required this.onLanguageChanged,
    required this.onColorChanged,
    required this.onTextChanged,
  });

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final List<TextEditingController> _textEditingControllersList = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  String errorMessage = '';

  void _verifyPinAndNavigate() {

    String enteredPin = _textEditingControllersList.map((e) => e.text).join();
    String correctPin = AppConstants.password;

    if (enteredPin == correctPin) {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) {
            return HomePage(
              onThemeChanged: widget.onThemeChanged,
              onBackgroundChanged: widget.onBackgroundChanged,
              onLanguageChanged: widget.onLanguageChanged,
              onColorChanged: widget.onColorChanged,
              onTextChanged: widget.onTextChanged,
            );
          },
        ),
      );
    } else {
      setState(() {
        errorMessage = 'Noto\'g\'ri PIN kod';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  for (int i = 0; i < _textEditingControllersList.length; i++)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          controller: _textEditingControllersList[i],
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          obscureText: true,
                          decoration: const InputDecoration(
                            counterText: '',
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty && i < _textEditingControllersList.length - 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                        ),
                      ),
                    ),
                ],
              ),
              if (errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: _verifyPinAndNavigate,
                child: const Text('Keyingi sahifaga o\'tish'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
