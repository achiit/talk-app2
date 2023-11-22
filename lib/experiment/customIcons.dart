import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DryRun extends StatefulWidget {
  const DryRun({super.key});

  @override
  State<DryRun> createState() => _DryRunState();
}

class _DryRunState extends State<DryRun> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(child: Lottie.asset('assets/json/animationTable.json')),
    );
  }
}
