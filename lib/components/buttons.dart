import 'package:commerce/constants/colors.dart';
import 'package:commerce/constants/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onBackground),
        ),
        SizedBox(
          child: MaterialButton(
            splashColor: CustomColors.customGrey,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
            padding: const EdgeInsets.all(0),
            onPressed: onPressed,
            child: Transform.rotate(
              angle: 4.71239,
              child: Lottie.asset(
                Images.proceed,
                height: 80,
                frameRate: FrameRate(60),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PrimaryShadowedButton extends StatelessWidget {
  const PrimaryShadowedButton({
    Key? key,
    required this.child,
    required this.onPressed,
    required this.borderRadius,
    required this.color,
  }) : super(key: key);

  final Widget child;
  final double borderRadius;
  final Color color;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: const RadialGradient(
          colors: [Colors.black54, Colors.black],
          center: Alignment.topLeft,
          radius: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.25),
            offset: const Offset(3, 2),
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ],
      ),
      child: MaterialButton(
        padding: const EdgeInsets.all(0),
        onPressed: onPressed,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            child,
          ],
        ),
      ),
    );
  }
}

class FavouriteButton extends StatelessWidget {
  const FavouriteButton({
    Key? key,
    required this.iconSize,
    required this.onPressed,
  }) : super(key: key);

  final double iconSize;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
        ),
        backgroundColor: MaterialStateProperty.all(Colors.pink),
        elevation: MaterialStateProperty.all(4),
        shadowColor: MaterialStateProperty.all(Colors.pink),
      ),
      child: Center(
        child: Icon(
          Icons.favorite,
          size: iconSize,
          color: Colors.white,
        ),
      ),
      onPressed: onPressed,
    );
  }
}

class RoundedAddButton extends StatelessWidget {
  const RoundedAddButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      padding: const EdgeInsets.all(0),
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      child: Icon(
        FontAwesomeIcons.plus,
        size: 16,
        color: Theme.of(context).colorScheme.surface,
      ),
      onPressed: onPressed,
      color: Colors.black,
    );
  }
}

class BagButton extends StatelessWidget {
  const BagButton({Key? key, this.numberOfItemsPurchased = 0}) : super(key: key);

  final int? numberOfItemsPurchased;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        IconButton(
          icon: Image.asset(
            Images.shoppingBag,
            height: 28,
          ),
          onPressed: () {},
        ),
        if (numberOfItemsPurchased != 0)
          Container(
            margin: const EdgeInsets.only(right: 4, top: 8),
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              color: CustomColors.darkBlue,
              shape: BoxShape.circle,
              border:
              Border.all(width: 1.5, color: Colors.white),
            ),
            child:
            Center(child:
            Text(numberOfItemsPurchased.toString(),
                style:
                TextStyle(fontSize :12, color : Colors.white)
            )
            ),
          ),
      ],
    );
  }
}
