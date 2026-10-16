import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareProductButton extends StatelessWidget {
  final String productId;
  const ShareProductButton({super.key, required this.productId});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.share),
      onPressed: () async {
        final productLink = "https://homavolve.web.app/products/$productId";
        final sharMessage = "Check out this product: $productLink";
        await SharePlus.instance.share(
          ShareParams(
            text: sharMessage,
            subject: "Check out this product on Huma Volve app",
          ),
        );
      },
    );
  }
}
// class ShareProductButton extends {}
