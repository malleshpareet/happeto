import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/doctor_provider.dart';
import '../providers/appointment_provider.dart';
import '../providers/selected_vet_provider.dart';
import 'vet_detail_screen.dart';

class VeterinarianScreen extends StatefulWidget {
  const VeterinarianScreen({super.key});

  @override
  State<VeterinarianScreen> createState() => _VeterinarianScreenState();
}

class _VeterinarianScreenState extends State<VeterinarianScreen> {
  int selectedTabIndex = 0;
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final vetProvider = Provider.of<VetProvider>(context);
    final filteredVets = vetProvider.vets.where((vet) =>
    vet.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
        vet.specialty.toLowerCase().contains(searchQuery.toLowerCase())).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildSearchField(),
            _buildTabs(),
            Expanded(
              child: selectedTabIndex == 0
                  ? _buildVetList(filteredVets)
                  : _buildEmptyScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          /// 👇 Back button with Navigator.pop
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, size: 24),
          ),
          const Spacer(),
          const Text("Veterinarians", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Spacer(),
          const SizedBox(width: 24),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          onChanged: (value) => setState(() => searchQuery = value),
          decoration: const InputDecoration(
            hintText: "Search",
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          _buildTab("Popular", 0),
          const SizedBox(width: 12),
          _buildTab("Nearby", 1),
          const SizedBox(width: 12),
          _buildTab("Last Visited", 2),
        ],
      ),
    );
  }

  Widget _buildTab(String label, int index) {
    bool isSelected = selectedTabIndex == index;
    return GestureDetector(
      onTap: () => setState(() => selectedTabIndex = index),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.black : Colors.grey,
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 2,
              width: 24,
              color: Colors.blue,
            ),
        ],
      ),
    );
  }

  Widget _buildVetList(List vets) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: vets.length,
      itemBuilder: (context, index) {
        final vet = vets[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 2),
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(vet.image),
                      radius: 28,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(vet.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 2),
                        Text(vet.specialty, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Row(
                              children: List.generate(5, (star) {
                                return Icon(
                                  Icons.star,
                                  color: star < vet.rating ? Colors.amber : Colors.grey[300],
                                  size: 16,
                                );
                              }),
                            ),
                            const SizedBox(width: 6),
                            Text("(${vet.reviews})", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  onPressed: () {
                    Provider.of<SelectedVetProvider>(context, listen: false)
                        .setVet(vet.name, vet.image, vet.fee.toDouble());

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const VetDetailScreen()),
                    );
                  },
                  child: Text("Start consult | ₹${vet.fee}", style: const TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyScreen() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 60, color: Colors.grey),
          SizedBox(height: 8),
          Text("No data found", style: TextStyle(color: Colors.grey, fontSize: 16)),
        ],
      ),
    );
  }
}
