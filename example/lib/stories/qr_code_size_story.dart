import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:qr/qr.dart';
import 'package:share_kit/share_kit.dart';
import 'package:storyboard/storyboard.dart';

import 'defaults.dart';

/// Basic button demo
class QrCodeSizeStory extends Story {
  @override
  List<Widget> get storyContent => [
        Container(
            child: RequestQRCode(
          requestData: Defaults.defaultData,
          qrOptions: QROptions(
            size: 300,
          ),
        ))
      ];
}