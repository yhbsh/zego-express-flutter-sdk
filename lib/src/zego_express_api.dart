
import 'dart:typed_data';
import 'zego_express_impl.dart';
import 'zego_express_defines.dart';

class ZegoExpressEngine {

  /// Private constructor
  ZegoExpressEngine._internal();

  /// Engine singleton instance
  static final ZegoExpressEngine instance = ZegoExpressEngine._internal();

  /// Creates a singleton instance of ZegoExpressEngine.
  ///
  /// The engine needs to be created and initialized before calling other functions. The SDK only supports the creation of one instance of ZegoExpressEngine. Multiple calls to this function return the same object.
  ///
  /// - [profile] The basic configuration information is used to create the engine.
  static Future<void> createEngineWithProfile(ZegoEngineProfile profile) async {
    return await ZegoExpressImpl.createEngineWithProfile(profile);
  }

  /// [Deprecated] Creates a singleton instance of ZegoExpressEngine.
  ///
  /// Deprecated since 2.13.0, please use the method with the same name without [isTestEnv] parameter instead.
  /// The engine needs to be created and initialized before calling other functions. The SDK only supports the creation of one instance of ZegoExpressEngine. Multiple calls to this function return the same object.
  ///
  /// @deprecated Deprecated since 2.13.0, please use the method with the same name without [isTestEnv] parameter instead.
  /// - [appID] Application ID issued by ZEGO for developers, please apply from the ZEGO Admin Console https://console-express.zego.im The value ranges from 0 to 4294967295.
  /// - [appSign] Application signature for each AppID, please apply from the ZEGO Admin Console. Application signature is a 64 character string. Each character has a range of '0' ~ '9', 'a' ~ 'z'.
  /// - [isTestEnv] Choose to use a test environment or a formal commercial environment, the formal environment needs to submit work order configuration in the ZEGO management console. The test environment is for test development, with a limit of 10 rooms and 50 users. Official environment App is officially launched. ZEGO will provide corresponding server resources according to the configuration records submitted by the developer in the management console. The test environment and the official environment are two sets of environments and cannot be interconnected.
  /// - [scenario] The application scenario. Developers can choose one of ZegoScenario based on the scenario of the app they are developing, and the engine will preset a more general setting for specific scenarios based on the set scenario. After setting specific scenarios, developers can still call specific functions to set specific parameters if they have customized parameter settings.
  /// - [enablePlatformView] Set whether to use Platform View for rendering, true: rendering using Platform View, false: rendering using Texture, default is false
  @Deprecated('Deprecated since 2.13.0, please use the method with the same name without [isTestEnv] parameter instead.')
  static Future<void> createEngine(int appID, String appSign, bool isTestEnv, ZegoScenario scenario, {bool? enablePlatformView}) async {
    return await ZegoExpressImpl.createEngine(appID, appSign, isTestEnv, scenario, enablePlatformView: enablePlatformView);
  }

  /// Destroys the singleton instance of ZegoExpressEngine asynchronously.
  ///
  /// Used to release resources used by ZegoExpressEngine.
  static Future<void> destroyEngine() async {
    return await ZegoExpressImpl.destroyEngine();
  }

  /// Set advanced engine configuration.
  ///
  /// Available since: 1.1.0
  /// Description: Used to enable advanced functions.
  /// When to call: Different configurations have different call timing requirements. For details, please consult ZEGO technical support.
  /// Restrictions: None.
  ///
  /// - [config] Advanced engine configuration
  static Future<void> setEngineConfig(ZegoEngineConfig config) async {
    return await ZegoExpressImpl.setEngineConfig(config);
  }

  /// Set room mode.
  ///
  /// Available since: 2.9.0
  /// Description: If you need to use the multi-room feature, please call this function to complete the configuration.
  /// When to call: Must be set before calling [createEngine] to take effect, otherwise it will fail.
  /// Restrictions: If you need to use the multi-room feature, please contact the instant technical support to configure the server support.
  /// Caution: None.
  ///
  /// - [mode] Room mode. Description: Used to set the room mode. Use cases: If you need to enter multiple rooms at the same time for publish-play stream, please turn on the multi-room mode through this interface. Required: True. Default value: ZEGO_ROOM_MODE_SINGLE_ROOM.
  static Future<void> setRoomMode(ZegoRoomMode mode) async {
    return await ZegoExpressImpl.setRoomMode(mode);
  }

  /// Gets the SDK's version number.
  ///
  /// Available since: 1.1.0
  /// Description: If you encounter an abnormality during the running of the SDK, you can submit the problem, log and other information to the ZEGO technical staff to locate and troubleshoot. Developers can also collect current SDK version information through this API, which is convenient for App operation statistics and related issues.
  /// When to call: Any time.
  /// Restrictions: None.
  /// Caution: None.
  ///
  /// - Returns SDK version.
  static Future<String> getVersion() async {
    return await ZegoExpressImpl.getVersion();
  }

  /// Uploads logs to the ZEGO server.
  ///
  /// Available since: 1.1.0
  /// Description: By default, SDK creates and prints log files in the App's default directory. Each log file defaults to a maximum of 5MB. Three log files are written over and over in a circular fashion. When calling this function, SDK will auto package and upload the log files to the ZEGO server.
  /// Use cases: Developers can provide a business “feedback” channel in the App. When users feedback problems, they can call this function to upload the local log information of SDK to help locate user problems.
  /// When to call: After [createEngine].
  /// Restrictions: If you call this interface repeatedly within 10 minutes, only the last call will take effect.
  /// Caution: After calling this interface to upload logs, if you call [destroyEngine] or exit the App too quickly, there may be a failure.It is recommended to wait a few seconds, and then call [destroyEngine] or exit the App after receiving the upload success callback.
  Future<void> uploadLog() async {
    return await ZegoExpressImpl.instance.uploadLog();
  }

  /// Call the RTC experimental API.
  ///
  /// Available since: 2.7.0
  /// Description: ZEGO provides some technical previews or special customization functions in RTC business through this API. If you need to get the use of the function or the details, please consult ZEGO technical support.
  /// When to call: After [createEngine].
  ///
  /// - [params] You need to pass in a parameter in the form of a JSON string, please consult ZEGO technical support for details.
  /// - Returns Returns an argument in the format of a JSON string, please consult ZEGO technical support for details.
  Future<String> callExperimentalAPI(String params) async {
    return await ZegoExpressImpl.instance.callExperimentalAPI(params);
  }

  /// Set the path of the static picture would be published when the camera is closed.
  ///
  /// Available: since 2.9.0
  /// Description: Set the path of the static picture would be published when enableCamera(false) is called, it would start to publish static pictures, and when enableCamera(true) is called, it would end publishing static pictures.
  /// Use case: The developer wants to display a static picture when the camera is closed. For example, when the anchor exits the background, the camera would be actively closed. At this time, the audience side needs to display the image of the anchor temporarily leaving.
  /// When to call: After the engine is initialized, call this API to configure the parameters before closing the camera.
  /// Restrictions: 1. Supported picture types are JPEG/JPG, PNG, BMP, HEIF. 2. The function is only for SDK video capture and does not take effect for custom video capture.
  /// Caution: 1. The static picture cannot be seen in the local preview. 2. External filters, mirroring, watermarks, and snapshots are all invalid. 3. If the picture aspect ratio is inconsistent with the set code aspect ratio, it will be cropped according to the code aspect ratio.
  /// Platform differences: 1. Windows: Fill in the location of the picture directly, such as "D://dir//image.jpg". 2. iOS: If it is a full path, add the prefix "file:", such as @"file:/var/image.png"; If it is a assets picture path, add the prefix "asset:", such as @"asset:watermark". 3. Android: If it is a full path, add the prefix "file:", such as "file:/sdcard/image.png"; If it is a assets directory path, add the prefix "asset:", such as "asset:watermark.png".
  ///
  /// - [filePath] Picture file path
  /// - [channel] Publish channel.
  Future<void> setDummyCaptureImagePath(String filePath, ZegoPublishChannel channel) async {
    return await ZegoExpressImpl.instance.setDummyCaptureImagePath(filePath, channel);
  }

