import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_3_blabla_project/ui/providers/rides_preferences_provider.dart';
import '../../../model/ride/ride_filter.dart';
import 'widgets/ride_pref_bar.dart';
import '../../../model/ride/ride.dart';
import '../../../model/ride/ride_pref.dart';
import '../../../service/rides_service.dart';
import '../../theme/theme.dart';
import '../../../utils/animations_util.dart';
import 'widgets/ride_pref_modal.dart';
import 'widgets/rides_tile.dart';


class RidesScreen extends StatelessWidget {
  const RidesScreen({super.key});

  void onBackPressed(BuildContext context) {
    Navigator.of(context).pop();
  }

  void onPreferencePressed(
      BuildContext context, RidePreference currentPreference) async {
    RidePreference? newPreference =
        await Navigator.of(context).push<RidePreference>(
      AnimationUtils.createTopToBottomRoute(
        RidePrefModal(initialPreference: currentPreference),
      ),
    );
    if (newPreference != null) {
      context
          .read<RidesPreferencesProvider>()
          .setCurrentPreference(newPreference);
    }
  }

  @override
  Widget build(BuildContext context) {
    final preferencesProvider = context.watch<RidesPreferencesProvider>();
    RidePreference? currentPreference =
        preferencesProvider.currentPreference;
    
    RideFilter currentFilter = RideFilter();
    List<Ride> matchingRides = RidesService.instance.getRidesFor(currentPreference!, currentFilter);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: BlaSpacings.m, vertical: BlaSpacings.s),
        child: Column(
          children: [
            RidePrefBar(
              ridePreference: currentPreference,
              onBackPressed: () => onBackPressed(context),
              onPreferencePressed: () => onPreferencePressed(context, currentPreference),
              onFilterPressed: () {}, // Add your filter logic here
            ),
            Expanded(
              child: ListView.builder(
                itemCount: matchingRides.length,
                itemBuilder: (ctx, index) =>
                    RideTile(ride: matchingRides[index], onPressed: () {}),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


 