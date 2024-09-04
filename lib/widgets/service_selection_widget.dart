import 'package:flutter/material.dart';
import '../models/booking.dart';

class ServiceSelectionWidget extends StatefulWidget {
  final CoreService? selectedService;
  final int nailArt;
  final int nailRemoval;
  final Function(CoreService?) onServiceSelected;
  final Function(int) onNailArtChanged;
  final Function(int) onNailRemovalChanged;

  const ServiceSelectionWidget({
    super.key,
    this.selectedService,
    required this.nailArt,
    required this.nailRemoval,
    required this.onServiceSelected,
    required this.onNailArtChanged,
    required this.onNailRemovalChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ServiceSelectionWidgetState createState() => _ServiceSelectionWidgetState();
}

class _ServiceSelectionWidgetState extends State<ServiceSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Select Core Service:'),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _buildServiceCard(
                CoreService.gelPolish,
                Icons.brush,
                'Gel Polish',
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: _buildServiceCard(
                CoreService.builderGel,
                Icons.layers,
                'Builder Gel',
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: _buildServiceCard(
                CoreService.gelExtension,
                Icons.extension,
                'Gel Extension',
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text('Nail Art: £${widget.nailArt}'),
        Slider(
          value: widget.nailArt.toDouble(),
          min: 0,
          max: 10,
          //label: '${widget.nailArt}',
          onChanged: (double value) {
            widget.onNailArtChanged(value.toInt());
          },
        ),
        const SizedBox(height: 20),
        Text('Nail Removal: £${widget.nailRemoval}'),
        Slider(
          value: widget.nailRemoval.toDouble(),
          min: 0,
          max: 10,
          //label: '${widget.nailRemoval}',
          onChanged: (double value) {
            widget.onNailRemovalChanged(value.toInt());
          },
        ),
      ],
    );
  }

  Widget _buildServiceCard(CoreService service, IconData icon, String label) {
    final isSelected = widget.selectedService == service;
    return GestureDetector(
      onTap: () => widget.onServiceSelected(service),
      child: Card(
        color: isSelected ? Colors.white : Colors.blueGrey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 40,
                color: isSelected
                    ? const Color.fromARGB(255, 72, 199, 242)
                    : Colors.grey,
              ),
              const SizedBox(height: 10),
              Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      color: isSelected
                          ? const Color.fromARGB(255, 72, 199, 242)
                          : Colors.grey,
                    ),
                    maxLines: 1, // Prevents text wrapping
                    overflow: TextOverflow.ellipsis, // Adds ellipsis if text overflows
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