  /// The callback for obtaining debugging error information.
  ///
  /// Available since: 1.1.0
  /// Description: When the SDK functions are not used correctly, the callback prompts for detailed error information.
  /// Trigger: Notify the developer when an exception occurs in the SDK.
  /// Restrictions: None.
  /// Caution: None.
  ///
  /// - [errorCode] Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
  /// - [funcName] Function name.
  /// - [info] Detailed error information.
  static void Function(int errorCode, String funcName, String info)? onDebugError;

  /// Method execution result callback
  ///
  /// Available since: 2.3.0
  /// Description: When the monitoring is turned on through [setApiCalledCallback], the results of the execution of all methods will be called back through this callback.
  /// Trigger: When the developer calls the SDK method, the execution result of the method is called back.
  /// Restrictions: None.
  /// Caution: It is recommended to monitor and process this callback in the development and testing phases, and turn off the monitoring of this callback after going online.
  ///
  /// - [errorCode] Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
  /// - [funcName] Function name.
  /// - [info] Detailed error information.
  static void Function(int errorCode, String funcName, String info)? onApiCalledResult;

  /// The callback triggered when the audio/video engine state changes.
  ///
  /// When the developer calls the function that enables audio and video related functions, such as calling [startPreview], [startPublishingStream], [startPlayingStream] and MediaPlayer related function, the audio/video engine will start; when all audio and video functions are stopped, the engine state will become stopped.
  /// When the developer has been [loginRoom], once [logoutRoom] is called, the audio/video engine will stop (preview, publishing/playing stream, MediaPlayer and other audio and video related functions will also stop).
  ///
  /// - [state] The audio/video engine state
  static void Function(ZegoEngineState state)? onEngineStateUpdate;

  /// Successful callback of network time synchronization..
  ///
  /// Available since: 2.12.0
  /// This callback is triggered when internal network time synchronization completes after a developer calls [createEngine].
  static void Function()? onNetworkTimeSynchronized;

  /// The callback triggered when the room connection state changes.
  ///
  /// Available since: 1.1.0
  /// Description: This callback is triggered when the connection status of the room changes, and the reason for the change is notified.
  /// Use cases: Developers can use this callback to determine the status of the current user in the room.
  /// When to call /Trigger: Users will receive this notification when they call [loginRoom], [logoutRoom], [switchRoom] functions. 2. This notification may also be received when the user device's network conditions change (SDK will automatically log in to the room again when the connection is disconnected, refer to https://doc-zh.zego.im/faq/reconnect ).
  /// Restrictions: None.
  /// Caution: If the connection is being requested for a long time, the general probability is that the user's network is unstable.
  /// Related APIs: [loginRoom]、[logoutRoom]、[switchRoom]
  ///
  /// - [roomID] Room ID, a string of up to 128 bytes in length.
  /// - [state] Changed room state
  /// - [errorCode] Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
  /// - [extendedData] Extended Information with state updates. When the room login is successful, the key "room_session_id" can be used to obtain the unique RoomSessionID of each audio and video communication, which identifies the continuous communication from the first user in the room to the end of the audio and video communication. It can be used in scenarios such as call quality scoring and call problem diagnosis.
  static void Function(String roomID, ZegoRoomState state, int errorCode, Map<String, dynamic> extendedData)? onRoomStateUpdate;

  /// The callback triggered when the number of other users in the room increases or decreases.
  ///
  /// This callback is used to monitor the increase or decrease of other users in the room, and the developer can judge the situation of the users in the room based on this callback.
  /// If developers need to use ZEGO room users notifications, please ensure that the [ZegoRoomConfig] sent by each user when logging in to the room has the [isUserStatusNotify] property set to true, otherwise the callback notification will not be received.
  /// The user logs in to the room, and there is no other user in the room at this time, the callback will not be triggered.
  /// The user logs in to the room. If multiple other users already exist in the room, the callback will be triggered. At this time, the callback belongs to the ADD type and contains the full list of users in the room. At the same time, other users in the room will also receive this callback of the ADD type, but there are only new current users in the received user list.
  /// When the user is already in the room, this callback will be triggered when other users in the room log in or log out of the room.
  ///
  /// - [roomID] Room ID where the user is logged in, a string of up to 128 bytes in length.
  /// - [updateType] Update type (add/delete)
  /// - [userList] List of users changed in the current room
  static void Function(String roomID, ZegoUpdateType updateType, List<ZegoUser> userList)? onRoomUserUpdate;

  /// The callback triggered every 30 seconds to report the current number of online users.
  ///
  /// Available since: 1.7.0
  /// Description: This method will notify the user of the current number of online users in the room..
  /// Use cases: Developers can use this callback to show the number of user online in the current room.
  /// When to call /Trigger: After successfully logging in to the room.
  /// Restrictions: None.
  /// Caution: 1. This function is called back every 30 seconds. 2. Because of this design, when the number of users in the room exceeds 500, there will be some errors in the statistics of the number of online people in the room.
  ///
  /// - [roomID] Room ID where the user is logged in, a string of up to 128 bytes in length.
  /// - [count] Count of online users.
  static void Function(String roomID, int count)? onRoomOnlineUserCountUpdate;

  /// The callback triggered when the number of streams published by the other users in the same room increases or decreases.
  ///
  /// Available since: 1.1.0
  /// This callback is used to monitor stream addition or stream deletion notifications of other users in the room. Developers can use this callback to determine whether other users in the same room start or stop publishing stream, so as to achieve active playing stream [startPlayingStream] or take the initiative to stop the playing stream [stopPlayingStream], and use it to change the UI controls at the same time.
  /// The user logs in to the room, and there is no other stream in the room at this time, the callback will not be triggered.
  /// The user logs in to the room. If there are multiple streams of other users in the room, the callback will be triggered. At this time, the callback belongs to the ADD type and contains the full list of streams in the room.
  /// When the user is already in the room, when other users in the room start or stop publishing stream (that is, when a stream is added or deleted), this callback will be triggered to notify the changed stream list.
  ///
  /// - [roomID] Room ID where the user is logged in, a string of up to 128 bytes in length.
  /// - [updateType] Update type (add/delete)
  /// - [streamList] Updated stream list
  /// - [extendedData] Extended information with stream updates.
  static void Function(String roomID, ZegoUpdateType updateType, List<ZegoStream> streamList, Map<String, dynamic> extendedData)? onRoomStreamUpdate;

  /// The callback triggered when there is an update on the extra information of the streams published by other users in the same room.
  ///
  /// Available since: 1.1.0
  /// Description: All users in the room will be notified by this callback when the extra information of the stream in the room is updated.
  /// Use cases: Users can realize some business functions through the characteristics of stream extra information consistent with stream life cycle.
  /// When to call /Trigger: When a user publishing the stream update the extra information of the stream in the same room, other users in the same room will receive the callback.
  /// Restrictions: None.
  /// Caution: Unlike the stream ID, which cannot be modified during the publishing process, the stream extra information can be updated during the life cycle of the corresponding stream ID.
  /// Related APIs: Users who publish stream can set extra stream information through [setStreamExtraInfo].
  ///
  /// - [roomID] Room ID where the user is logged in, a string of up to 128 bytes in length.
  /// - [streamList] List of streams that the extra info was updated.
  static void Function(String roomID, List<ZegoStream> streamList)? onRoomStreamExtraInfoUpdate;

  /// The callback triggered when there is an update on the extra information of the room.
  ///
  /// Available since: 1.1.0
  /// Description: After the room extra information is updated, all users in the room will be notified except update the room extra information user.
  /// Use cases: Extra information for the room.
  /// When to call /Trigger: When a user update the room extra information, other users in the same room will receive the callback.
  /// Restrictions: None.
  /// Related APIs: Users can update room extra information through [setRoomExtraInfo] function.
  ///
  /// - [roomID] Room ID where the user is logged in, a string of up to 128 bytes in length.
  /// - [roomExtraInfoList] List of the extra info updated.
  static void Function(String roomID, List<ZegoRoomExtraInfo> roomExtraInfoList)? onRoomExtraInfoUpdate;

