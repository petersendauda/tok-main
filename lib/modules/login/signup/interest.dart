import 'package:flutter/material.dart';
import 'package:tok/modules/login/signup/popular.dart'; // Import the PopularWidget

class InterestWidget extends StatefulWidget {
  const InterestWidget({super.key});

  @override
  State<InterestWidget> createState() => _InterestWidgetState();
}

class _InterestWidgetState extends State<InterestWidget> {
  final List<String> topics = [
    'Culture',
    'Education',
    'Politics',
    'Comics',
    'Sports',
    'Finances',
    'Fintech',
    'Blockchain',
    'Faith',
    'Music',
    'Arts',
    'Podcast',
    'Web 3',
    'SchoolTech',
  ];

  List<bool> selectedTopics = List.generate(14, (index) => false); // Track selection

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // Get screen width
    final screenHeight = MediaQuery.of(context).size.height; // Get screen height

    return Scaffold(
      backgroundColor: Color(0xFFF0F4F9),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Center(
              child: Text(
                'We\'ll recommend great writing based on the topics you select',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              width: screenWidth * 0.85, // Set width to 85% of screen width for better responsiveness
              height: screenHeight * 0.7, // Increased height to 70% of screen height
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(40.0), // Padding around the containers
                child: Column(
                  children: [
                    Wrap(
                      spacing: 10, // Horizontal space between cards
                      runSpacing: 10, // Vertical space between cards
                      children: List.generate(topics.length + 1, (index) {
                        if (index < topics.length) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedTopics[index] = !selectedTopics[index]; // Toggle selection
                              });
                            },
                            child: Container(
                              width: 200, // Set width to 200 for the boxes
                              height: 90, // Set height to 90 for the boxes
                              decoration: BoxDecoration(
                                color: selectedTopics[index] ? Colors.blue : Colors.grey[300], // Change color based on selection
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                topics[index],
                                style: TextStyle(
                                  color: selectedTopics[index] ? Colors.white : Colors.black, // Change text color based on selection
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        } else {
                          // Plus icon for adding more topics
                          return GestureDetector(
                            onTap: () {
                              // Handle adding more topics
                            },
                            child: Container(
                              width: 200, // Set width to 200 for the plus icon
                              height: 90, // Set height to 90 for the plus icon
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.add,
                                color: Colors.black,
                                size: 30, // Size of the plus icon
                              ),
                            ),
                          );
                        }
                      }),
                    ),
                    SizedBox(height: 102.0), // Space between topics and buttons
                    Opacity(
                      opacity: selectedTopics.contains(true) ? 1.0 : 0.5, // Full opacity if selected, else 50%
                      child: ElevatedButton(
                        onPressed: selectedTopics.contains(true) ? () {
                          // Navigate to PopularWidget if at least one topic is selected
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PopularWidget()),
                          );
                        } : null, // Disable button if no topics are selected
                        child: Text('Continue'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(350, 50), // Set minimum size to 350x50
                          backgroundColor: Color(0xFF8B1F41), // Button color
                          foregroundColor: Colors.white, // Text color
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0), // Space between buttons
                    TextButton(
                      onPressed: () {
                        // Navigate to PopularWidget when skipping
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PopularWidget()),
                        );
                      },
                      child: Text('Skip for now'),
                      style: TextButton.styleFrom(
                        minimumSize: Size(350, 50), // Set width to 350
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
