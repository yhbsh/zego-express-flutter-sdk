import 'dart:io';

import 'package:flutter/material.dart';

/// Native implementation of [createPlatformView]
class ZegoExpressPlatformViewImpl {
  /// Create a PlatformView and return the view ID
  static Widget? createPlatformView(Function(int viewID) onViewCreated, {Key? key}) {
    if (Platform.isIOS) return UiKitView(key: key, viewType: 'plugins.zego.im/zego_express_view', onPlatformViewCreated: (viewID) => onViewCreated(viewID));
    if (Platform.isMacOS) return UiKitView(key: key, viewType: 'plugins.zego.im/zego_express_view', onPlatformViewCreated: (viewID) => onViewCreated(viewID));
    if (Platform.isAndroid) return AndroidView(key: key, viewType: 'plugins.zego.im/zego_express_view', onPlatformViewCreated: (viewID) => onViewCreated(viewID));

    return null;
  }
}