  /// Callback notification that room Token authentication is about to expire.
  ///
  /// Available since: 2.8.0
  /// Description: The callback notification that the room Token authentication is about to expire, please use [renewToken] to update the room Token authentication.
  /// Use cases: In order to prevent illegal entry into the room, it is necessary to perform authentication control on login room, push streaming, etc., to improve security.
  /// When to call /Trigger: 30 seconds before the Token expires, the SDK will call [onRoomTokenWillExpire] to notify developer.
  /// Restrictions: None.
  /// Caution: The token contains important information such as the user's room permissions, publish stream permissions, and effective time, please refer to https://doc-en.zego.im/article/11649.
  /// Related APIs: When the developer receives this callback, he can use [renewToken] to update the token authentication information.
  ///
  /// - [roomID] Room ID where the user is logged in, a string of up to 128 bytes in length.
  /// - [remainTimeInSecond] The remaining time before the token expires.
  static void Function(String roomID, int remainTimeInSecond)? onRoomTokenWillExpire;

  /// The callback triggered when the state of stream publishing changes.
  ///
  /// Available since: 1.1.0
  /// Description: After calling the [startPublishingStream] successfully, the notification of the publish stream state change can be obtained through the callback function. You can roughly judge the user's uplink network status based on whether the state parameter is in [PUBLISH_REQUESTING].
  /// Caution: The parameter [extendedData] is extended information with state updates. If you use ZEGO's CDN content distribution network, after the stream is successfully published, the keys of the content of this parameter are [flv_url_list], [rtmp_url_list], [hls_url_list], these correspond to the publishing stream URLs of the flv, rtmp, and hls protocols.
  /// Related callbacks: After calling the [startPlayingStream] successfully, the notification of the play stream state change can be obtained through the callback function [onPlayerStateUpdate]. You can roughly judge the user's downlink network status based on whether the state parameter is in [PLAY_REQUESTING].
  ///
  /// - [streamID] Stream ID.
  /// - [state] State of publishing stream.
  /// - [errorCode] The error code corresponding to the status change of the publish stream, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
  /// - [extendedData] Extended information with state updates.
  static void Function(String streamID, ZegoPublisherState state, int errorCode, Map<String, dynamic> extendedData)? onPublisherStateUpdate;

  /// Callback for current stream publishing quality.
  ///
  /// Available since: 1.1.0
  /// Description: After calling the [startPublishingStream] successfully, the callback will be received every 3 seconds default(If you need to change the time, please contact the instant technical support to configure). Through the callback, the collection frame rate, bit rate, RTT, packet loss rate and other quality data of the published audio and video stream can be obtained, and the health of the publish stream can be monitored in real time.You can monitor the health of the published audio and video streams in real time according to the quality parameters of the callback function, in order to show the uplink network status in real time on the device UI.
  /// Caution: If you does not know how to use the parameters of this callback function, you can only pay attention to the [level] field of the [quality] parameter, which is a comprehensive value describing the uplink network calculated by SDK based on the quality parameters.
  /// Related callbacks: After calling the [startPlayingStream] successfully, the callback [onPlayerQualityUpdate] will be received every 3 seconds. You can monitor the health of play streams in real time based on quality data such as frame rate, code rate, RTT, packet loss rate, etc.
  ///
  /// - [streamID] Stream ID.
  /// - [quality] Publishing stream quality, including audio and video framerate, bitrate, RTT, etc.
  static void Function(String streamID, ZegoPublishStreamQuality quality)? onPublisherQualityUpdate;

  /// The callback triggered when the first audio frame is captured.
  ///
  /// Available since: 1.1.0
  /// Description: After the [startPublishingStream] function is called successfully, this callback will be called when SDK received the first frame of audio data. Developers can use this callback to determine whether SDK has actually collected audio data. If the callback is not received, the audio capture device is occupied or abnormal.
  /// Trigger: In the case of no startPublishingStream audio and video stream or preview [startPreview], the first startPublishingStream audio and video stream or first preview, that is, when the engine of the audio and video module inside SDK starts, it will collect audio data of the local device and receive this callback.
  /// Related callbacks: After the [startPublishingStream] function is called successfully, determine if the SDK actually collected video data by the callback function [onPublisherCapturedVideoFirstFrame], determine if the SDK has rendered the first frame of video data collected by calling back [onPublisherRenderVideoFirstFrame].
  static void Function()? onPublisherCapturedAudioFirstFrame;

  /// The callback triggered when the first video frame is captured.
  ///
  /// Available since: 1.1.0
  /// Description: After the [startPublishingStream] function is called successfully, this callback will be called when SDK received the first frame of video data. Developers can use this callback to determine whether SDK has actually collected video data. If the callback is not received, the video capture device is occupied or abnormal.
  /// Trigger: In the case of no startPublishingStream video stream or preview, the first startPublishingStream video stream or first preview, that is, when the engine of the audio and video module inside SDK starts, it will collect video data of the local device and receive this callback.
  /// Related callbacks: After the [startPublishingStream] function is called successfully, determine if the SDK actually collected audio data by the callback function [onPublisherCapturedAudioFirstFrame], determine if the SDK has rendered the first frame of video data collected by calling back [onPublisherRenderVideoFirstFrame].
  ///
  /// - [channel] Publishing stream channel.If you only publish one audio and video stream, you can ignore this parameter.
  static void Function(ZegoPublishChannel channel)? onPublisherCapturedVideoFirstFrame;

  /// The callback triggered when the first video frame is rendered.
  ///
  /// Available since: 2.4.0
  /// Description: this callback will be called after SDK rendered the first frame of video data captured. This interface is for preview rendering. The first frame callback is only available for external collection and internal preview. If it is not for SDK rendering, there is no such callback.
  /// Related callbacks: After the [startPublishingStream] function is called successfully, determine if the SDK actually collected audio data by the callback function [onPublisherCapturedAudioFirstFrame], determine if the SDK actually collected video data by the callback function [onPublisherCapturedVideoFirstFrame].
  ///
  /// - [channel] Publishing stream channel.If you only publish one audio and video stream, you can ignore this parameter.
  static void Function(ZegoPublishChannel channel)? onPublisherRenderVideoFirstFrame;

  /// The callback triggered when the video capture resolution changes.
  ///
  /// Available since: 1.1.0
  /// Description: When the audio and video stream is not published [startPublishingStream] or previewed [startPreview] for the first time, the publishing stream or preview first time, that is, the engine of the audio and video module inside the SDK is started, the video data of the local device will be collected, and the collection resolution will change at this time.
  /// Trigger: After the successful publish [startPublishingStream], the callback will be received if there is a change in the video capture resolution in the process of publishing the stream.
  /// Use cases: You can use this callback to remove the cover of the local preview UI and similar operations.You can also dynamically adjust the scale of the preview view based on the resolution of the callback.
  /// Caution: What is notified during external collection is the change in encoding resolution, which will be affected by flow control.
  ///
  /// - [width] Video capture resolution width.
  /// - [height] Video capture resolution height.
  /// - [channel] Publishing stream channel.If you only publish one audio and video stream, you can ignore this parameter.
  static void Function(int width, int height, ZegoPublishChannel channel)? onPublisherVideoSizeChanged;

  /// The callback triggered when the state of relayed streaming to CDN changes.
  ///
  /// Available since: 1.1.0
  /// Description: Developers can use this callback to determine whether the audio and video streams of the relay CDN are normal. If they are abnormal, further locate the cause of the abnormal audio and video streams of the relay CDN and make corresponding disaster recovery strategies.
  /// Trigger: After the ZEGO RTC server relays the audio and video streams to the CDN, this callback will be received if the CDN relay status changes, such as a stop or a retry.
  /// Caution: If you do not understand the cause of the abnormality, you can contact ZEGO technicians to analyze the specific cause of the abnormality.
  ///
  /// - [streamID] Stream ID.
  /// - [infoList] List of information that the current CDN is relaying.
  static void Function(String streamID, List<ZegoStreamRelayCDNInfo> infoList)? onPublisherRelayCDNStateUpdate;

