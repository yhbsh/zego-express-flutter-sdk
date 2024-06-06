import 'impl/zego_express_impl.dart';
import 'zego_express_api.dart';

extension ZegoExpressAssetsUtils on ZegoExpressEngine {
  /// Get the actual absolute path of the asset through the relative path of the asset
  ///
  /// - [assetPath] The resource path configured in the `flutter` -> `assets` field of pubspec.yaml, for example: assets/icon/setting.png
  /// - Returns the actual absolute path of the asset
  Future<String?> getAssetAbsolutePath(String assetPath) async {
    return await ZegoExpressImpl.methodChannel.invokeMethod('getAssetAbsolutePath', {'assetPath': assetPath});
  }
}
