import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_extensions.dart';
import '../../base/common_ui_components/custom_app_bar.dart';
import '../../lib_change_language/bloc/change_language_bloc.dart';
import '../../lib_change_language/extensions/language_model_extensions.dart';
import '../../lib_change_language/ui_components/language_picker_button.dart';
import '../blocs/scanner_bloc.dart';
import '../ui_components/card_form.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: context.l10n.featureScanner.scannerPageTitle,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<ScannerBlocType>().events.scanCard(),
        child: Icon(
          Icons.add_a_photo_outlined,
          color: context.designSystem.colors.white,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(context.designSystem.spacing.xs),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildLanguageButton(context),
                const CardForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageButton(BuildContext context) => SizedBox(
        width: context.designSystem.spacing.xxxxl2,
        height: context.designSystem.spacing.xxxxl2,
        child: LanguagePickerButton(
          onChanged: (language) => context
              .read<ChangeLanguageBlocType>()
              .events
              .setCurrentLanguage(language),
          padding: context.designSystem.spacing.xss,
          buttonText:
              context.l10n.featureScanner.scannerPageChangeLanguageButton,
          translate: (model) => model.asText(context),
        ),
      );
}