  /// The callback triggered when the video encoder changes in publishing stream.
  ///
  /// Available since: 2.12.0
  /// Description: After the H.265 automatic downgrade policy is enabled, if H.265 encoding is not supported or the encoding fails during the streaming process with H.265 encoding, the SDK will actively downgrade to the specified encoding (H.264), and this callback will be triggered at this time.
  /// When to trigger: In the process of streaming with H.265 encoding, if H.265 encoding is not supported or encoding fails, the SDK will actively downgrade to the specified encoding (H.264), and this callback will be triggered at this time.
  /// Caution: When this callback is triggered, if local video recording or cloud recording is in progress, multiple recording files will be generated. Developers need to collect all the recording files for processing after the recording ends. When this callback is triggered, because the streaming code has changed, the developer can evaluate whether to notify the streaming end, so that the streaming end can deal with it accordingly.
  ///
  /// - [fromCodecID] Video codec ID before the change.
  /// - [toCodecID] Video codec ID after the change.
  /// - [channel] Publishing stream channel.If you only publish one audio and video stream, you can ignore this parameter.
  static void Function(ZegoVideoCodecID fromCodecID, ZegoVideoCodecID toCodecID, ZegoPublishChannel channel)? onPublisherVideoEncoderChanged;

  /// The callback triggered when the state of stream playing changes.
  ///
  /// Available since: 1.1.0
  /// Description: After calling the [startPlayingStream] successfully, the notification of the playing stream state change can be obtained through the callback function. You can roughly judge the user's downlink network status based on whether the state parameter is in [PLAY_REQUESTING].
  /// When to trigger:  After calling the [startPublishingStream], this callback is triggered when a playing stream's state changed.
  /// Related callbacks: After calling the [startPublishingStream] successfully, the notification of the publish stream state change can be obtained through the callback function [onPublisherStateUpdate]. You can roughly judge the user's uplink network status based on whether the state parameter is in [PUBLISH_REQUESTING].
  ///
  /// - [streamID] stream ID.
  /// - [state] State of playing stream.
  /// - [errorCode] The error code corresponding to the status change of the playing stream, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
  /// - [extendedData] Extended Information with state updates. As the standby, only an empty json table is currently returned.
  static void Function(String streamID, ZegoPlayerState state, int errorCode, Map<String, dynamic> extendedData)? onPlayerStateUpdate;

  /// Callback for current stream playing quality.
  ///
  /// Available since: 1.1.0
  /// Description: After calling the [startPlayingStream] successfully, this callback will be triggered every 3 seconds. The collection frame rate, bit rate, RTT, packet loss rate and other quality data can be obtained, and the health of the played audio and video streams can be monitored in real time.
  /// Use cases: You can monitor the health of the played audio and video streams in real time according to the quality parameters of the callback function, in order to show the downlink network status on the device UI in real time.
  /// Caution: If you does not know how to use the various parameters of the callback function, you can only focus on the level field of the quality parameter, which is a comprehensive value describing the downlink network calculated by SDK based on the quality parameters.
  /// Related callbacks: After calling the [startPublishingStream] successfully, a callback [onPublisherQualityUpdate] will be received every 3 seconds. You can monitor the health of publish streams in real time based on quality data such as frame rate, code rate, RTT, packet loss rate, etc.
  ///
  /// - [streamID] Stream ID.
  /// - [quality] Playing stream quality, including audio and video framerate, bitrate, RTT, etc.
  static void Function(String streamID, ZegoPlayStreamQuality quality)? onPlayerQualityUpdate;

  /// The callback triggered when a media event occurs during streaming playing.
  ///
  /// Available since: 1.1.0
  /// Description: This callback is used to receive pull streaming events.
  /// Use cases: You can use this callback to make statistics on stutters or to make friendly displays in the UI of the app.
  /// When to trigger:  After calling the [startPublishingStream], this callback is triggered when an event such as audio and video jamming and recovery occurs in the playing stream.
  ///
  /// - [streamID] Stream ID.
  /// - [event] Specific events received when playing the stream.
  static void Function(String streamID, ZegoPlayerMediaEvent event)? onPlayerMediaEvent;

  /// The callback triggered when the first audio frame is received.
  ///
  /// Available since: 1.1.0
  /// Description: After the [startPlayingStream] function is called successfully, this callback will be called when SDK received the first frame of audio data.
  /// Use cases: Developer can use this callback to count time consuming that take the first frame time or update the UI for playing stream.
  /// Trigger: This callback is triggered when SDK receives the first frame of audio data from the network.
  /// Related callbacks: After a successful call to [startPlayingStream], the callback function [onPlayerRecvVideoFirstFrame] determines whether the SDK has received the video data, and the callback [onPlayerRenderVideoFirstFrame] determines whether the SDK has rendered the first frame of the received video data.
  ///
  /// - [streamID] Stream ID.
  static void Function(String streamID)? onPlayerRecvAudioFirstFrame;

  /// The callback triggered when the first video frame is received.
  ///
  /// Available since: 1.1.0
  /// Description: After the [startPlayingStream] function is called successfully, this callback will be called when SDK received the first frame of video data.
  /// Use cases: Developer can use this callback to count time consuming that take the first frame time or update the UI for playing stream.
  /// Trigger: This callback is triggered when SDK receives the first frame of video data from the network.
  /// Related callbacks: After a successful call to [startPlayingStream], the callback function [onPlayerRecvAudioFirstFrame] determines whether the SDK has received the audio data, and the callback [onPlayerRenderVideoFirstFrame] determines whether the SDK has rendered the first frame of the received video data.
  ///
  /// - [streamID] Stream ID.
  static void Function(String streamID)? onPlayerRecvVideoFirstFrame;

  /// The callback triggered when the first video frame is rendered.
  ///
  /// Available since: 1.1.0
  /// Description: After the [startPlayingStream] function is called successfully, this callback will be called when SDK rendered the first frame of video data.
  /// Use cases: Developer can use this callback to count time consuming that take the first frame time or update the UI for playing stream.
  /// Trigger: This callback is triggered when SDK rendered the first frame of video data from the network.
  /// Related callbacks: After a successful call to [startPlayingStream], the callback function [onPlayerRecvAudioFirstFrame] determines whether the SDK has received the audio data, and the callback [onPlayerRecvVideoFirstFrame] determines whether the SDK has received the video data.
  ///
  /// - [streamID] Stream ID.
  static void Function(String streamID)? onPlayerRenderVideoFirstFrame;

  /// The callback triggered when the stream playback resolution changes.
  ///
  /// Available since: 1.1.0
  /// Description: After the [startPlayingStream] function is called successfully, the play resolution will change when the first frame of video data is received, or when the publisher changes the encoding resolution by calling [setVideoConfig], or when the network traffic control strategies work.
  /// Use cases: Developers can update or switch the UI components that actually play the stream based on the final resolution of the stream.
  /// Trigger: After the [startPlayingStream] function is called successfully, this callback is triggered when the video resolution changes while playing the stream.
  /// Caution: If the stream is only audio data, the callback will not be triggered.
  ///
  /// - [streamID] Stream ID.
  /// - [width] Video decoding resolution width.
  /// - [height] Video decoding resolution height.
  static void Function(String streamID, int width, int height)? onPlayerVideoSizeChanged;

  /// The callback triggered when Supplemental Enhancement Information is received.
  ///
  /// Available since: 1.1.0
  /// Description: After the [startPlayingStream] function is called successfully, when the remote stream sends SEI (such as directly calling [sendSEI], audio mixing with SEI data, and sending custom video capture encoded data with SEI, etc.), the local end will receive this callback.
  /// Trigger: After the [startPlayingStream] function is called successfully, when the remote stream sends SEI, the local end will receive this callback.
  /// Caution: Since the video encoder itself generates an SEI with a payload type of 5, or when a video file is used for publishing, such SEI may also exist in the video file. Therefore, if the developer needs to filter out this type of SEI, it can be before [createEngine] Call [ZegoEngineConfig.advancedConfig("unregister_sei_filter", "XXXXX")]. Among them, unregister_sei_filter is the key, and XXXXX is the uuid filter string to be set.
  ///
  /// - [streamID] Stream ID.
  /// - [data] SEI content.
  static void Function(String streamID, Uint8List data)? onPlayerRecvSEI;

