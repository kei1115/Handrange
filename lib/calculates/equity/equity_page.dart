import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handrange/calculates/components/board_boxes.dart';
import 'package:handrange/calculates/equity/components/player.dart';
import 'package:handrange/components/widgets/drawer.dart';
import 'models/calculation_model.dart';
import 'equity_select_page.dart';
import 'models/equity_page_model.dart';
import 'package:provider/provider.dart';

class EquityPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('エクイティ計算'),
      ),
      drawer: returnDrawer(context),
      body: Consumer<EquityPageModel>(builder: (context, model, child) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 16),
              child: BoardBoxes(
                boardCard: model.boardCard,
                selectPage: EquitySelectPage(cardList: model.cards, name: 'board'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RaisedButton(
                  child: Text('クリア'),
                  onPressed: () => model.onClear(),
                ),
                RaisedButton(
                    child: Text('計算'),
                    onPressed: () {
                    }
                )
              ],
            ),
            Player(num: 1, cardHole: model.cardHole1, range: model.status1),
            Player(num: 2, cardHole: model.cardHole2, range: model.status2),
          ],
        );
      }),
    );
  }
}
