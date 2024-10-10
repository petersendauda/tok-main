import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: Color(0xFFF0F4F9),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Container(
              color: Colors.amber,
              width: 1000,
              height: 2500,
              child: Expanded(
                child: ListView.builder(
                  itemCount: bloggers.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      title: Text(bloggers[index]['name']!),
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
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle continue action
              },
              child: Text('Continue'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(350, 50), // Set width to 350
                backgroundColor: Color(0xFF8B1F41), // Button color
                foregroundColor: Colors.white, // Text color
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Handle skip action
              },
              child: Text('Skip for now'),
              style: TextButton.styleFrom(
                minimumSize: Size(350, 50), // Set width to 350
              ),
            ),
          ],
        ),
      ),
    );
  }
}