  /// The callback triggered when the state of relayed streaming of the mixed stream to CDN changes.
  ///
  /// Available since: 1.2.1
  /// Description: The general situation of the mixing task on the ZEGO RTC server will push the output stream to the CDN using the RTMP protocol, and the state change during the push process will be notified from the callback function.
  /// Use cases: It is often used when multiple video images are required to synthesize a video using mixed streaming, such as education, live teacher and student images.
  /// When to trigger: After the developer calls the [startMixerTask] function to start mixing, when the ZEGO RTC server pushes the output stream to the CDN, there is a state change.
  /// Restrictions: None.
  /// Related callbacks: Develop can get the sound update notification of each single stream in the mixed stream through [OnMixerSoundLevelUpdate].
  /// Related APIs: Develop can start a mixed flow task through [startMixerTask].
  ///
  /// - [taskID] The mixing task ID. Value range: the length does not exceed 256. Caution: This parameter is in string format and cannot contain URL keywords, such as 'http' and '?' etc., otherwise the push and pull flow will fail. Only supports numbers, English characters and'~','!','@','$','%','^','&','*','(',')','_' ,'+','=','-','`',';',''',',','.','<','>','/','\'.
  /// - [infoList] List of information that the current CDN is being mixed.
  static void Function(String taskID, List<ZegoStreamRelayCDNInfo> infoList)? onMixerRelayCDNStateUpdate;

  /// The callback triggered when the sound level of any input stream changes in the stream mixing process.
  ///
  /// Available since: 1.2.1
  /// Description: Developers can use this callback to display the effect of which stream’s anchor is talking on the UI interface of the mixed stream of the audience.
  /// Use cases: It is often used when multiple video images are required to synthesize a video using mixed streaming, such as education, live teacher and student images.
  /// When to trigger: After the developer calls the [startPlayingStream] function to start playing the mixed stream.
  /// Restrictions: Due to the high frequency of this callback, please do not perform time-consuming tasks or UI operations in this callback to avoid stalling.
  /// Related callbacks: [OnMixerRelayCDNStateUpdate] can be used to get update notification of mixing stream repost CDN status.
  /// Related APIs: Develop can start a mixed flow task through [startMixerTask].
  ///
  /// - [soundLevels] The sound key-value pair of each single stream in the mixed stream, the key is the soundLevelID of each single stream, and the value is the sound value of the corresponding single stream. Value range: The value range of value is 0.0 ~ 100.0.
  static void Function(Map<int, double> soundLevels)? onMixerSoundLevelUpdate;

  /// The callback triggered when the sound level of any input stream changes in the auto stream mixing process.
  ///
  /// Available since: 2.10.0
  /// Description: According to this callback, user can obtain the sound level information of each stream pulled during auto stream mixing.
  /// Use cases: Often used in voice chat room scenarios.Users can use this callback to show which streamer is speaking when an audience pulls a mixed stream.
  /// Trigger: Call [startPlayingStream] function to pull the stream.
  /// Related APIs: Users can call [startAutoMixerTask] function to start an auto stream mixing task.Users can call [stopAutoMixerTask] function to stop an auto stream mixing task.
  ///
  /// - [soundLevels] Sound level hash map, key is the streamID of every single stream in this mixer stream, value is the sound level value of that single stream, value ranging from 0.0 to 100.0.
  static void Function(Map<String, double> soundLevels)? onAutoMixerSoundLevelUpdate;

  /// The callback triggered when there is a change to audio devices (i.e. new device added or existing device deleted).
  ///
  /// Only supports desktop.
  /// This callback is triggered when an audio device is added or removed from the system. By listening to this callback, users can update the sound collection or output using a specific device when necessary.
  ///
  /// - [updateType] Update type (add/delete)
  /// - [deviceType] Audio device type
  /// - [deviceInfo] Audio device information
  static void Function(ZegoUpdateType updateType, ZegoAudioDeviceType deviceType, ZegoDeviceInfo deviceInfo)? onAudioDeviceStateChanged;

  /// The callback triggered when there is a change to video devices (i.e. new device added or existing device deleted).
  ///
  /// This callback is triggered when a video device is added or removed from the system. By listening to this callback, users can update the video capture using a specific device when necessary.
  ///
  /// - [updateType] Update type (add/delete)
  /// - [deviceInfo] Audio device information
  static void Function(ZegoUpdateType updateType, ZegoDeviceInfo deviceInfo)? onVideoDeviceStateChanged;

  /// The local captured audio sound level callback.
  ///
  /// To trigger this callback function, the [startSoundLevelMonitor] function must be called to start the sound level monitor and you must be in a state where it is publishing the audio and video stream or be in [startPreview] state.
  /// The callback notification period is the setting parameter of [startSoundLevelMonitor].
  ///
  /// - [soundLevel] Locally captured sound level value, ranging from 0.0 to 100.0
  static void Function(double soundLevel)? onCapturedSoundLevelUpdate;

  /// The local captured audio sound level callback.
  ///
  /// Available: since 2.10.0
  /// To trigger this callback function, the [startSoundLevelMonitor] function must be called to start the sound level monitor and you must be in a state where it is publishing the audio and video stream or be in [startPreview] state.
  /// The callback notification period is the setting parameter of [startSoundLevelMonitor].
  ///
  /// - [soundLevelInfo] Locally captured sound level value, ranging from 0.0 to 100.0
  static void Function(ZegoSoundLevelInfo soundLevelInfo)? onCapturedSoundLevelInfoUpdate;

  /// The remote playing streams audio sound level callback.
  ///
  /// To trigger this callback function, the [startSoundLevelMonitor] function must be called to start the sound level monitor and you must be in a state where it is playing the audio and video stream.
  /// The callback notification period is the setting parameter of [startSoundLevelMonitor].
  ///
  /// - [soundLevels] Remote sound level hash map, key is the streamID, value is the sound level value of the corresponding streamID, value ranging from 0.0 to 100.0
  static void Function(Map<String, double> soundLevels)? onRemoteSoundLevelUpdate;

  /// The remote playing streams audio sound level callback.
  ///
  /// Available: since 2.10.0
  /// To trigger this callback function, the [startSoundLevelMonitor] function must be called to start the sound level monitor and you must be in a state where it is playing the audio and video stream.
  /// The callback notification period is the setting parameter of [startSoundLevelMonitor].
  ///
  /// - [soundLevelInfos] Remote sound level hash map, key is the streamID, value is the sound level value of the corresponding streamID, value ranging from 0.0 to 100.0
  static void Function(Map<String, ZegoSoundLevelInfo> soundLevelInfos)? onRemoteSoundLevelInfoUpdate;

  /// The local captured audio spectrum callback.
  ///
  /// To trigger this callback function, the [startAudioSpectrumMonitor] function must be called to start the audio spectrum monitor and you must be in a state where it is publishing the audio and video stream or be in [startPreview] state.
  /// The callback notification period is the setting parameter of [startAudioSpectrumMonitor].
  ///
  /// - [audioSpectrum] Locally captured audio spectrum value list. Spectrum value range is [0-2^30]
  static void Function(List<double> audioSpectrum)? onCapturedAudioSpectrumUpdate;

  /// The remote playing streams audio spectrum callback.
  ///
  /// To trigger this callback function, the [startAudioSpectrumMonitor] function must be called to start the audio spectrum monitor and you must be in a state where it is playing the audio and video stream.
  /// The callback notification period is the setting parameter of [startAudioSpectrumMonitor].
  ///
  /// - [audioSpectrums] Remote audio spectrum hash map, key is the streamID, value is the audio spectrum list of the corresponding streamID. Spectrum value range is [0-2^30]
  static void Function(Map<String, List<double>> audioSpectrums)? onRemoteAudioSpectrumUpdate;

  /// The callback triggered when a device exception occurs.
  ///
  /// This callback is triggered when an exception occurs when reading or writing the audio and video device.
  ///
  /// - [errorCode] The error code corresponding to the status change of the playing stream, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
  /// - [deviceName] device name
  static void Function(int errorCode, String deviceName)? onDeviceError;

  /// The callback triggered when the state of the remote camera changes.
  ///
  /// When the state of the remote camera device changes, such as switching the camera, by monitoring this callback, it is possible to obtain an event related to the far-end camera, which can be used to prompt the user that the video may be abnormal.
  /// Developers of 1v1 education scenarios or education small class scenarios and similar scenarios can use this callback notification to determine whether the camera device of the remote publishing stream device is working normally, and preliminary understand the cause of the device problem according to the corresponding state.
  /// This callback will not be called back when the remote stream is play from the CDN, and will not be called back if the remote stream end user has enabled custom video capture function.
  ///
  /// - [streamID] Stream ID
  /// - [state] Remote camera status
  static void Function(String streamID, ZegoRemoteDeviceState state)? onRemoteCameraStateUpdate;

