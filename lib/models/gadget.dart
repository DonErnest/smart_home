import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum GadgetStatus {
  disconnected("Disconnected"),
  active("Active"),
  alert("Alert");

  final String displayStatus;

  const GadgetStatus(this.displayStatus);
}

enum GadgetType { light, conditioner, teapot }

class Gadget {
  late final String id;
  final String name;
  final GadgetStatus status;
  final GadgetType type;

  Gadget({
    String? id,
    required this.name,
    required this.status,
    required this.type,
  }) : id = id ?? uuid.v4();

  Gadget copyWith({String? id, String? name, GadgetStatus? status}) {
    return Gadget(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      type: type,
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
  }) : super(type: GadgetType.light);

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
  }) : super(type: GadgetType.conditioner);

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
      mode: mode ?? this.mode,
    );
  }
}

enum TeapotState {
  heating("Heating"),
  idle("Idle");

  final String displayStatus;

  const TeapotState(this.displayStatus);
}

class Teapot extends Gadget {
  final double waterLevelMl;
  final double temperature;
  final bool sendingDataToCIA;
  final TeapotState state;

  Teapot({
    super.id,
    required super.name,
    required super.status,
    required this.waterLevelMl,
    required this.temperature,
    required this.sendingDataToCIA,
    required this.state,
  }) : super(type: GadgetType.teapot);

  @override
  Teapot copyWith({
    String? id,
    String? name,
    GadgetStatus? status,
    double? temperature,
    double? waterLevelMl,
    TeapotState? state,
    bool? sendingDataToCIA,
  }) {
    return Teapot(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      state: state ?? this.state,
      temperature: temperature ?? this.temperature,
      waterLevelMl: waterLevelMl ?? this.waterLevelMl,
      sendingDataToCIA: sendingDataToCIA ?? this.sendingDataToCIA,
    );
  }
}

final sampleLightingAppliances = [
  Light(name: "Гостиная", status: GadgetStatus.active, state: LightState.off),
];

final sampleTeapotAppliances = [
  Teapot(
    name: "Чайник умный",
    status: GadgetStatus.active,
    state: TeapotState.idle,
    temperature: 20.0,
    waterLevelMl: 400.0,
    sendingDataToCIA: true,
  ),
  Teapot(
    name: "Чайник в подвале",
    status: GadgetStatus.disconnected,
    state: TeapotState.idle,
    temperature: 20.0,
    waterLevelMl: 400.0,
    sendingDataToCIA: true,
  ),
];

final sampleConditioningAppliances = [
  Conditioning(
    name: "Спальня",
    status: GadgetStatus.active,
    temperature: 27,
    mode: ConditioningMode.cooling,
    state: ConditionState.on,
  ),
  Conditioning(
    name: "Чердак",
    status: GadgetStatus.disconnected,
    temperature: 27,
    mode: ConditioningMode.cooling,
    state: ConditionState.on,
  ),
];
