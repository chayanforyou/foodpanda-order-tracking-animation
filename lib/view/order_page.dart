import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodpanda_animation_demo/view/delivery_details_card.dart';
import 'package:lottie/lottie.dart';

import '../widgets/animated_step_bar.dart';
import 'contact_rider_card.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.pink,
        ),
        title: const Text(
          'Your Order',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              minimumSize: const Size(80, 80),
              foregroundColor: Colors.pink,
              textStyle: const TextStyle(fontSize: 17),
            ),
            child: const Text('Help'),
          ),
        ],
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 16),
                const Text(
                  'Estimated time of delivery',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  '15 - 20 mins',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                Lottie.asset('assets/lottiefiles/delivery_girl_cycling.json', height: 160),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: AnimatedStepBar(
                    totalSteps: 4,
                    currentStep: 3,
                    height: 4,
                    padding: 3,
                    stepWidths: const [1, 3, 2, 2],
                    selectedColor: Colors.pink,
                    unselectedColor: Colors.grey.shade300,
                    roundedEdges: const Radius.circular(10),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'We’ve got you a rider! They’re\n'
                  'heading to the restaurant',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 50),
                const ContactRiderCard(),
              ],
            ),
          ),
          const DeliveryDetailsCard(),
        ],
      ),
    );
  }
}
