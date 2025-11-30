import 'package:flutter/material.dart';

class PrintShackNavDropdown extends StatelessWidget {
  const PrintShackNavDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        final current = ModalRoute.of(context)?.settings.name;
        String? target;

        switch (value) {
          case 'about':
            target = '/print-shack';
            break;
          case 'personalisation':
            target = '/print-shack-personalisation';
            break;
        }

        if (target == null) return;
        if (current == target) return; // avoid reloading same page

        Navigator.pushNamed(context, target);
      },
      offset: const Offset(0, 20),
      elevation: 4,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      itemBuilder: (context) => const <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'about',
          child: Text('About the Print Shack'),
        ),
        PopupMenuItem<String>(
          value: 'personalisation',
          child: Text('Personalisation'),
        ),
      ],
      child: const Row(
        children: [
          Text(
            'PRINT SHACK',
            style: TextStyle(
              fontSize: 13,
              letterSpacing: 1,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 2),
          Icon(
            Icons.keyboard_arrow_down,
            size: 18,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
