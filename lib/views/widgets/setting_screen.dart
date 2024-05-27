import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:homework_43/views/widgets/pasword/pasword_dialog.dart';
import 'package:homework_43/views/widgets/textdialog.dart';
import '../../utils/styles.dart';
import '../custom_drawer/custom_drawer.dart';

class SettingsScreen extends StatefulWidget {
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<String> onBackgroundChanged;
  final ValueChanged<String> onLanguageChanged;
  final ValueChanged<Color> onColorChanged;
  final Function(Color, double) onTextChanged;

  const SettingsScreen({
    super.key,
    required this.onThemeChanged,
    required this.onBackgroundChanged,
    required this.onLanguageChanged,
    required this.onColorChanged,
    required this.onTextChanged,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final List<String> _items = ['uz', 'eng', 'rus'];
  String? _selectedItem;
  Color _currentColor = AppConstants.appColor;

  void _openColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Color picker panel',
            style: TextStyle(
              color: AppConstants.textColor,
              fontSize: AppConstants.textSize,
            ),
          ),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _currentColor,
              onColorChanged: (Color color) {
                setState(() {
                  _currentColor = color;
                });
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                widget.onColorChanged(_currentColor);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
            color: AppConstants.textColor,
            fontSize: AppConstants.textSize,
          ),
        ),
        actions: [
          DropdownButton<String>(
            hint: Text(AppConstants.language),
            value: _selectedItem,
            onChanged: (String? value) {
              setState(() {
                _selectedItem = value;
              });
              widget.onLanguageChanged(value ?? '');
            },
            items: _items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      drawer: CustomDrawer(
        onThemeChanged: widget.onThemeChanged,
        onBackgroundChanged: widget.onBackgroundChanged,
        onLanguageChanged: widget.onLanguageChanged,
        onColorChanged: widget.onColorChanged,
        onTextChanged: widget.onTextChanged,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  AppConstants.imageUrl,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              SwitchListTile(
                value: AppConstants.themeMode == ThemeMode.dark,
                onChanged: widget.onThemeChanged,
                title: Text(
                  "Night mode",
                  style: TextStyle(
                    color: AppConstants.textColor,
                    fontSize: AppConstants.textSize,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Write image url',
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (_textEditingController.text.isEmpty) {
                    widget.onBackgroundChanged(
                        'https://img.freepik.com/free-vector/blur-pink-blue-abstract-gradient-background-vector_53876-174836.jpg');
                  } else {
                    widget.onBackgroundChanged(_textEditingController.text);
                  }
                  setState(() {});
                },
                icon: const Icon(Icons.check_circle),
              ),
              TextButton(
                onPressed: _openColorPicker,
                child: Text(
                  'Change color',
                  style: TextStyle(
                    color: AppConstants.textColor,
                    fontSize: AppConstants.textSize,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const PasswordAlertDialog();
                    },
                  );
                },
                child: Text(
                  'Change password',
                  style: TextStyle(
                    color: AppConstants.textColor,
                    fontSize: AppConstants.textSize,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => EditTextAlertDialog(
                      onTextChanged: widget.onTextChanged,
                    ),
                  );
                },
                child: Text(
                  'Change text style',
                  style: TextStyle(
                    color: AppConstants.textColor,
                    fontSize: AppConstants.textSize,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
