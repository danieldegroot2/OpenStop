import 'package:flutter/material.dart';

class SelectDialog<T> extends StatefulWidget {
  final Map<T, String> valueLabelMap;

  final T? value;

  final Widget? title;

  const SelectDialog({
    required this.valueLabelMap,
    this.value,
    this.title,
    Key? key
  }) : super(key: key);

  @override
  State<SelectDialog<T>> createState() => _SelectDialogState<T>();
}

class _SelectDialogState<T> extends State<SelectDialog<T>> {
  late var _entries = widget.valueLabelMap.entries.toList();

  late T? _selectedValue = widget.value;

  @override
  void didUpdateWidget(covariant SelectDialog<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _entries = widget.valueLabelMap.entries.toList();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.title,
      contentPadding: EdgeInsets.zero,
      // use list view because the content could potentially be scrollable
      // also build the items lazy because there could potentially be hundred of them
      content: ListView.builder(
          shrinkWrap: true,
          itemCount: _entries.length,
          itemBuilder: (context, index) {
            final entry = _entries[index];
            return RadioListTile<T>(
              groupValue: _selectedValue,
              value: entry.key,
              onChanged: (T? value) {
                setState(() {
                  _selectedValue = value;
                });
              },
              title: Text(entry.value),
            );
          }
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('ABBRECHEN'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, _selectedValue),
          child: const Text('OK'),
        ),
      ],
    );
  }
}