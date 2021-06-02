import 'package:flutter/material.dart';

class FilterContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSwitchListTile('Lakme', false),
        _buildSwitchListTile('Loreal', false),
        _buildSwitchListTile('Iconic', false),
        _buildSwitchListTile('Gucci', false),
      ],
    );
  }
}

Widget _buildSwitchListTile(
  String title,
  bool currentValue,
  //Function updateValue,
) {
  return SwitchListTile(
    title: Text(title),
    value: currentValue,
    //onChanged: updateValue,
  );
}
