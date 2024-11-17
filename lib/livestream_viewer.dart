import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class LivestreamViewer extends StatefulWidget {
  final String liveUrl;
  final String videoId;
  final String accessToken;

  LivestreamViewer({
    required this.liveUrl,
    required this.videoId,
    required this.accessToken,
  });

  @override
  _LivestreamViewerState createState() => _LivestreamViewerState();
}

class _LivestreamViewerState extends State<LivestreamViewer> {
  List<Map<String, dynamic>> _comments = [];
  bool _isLoadingComments = true;
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();

    WebView.platform = SurfaceAndroidWebView();

    // Fetch comments periodically
    _fetchLiveComments();
    _refreshTimer = Timer.periodic(Duration(seconds: 10), (timer) {
      _fetchLiveComments();
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _fetchLiveComments() async {
    final url = Uri.parse(
        'https://graph.facebook.com/v15.0/${widget.videoId}/comments?filter=top&fields=from,message,created_time&access_token=${widget.accessToken}');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _comments = (data['data'] as List).map((comment) {
            return {
              'name': comment['from']['name'],
              'message': comment['message'],
              'time': comment['created_time'],
            };
          }).toList();
          _isLoadingComments = false;
        });
      } else {
        print('Failed to fetch comments: ${response.body}');
        _showErrorSnackbar(
            'Failed to fetch comments: ${response.body}');
      }
    } catch (e) {
      print('Error fetching comments: $e');
      _showErrorSnackbar('An error occurred while fetching comments.');
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Livestream Viewer'),
        backgroundColor: Colors.blueGrey[800],
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Embedded Facebook Video
          Expanded(
            flex: 2,
            child: WebView(
              initialUrl:
              'https://www.facebook.com/plugins/video.php?href=${Uri.encodeComponent(widget.liveUrl)}&autoplay=1',
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
          // Live Comments Section
          Expanded(
            flex: 3,
            child: _isLoadingComments
                ? Center(child: CircularProgressIndicator())
                : _comments.isEmpty
                ? Center(
              child: Text(
                'No comments available.',
                style: TextStyle(
                    fontSize: 16, color: Colors.grey[600]),
              ),
            )
                : ListView.builder(
              itemCount: _comments.length,
              itemBuilder: (context, index) {
                final comment = _comments[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      comment['name'][0],
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.orangeAccent,
                  ),
                  title: Text(
                    comment['name'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(comment['message']),
                  trailing: Text(
                    _formatTimestamp(comment['time']),
                    style: TextStyle(
                        fontSize: 12, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(String timestamp) {
    try {
      final dateTime = DateTime.parse(timestamp);
      return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      print('Error parsing timestamp: $e');
      return timestamp;
    }
  }
}
