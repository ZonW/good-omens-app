import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:vector_math/vector_math.dart' as vector_math;

class ThreeBodySimulation extends StatefulWidget {
  @override
  _ThreeBodySimulationState createState() => _ThreeBodySimulationState();
}

class Body {
  vector_math.Vector3 position;
  vector_math.Vector3 velocity;
  double mass;

  Body(this.position, this.velocity, this.mass);
}

vector_math.Vector3 gravitationalForce(Body a, Body b) {
  const double G = 6.67430e-9;
  vector_math.Vector3 r = b.position - a.position;
  double distance = r.length;
  r.normalize();
  double magnitude = (G * a.mass * b.mass) / (distance * distance);
  return r * magnitude;
}

void integrate(List<Body> bodies, double timestep, int iterations) {
  List<vector_math.Vector3> forces =
      List.filled(bodies.length, vector_math.Vector3.zero());

  for (int k = 0; k < iterations; k++) {
    for (int i = 0; i < bodies.length; i++) {
      forces[i] = vector_math.Vector3.zero();
      for (int j = 0; j < bodies.length; j++) {
        if (i != j) {
          forces[i] += gravitationalForce(bodies[i], bodies[j]);
        }
      }
    }

    for (int i = 0; i < bodies.length; i++) {
      vector_math.Vector3 acceleration = forces[i] / bodies[i].mass;
      bodies[i].velocity += acceleration * timestep;
      bodies[i].position += bodies[i].velocity * timestep;
    }
  }
}

class _ThreeBodySimulationState extends State<ThreeBodySimulation>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  double timestep = 10000;
  //initial body conditions, position, velocity, mass
  List<Body> bodies = [
    Body(vector_math.Vector3(0, -1e11, -1e11), vector_math.Vector3(0, 1000, 0),
        3e25),
    Body(vector_math.Vector3(-1e11, 1e11, 0), vector_math.Vector3(-1000, 0, 0),
        4e25),
    Body(vector_math.Vector3(1e11, 0, -1e11), vector_math.Vector3(0, -1000, 0),
        5e25),
  ];

  @override
  void initState() {
    super.initState();

    // Calculate the center of mass velocity and adjust the velocities of the bodies to set it to zero
    vector_math.Vector3 centerOfMassVelocity = vector_math.Vector3.zero();
    double totalMass = 0.0;
    for (var body in bodies) {
      centerOfMassVelocity += body.velocity * body.mass;
      totalMass += body.mass;
    }
    centerOfMassVelocity /= totalMass;
    for (var body in bodies) {
      body.velocity -= centerOfMassVelocity;
    }

    _ticker = this.createTicker((Duration elapsed) {
      integrate(bodies, timestep, 100);
      setState(() {});
    })
      ..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SpacePainter(bodies),
      child: Container(),
    );
  }
}

class SpacePainter extends CustomPainter {
  final List<Body> bodies;

  SpacePainter(this.bodies);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color.fromARGB(255, 123, 46, 255);

    for (var body in bodies) {
      canvas.drawCircle(
          Offset(body.position.x * 3e-10 + size.width / 2,
              body.position.y * 3e-10 + size.height / 2),
          8,
          paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
