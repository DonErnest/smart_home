import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum GadgetStatus {
  disconnected("Disconnected"),
  active("Active"),
  processing("Processing"),
  alert("Alert");

  final String displayStatus;

  const GadgetStatus(this.displayStatus);
}

class Gadget {
  late final String id;
  final String name;
  final GadgetStatus status;

  Gadget({String? id, required this.name, required this.status})
    : id = id ?? uuid.v4();

  Gadget copyWith({String? id, String? name, GadgetStatus? status}) {
    return Gadget(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }
}

enum LightState {
  off("Off"),
  on("On"),
  onMovement("Turned on movement");

  final String displayStatus;

  const LightState(this.displayStatus);
}

class Light extends Gadget {
  final LightState state;

  Light({
    super.id,
    required super.name,
    required super.status,
    required this.state,
  });

  @override
  Light copyWith({
    String? id,
    String? name,
    GadgetStatus? status,
    LightState? state,
  }) {
    return Light(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      state: state ?? this.state,
    );
  }
}

enum ConditioningMode {
  heating("Heating"),
  cooling("Cooling"),
  aeration("Aeration");

  final String displayStatus;

  const ConditioningMode(this.displayStatus);
}

class Conditioning extends Gadget {
  final double temperature;
  final ConditioningMode mode;

  Conditioning({
    required super.name,
    required super.status,
    required this.temperature,
    required this.mode,
  });
}

class Teapot extends Gadget {
  final double waterLevelMl;
  final double temperature;
  final bool sendingDataToCIA;

  Teapot({
    required super.name,
    required super.status,
    required this.waterLevelMl,
    required this.temperature,
    required this.sendingDataToCIA,
  });
}


final sampleLightingAppliances = [
  Light(name: "Гостиная", status: GadgetStatus.active, state: LightState.off),
];