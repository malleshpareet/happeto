import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/appointment_provider.dart';
import '../providers/selected_vet_provider.dart';
import 'VetChatScreen.dart';
import 'appointment_screen.dart';
import 'vet_reviews_screen.dart';

class VetDetailScreen extends StatefulWidget {
  const VetDetailScreen({super.key});

  @override
  State<VetDetailScreen> createState() => _VetDetailScreenState();
}

class _VetDetailScreenState extends State<VetDetailScreen> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final vet = Provider.of<SelectedVetProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Vet Detail'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Doctor image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                width: double.infinity,
                height: 200,
                child: Image.asset(vet.image, fit: BoxFit.fitWidth),
              ),
            ),
            const SizedBox(height: 16),

            /// Name + Icons Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    vet.name,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const Icon(Icons.calendar_today, size: 20),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () => _showCallBottomSheet(context),
                  child: const Icon(Icons.phone, size: 20),
                ),
              ],
            ),

            const SizedBox(height: 4),

            /// Star rating
            Row(
              children: const [
                Icon(Icons.star, color: Colors.amber, size: 16),
                Text(" 4.5 ", style: TextStyle(fontWeight: FontWeight.w500)),
                Text("(124)", style: TextStyle(color: Colors.grey)),
              ],
            ),

            const SizedBox(height: 12),

            /// Description
            Text(
              _isExpanded
                  ? "Dr. Spoorthi Madhu is a Bengaluru-based veterinary critical care specialist with expertise in small animal emergency medicine. A graduate of KVAFSU, she completed her internship in Mumbai and a residency program focused on companion animal medicine. With her calm demeanor and years of experience, she is a trusted vet for many pet parents across India."
                  : "Dr. Spoorthi Madhu is a Bengaluru-based veterinary critical care specialist with expertise in small animal emergency medicine...",
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Text(_isExpanded ? "Read less" : "Read more"),
            ),

            const SizedBox(height: 16),

            /// Experience / Completed / Fee
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _infoTile("12", "Experience"),
                  _infoTile("46", "Completed"),
                  _infoTile("₹${vet.fee.toInt()}", "Fee"),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// Reviews Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Reviews", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const VetReviewsScreen()));
                  },
                  child: const Text("Read all reviews", style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
            const SizedBox(height: 12),

            /// Horizontal Reviews List
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: [
                  _reviewCard("Darshan", "So impressed with the care my dog Bella has received. Amazing surgical skills alongside high sta...", "2d ago"),
                  _reviewCard("Pandu", "I never leave reviews but on this occasion I had to share how helpful Dr. Keisha has been...", "3d ago"),
                ],
              ),
            ),
          ],
        ),
      ),

      /// Start consult button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () {
            final vetProvider = Provider.of<SelectedVetProvider>(context, listen: false);
            final appointmentProvider = Provider.of<AppointmentProvider>(context, listen: false);

            appointmentProvider.setDoctor(vetProvider.name, vetProvider.image);

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AppointmentScreen()),
            );
          },
          child: const Text("Start consult", style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ),
    );
  }

  /// Info tile for experience, completed, fee
  Widget _infoTile(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
      ],
    );
  }

  /// Review card UI
  Widget _reviewCard(String name, String review, String time) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              const Spacer(),
              Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            review,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }

  /// Show call bottom sheet with clickable icons
  void _showCallBottomSheet(BuildContext context) {
    final vet = Provider.of<SelectedVetProvider>(context, listen: false);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(vet.image),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(vet.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const Text("Veterinary"),
                      Row(
                        children: const [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          SizedBox(width: 4),
                          Text("4.5", style: TextStyle(fontWeight: FontWeight.w500)),
                          SizedBox(width: 6),
                          Text("(124)", style: TextStyle(color: Colors.grey)),
                        ],
                      )
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Consultation fee", style: TextStyle(fontSize: 14)),
                  Text("₹${vet.fee.toInt()}", style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Payment methods", style: TextStyle(fontSize: 14)),
                  Row(
                    children: [
                      Icon(Icons.credit_card, color: Colors.orange),
                      SizedBox(width: 6),
                      Text("•••• 1994", style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),

              /// Clickable Call and Chat Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {

                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 26,
                      child: Icon(Icons.call, color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VetChatScreen(
                            vetName: vet.name,
                            vetImage: vet.image,
                          ),
                        ),
                      );// Chat button tapped
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 26,
                      child: Icon(Icons.chat_bubble_outline_sharp, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
