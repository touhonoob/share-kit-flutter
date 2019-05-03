import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_kit/src/elements/assets.dart';
import 'package:share_kit/src/types.dart' show RequestData;
import 'package:url_launcher/url_launcher.dart';

class RequestButton extends StatelessWidget {
  final RequestData requestData;
  final String buttonCallbackUrl;
  final double width;
  final double height;
  final VoidCallback requestButtonOnTapCallback;

  RequestButton(
      {@required this.requestData,
      @required this.buttonCallbackUrl,
      this.width = 300,
      this.height = 50,
      this.requestButtonOnTapCallback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          await onTap();
          if (requestButtonOnTapCallback != null) requestButtonOnTapCallback();
        },
        child: Container(
            height: this.height,
            width: this.width,
            child: FractionallySizedBox(
              widthFactor: 1.0,
              heightFactor: 1.0,
              child: Stack(fit: StackFit.expand, children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    gradient: LinearGradient(
                      begin: FractionalOffset.centerLeft,
                      end: FractionalOffset.centerRight,
                      colors: [
                        Color(0xff7A7CF3).withOpacity(1),
                        Color(0xff6262F6).withOpacity(1),
                      ],
                    ),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: MemoryImage(Assets.BACKGROUND_IMAGE),
                        repeat: ImageRepeat.noRepeat),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 24),
                    child: SvgPicture.string(Assets.LOCK_ICON_SVG,
                        width: 20,
                        height: 20,
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft)),
                Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 8),
                          child: SvgPicture.string(
                            Assets.BLOOM_LOGO_SVG,
                            width: 20,
                            height: 20,
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.center,
                          ),
                        ),
                        SvgPicture.string(Assets.TEXT_SVG,
                            width: 111,
                            height: 14,
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.center)
                      ],
                    ))
              ]),
            )));
  }

  @protected
  onTap() async {
    var url =
        'https://bloom.co/download?request=${base64.encode(utf8.encode(jsonEncode(requestData.toJson())))}&callback_url=${Uri.encodeComponent(buttonCallbackUrl)}&share-kit-from=button';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
