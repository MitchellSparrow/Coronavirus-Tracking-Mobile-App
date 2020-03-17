import 'package:coronatracker/Screens/home_page.dart';
import 'package:coronatracker/Screens/list_view.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.yellow,
      home: DefaultTabController(
        length: 2,
        child: new Scaffold(
          body: TabBarView(
            children: [
              new Container(
                color: Colors.white,
                child: HomePageWidget(),
              ),
              new Container(
                child: ListViewWidget(),
              ),
            ],
          ),
          bottomNavigationBar: new TabBar(
            tabs: [
              Tab(
                icon: new Icon(Icons.home),
              ),
              Tab(
                icon: new Icon(Icons.list),
              ),
            ],
            labelColor: Colors.blue[900],
            unselectedLabelColor: Colors.blue[600],
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: Colors.blue[900],
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
