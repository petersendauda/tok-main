import 'package:flutter/material.dart';

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
              width: 1200,
              height: 600,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: GridView.builder(
                padding: EdgeInsets.all(20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of columns
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: topics.length + 1, // Add one for the plus icon
                itemBuilder: (context, index) {
                  if (index < topics.length) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTopics[index] = !selectedTopics[index]; // Toggle selection
                        });
                      },
                      child: Container(
                        width: 100, // Set a smaller width for the boxes
                        height: 50, // Set a fixed height for the boxes
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
                        width: 100, // Set a smaller width for the plus icon
                        height: 50, // Set a fixed height for the plus icon
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
                },
              ),
            ),
          ),
          SizedBox(height: 50.0),
          ElevatedButton(
            onPressed: () {
              // Handle continue action
            },
            child: Text('Continue'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Color(0xFF8B1F41), // Text color
            ),
          ),
          TextButton(
            onPressed: () {
              // Handle skip action
            },
            child: Text('Skip for now'),
          ),
        ],
      ),
    );
  }
}
