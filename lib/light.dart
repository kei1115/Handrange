import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:handrange/combination.dart';
import 'package:handrange/sql.dart';

class Light extends ChangeNotifier {
  List<Map<String, dynamic>> status = CONBI.map((e) => {
    "hand": e["hand"],
    "value": e["value"],
    "isSelected": false,
  }).toList();

  int tablenumber;
  bool isPocket = false;
  bool isAce = false;
  bool isKing = false;
  bool isQueen = false;
  bool isJack = false;
  double count = 0;
  List<Graph> graphs =[];

  onSave() async {
    List<String> TF = new List<String>();
    String TFText = "";
    List<Map<String, dynamic>> inputTF = status.map((e) =>
    {
      "isSelected": e["isSelected"],
    }).toList();

    inputTF.forEach((element) {
      String isSelected;
      if (element["isSelected"] == true){
        isSelected = "T";
      }
      else {
        isSelected = "F";
      }
      TF.add(isSelected);
    });

    for(int i = 0; i <= 168; i++ ) {
      TFText +="${TF[i]}";
    }

    Graph graph = Graph(text: TFText);
    await Graph.insertGraph(graph);
    notifyListeners();
  }

  onUpdate1() async {
    List<String> TF = new List<String>();
    String TFText = "";
    List<Map<String, dynamic>> inputTF = status.map((e) =>
    {
      "isSelected": e["isSelected"],
    }).toList();

    inputTF.forEach((element) {
      String isSelected;
      if (element["isSelected"] == true){
        isSelected = "T";
      }
      else {
        isSelected = "F";
      }
      TF.add(isSelected);
    });

    for(int i = 0; i <= 168; i++ ) {
      TFText +="${TF[i]}";
    }

    Graph graph = Graph(id: 1, text: TFText);
    await Graph.updateGraph(graph);
    print(graph);
  }

  onGet1() async {
    tablenumber = 0;
    graphs = await Graph.getGraph();
    int i;
    String graph = graphs[0].text;
    print(graph);
    for(i = 0; i <= 168; i++){
      String isLighted = graph[i];
      if(isLighted == "T"){
        status[i].removeWhere((key, value) => value == false || value == true);
        status[i].addAll(
            <String,bool>{
              "isSelected": true,
            }
        );
      }
      else if (isLighted == "F"){
        status[i].removeWhere((key, value) => value == false || value == true);
        status[i].addAll(
            <String,dynamic>{
              "isSelected": false,
            }
        );
      }
    }
    print(graphs);
    print(status);
    notifyListeners();
  }

  onDelete(int id) async {
    await Graph.deleteGraph(id);
  }

  onTapped(String hand) {
    status.forEach((element) {
      if (element["hand"] == hand) {
        element["isSelected"] = !element["isSelected"];
        element["isSelected"] ? count = count + element["value"] : count = count - element["value"];
      }
    }
    );
    notifyListeners();
  }

  onPocket() {
    isPocket = !isPocket;
    status.forEach((element) {
      if (element["hand"].length == 2) {
        element["isSelected"] = isPocket;
        isPocket ? count = count + element["value"] : count = count - element["value"];
      }
    }
    );
    notifyListeners();
  }

  onAhigh() {
    isAce = !isAce;
    status.forEach((element) {
      String hand = element["hand"];
      if (hand.startsWith('A')) {
        element["isSelected"] = isAce;
        isAce ? count = count + element["value"] : count = count - element["value"];
      }
    }
    );
    notifyListeners();
  }

  onKhigh() {
    isKing = !isKing;
    status.forEach((element) {
      String hand = element["hand"];
      if (hand.startsWith('K') || hand.endsWith('Ks') || hand.endsWith('Ko') ) {
        element["isSelected"] = isKing;
        isKing ? count = count + element["value"] : count = count - element["value"];
      }
    }
    );
    notifyListeners();
  }

  onQhigh() {
    isQueen = !isQueen;
    status.forEach((element) {
      String hand = element["hand"];
      if (hand.startsWith('Q') || hand.endsWith('Qs') || hand.endsWith('Qo')) {
        element["isSelected"] = isQueen;
        isQueen ? count = count + element["value"] : count = count - element["value"];
      }
    }
    );
    notifyListeners();
  }

  onJhigh() {
    isJack = !isJack;
    status.forEach((element) {
      String hand = element["hand"];
      if (hand.startsWith('J') || hand.endsWith('Js') || hand.endsWith('Jo')) {
        element["isSelected"] = isJack;
        isJack ? count = count + element["value"] : count = count - element["value"];
      }
    }
    );
    notifyListeners();
  }

  List<Map<String, dynamic>> TF = CONBI.map((e) => {
    "hand": e["hand"],
    "value": e["value"],
  }).toList();

  List <List> TFs = [];
  Map numbers_map = {};
  List <Map<dynamic,dynamic>> numbers = [{
    "id" : 0
  },{
    "id" : 1
  },{
    "id" : 2
  }];

  Creategraphs() async {
    final List<Graph> graphs = await Graph.getGraph();
    int i, j;
    //print(graphs);
    for (j = 0; j < graphs.length ; j++) {
      String graph = graphs[j].text;
      //print(graph);
      for (i = 0; i <= 168; i++) {
        String isLighted = graph[i];
        //print(isLighted);
        if (isLighted == "T") {
          TF[i].addAll(
              <String, bool>{
                "isSelected": true,
              }
          );
        }
        else if (isLighted == "F") {
          TF[i].addAll(
              <String, bool>{
                "isSelected": false,
              }
          );
        }
        //print(TF[i]);
      }
      TFs.add(TF);
      //print(TFs);
      // numbers_map.addAll(
      //     <dynamic,dynamic>{
      //       "id": j
      //     }
      // );
      // numbers.add(numbers_map);
    }
    notifyListeners();
  }
}

