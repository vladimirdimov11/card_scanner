import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_extensions.dart';
import '../../base/common_ui_components/regular_button.dart';
import '../blocs/success_bloc.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                context.l10n.featureSuccess.successMessage,
                textAlign: TextAlign.center,
                style: context.designSystem.typography.h1Bold18,
              ),
              SizedBox(
                height: context.designSystem.spacing.s,
              ),
              RegularButton(
                title: context.l10n.featureSuccess.successScanAgainButton,
                onPressed: context.read<SuccessBlocType>().events.scanAgain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
