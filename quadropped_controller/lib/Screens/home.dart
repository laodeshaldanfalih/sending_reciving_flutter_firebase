import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:firebase_core/firebase_core.dart';

// import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool button = true;
  String hcsr = '0';
  FirebaseDatabase database = FirebaseDatabase.instance;
  final refSet = FirebaseDatabase.instance.ref('test/');
  final refGet = FirebaseDatabase.instance.ref();

  //getting data from firebase
  void initState() {
    super.initState();
    activelisteners();
  }

  void activelisteners() {
    refGet.child('test_hcsr/jarak').onValue.listen((event) {
      final description = event.snapshot.value;
      setState(() {
        hcsr = '$description';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 24, 22, 22),
      body: Column(
        children: [
          // On-Off LED Button
          Padding(
            padding: const EdgeInsets.only(left: 600, top: 300),
            child: SizedBox(
              width: 200,
              height: 200,
              child: ElevatedButton(
                onPressed: () async {
                  // Provider.of(context, listen: false);
                  button = !button;
                  await refSet.set(button ? {'int': 1} : {'int': 0});
                  print(button);
                  setState(() {});
                },
                child: Text(button ? 'On' : 'Off'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      button ? Colors.green : Colors.red),
                  textStyle: MaterialStateProperty.all(
                    TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 540, top: 40),
            child: Text(
              'HCSR: $hcsr',
              style: TextStyle(color: Colors.white, fontSize: 45),
            ),
          )
        ],
      ),
    );
  }
}
