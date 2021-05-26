import 'package:flutter/material.dart';
import 'package:qrreader/src/pages/addresses_page.dart';
import 'package:qrreader/src/pages/maps_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {},
          )
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _createBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _createFloatingActionButton(),
    );
  }

  Widget _callPage(int currentPage) {
    switch (currentPage) {
      case 0: return MapsPage();
      case 1: return AddressesPage();
      default: return MapsPage();
    }
  }

  Widget _createBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Maps'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          label: 'Addresses'
        ),
      ],
    );
  }

  Widget _createFloatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.filter_center_focus),
      onPressed: () {},
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}