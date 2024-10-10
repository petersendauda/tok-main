import 'package:flutter/material.dart';
import 'package:tok/modules/login/signup/monthly_sub.dart'; // Import the MonthlySubscription widget

class PopularWidget extends StatefulWidget {
  const PopularWidget({super.key});

  @override
  State<PopularWidget> createState() => _PopularWidgetState();
}

class _PopularWidgetState extends State<PopularWidget> {
  final List<Map<String, String>> bloggers = [
    {
      'name': 'SaloneX',
      'description': "Blogs about what's happening on X app",
    },
    {
      'name': 'Solana',
      'description': 'Big tech and startups. From the inside, relevant for software engineers and managers.',
    },
    {
      'name': 'SchoolTech',
      'description': 'School Management Information Systems that records, stores, and process school data.',
    },
    {
      'name': 'Solana',
      'description': 'Big tech and startups. From the inside, relevant for software engineers and managers.',
    },
  ];

  List<bool> selectedBloggers = List.generate(4, (index) => false); // Track selection

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // Get screen width
    final screenHeight = MediaQuery.of(context).size.height; // Get screen height

    return Scaffold(
      backgroundColor: Color(0xFFF0F4F9),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center items vertically
          crossAxisAlignment: CrossAxisAlignment.center, // Center items horizontally
          children: [
            Text(
              'Bloggers you may want to follow',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Based on your interests, here are some bloggers you might enjoy',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Center( // Center the container
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Change color to white
                  borderRadius: BorderRadius.circular(20), // Set border radius for rounded edges
                ),
                width: 700, // Set width to a fixed value of 700 pixels
                height: screenHeight * 0.6, // Set height to 60% of screen height
                child: Column( // Change from ListView to Column for better centering
                  mainAxisAlignment: MainAxisAlignment.center, // Center items vertically within the container
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: bloggers.length,
                        itemBuilder: (context, index) {
                          return CheckboxListTile(
                            title: Text(
                              bloggers[index]['name']!,
                              style: TextStyle(fontWeight: FontWeight.bold), // Make the name bold
                            ),
                            subtitle: Text(bloggers[index]['description']!),
                            value: selectedBloggers[index],
                            onChanged: (bool? value) {
                              setState(() {
                                selectedBloggers[index] = value!;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.trailing, // Checkbox on the right
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20), // Space between the list and buttons
                    Opacity(
                      opacity: selectedBloggers.contains(true) ? 1.0 : 0.5, // Full opacity if at least one blogger is selected
                      child: ElevatedButton(
                        onPressed: selectedBloggers.contains(true) ? () {
                          // Navigate to MonthlySubscription when "Continue" is pressed
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MonthlySubscription()),
                          );
                        } : null, // Disable button if no bloggers are selected
                        child: Text('Continue'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(350, 50), // Set minimum size to 350x50
                          backgroundColor: Color(0xFF8B1F41), // Button color
                          foregroundColor: Colors.white, // Text color
                        ),
                      ),
                    ),
                    SizedBox(height: 10), // Space between buttons
                    TextButton(
                      onPressed: () {
                        // Navigate to MonthlySubscription when "Skip for now" is pressed
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MonthlySubscription()),
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
          ],
        ),
      ),
    );
  }
}
