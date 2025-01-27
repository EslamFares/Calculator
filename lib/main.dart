import 'package:flutter/material.dart';

void main() => runApp(MyCalculator());

class MyCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Calculator();
}

class _Calculator extends State<Calculator> {
  String text = '0';
  double numOne = 0;
  double numTwo = 0;
  String result = '0';
  String finalResult = '0';
  String opr = '';
  String preOpr = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.only(bottom: 10, left: 3.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 60.0,
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.right,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button('C', Color(0xffa5a5a5)),
                button('+/-', Color(0xffa5a5a5)),
                button('%', Color(0xffa5a5a5)),
                button('⌫', Color(0xffa5a5a5)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button('7', Color(0xff323232)),
                button('8', Color(0xff323232)),
                button('9', Color(0xff323232)),
                button('×', Colors.amber[800]),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button('4', Color(0xff323232)),
                button('5', Color(0xff323232)),
                button('6', Color(0xff323232)),
                button('-', Colors.amber[800]),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button('1', Color(0xff323232)),
                button('2', Color(0xff323232)),
                button('3', Color(0xff323232)),
                button('+', Colors.amber[800]),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  width: 2,
                ),
                button('0', Color(0xff323232)),
                button('.', Color(0xff323232)),
                button('/', Color(0xffff9800)),
                button('=', Colors.amber[800]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget button(String btnTxt, Color color) {
    Container container;
    container = Container(
      padding: EdgeInsets.only(bottom: 10),
      child: RaisedButton(
        onPressed: () {
          calculate(btnTxt);
        },
        child: Text(
          btnTxt,
          style: TextStyle(
            fontSize: 30.0,
          ),
        ),
        color: color,
        padding: EdgeInsets.all(20),
        shape: CircleBorder(),
      ),
    );

    return container;
  }

  void calculate(txtBtn) {
    if (txtBtn == 'C') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (txtBtn == '⌫') {
      //................For clrear num ..........
      result = result.substring(0, result.length - 1);
      finalResult = result;
    } else if (opr == '=' && txtBtn == '=') {
      switch (preOpr) {
        case '+':
          finalResult = add();
          break;
        case '-':
          finalResult = sub();
          break;
        case '×':
          finalResult = mul();
          break;
        case '/':
          finalResult = div();
          break;
      }
    }
    //if press in oprs continue without press "+"
    else if (txtBtn == '+' ||
        txtBtn == '-' ||
        txtBtn == '×' ||
        txtBtn == '/' ||
        txtBtn == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }
      switch (opr) {
        case '+':
          result = "$numOne + $numTwo";
          finalResult = add();
          break;
        case '-':
          finalResult = sub();
          break;
        case '×':
          finalResult = mul();
          break;
        case '/':
          finalResult = div();
          break;
      }

      preOpr = opr;
      opr = txtBtn;
      result = '';
    } else if (txtBtn == '%') {
      result = (numOne / 100).toString();
      finalResult = result;
    } else if (txtBtn == '.') {
      if (!result.contains('.')) {
        result += '.';
      }
      finalResult = result;
    } else if (txtBtn == '+/-') {
      result.startsWith('-')
          ? result = result.substring(1)
          : result = '-' + result;
      finalResult = result;
    } else {
      if (result == '0') {
        result = txtBtn;
      } else
        result = result + txtBtn;
      finalResult = result;
    }
    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return dotRemove(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return dotRemove(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return dotRemove(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return dotRemove(result);
  }

  String dotRemove(String _result) {
    if (_result.contains('.')) {
      List<String> split = _result.split('.');
      if (!(int.parse(split[1]) > 0)) {
        return split[0];
      }
    }
    return _result;
  }
}
