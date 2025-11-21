import 'package:flutter/material.dart';

class ShopNavDropdown extends StatelessWidget {
  const ShopNavDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        switch (value) {
          case 'clothing':
            Navigator.pushNamed(context, '/collections');
            break;
          case 'merch':
            Navigator.pushNamed(context, '/merch'); // TODO: create route/page
            break;
          case 'halloween':
            Navigator.pushNamed(context, '/halloween'); // TODO
            break;
          case 'signature':
            Navigator.pushNamed(context, '/signature'); // TODO
            break;
        }
      },
      offset: const Offset(0, 20),
      elevation: 4,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      itemBuilder: (context) => const <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'clothing',
          child: Text('Clothing'),
        ),
        PopupMenuItem<String>(
          value: 'merch',
          child: Text('Merchandise'),
        ),
        PopupMenuItem<String>(
          value: 'halloween',
          child: Text('Halloween 🎃'),
        ),
        PopupMenuItem<String>(
          value: 'signature',
          child: Text('Signature & Essential Range'),
        ),
      ],
      child: Row(
        children: const [
          Text(
            'SHOP',
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
