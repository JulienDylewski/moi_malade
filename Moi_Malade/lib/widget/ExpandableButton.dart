import 'package:flutter/material.dart';

class ExpandableButton extends StatefulWidget {
  const ExpandableButton({
    Key? key,
    required this.buttonName,
    required this.label,
  }) : super(key: key);
  final String buttonName;
  final String label;

  @override
  _ExpandableButtonState createState() => _ExpandableButtonState();
}

class _ExpandableButtonState extends State<ExpandableButton> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: const Color(0xff000000)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ExpansionTile(
        title: Row(
          children: [
            Container(
              width: 8.0,
              height: 8.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffFFBBD7),
              ),
            ),
            const SizedBox(width: 8.0),
            Text(widget.buttonName,
                style: TextStyle(
                    color: Color(_isExpanded ? 0xffFFBBD7 : 0xff000000))),
          ],
        ),
       /* trailing: Icon(
          color: Color(_isExpanded ? 0xff54cbc4 : 0xff000000),
          _isExpanded ? Icons.arrow_drop_down_circle : Icons.arrow_drop_down,
        ), */
        children: <Widget>[
          ListTile(title: Text(widget.label)),
        ],
        onExpansionChanged: (bool expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
      ),
    );
  }
}