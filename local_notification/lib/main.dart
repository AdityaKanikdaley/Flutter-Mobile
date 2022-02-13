import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late FlutterLocalNotificationsPlugin fltrNotification;
  var task,_selectedParam,val;

  @override
  void initState() {
    super.initState();
    var androidInitilize = new AndroidInitializationSettings('app_icon');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings =
    new InitializationSettings(android: androidInitilize, iOS: iOSinitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: notificationSelected);
  }

  Future _showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
        "Channel ID", "Aditya", "This is my channel",
        importance: Importance.max);
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails = new NotificationDetails(android: androidDetails, iOS: iSODetails);

    //for instant notification
    //   await fltrNotification.show(0, 'Task', 'You Created a task', generalNotificationDetails, payload: 'Payload');

    //for scheduled notification
    var scheduledTime;
    if(_selectedParam == 'Hour'){
      scheduledTime = DateTime.now().add(Duration(hours: val));
    }else if(_selectedParam == 'Minute'){
      scheduledTime = DateTime.now().add(Duration(minutes: val));
    }else{
      scheduledTime = DateTime.now().add(Duration(seconds: val));
    }

    fltrNotification.schedule(1, 'Times up', task, scheduledTime, generalNotificationDetails, payload: 'Payload');
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Notification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  onChanged: (_val){
                    task = _val;
                  },
                ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                DropdownButton(
                  value: _selectedParam,
                  items: [
                    DropdownMenuItem(child: Text('Seconds'), value: 'Seconds'),
                    DropdownMenuItem(child: Text('Minutes'), value: 'Minutes'),
                    DropdownMenuItem(child: Text('Hours'), value: 'Hours'),
                  ],
                  hint: Text('Select Your Field', style: TextStyle(color: Colors.black),
                  ),
                  onChanged: (_val){
                    setState(() {
                      _selectedParam = _val;
                    });
                  },
                ),

                DropdownButton<int>(
                    value: val,
                    items: [
                      DropdownMenuItem<int>(child: Text('1'), value: 1,),
                      DropdownMenuItem<int>(child: Text('2'), value: 2,),
                      DropdownMenuItem<int>(child: Text('3'), value: 3,),
                      DropdownMenuItem<int>(child: Text('4'), value: 4,),
                    ],
                  hint: Text('Select Value', style: TextStyle(color: Colors.black),
                ),
                  onChanged: (_val){
                      setState(() {
                        val = _val;
                      });
                  },
                )
              ],
            ),
            ElevatedButton(
                onPressed: _showNotification,
                child: Text('Set Task With Notification'))
          ],
        )
      )
    );
  }

  Future notificationSelected(String? payload) async{
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Notification : $payload"),
      ),
    );
  }
}
