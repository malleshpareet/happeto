import 'package:cards_happeto/screens/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../providers/appointment_provider.dart';
import '../providers/selected_vet_provider.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppointmentProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F8F8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Appointment',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Doctor Card
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(provider.doctorImage),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(provider.doctorName, style: const TextStyle(fontWeight: FontWeight.bold)),
                      const Text("Veterinary"),
                      const SizedBox(height: 4),
                      const Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 16),
                          Icon(Icons.star, color: Colors.orange, size: 16),
                          Icon(Icons.star, color: Colors.orange, size: 16),
                          Icon(Icons.star, color: Colors.orange, size: 16),
                          Icon(Icons.star_border, color: Colors.orange, size: 16),
                          SizedBox(width: 4),
                          Text("(1094)", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Calendar
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2035, 12, 31),
                focusedDay: provider.selectedDay,
                selectedDayPredicate: (day) => isSameDay(day, provider.selectedDay),
                onDaySelected: (selectedDay, focusedDay) {
                  provider.setSelectedDay(selectedDay);
                },
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                  todayDecoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                ),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Time", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            // Time Slot Section
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(width: 4),
                  timeSlotButton(context, "09:00 AM"),
                  const SizedBox(width: 12),
                  timeSlotButton(context, "09:30 AM"),
                  const SizedBox(width: 12),
                  timeSlotButton(context, "10:00 AM"),
                  const SizedBox(width: 12),
                  timeSlotButton(context, "11:00 AM"),
                  const SizedBox(width: 12),
                  timeSlotButton(context, "11:30 AM"),
                  const SizedBox(width: 12),
                  timeSlotButton(context, "12:00 PM"),
                  const SizedBox(width: 12),
                  timeSlotButton(context, "12:30 PM"),
                  const SizedBox(width: 12),
                  timeSlotButton(context, "01:00 PM"),
                  const SizedBox(width: 4),
                ],
              ),
            ),


            const Spacer(),

            // Next Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  final vetProvider = Provider.of<SelectedVetProvider>(context, listen: false);
                  final appointmentProvider = Provider.of<AppointmentProvider>(context, listen: false);

                  appointmentProvider.setDoctor(vetProvider.name, vetProvider.image);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PaymentScreen()),
                  );
                },
                child: const Text("Next", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget timeSlotButton(BuildContext context, String time) {
    final provider = Provider.of<AppointmentProvider>(context);
    final isSelected = provider.selectedTime == time;

    return GestureDetector(
      onTap: () => provider.setSelectedTime(time),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : const Color(0xFFEDEDED),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: isSelected ? Colors.blue : Colors.transparent),
        ),
        child: Text(
          time,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.blue : Colors.black,
          ),
        ),
      ),
    );
  }
}
