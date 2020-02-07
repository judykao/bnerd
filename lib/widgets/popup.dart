import 'package:flutter/material.dart';
//import 'package:share/share.dart';
import 'package:bnerd/model/db_wrapper.dart';
import 'package:bnerd/utils/utils.dart';

class Popup extends StatelessWidget {
  Function getTodosAndDones;

  Popup({this.getTodosAndDones});

  @override
  Widget build(BuildContext context) {
    /*String appUrl = Utils.getPlatformSpecificUrl(
        iOSUrl: kAppPortfolioApple, androidUrl: kGooglePlayUrl);
    String portfolioUrl = Utils.getPlatformSpecificUrl(
        iOSUrl: kAppPortfolioApple, androidUrl: kappPortfolioGoogle);*/

    return PopupMenuButton<int>(
        elevation: 4,
        icon: Icon(Icons.more_vert),
        onSelected: (value) {
          print('Selected value: $value');
          if (value == kMoreOptionsKeys.clearAll.index) {
            Utils.showCustomDialog(context,
                title: 'Are you sure?',
                msg: 'All done todos will be deleted permanently',
                onConfirm: () {
                  DBWrapper.sharedInstance.deleteAllDoneTodos();
                  getTodosAndDones();
                });
          }
        },
        itemBuilder: (context) {
          List list = List<PopupMenuEntry<int>>();

          for (int i = 0; i < kMoreOptionsMap.length; ++i) {
            list.add(PopupMenuItem(value: i, child: Text(kMoreOptionsMap[i])));

            if (i == 0) {
              list.add(PopupMenuDivider(
                height: 5,
              ));
            }
          }

          return list;
        });
  }
}