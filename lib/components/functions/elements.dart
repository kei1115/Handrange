import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Container CardBox(int n, String m){
  return Container(
    color: n == 0 ? Colors.black26 : Colors.white,
    child: Container(
      width: 40,
      height: 65,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: bigCard(n, m),
    ),
  );
}

// ignore: non_constant_identifier_names
Column bigCard(int number, String selectedMark) {
  String returnText(int n) {
    if (n == 0) {
      return "";
    }
    else if (n == 13) {
      return "K";
    }
    else if (n == 12) {
      return "Q";
    }
    else if (n == 11) {
      return "J";
    }
    else if (n == 10) {
      return "T";
    }
    else if (n == 1) {
      return "A";
    }
    else{
      return "$n";
    }
  }
  String returnMark(String m) {
    if (m == "") {
      return "";
    }
    else if (m == "s") {
      return "♠";
    }
    else if (m == "c") {
      return "♣";
    }
    else if (m == "h") {
      return "♥";
    }
    else if (m == "d") {
      return "♦";
    }
    else {
      return "error";
    }
  }
  return Column(
    children: [
      Center(
        child: Text(
          returnText(number),
          style: TextStyle(fontSize: 23,fontFamily: "PTS"),
        ),
      ),
      Center(
        child: Text(
          returnMark(selectedMark),
          style: TextStyle(fontSize: 23,fontFamily: "PTS"),
        ),
      ),
    ],
  );
}

Column smallCard(int number, String selectedMark){
  String returnText(int n) {
    if (n == 0) {
      return "";
    }
    else if (n == 13) {
      return "K";
    }
    else if (n == 12) {
      return "Q";
    }
    else if (n == 11) {
      return "J";
    }
    else if (n == 10) {
      return "T";
    }
    else if (n == 1) {
      return "A";
    }
    else{
      return "$n";
    }
  }
  String returnMark(String m) {
    if (m == "") {
      return "";
    }
    else if (m == "s") {
      return "♠";
    }
    else if (m == "c") {
      return "♣";
    }
    else if (m == "h") {
      return "♥";
    }
    else if (m == "d") {
      return "♦";
    }
    else{
      return "error";
    }
  }
  return Column(
    children: [
      Expanded(child: Text(returnText(number))),
      Expanded(child: Text(returnMark(selectedMark))),
    ],
  );
}