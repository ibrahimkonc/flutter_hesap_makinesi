import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'Hesap Makinesi'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String sonuc = "0";
  String denklem = "0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: FittedBox(
                child: Text(
                  denklem,
                  style: const TextStyle(fontSize: 50),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                child: Text(
                  sonuc,
                  style: const TextStyle(fontSize: 40),
                )),
            const SizedBox(height: 50),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Table(
                    children: [
                      TableRow(children: [
                        Buttonlar("C", 1, Colors.red),
                        Buttonlar("⌫", 1, Colors.red.shade300),
                        Buttonlar("/", 1, Colors.orange),
                      ]),
                      TableRow(children: [
                        Buttonlar("7", 1, Colors.black38),
                        Buttonlar("8", 1, Colors.black38),
                        Buttonlar("9", 1, Colors.black38),
                      ]),
                      TableRow(children: [
                        Buttonlar("4", 1, Colors.black38),
                        Buttonlar("5", 1, Colors.black38),
                        Buttonlar("6", 1, Colors.black38),
                      ]),
                      TableRow(children: [
                        Buttonlar("1", 1, Colors.black38),
                        Buttonlar("2", 1, Colors.black38),
                        Buttonlar("3", 1, Colors.black38),
                      ]),
                      TableRow(children: [
                        Buttonlar(".", 1, Colors.black38),
                        Buttonlar("0", 1, Colors.black38),
                        Buttonlar("00", 1, Colors.black38),
                      ]),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Table(children: [
                    TableRow(children: [Buttonlar("*", 1, Colors.orange)]),
                    TableRow(children: [Buttonlar("+", 1, Colors.orange)]),
                    TableRow(children: [Buttonlar("-", 1, Colors.orange)]),
                    TableRow(children: [Buttonlar("=", 2, Colors.green)]),
                  ]),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget Buttonlar(
      String buttonIcerik, double buttonYukseklik, Color buttonRenk) {
    return Container(
      margin: const EdgeInsets.only(top: 1),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: buttonRenk),
      height: MediaQuery.of(context).size.height * 0.1 * buttonYukseklik,
      //color: buttonRenk,
      child: TextButton(
        onPressed: () => buttonPress(buttonIcerik),
        child: Text(
          buttonIcerik,
          style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
      ),
    );
  }

  buttonPress(buttonIcerik) {
    setState(() {
      if (buttonIcerik == "C") {
        denklem = "0";
        sonuc = "0";
      } else if (buttonIcerik == "=") {
        String isSum = denklem.contains("+")
            ? "+"
            : denklem.contains("-")
                ? "-"
                : denklem.contains("/")
                    ? "/"
                    : denklem.contains("*")
                        ? "*"
                        : "";

        double calc = 0;
        switch (isSum) {
          case "+":
            denklem.toString().split(isSum).forEach((element) {
              calc += double.parse(element);
              sonuc =
                  "=${calc.toString().split(".")[1] == "0" ? calc.toString().split(".")[0] : calc}";
            });
            break;
          case "-":
            denklem.toString().split(isSum).forEach((element) {
              calc = calc == 0
                  ? double.parse(element)
                  : calc - double.parse(element);
              sonuc =
                  "=${calc.toString().split(".")[1] == "0" ? calc.toString().split(".")[0] : calc}";
            });
            break;
          case "*":
            denklem.toString().split(isSum).forEach((element) {
              calc = calc == 0
                  ? double.parse(element)
                  : calc * double.parse(element);
              sonuc =
                  "=${calc.toString().split(".")[1] == "0" ? calc.toString().split(".")[0] : calc}";
            });
            break;
          case "/":
            denklem.toString().split(isSum).forEach((element) {
              calc = calc == 0
                  ? double.parse(element)
                  : calc / double.parse(element);
              sonuc =
                  "=${calc.toString().split(".")[1] == "0" ? calc.toString().split(".")[0] : calc}";
            });
            break;
          default:
            sonuc = denklem;
        }
        calc = 0;
      } else if (buttonIcerik == "⌫") {
        denklem = denklem.substring(0, denklem.length - 1);
        if (denklem.isEmpty) {
          denklem = "0";
        }
      } else {
        if (denklem == "0") {
          denklem = "";
        }
        denklem += buttonIcerik.toString();
      }
    });
  }
}
