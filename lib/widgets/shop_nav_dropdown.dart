import 'package:flutter/material.dart';

class ShopNavDropdown extends StatelessWidget {
  const ShopNavDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        // avoid pushing the same route if we're already on it
        final current = ModalRoute.of(context)?.settings.name;
        String? target;
        switch (value) {
          case 'clothing':
            target = '/clothing';
            break;
          case 'merch':
            target = '/merch';
            break;
          case 'halloween':
            target = '/halloween';
            break;
          case 'signature':
            target = '/signature';
            break;
        }
        if (target == null) return;
        if (current == target) return; // already there
        Navigator.pushNamed(context, target);
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
      child: const Row(
        children: [
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
