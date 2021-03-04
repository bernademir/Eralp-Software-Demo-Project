import 'package:flutter/material.dart';
import 'package:todo/ui/shared/style/theme.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const CustomCard({Key key, this.title, this.subtitle}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: ListTile(
        title: Text(this.title, style: TextStyle(color: myTheme.primaryColor)),
        subtitle: Text(this.subtitle),
      ),
    );
  }
}