  /// The callback triggered when the state of the remote microphone changes.
  ///
  /// When the state of the remote microphone device is changed, such as switching a microphone, etc., by listening to the callback, it is possible to obtain an event related to the remote microphone, which can be used to prompt the user that the audio may be abnormal.
  /// Developers of 1v1 education scenarios or education small class scenarios and similar scenarios can use this callback notification to determine whether the microphone device of the remote publishing stream device is working normally, and preliminary understand the cause of the device problem according to the corresponding state.
  /// This callback will not be called back when the remote stream is play from the CDN, and will not be called back if the remote stream end user has enabled custom audio capture function.
  ///
  /// - [streamID] Stream ID
  /// - [state] Remote microphone status
  static void Function(String streamID, ZegoRemoteDeviceState state)? onRemoteMicStateUpdate;

  /// The callback triggered when the state of the remote speaker changes.
  ///
  /// When the state of the remote speaker device changes, such as switching the speaker, by monitoring this callback, you can get events related to the remote speaker.
  /// Developers of 1v1 education scenarios or education small class scenarios and similar scenarios can use this callback notification to determine whether the speaker device of the remote publishing stream device is working normally, and preliminary understand the cause of the device problem according to the corresponding state.
  /// This callback will not be called back when the remote stream is play from the CDN.
  ///
  /// - [streamID] Stream ID
  /// - [state] Remote speaker status
  static void Function(String streamID, ZegoRemoteDeviceState state)? onRemoteSpeakerStateUpdate;

  /// Callback for device's audio route changed.
  ///
  /// This callback will be called when there are changes in audio routing such as earphone plugging, speaker and receiver switching, etc.
  ///
  /// - [audioRoute] Current audio route
  static void Function(ZegoAudioRoute audioRoute)? onAudioRouteChange;

  /// The callback triggered when Broadcast Messages are received.
  ///
  /// Available since: 1.2.1
  /// Description: This callback is used to receive broadcast messages sent by other users in the same room.
  /// Use cases: Generally used when the number of people in the live room does not exceed 500
  /// When to trigger: After calling [loginRoom] to log in to the room, if a user in the room sends a broadcast message via [sendBroadcastMessage] function, this callback will be triggered.
  /// Restrictions: None
  /// Caution: The broadcast message sent by the user will not be notified through this callback.
  /// Related callbacks: You can receive room barrage messages through [onIMRecvBarrageMessage], and you can receive room custom signaling through [onIMRecvCustomCommand].
  ///
  /// - [roomID] Room ID. Value range: The maximum length is 128 bytes. Caution: The room ID is in string format and only supports numbers, English characters and'~','!','@','#','$','%','^','&', ' *','(',')','_','+','=','-','`',';',''',',','.','<' ,'>','/','\'.
  /// - [messageList] List of received messages. Value range: Up to 50 messages can be received each time.
  static void Function(String roomID, List<ZegoBroadcastMessageInfo> messageList)? onIMRecvBroadcastMessage;

  /// The callback triggered when Barrage Messages are received.
  ///
  /// Available since: 1.5.0
  /// Description: This callback is used to receive barrage messages sent by other users in the same room.
  /// Use cases: Generally used in scenarios where there is a large number of messages sent and received in the room and the reliability of the messages is not required, such as live barrage.
  /// When to trigger: After calling [loginRoom] to log in to the room, if a user in the room sends a barrage message through the [sendBarrageMessage] function, this callback will be triggered.
  /// Restrictions: None
  /// Caution: Barrage messages sent by users themselves will not be notified through this callback. When there are a large number of barrage messages in the room, the notification may be delayed, and some barrage messages may be lost.
  /// Related callbacks: Develop can receive room broadcast messages through [onIMRecvBroadcastMessage], and can receive room custom signaling through [onIMRecvCustomCommand].
  ///
  /// - [roomID] Room ID. Value range: The maximum length is 128 bytes. Caution: The room ID is in string format and only supports numbers, English characters and'~','!','@','#','$','%','^','&', ' *','(',')','_','+','=','-','`',';',''',',','.','<' ,'>','/','\'.
  /// - [messageList] List of received messages. Value range: Up to 50 messages can be received each time.
  static void Function(String roomID, List<ZegoBarrageMessageInfo> messageList)? onIMRecvBarrageMessage;

  /// The callback triggered when a Custom Command is received.
  ///
  /// Available since: 1.2.1
  /// Description: This callback is used to receive custom command sent by other users in the same room.
  /// Use cases: Generally used when the number of people in the live room does not exceed 500
  /// When to trigger: After calling [loginRoom] to log in to the room, if other users in the room send custom signaling to the developer through the [sendCustomCommand] function, this callback will be triggered.
  /// Restrictions: None
  /// Caution: The custom command sent by the user himself will not be notified through this callback.
  /// Related callbacks: You can receive room broadcast messages through [onIMRecvBroadcastMessage], and you can receive room barrage message through [onIMRecvBarrageMessage].
  ///
  /// - [roomID] Room ID. Value range: The maximum length is 128 bytes. Caution: The room ID is in string format and only supports numbers, English characters and'~','!','@','#','$','%','^','&', ' *','(',')','_','+','=','-','`',';',''',',','.','<' ,'>','/','\'.
  /// - [fromUser] Sender of the command.
  /// - [command] Command content received.Value range: The maximum length is 1024 bytes.
  static void Function(String roomID, ZegoUser fromUser, String command)? onIMRecvCustomCommand;

  /// The callback triggered when the state of the media player changes.
  ///
  /// - [mediaPlayer] Callback player object
  /// - [state] Media player status
  /// - [errorCode] Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
  static void Function(ZegoMediaPlayer mediaPlayer, ZegoMediaPlayerState state, int errorCode)? onMediaPlayerStateUpdate;

  /// The callback triggered when the network status of the media player changes.
  ///
  /// - [mediaPlayer] Callback player object
  /// - [networkEvent] Network status event
  static void Function(ZegoMediaPlayer mediaPlayer, ZegoMediaPlayerNetworkEvent networkEvent)? onMediaPlayerNetworkEvent;

  /// The callback to report the current playback progress of the media player.
  ///
  /// - [mediaPlayer] Callback player object
  /// - [millisecond] Progress in milliseconds
  static void Function(ZegoMediaPlayer mediaPlayer, int millisecond)? onMediaPlayerPlayingProgress;

  /// The callback triggered when the media player got media side info.
  ///
  /// - [mediaPlayer] Callback player object
  /// - [data] SEI content
  static void Function(ZegoMediaPlayer mediaPlayer, Uint8List data)? onMediaPlayerRecvSEI;

  /// Audio effect playback state callback.
  ///
  /// This callback is triggered when the playback state of a audio effect of the audio effect player changes.
  ///
  /// - [audioEffectPlayer] Audio effect player instance that triggers this callback
  /// - [audioEffectID] The ID of the audio effect resource that triggered this callback
  /// - [state] The playback state of the audio effect
  /// - [errorCode] Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
  static void Function(ZegoAudioEffectPlayer audioEffectPlayer, int audioEffectID, ZegoAudioEffectPlayState state, int errorCode)? onAudioEffectPlayStateUpdate;

  /// The callback triggered when the state of data recording (to a file) changes.
  ///
  /// - [state] File recording status, according to which you should determine the state of the file recording or the prompt of the UI.
  /// - [errorCode] Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
  /// - [config] Record config
  /// - [channel] Publishing stream channel
  static void Function(ZegoDataRecordState state, int errorCode, ZegoDataRecordConfig config, ZegoPublishChannel channel)? onCapturedDataRecordStateUpdate;

  /// The callback to report the current recording progress.
  ///
  /// - [progress] File recording progress, which allows developers to hint at the UI, etc.
  /// - [config] Record config
  /// - [channel] Publishing stream channel
  static void Function(ZegoDataRecordProgress progress, ZegoDataRecordConfig config, ZegoPublishChannel channel)? onCapturedDataRecordProgressUpdate;

  /// The system performance status callback.
  ///
  /// To trigger this callback function, the [startPerformanceMonitor] function must be called to start the system performance monitor.
  /// The callback notification period is the setting parameter of [startPerformanceMonitor].
  ///
  /// - [status] The system performance status.
  static void Function(ZegoPerformanceStatus status)? onPerformanceStatusUpdate;

