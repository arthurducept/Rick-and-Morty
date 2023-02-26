import 'package:flutter/cupertino.dart';

class ReqNetworkImage extends StatelessWidget {
  const ReqNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: DefaultRect(width: width, height: height),
      future: Future.delayed(
        const Duration(seconds: 1),
        () => Image.network(
          imageUrl,
          errorBuilder: (context, error, stackTrace) {
            return DefaultRect(width: width, height: height);
          },
          width: width,
          height: height,
          fit: fit ?? BoxFit.cover,
        ),
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return DefaultRect(width: width, height: height);
        } else if (snapshot.hasData) {
          return snapshot.data as Widget;
        } else {
          return DefaultRect(width: width, height: height);
        }
      },
    );
  }
}

class DefaultRect extends StatelessWidget {
  const DefaultRect({
    super.key,
    required this.width,
    required this.height,
  });

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: CupertinoDynamicColor.resolve(
        CupertinoColors.systemGrey,
        context,
      ),
    );
  }
}
