import 'package:flutter/material.dart';
import 'package:handrange/calculatepage.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:handrange/light.dart';
import 'package:handrange/combination.dart';
import 'calculation.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Handrange',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: SelectPage(),
    );
  }
}

class SelectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Consumer<Light>(builder: (context, model, child) {
        return
          Scaffold(
            appBar: AppBar(
              title: Text('Handrange'),
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text(
                      'Drawer Header',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    onTap: () {
                      Navigator.pushNamed(context, '/');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.graphic_eq_sharp),
                    title: Text('Graphs'),
                    onTap: () async {
                      await model.createGraphs();
                      await Navigator.pushNamed(context, '/save');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.file_copy),
                    title: Text('Calculate'),
                    onTap: () async {
                      await model.createGraphs();
                      await Navigator.pushNamed(context, '/calculate');
                    },
                  ),
                ],
              ),
            ),
            body: SelectCards(),
          );
      });
  }
}

class SelectCards extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return
      Consumer<Light>(builder: (context, model, child) {
        return
          Column(
            children: [
              CardBoxes(),
              Buttons(),
            ],
          );
      });
  }
}

class Buttons extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return
      Container(
        child: Consumer<Light>(builder: (context, model, child) {
          return
            GridView.count(
                crossAxisCount: 13,
                mainAxisSpacing: 0.001,
                crossAxisSpacing: 0.001,
                childAspectRatio: 0.78,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: CARDS.map((e) => GridTile(
                  child: Button(num: e["num"], mark: e["mark"], card: e["card"]),
                ),
                ).toList()
            );
        }),
      );
  }
}

class Button extends StatelessWidget{
  Button( {Key key,  this.num, this.mark,  this.card }) : super(key: key);
  int num;
  String mark;
  String card;

  @override
  Widget build(BuildContext context) {
    return
      Container(
        child: Consumer<Calculation>(builder: (context, model, child) {
          return
            GestureDetector(
                onTap: () =>{
                  if(model.num1 == null){
                    model.num1 = num,
                    model.mark1 = mark,
                    model.card1 = card,
                    Navigator.pushNamed(context, '/calculate')
                  }
                  else if(model.num2 == null && model.card1 != card){
                    model.num2 = num,
                    model.mark2 = mark,
                    model.card2 = card,
                    Navigator.pushNamed(context, '/calculate')
                  }
                  else if(model.num3 == null && model.card1 != card && model.card2 != card){
                      model.num3 = num,
                      model.mark3 = mark,
                      model.card3 = card,
                      Navigator.pushNamed(context, '/calculate')
                    }
                    else if(model.num4 == null && model.card1 != card && model.card2 != card && model.card3 != card ){
                        model.num4 = num,
                        model.mark4 = mark,
                        model.card4 = card,
                        Navigator.pushNamed(context, '/calculate')
                      }
                      else if(model.num5 == null && model.card1 != card && model.card2 != card && model.card3 != card && model.card4 != card){
                          model.num5 = num,
                          model.mark5 = mark,
                          model.card5 = card,
                          Navigator.pushNamed(context, '/calculate')
                        }
                },
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: returnCard(num, mark)
                )
            );
        }),
      );
  }
}