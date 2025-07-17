import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/appointment_provider.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appointmentProvider = Provider.of<AppointmentProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F8F8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Payment', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: Payment Method Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Payment method",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const Text("+ Add",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue)),
              ],
            ),
            const SizedBox(height: 14),

            // Section: Cards
            Row(
              children: [
                _buildCard(
                  context,
                  logoPath: "assets/images/mastercard.png",
                  lastDigits: "2048",
                  isSelected: true,
                  color: Colors.black,
                ),
                const SizedBox(width: 16),
                _buildCard(
                  context,
                  logoPath: "assets/images/visa.png",
                  lastDigits: "1981",
                  isSelected: false,
                  color: const Color(0xFF0155D7),
                ),
              ],
            ),
            const SizedBox(height: 28),

            // Section: Appointment Details Header
            Text("Appointment details",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 14),

            // Section: Appointment Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(appointmentProvider.doctorImage),
                    radius: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(appointmentProvider.doctorName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 2),
                        const Text("Veterinary",
                            style:
                            TextStyle(color: Colors.grey, fontSize: 13)),
                        const SizedBox(height: 6),
                        const Row(
                          children: [
                            Icon(Icons.star, size: 16, color: Colors.orange),
                            Icon(Icons.star, size: 16, color: Colors.orange),
                            Icon(Icons.star, size: 16, color: Colors.orange),
                            Icon(Icons.star, size: 16, color: Colors.orange),
                            Icon(Icons.star_border,
                                size: 16, color: Colors.orange),
                            SizedBox(width: 6),
                            Text("(1094)",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey))
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Section: Date and Time
            Text("Date and Time",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black)),
            const SizedBox(height: 6),
            const Text("20 June 2022 - Wednesday   09:30",
                style: TextStyle(color: Colors.grey, fontSize: 13)),

            const SizedBox(height: 24),

            // Section: Estimated Cost
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Estimated Cost",
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Text("₹929",
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),

            const Spacer(),

            // Section: Confirm Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  // Navigate to confirmation screen
                },
                child: const Text("Confirm", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
      BuildContext context, {
        required String logoPath,
        required String lastDigits,
        required bool isSelected,
        required Color color,
      }) {
    return Expanded(
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(logoPath,
                    width: 44, height: 28, fit: BoxFit.contain),
                const Spacer(),
                Text("•••• $lastDigits",
                    style: const TextStyle(color: Colors.white, fontSize: 14)),
              ],
            ),
            if (isSelected)
              const Positioned(
                right: 0,
                top: 0,
                child: Icon(Icons.check_circle, color: Colors.white, size: 20),
              ),
          ],
        ),
      ),
    );
  }
}