  /// Callback for network mode changed.
  ///
  /// This callback will be called when the device's network mode changes, such as switching from WiFi to 5G, or when the network is disconnected.
  ///
  /// - [mode] Current network mode.
  static void Function(ZegoNetworkMode mode)? onNetworkModeChanged;

  /// The callback triggered when error occurred when testing network speed.
  ///
  /// - [errorCode] The error code corresponding to the network speed test, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
  /// - [type] Uplink or downlink
  static void Function(int errorCode, ZegoNetworkSpeedTestType type)? onNetworkSpeedTestError;

  /// The callback triggered when quality updated when testing network speed.
  ///
  /// When error occurs or called stopNetworkSpeedTest, this callback will be stopped.
  ///
  /// - [quality] Network speed quality
  /// - [type] Uplink or downlink
  static void Function(ZegoNetworkSpeedTestQuality quality, ZegoNetworkSpeedTestType type)? onNetworkSpeedTestQualityUpdate;

  /// Receive custom JSON content
  ///
  /// - [content] JSON string content
  static void Function(String content)? onRecvExperimentalAPI;

  /// The network quality callback of users who are pushing and playing in the room.
  ///
  /// Available: Since 2.10.0
  /// Description: The uplink and downlink network callbacks of the local and remote users, that would be called by default every two seconds for the local and each playing remote user's network quality.
  /// Use case: When the developer wants to analyze the network condition on the link, or wants to know the network condition of local and remote users.
  /// When to Trigger: After playing a stream by called [startPublishingStream] and [startPlayingStream].
  ///
  /// - [userID] User ID, empty means local user
  /// - [upstreamQuality] Upstream network quality
  /// - [downstreamQuality] Downstream network quality
  static void Function(String userID, ZegoStreamQualityLevel upstreamQuality, ZegoStreamQualityLevel downstreamQuality)? onNetworkQuality;

  /// Custom audio processing local captured PCM audio frame callback.
  ///
  /// Available: Since 2.13.0
  /// Description: In this callback, you can receive the PCM audio frames captured locally after used headphone monitor. Developers can modify the audio frame data, as well as the audio channels and sample rate. The timestamp can be used for data synchronization, such as lyrics, etc. If you need the data after used headphone monitor, please use the [onProcessCapturedAudioDataAfterUsedHeadphoneMonitor] callback.
  /// When to trigger: You need to call [enableCustomAudioCaptureProcessing] to enable the function first, and call [startPreivew] or [startPublishingStream] to trigger this callback function.
  /// Caution: This callback is a high-frequency callback, please do not perform time-consuming operations in this callback.
  ///
  /// - [data] Audio data in PCM format
  /// - [dataLength] Length of the data
  /// - [param] Parameters of the audio frame
  /// - [timestamp] The audio frame timestamp, starting from 0 when capture is started, the unit is milliseconds.
  static void Function(Uint8List data, int dataLength, ZegoAudioFrameParam param, double timestamp)? onProcessCapturedAudioData;

  /// Custom audio processing local captured PCM audio frame callback after used headphone monitor.
  ///
  /// Available: Since 2.13.0
  /// Description: In this callback, you can receive the PCM audio frames captured locally after used headphone monitor. Developers can modify the audio frame data, as well as the audio channels and sample rate. The timestamp can be used for data synchronization, such as lyrics, etc.
  /// When to trigger: You need to call [enableCustomAudioCaptureProcessingAfterHeadphoneMonitor] to enable the function first, and call [startPreivew] or [startPublishingStream] to trigger this callback function.
  /// Caution: This callback is a high-frequency callback, please do not perform time-consuming operations in this callback.
  ///
  /// - [data] Audio data in PCM format
  /// - [dataLength] Length of the data
  /// - [param] Parameters of the audio frame
  /// - [timestamp] The audio frame timestamp, starting from 0 when capture is started, the unit is milliseconds.
  static void Function(Uint8List data, int dataLength, ZegoAudioFrameParam param, double timestamp)? onProcessCapturedAudioDataAfterUsedHeadphoneMonitor;

  /// Custom audio processing remote playing stream PCM audio frame callback.
  ///
  /// Available: Since 2.13.0
  /// Description: In this callback, you can receive the PCM audio frames of remote playing stream. Developers can modify the audio frame data, as well as the audio channels and sample rate. The timestamp can be used for data synchronization, such as lyrics, etc.
  /// When to trigger: You need to call [enableCustomAudioRemoteProcessing] to enable the function first, and call [startPlayingStream] to trigger this callback function.
  /// Caution: This callback is a high-frequency callback, please do not perform time-consuming operations in this callback.
  ///
  /// - [data] Audio data in PCM format
  /// - [dataLength] Length of the data
  /// - [param] Parameters of the audio frame
  /// - [streamID] Corresponding stream ID
  /// - [timestamp] The audio frame timestamp, starting from 0 when capture is started, the unit is milliseconds.
  static void Function(Uint8List data, int dataLength, ZegoAudioFrameParam param, String streamID, double timestamp)? onProcessRemoteAudioData;

  /// Custom audio processing SDK playback PCM audio frame callback.
  ///
  /// Available: Since 2.13.0
  /// Description: In this callback, you can receive the SDK playback PCM audio frame. Developers can modify the audio frame data, as well as the audio channels and sample rate. The timestamp can be used for data synchronization, such as lyrics, etc.
  /// When to trigger: You need to call [enableCustomAudioPlaybackProcessing] to enable the function first, and call [startPublishingStream], [startPlayingStream], [startPreview], [createMediaPlayer] or [createAudioEffectPlayer] to trigger this callback function.
  /// Caution: This callback is a high-frequency callback, please do not perform time-consuming operations in this callback.
  ///
  /// - [data] Audio data in PCM format
  /// - [dataLength] Length of the data
  /// - [param] Parameters of the audio frame
  /// - [timestamp] The audio frame timestamp, starting from 0 when capture is started, the unit is milliseconds. (It is effective when there is one and only one stream)
  static void Function(Uint8List data, int dataLength, ZegoAudioFrameParam param, double timestamp)? onProcessPlaybackAudioData;

  /// The callback for obtaining the audio data captured by the local microphone.
  ///
  /// In non-custom audio capture mode, the SDK capture the microphone's sound, but the developer may also need to get a copy of the audio data captured by the SDK is available through this callback.
  /// On the premise of calling [setAudioDataHandler] to set the listener callback, after calling [enableAudioDataCallback] to set the mask 0b01 that means 1 << 0, this callback will be triggered only when it is in the publishing stream state.
  ///
  /// - [data] Audio data in PCM format
  /// - [dataLength] Length of the data
  /// - [param] Parameters of the audio frame
  static void Function(Uint8List data, int dataLength, ZegoAudioFrameParam param)? onCapturedAudioData;

  /// The callback for obtaining the audio data of all the streams playback by SDK.
  ///
  /// This function will callback all the mixed audio data to be playback. This callback can be used for that you needs to fetch all the mixed audio data to be playback to proccess.
  /// On the premise of calling [setAudioDataHandler] to set the listener callback, after calling [enableAudioDataCallback] to set the mask 0b100 that means 1 << 2, this callback will be triggered only when it is in the SDK inner audio and video engine started(called the [startPreivew] or [startPlayingStream] or [startPublishingStream]).
  /// When the engine is started in the non-playing stream state or the media player is not used to play the media file, the audio data to be called back is muted audio data.
  ///
  /// - [data] Audio data in PCM format
  /// - [dataLength] Length of the data
  /// - [param] Parameters of the audio frame
  static void Function(Uint8List data, int dataLength, ZegoAudioFrameParam param)? onPlaybackAudioData;

  /// The callback for obtaining the mixed audio data. Such mixed auido data are generated by the SDK by mixing the audio data of all the remote playing streams and the auido data captured locally.
  ///
  /// The audio data of all playing data is mixed with the data captured by the local microphone before it is sent to the loudspeaker, and calleback out in this way.
  /// On the premise of calling [setAudioDataHandler] to set the listener callback, after calling [enableAudioDataCallback] to set the mask 0x04, this callback will be triggered only when it is in the publishing stream state or playing stream state.
  ///
  /// - [data] Audio data in PCM format
  /// - [dataLength] Length of the data
  /// - [param] Parameters of the audio frame
  static void Function(Uint8List data, int dataLength, ZegoAudioFrameParam param)? onMixedAudioData;

