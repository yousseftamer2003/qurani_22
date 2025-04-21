import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:provider/provider.dart';
import 'package:qurani_22/controllers/start_controller.dart';

class QiblaScreen extends StatefulWidget {
  const QiblaScreen({super.key});

  @override
  State<QiblaScreen> createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen> {
  final _qiblahStream = FlutterQiblah.qiblahStream;

  // Fixed Qibla angle based on coordinates
  double getFixedQiblaAngle(double lat, double long) {
    const double kaabaLat = 21.4225;
    const double kaabaLong = 39.8262;

    double deltaLong = (kaabaLong - long) * (pi / 180); // Convert to radians
    double lat1 = lat * (pi / 180);
    double lat2 = kaabaLat * (pi / 180);

    double qiblaAngle = atan2(sin(deltaLong), cos(lat1) * tan(lat2) - sin(lat1) * cos(deltaLong));
    return qiblaAngle * (180 / pi); // Convert back to degrees
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("القبلة", style: TextStyle(fontSize: 20)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: StreamBuilder<QiblahDirection>(
        stream: _qiblahStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("حدث خطأ أثناء تحديد القبلة."));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text("لا يمكن تحديد القبلة الآن."));
          }

          final qiblaDirection = snapshot.data!;
          double angle = qiblaDirection.direction * (pi / 180); // Convert to radians
          int offset = qiblaDirection.offset.toInt(); // Live offset

          final startProvider = Provider.of<StartController>(context, listen: false);
          final latitude = startProvider.latitude;
          final longitude = startProvider.longitude;

          // Get fixed Qibla angle for the current location
          double fixedQiblaAngle = getFixedQiblaAngle(latitude, longitude);
          bool isAligned = (qiblaDirection.qiblah - fixedQiblaAngle).abs() < 3; // 3-degree threshold

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isAligned
                    ? "تم التوجيه بدقة نحو القبلة! ✅"
                    : "اتجه ${offset > 0 ? 'يميناً' : 'يساراً'} قليلاً",
                style: TextStyle(fontSize: 18, color: isAligned ? Colors.green : Colors.black),
              ),
              const SizedBox(height: 20),
              _buildCompass(angle, offset),
              const SizedBox(height: 20),
              Text(
                "° زاوية الجهاز: ${qiblaDirection.direction.toInt()}",
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                "° زاوية القبلة: ${qiblaDirection.qiblah.toInt()}",
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                "° الفرق: ${offset.abs()}",
                style: const TextStyle(fontSize: 16, color: Colors.red),
              ),
              Text(
                "° القبلة الثابتة لموقعك: ${fixedQiblaAngle.toInt()}",
                style: const TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCompass(double angle, int offset) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[200],
          ),
        ),
        Transform.rotate(
          angle: angle,
          child: SvgPicture.asset('assets/images/qibla_arrow.svg'),
        ),
        Positioned(
          bottom: 10,
          child: Text(
            "$offset°",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    FlutterQiblah().dispose();
    super.dispose();
  }
}
