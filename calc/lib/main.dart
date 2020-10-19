import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}
class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic displaytxt = 20;
  //Button Widget
  Widget calcbutton(String btntxt,Color btncolor,Color txtcolor){
    return  Container(
      height: 100,
      width: 100,
      child: RaisedButton(
        onPressed: (){
          calculation(btntxt);
        },
        child: Text('$btntxt',
          style: TextStyle(
            fontSize: 25,
            color: txtcolor,
          ),
        ),
        shape: RoundedRectangleBorder(),
        color: btncolor,
        padding: EdgeInsets.all(25),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    //Calculator

    return Scaffold(

      backgroundColor: Colors.grey[700].withOpacity(0.9),


      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // Calculator display
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('$text',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 100,
                        fontWeight: FontWeight.w200
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('C',Colors.grey[600].withOpacity(0.7),Colors.white),
                calcbutton('+/-',Colors.grey[600].withOpacity(0.7),Colors.white),
                calcbutton('%',Colors.grey[600].withOpacity(0.7),Colors.white),
                calcbutton('÷',Colors.amber[700],Colors.white),
              ],
            ),
            SizedBox(height: 2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('7',Colors.grey[600],Colors.white),
                calcbutton('8',Colors.grey[600],Colors.white),
                calcbutton('9',Colors.grey[600],Colors.white),
                calcbutton('x',Colors.amber[700],Colors.white),
              ],
            ),
            SizedBox(height: 2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('4',Colors.grey[600],Colors.white),
                calcbutton('5',Colors.grey[600],Colors.white),
                calcbutton('6',Colors.grey[600],Colors.white),
                calcbutton('-',Colors.amber[700],Colors.white),
              ],
            ),
            SizedBox(height: 2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('1',Colors.grey[600],Colors.white),
                calcbutton('2',Colors.grey[600],Colors.white),
                calcbutton('3',Colors.grey[600],Colors.white),
                calcbutton('+',Colors.amber[700],Colors.white),
              ],
            ),
            SizedBox(height: 2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //this is button Zero
                RaisedButton(
                  padding: EdgeInsets.fromLTRB(53, 35, 128, 20),
                  onPressed: (){
                    calculation('0');
                  },
                  shape: RoundedRectangleBorder(),
                  child: Text('0',
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.white),
                  ),
                  color: Colors.grey[600],
                ),
                calcbutton('.',Colors.grey[600],Colors.white),
                calcbutton('=',Colors.amber[700],Colors.white),
              ],
            ),
            SizedBox(height: 2,),
          ],
        ),
      ),
    );
  }

  //Calculator logic
  dynamic text ='0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {


    if(btnText  == 'C') {
      text ='0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';

    } else if( opr == '=' && btnText == '=') {

      if(preOpr == '+') {
        finalResult = add();
      } else if( preOpr == '-') {
        finalResult = sub();
      } else if( preOpr == 'x') {
        finalResult = mul();
      } else if( preOpr == '÷') {
        finalResult = div();
      }

    } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '÷' || btnText == '=') {

      if(numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if(opr == '+') {
        finalResult = add();
      } else if( opr == '-') {
        finalResult = sub();
      } else if( opr == 'x') {
        finalResult = mul();
      } else if( opr == '÷') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    }
    else if(btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      finalResult = result;
    }

    else if(btnText == '+/-') {
      result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-'+result.toString();
      finalResult = result;

    }

    else {
      result = result + btnText;
      finalResult = result;
    }


    setState(() {
      text = finalResult;
    });

  }


  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }


  String doesContainDecimal(dynamic result) {

    if(result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if(!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }

}