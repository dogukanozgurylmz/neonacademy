import 'package:flutter/material.dart';
import 'package:future_tech_app/models/device_model.dart';
import 'models/room_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController roomNameController = TextEditingController();
  final List<DeviceModel> selectedDevices = [];
  final List<DeviceModel> devices = [
    DeviceModel(
      name: "TV",
      status: false,
      icon: const Icon(Icons.tv),
    ),
    DeviceModel(
      name: "Coffee",
      status: false,
      icon: const Icon(Icons.coffee_maker),
    ),
    DeviceModel(
      name: "Light",
      status: false,
      icon: const Icon(Icons.light),
    ),
    DeviceModel(
      name: "Music",
      status: false,
      icon: const Icon(Icons.play_circle_rounded),
    ),
    DeviceModel(
      name: "Fan",
      status: false,
      icon: const Icon(Icons.wind_power_rounded),
    ),
    DeviceModel(
      name: "Windows",
      status: false,
      icon: const Icon(Icons.window_outlined),
    ),
  ];
  final List<RoomModel> rooms = [];

  Future<void> addRoom() async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Add Room'),
        content: Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(controller: roomNameController),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              RoomModel roomModel = RoomModel(
                roomName: roomNameController.text.trim(),
                devices: [],
              );
              setState(() {
                rooms.add(roomModel);
              });
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffDEE7FF),
      appBar: AppBar(
        title: const Text("FutureTech"),
        backgroundColor: const Color(0xffDEE7FF),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          selectedDevices.clear();
          await addRoom();
        },
        child: const Icon(Icons.add),
      ),
      body: RoomsWidget(
        rooms: rooms,
        selectedDevices: selectedDevices,
        devices: devices,
      ),
    );
  }
}

class RoomsWidget extends StatefulWidget {
  final List<DeviceModel> selectedDevices;
  final List<DeviceModel> devices;
  final List<RoomModel> rooms;
  const RoomsWidget({
    super.key,
    required this.rooms,
    required this.selectedDevices,
    required this.devices,
  });

  @override
  State<RoomsWidget> createState() => _RoomsWidgetState();
}

class _RoomsWidgetState extends State<RoomsWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.rooms.length,
      itemBuilder: (context, index) {
        var room = widget.rooms[index];
        return Column(
          children: [
            Text(room.roomName!),
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        List<DeviceModel> selectedDevs =
                            await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddDeviceView(
                            devices: widget.devices,
                            selectedDevices: widget.selectedDevices,
                          ),
                        ));
                        room.devices!.clear();
                        setState(() {
                          room.devices!.addAll([...selectedDevs.toList()]);
                        });
                      },
                      icon: const Icon(Icons.add),
                    ),
                    if (room.devices != null)
                      ...room.devices!
                          .map((device) => Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onLongPress: () {
                                        setState(() {
                                          room.devices!.remove(device);
                                        });
                                      },
                                      child: device.icon!,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(device.name!),
                                    Switch(
                                      value: device.status ?? false,
                                      onChanged: (value) {
                                        setState(() {
                                          device.status = value;
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ))
                          .toList(),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class AddDeviceView extends StatefulWidget {
  final List<DeviceModel> selectedDevices;
  final List<DeviceModel> devices;
  const AddDeviceView({
    super.key,
    required this.selectedDevices,
    required this.devices,
  });

  @override
  State<AddDeviceView> createState() => _AddDeviceViewState();
}

class _AddDeviceViewState extends State<AddDeviceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            for (var device in widget.devices)
              ListTile(
                title: Text(device.name!),
                leading: device.icon!,
                trailing: widget.selectedDevices.contains(device)
                    ? const Icon(Icons.check)
                    : null,
                onTap: () {
                  DeviceModel deviceModel = DeviceModel(
                    name: device.name,
                    icon: device.icon,
                    status: device.status,
                  );
                  setState(() {
                    widget.selectedDevices.add(deviceModel);
                  });
                },
              ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(widget.selectedDevices);
              },
              child: const Text("OK"),
            )
          ],
        ),
      ),
    );
  }
}
