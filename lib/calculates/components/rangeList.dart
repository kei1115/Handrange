import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handrange/calculates/components/saved_range.dart';
import 'package:handrange/components/functions/creategraph.dart';
import 'package:handrange/data/sql.dart';

class RangeList extends StatefulWidget {
  RangeList({
    Key? key,
    required this.range,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.crossAxisCount = 2,
    required this.mainAxisSpacing,
    required this.crossAxisSpacing,
    required this.childAspectRatio,
  }) : super(key: key);

  final List<Map<String, dynamic>> range;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;

  @override
  _RangeListState createState() => _RangeListState();
}

class _RangeListState extends State<RangeList>{
  final Future<List<Graph>> rangeList = Graph.getGraph();

  @override
  Widget build(BuildContext context) {
    double screenSizeWidth = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: rangeList,
        builder: (BuildContext context, AsyncSnapshot<List<Graph>> snapshot) {
          if (snapshot.hasData) {
            return Container(
              padding: widget.padding,
              margin: widget.margin,
              width: screenSizeWidth,
              child: GridView.count(
                crossAxisCount: widget.crossAxisCount,
                mainAxisSpacing: widget.mainAxisSpacing,
                crossAxisSpacing: widget.crossAxisSpacing,
                childAspectRatio: widget.childAspectRatio,
                children: getRangeListFromSQL(snapshot).map((e) =>
                    GridTile(
                      child: SavedRange(
                        num: e["num"],
                        text: e["text"],
                        name: e["name"],
                        count: e["count"],
                        onPressed: () {
                          getRangeFromSQL(e['id'], widget.range, snapshot.data);
                          Navigator.pop(context);
                        }
                      ),
                    ),
                ).toList(),
              ),
            );
          }
          else if(snapshot.hasError){
            return Center(child: Text("Error"));
          }
          else{
            return Center(child: CircularProgressIndicator());
          }
        }
    );
  }
}