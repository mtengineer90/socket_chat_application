import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatController extends GetxController {

  /* Socketsbay socket service connection */
  final channel = WebSocketChannel.connect(
    /* My Chat API for Testing Socket Connection */
    //Uri.parse('wss://socketsbay.com/wss/v2/10/349cd0f881cc1c9bd5e4f819ca4733d4/'),

    /* Test Purpose Connection Info */
    Uri.parse('wss://socketsbay.com/wss/v2/1/demo/'),
  );

  //Channel Sink Close on Dispose
  @override
  void dispose() {
    super.dispose();
    channel.sink.close();
  }

  //Initialization
  @override
  void onInit() {
    super.onInit();
  }
}