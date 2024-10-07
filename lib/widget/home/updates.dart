import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widget/theme/theme_provider.dart';
import '../../modules/write.dart'; // Import the WritePage

class UpdatesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Column( // Changed from SingleChildScrollView to Column
      children: [
        _buildWriteBlogCard(themeProvider, context), // Pass context to the card
        SizedBox(height: 20),
        SingleChildScrollView( // Added SingleChildScrollView here
          child: Column(
            children: [
              _buildUpdatesCard(themeProvider),
              SizedBox(height: 20),
              _buildArticlesCard(themeProvider),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWriteBlogCard(ThemeProvider themeProvider, BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Write a Blog",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: themeProvider.themeData.colorScheme.onBackground,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Say what's on your mind",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: themeProvider.themeData.colorScheme.onBackground
                    .withOpacity(0.7),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: SizedBox(
                width: 350, // Adjust this value to increase or decrease width
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to WritePage when the button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WritePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF8B1F41),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: Text("Begin Tok"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdatesCard(ThemeProvider themeProvider) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUpdateItem("Sierra Leone blogs", "SaloneX", "1200 posts"),
            _buildUpdateItem("Education blogs", "SchoolTech", "2500 posts"),
            _buildUpdateItem("Football blogs", "Leone Stars", "500 posts"),
            _buildUpdateItem("Meme blogs", "Meme Drip", "1000 posts"),
          ],
        ),
      ),
    );
  }

  Widget _buildArticlesCard(ThemeProvider themeProvider) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Articles",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: themeProvider.themeData.colorScheme.onBackground,
              ),
            ),
            SizedBox(height: 16),
            _buildArticleItem("Blockchain articles", "Solana", "3000 posts"),
            _buildArticleItem("Education articles", "Artificial Intelligence", "2500 posts"),
            _buildArticleItem("Football articles", "Lionel Messi", "500 posts"),
            _buildArticleItem("Wild life articles", "Savana Forest", "1000 posts"),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdateItem(String title, String subtitle, String posts) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 14, color: Colors.grey)),
              Text(subtitle, style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Row(
            children: [
              Text(posts, style: TextStyle(color: Colors.grey)),
              Icon(Icons.more_horiz, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildArticleItem(String category, String title, String postCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(category, style: TextStyle(fontSize: 12, color: Colors.grey)),
                Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(postCount, style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Icon(Icons.more_horiz, color: Colors.grey),
        ],
      ),
    );
  }
}
