import 'package:flutter/material.dart';
import '../viewmodels/cruise_booking_viewmodel.dart';
import 'widgets/action_bar_widget.dart';
import 'widgets/booking_controls_widget.dart';
import 'widgets/description_widget.dart';
import 'widgets/header_image_widget.dart';
import 'widgets/title_section_widget.dart';

class CruiseBookingScreen extends StatelessWidget {
  final CruiseBookingViewModel viewModel;

  const CruiseBookingScreen({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        return OrientationBuilder(
          builder: (context, orientation) {
            final isLandscape = orientation == Orientation.landscape;

            return Scaffold(
              appBar: AppBar(
                title: Text(
                  isLandscape
                      ? 'Sibu River Cruise & Heritage (Landscape Split View)'
                      : 'Sibu River Cruise & Heritage',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                actions: [
                  if (isLandscape)
                    Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Center(
                        child: Text(
                          'Orientation: landscape',
                          style: TextStyle(fontSize: 11, color: Colors.white70),
                        ),
                      ),
                    ),
                  IconButton(
                    icon: Icon(
                      viewModel.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                    ),
                    tooltip: 'Toggle Theme',
                    onPressed: () {
                      viewModel.toggleTheme(!viewModel.isDarkMode);
                    },
                  ),
                ],
              ),
              body: isLandscape
                  ? _buildLandscapeLayout(context)
                  : _buildPortraitLayout(context),
            );
          },
        );
      },
    );
  }

  // Portrait Layout: Single Column ListView
  Widget _buildPortraitLayout(BuildContext context) {
    return ListView(
      children: [
        HeaderImageWidget(
          imagePath: viewModel.destination.imagePath,
          label: viewModel.destination.landmarkTag,
          height: 240,
        ),
        TitleSectionWidget(
          title: viewModel.destination.name,
          location: viewModel.destination.location,
          rating: viewModel.rating,
          isFavorited: viewModel.isFavorited,
          onToggleRating: viewModel.toggleRating,
        ),
        const ActionBarWidget(),
        const Divider(indent: 20, endIndent: 20, height: 1),
        DescriptionWidget(
          description: viewModel.destination.description,
        ),
        const Divider(indent: 20, endIndent: 20, height: 1),
        BookingControlsWidget(
          viewModel: viewModel,
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  // Landscape Layout: Side-by-Side Split Pane (Row + Expanded)
  Widget _buildLandscapeLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Left Pane: Hero Image
        const Expanded(
          flex: 4,
          child: HeaderImageWidget(
            imagePath: 'assets/images/rajang_river.jpg',
            label: 'Rajang River Horizon',
            height: double.infinity,
          ),
        ),
        // Right Pane: Details and Controls
        Expanded(
          flex: 5,
          child: ListView(
            children: [
              TitleSectionWidget(
                title: viewModel.destination.name,
                location: viewModel.destination.location,
                rating: viewModel.rating,
                isFavorited: viewModel.isFavorited,
                onToggleRating: viewModel.toggleRating,
              ),
              const ActionBarWidget(),
              const Divider(indent: 20, endIndent: 20, height: 1),
              DescriptionWidget(
                description: viewModel.destination.description,
                showHeader: true,
              ),
              const Divider(indent: 20, endIndent: 20, height: 1),
              BookingControlsWidget(
                viewModel: viewModel,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}
