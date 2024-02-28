import 'package:flutter/material.dart';

class DeliveryDetailsCard extends StatelessWidget {
  const DeliveryDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.location_on_outlined, color: Colors.pink, size: 28),
              const SizedBox(width: 16),
              const Text(
                'Delivery details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  minimumSize: const Size(20, 20),
                  foregroundColor: Colors.pink,
                  textStyle: const TextStyle(fontSize: 17),
                ),
                child: const Text('Edit'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Oranienburger Strabe 70, 10117 Berlin\n'
            'Country yard building, 2nd floor',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Transform.flip(
                    flipX: true,
                    child: Text('\u275E', style: TextStyle(color: Colors.grey.shade800)),
                  ),
                ),
                const TextSpan(text: '  Please don’t ring the bell, my kids are sleeping'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              children: [
                const TextSpan(text: 'Delivered by'),
                TextSpan(
                  text: ' San pellegrino',
                  style: TextStyle(
                    color: Colors.blueGrey[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
