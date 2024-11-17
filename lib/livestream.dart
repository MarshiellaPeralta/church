import 'package:flutter/material.dart';
import 'livestream_viewer.dart';

class LivestreamPage extends StatelessWidget {
  final Map<String, String> _churchImages = {
    'STA ANA': 'assets/sa.jpg',
    'ARAYAT': 'assets/ar.jpg',
    'MEXICO': 'assets/mex.jpg',
    'CANDABA': 'assets/background02.jpg',
    'SAN LUIS': 'assets/luis.jpg',
    'SanctiSync': 'assets/sf-img.jpg',
  };

  final Map<String, String> _churchLiveUrls = {
    'MEXICO': 'https://www.facebook.com/stamonicademexicopampanga/videos/1248162299839570',
    'ARAYAT': 'https://www.facebook.com/ApungTali1590/videos/3493001484342749',
    'STA ANA': 'https://www.facebook.com/parokyanang.santaana/videos/1358592665112173',
    'SAN LUIS': 'https://www.facebook.com/SanLuisGonzaga1734/videos/2030145657470471',
    'CANDABA': 'https://www.facebook.com/SanAndresCandaba/videos/414698628346062',
    'SanctiSync': 'https://www.facebook.com/100083499875388/videos/1904997539986849',
  };

  final List<String> _churchOrder = [
    'SAN LUIS',
    'CANDABA',
    'MEXICO',
    'STA ANA',
    'ARAYAT',
    'SanctiSync',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Church Livestreams",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey[800],
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _churchOrder.length,
        itemBuilder: (context, index) {
          final churchName = _churchOrder[index];
          final imageUrl = _churchImages[churchName] ?? 'assets/default.jpg';
          final liveUrl = _churchLiveUrls[churchName] ?? '';

          return _buildChurchCard(context, churchName, imageUrl, liveUrl);
        },
      ),
    );
  }

  Widget _buildChurchCard(
      BuildContext context, String churchName, String imageUrl, String liveUrl) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4,
      child: ListTile(
        contentPadding: EdgeInsets.all(10.0),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image.asset(
            imageUrl,
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          churchName,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          liveUrl.isNotEmpty ? "Live Stream Available" : "No Live Stream",
          style: TextStyle(
            fontSize: 14,
            color: liveUrl.isNotEmpty ? Colors.green : Colors.red,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: liveUrl.isNotEmpty
            ? ElevatedButton(
          onPressed: () => _viewLivestream(context, liveUrl),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orangeAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child: Text("Watch"),
        )
            : null,
      ),
    );
  }

  void _viewLivestream(BuildContext context, String liveUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LivestreamViewer(
          liveUrl: liveUrl,
          accessToken:
          'EAAY86FkaOWQBO41rc2oTAp7hVp8JJtMeTbpOlHHKZArw2iagAozuPZAZCQQhNtNehbZCKGXQcLXtXPspZBhUSYYfherWEak46GHnZBNkAR1LD4FXLMFJn7ZByOv4gZCqK57GeWxDPgjk8xlfVJ54D8I8E4qrig0qZCrgVjhK0oHvXbsaBBnObNk4hGNDrul6TCReDT8nRdTJSgq9TSIeH3ZBt3wOQFs9xOpdyZCd48LDfylxkUZD',
          videoId: '2030145657470471',
        ),
      ),
    );
  }
}
