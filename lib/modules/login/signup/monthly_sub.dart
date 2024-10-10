import 'package:flutter/material.dart';

class MonthlySubscription extends StatelessWidget {
  const MonthlySubscription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F4F9),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Subscribe to our platform and get access to all our stories and privileges',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle Monthly Subscription
                  },
                  child: Text('Monthly Subscription'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Button color
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Handle Annual Subscription
                  },
                  child: Text('Annual Subscription'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey, // Button color
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SubscriptionCard(
                  title: 'Normal Subscription',
                  price: 'Le 25 per month',
                  description: 'Subscribe to our platform and enjoy more reading and writing privileges',
                  onPressed: () {
                    // Handle Normal Subscription
                  },
                ),
                SubscriptionCard(
                  title: 'Premium Subscription',
                  price: 'Le 50 per month',
                  description: 'Subscribe to our platform and enjoy more reading and writing privileges',
                  onPressed: () {
                    // Handle Premium Subscription
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Handle skip action
              },
              child: Text('Skip for now'),
            ),
          ],
        ),
      ),
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  final String title;
  final String price;
  final String description;
  final VoidCallback onPressed;

  const SubscriptionCard({
    required this.title,
    required this.price,
    required this.description,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Rounded edges
      ),
      child: Container(
        width: 150, // Fixed width for the cards
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 30,
              child: Text('S'), // Placeholder for icon or letter
            ),
            SizedBox(height: 10),
            Text(
              price,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(description, textAlign: TextAlign.center),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: onPressed,
              child: Text('Subscribe'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF8B1F41), // Button color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
