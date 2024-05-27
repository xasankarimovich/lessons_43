import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class EditTextAlertDialog extends StatefulWidget {
  final Function(Color, double) onTextChanged;

  const EditTextAlertDialog({
    super.key,
    required this.onTextChanged,
  });

  @override
  _EditTextAlertDialogState createState() => _EditTextAlertDialogState();
}

class _EditTextAlertDialogState extends State<EditTextAlertDialog> {
  Color _currentColor = Colors.black;
  double _currentFontSize = 14.0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Change Text Style'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Text Color',
              style: TextStyle(color: _currentColor, fontSize: _currentFontSize),
            ),
            ColorPicker(
              pickerColor: _currentColor,
              onColorChanged: (color) {
                setState(() {
                  _currentColor = color;
                });
              },
            ),
            const SizedBox(height: 20),
            Text('Select Font Size'),
            Slider(
              value: _currentFontSize,
              min: 8.0,
              max: 32.0,
              divisions: 24,
              label: _currentFontSize.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentFontSize = value;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onTextChanged(_currentColor, _currentFontSize);
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