  /// The callback for obtaining the audio data of each stream.
  ///
  /// This function will call back the data corresponding to each playing stream. Different from [onPlaybackAudioData], the latter is the mixed data of all playing streams. If developers need to process a piece of data separately, they can use this callback.
  /// On the premise of calling [setAudioDataHandler] to set up listening for this callback, calling [enableAudioDataCallback] to set the mask 0x08 that is 1 << 3, and this callback will be triggered when the SDK audio and video engine starts to play the stream.
  ///
  /// - [data] Audio data in PCM format
  /// - [dataLength] Length of the data
  /// - [param] Parameters of the audio frame
  /// - [streamID] Corresponding stream ID
  static void Function(Uint8List data, int dataLength, ZegoAudioFrameParam param, String streamID)? onPlayerAudioData;

  /// Range audio microphone state callback.
  ///
  /// Available since: 2.11.0
  /// Description: The status change notification of the microphone, starting to send audio is an asynchronous process, and the state switching in the middle is called back through this function.
  /// Trigger: After the [enableMicrophone] function.
  /// Caution: It must be monitored before the [enableMicrophone] function is called.
  ///
  /// - [rangeAudio] Range audio instance that triggers this callback.
  /// - [state] The use state of the range audio.
  /// - [errorCode] Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
  static void Function(ZegoRangeAudio rangeAudio, ZegoRangeAudioMicrophoneState state, int errorCode)? onRangeAudioMicrophoneStateUpdate;

}

extension ZegoExpressEngineDeprecatedApi on ZegoExpressEngine {

  /// [Deprecated] Turns on/off verbose debugging and sets up the log language.
  ///
  /// This function has been deprecated after version 2.3.0, please use the [setEngineConfig] function to set the advanced configuration property advancedConfig to achieve the original function.
  /// The debug switch is set to on and the language is English by default.
  ///
  /// @deprecated This function has been deprecated after version 2.3.0, please use the [setEngineConfig] function to set the advanced configuration property advancedConfig to achieve the original function.
  /// - [enable] Detailed debugging information switch
  /// - [language] Debugging information language
  @Deprecated('This function has been deprecated after version 2.3.0, please use the [setEngineConfig] function to set the advanced configuration property advancedConfig to achieve the original function.')
  Future<void> setDebugVerbose(bool enable, ZegoLanguage language) async {
    return await ZegoExpressImpl.instance.setDebugVerbose(enable, language);
  }

  /// [Deprecated] Logs in multi room.
  ///
  /// This method has been deprecated after version 2.9.0 If you want to access the multi-room feature, Please set [setRoomMode] to select multi-room mode before the engine started, and then call [loginRoom] to use multi-room. If you call [loginRoom] function to log in to multiple rooms, please make sure to pass in the same user information.
  /// You must log in the main room with [loginRoom] before invoke this function to logging in to multi room.
  /// Currently supports logging into 1 main room and 1 multi room at the same time.
  /// When logging out, you must log out of the multi room before logging out of the main room.
  /// User can only publish the stream in the main room, but can play the stream in the main room and multi room at the same time, and can receive the signaling and callback in each room.
  /// The advantage of multi room is that you can login another room without leaving the current room, receive signaling and callback from another room, and play streams from another room.
  /// To prevent the app from being impersonated by a malicious user, you can add authentication before logging in to the room, that is, the [token] parameter in the ZegoRoomConfig object passed in by the [config] parameter.
  /// Different users who log in to the same room can get room related notifications in the same room (eg [onRoomUserUpdate], [onRoomStreamUpdate], etc.), and users in one room cannot receive room signaling notifications in another room.
  /// Messages sent in one room (e.g. [setStreamExtraInfo], [sendBroadcastMessage], [sendBarrageMessage], [sendCustomCommand], etc.) cannot be received callback ((eg [onRoomStreamExtraInfoUpdate], [onIMRecvBroadcastMessage], [onIMRecvBarrageMessage], [onIMRecvCustomCommand], etc) in other rooms. Currently, SDK does not provide the ability to send messages across rooms. Developers can integrate the SDK of third-party IM to achieve.
  /// SDK supports startPlayingStream audio and video streams from different rooms under the same appID, that is, startPlayingStream audio and video streams across rooms. Since ZegoExpressEngine's room related callback notifications are based on the same room, when developers want to startPlayingStream streams across rooms, developers need to maintain related messages and signaling notifications by themselves.
  /// If the network is temporarily interrupted due to network quality reasons, the SDK will automatically reconnect internally. You can get the current connection status of the local room by listening to the [onRoomStateUpdate] callback method, and other users in the same room will receive [onRoomUserUpdate] callback notification.
  /// It is strongly recommended that userID corresponds to the user ID of the business APP, that is, a userID and a real user are fixed and unique, and should not be passed to the SDK in a random userID. Because the unique and fixed userID allows ZEGO technicians to quickly locate online problems.
  ///
  /// @deprecated This method has been deprecated after version 2.9.0 If you want to access the multi-room feature, Please set [setRoomMode] to select multi-room mode before the engine started, and then call [loginRoom] to use multi-room. If you call [loginRoom] function to log in to multiple rooms, please make sure to pass in the same user information.
  /// - [roomID] Room ID, a string of up to 128 bytes in length. Only support numbers, English characters and '~', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+', '=', '-', '`', ';', '’', ',', '.', '<', '>', '/', '\'.
  /// - [config] Advanced room configuration.
  @Deprecated('This method has been deprecated after version 2.9.0 If you want to access the multi-room feature, Please set [setRoomMode] to select multi-room mode before the engine started, and then call [loginRoom] to use multi-room. If you call [loginRoom] function to log in to multiple rooms, please make sure to pass in the same user information.')
  Future<void> loginMultiRoom(String roomID, {ZegoRoomConfig? config}) async {
    return await ZegoExpressImpl.instance.loginMultiRoom(roomID, config: config);
  }

  /// [Deprecated] Set the selected video layer of playing stream.
  ///
  /// Available: 1.19.0 to 2.3.0, deprecated.
  /// This function has been deprecated since version 2.3.0, Please use [setPlayStreamVideoType] instead.
  /// When the publisher has set the codecID to SVC through [setVideoConfig], the player can dynamically set whether to use the standard layer or the base layer (the resolution of the base layer is one-half of the standard layer)
  /// Under normal circumstances, when the network is weak or the rendered UI form is small, you can choose to use the video that plays the base layer to save bandwidth.
  /// It can be set before and after playing stream.
  ///
  /// @deprecated This function has been deprecated since version 2.3.0, Please use [setPlayStreamVideoType] instead.
  /// - [streamID] Stream ID.
  /// - [videoLayer] Video layer of playing stream. AUTO by default.
  @Deprecated('This function has been deprecated since version 2.3.0, Please use [setPlayStreamVideoType] instead.')
  Future<void> setPlayStreamVideoLayer(String streamID, ZegoPlayerVideoLayer videoLayer) async {
    return await ZegoExpressImpl.instance.setPlayStreamVideoLayer(streamID, videoLayer);
  }

  /// [Deprecated] Whether to use the built-in speaker to play audio.This function has been deprecated since version 2.3.0 Please use [setAudioRouteToSpeaker] instead.
  ///
  /// This function has been deprecated since version 2.3.0 Please use [setAudioRouteToSpeaker] instead.
  /// When you choose not to use the built-in speaker to play sound, that is, set to false, the SDK will select the currently highest priority audio output device to play the sound according to the system schedule
  ///
  /// @deprecated This function has been deprecated since version 2.3.0 Please use [setAudioRouteToSpeaker] instead.
  /// - [enable] Whether to use the built-in speaker to play sound, true: use the built-in speaker to play sound, false: use the highest priority audio output device scheduled by the current system to play sound
  @Deprecated('This function has been deprecated since version 2.3.0 Please use [setAudioRouteToSpeaker] instead.')
  Future<void> setBuiltInSpeakerOn(bool enable) async {
    return await ZegoExpressImpl.instance.setBuiltInSpeakerOn(enable);
  }

}
