import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum GadgetStatus {
  disconnected("Disconnected"),
  active("Active"),
  alert("Alert");

  final String displayStatus;

  const GadgetStatus(this.displayStatus);
}

enum GadgetType {
  light,
  conditioner,
  teapot;
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

enum ConditionState {
  off("Off"),
  on("On");

  final String displayStatus;

  const ConditionState(this.displayStatus);
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
  final ConditionState state;

  Conditioning({
    super.id,
    required super.name,
    required super.status,
    required this.temperature,
    required this.mode,
    required this.state,
  });

  @override
  Conditioning copyWith({
    String? id,
    String? name,
    GadgetStatus? status,
    ConditionState? state,
    ConditioningMode? mode,
    double? temperature,
  }) {
    return Conditioning(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      state: state ?? this.state,
      temperature: temperature ?? this.temperature,
      mode: mode ?? this.mode
    );
  }
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


final sampleConditioningAppliances = [
  Conditioning(name: "Спальня", status: GadgetStatus.active, temperature: 27, mode: ConditioningMode.cooling, state: ConditionState.on),
];