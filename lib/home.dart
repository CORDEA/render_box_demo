import 'package:flutter/material.dart';

import 'image_list_tile.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: ImageListTile(
          thumbnail: Container(
            width: 174,
            height: 174,
            color: Colors.black12,
          ),
          title: Text('text', maxLines: 1),
          titleBackgroundColor: Colors.pink.shade100,
        ),
      ),
    );
  }
}
