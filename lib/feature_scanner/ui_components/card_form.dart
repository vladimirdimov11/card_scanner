import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:flutter_rx_bloc/rx_form.dart';
import 'package:widget_toolkit/ui_components.dart';

import '../../app_extensions.dart';
import '../../base/common_ui_components/app_error_modal_widget.dart';
import '../../base/extensions/async_snapshot_extensions.dart';
import '../../base/extensions/error_model_field_translations.dart';
import '../../base/utils/card_date_input_formatter.dart';
import '../../base/utils/card_number_input_formatter.dart';
import '../blocs/scanner_bloc.dart';

class CardForm extends StatefulWidget {
  const CardForm({super.key});

  @override
  State<CardForm> createState() => _CardFormState();
}

class _CardFormState extends State<CardForm> {
  final _numberFocusNode = FocusNode(debugLabel: 'numberFocus');
  final _nameFocusNode = FocusNode(debugLabel: 'nameFocus');
  final _expDateFocusNode = FocusNode(debugLabel: 'expDateFocus');
  final _cvvFocusNode = FocusNode(debugLabel: 'cvvFocus');

  /// Get all focus nodes of the form
  List<FocusNode> get _focusNodes => [
        _numberFocusNode,
        _nameFocusNode,
        _expDateFocusNode,
        _cvvFocusNode,
      ];

  @override
  void dispose() {
// Since the focus nodes are long living object, they should be disposed.
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RxTextFormFieldBuilder<ScannerBlocType>(
            state: (bloc) => bloc.states.cardNumber.translate(context),
            showErrorState: (bloc) => bloc.states.showErrors,
            onChanged: (bloc, value) => bloc.events.setCardNumber(value),
            builder: (fieldState) => _buildCardNumberField(
              fieldState,
              context,
            ),
          ),
          SizedBox(height: context.designSystem.spacing.xs1),
          RxTextFormFieldBuilder<ScannerBlocType>(
            state: (bloc) => bloc.states.cardHolder.translate(context),
            showErrorState: (bloc) => bloc.states.showErrors,
            onChanged: (bloc, value) => bloc.events.setCardHolder(value),
            builder: (fieldState) => _buildCardholderNameField(
              fieldState,
              context,
            ),
          ),
          SizedBox(height: context.designSystem.spacing.xs1),
          RxTextFormFieldBuilder<ScannerBlocType>(
            state: (bloc) => bloc.states.cardExpirationDate.translate(context),
            showErrorState: (bloc) => bloc.states.showErrors,
            onChanged: (bloc, value) => bloc.events.setCardExpDate(value),
            builder: (fieldState) => _buildCardExpDateField(
              fieldState,
              context,
            ),
          ),
          SizedBox(height: context.designSystem.spacing.xs1),
          RxTextFormFieldBuilder<ScannerBlocType>(
            state: (bloc) => bloc.states.cardCVV.translate(context),
            showErrorState: (bloc) => bloc.states.showErrors,
            onChanged: (bloc, value) => bloc.events.setCardCVV(value),
            builder: (fieldState) => _buildCardCVVField(
              fieldState,
              context,
            ),
          ),
          const Divider(indent: 5, endIndent: 5),
          SizedBox(height: context.designSystem.spacing.xs1),
          RxBlocBuilder<ScannerBlocType, bool>(
            state: (bloc) => bloc.states.isLoading,
            builder: _buildSubmitButton,
          ),
          AppErrorModalWidget<ScannerBlocType>(
            errorState: (bloc) => bloc.states.errors,
          ),
        ],
      );

  TextFormField _buildCardNumberField(
    RxTextFormFieldBuilderState<ScannerBlocType> fieldState,
    BuildContext context,
  ) =>
      TextFormField(
        key: K.scannerCardNumberField,
        controller: fieldState.controller,
        textInputAction: TextInputAction.next,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(19),
          CardNumberInputFormatter(),
        ],
        keyboardType: TextInputType.number,
        focusNode: _numberFocusNode,
        onEditingComplete: () =>
            FocusScope.of(context).requestFocus(_nameFocusNode),
        decoration: fieldState.decoration.copyWith(
          labelText: context.l10n.field.cardNumber,
        ),
      );

  TextFormField _buildCardholderNameField(
    RxTextFormFieldBuilderState<ScannerBlocType> fieldState,
    BuildContext context,
  ) =>
      TextFormField(
        key: K.scannerCardHolderField,
        controller: fieldState.controller,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        focusNode: _nameFocusNode,
        onEditingComplete: () =>
            FocusScope.of(context).requestFocus(_expDateFocusNode),
        decoration: fieldState.decoration.copyWith(
          labelText: context.l10n.field.cardHolderName,
        ),
      );

  TextFormField _buildCardExpDateField(
    RxTextFormFieldBuilderState<ScannerBlocType> fieldState,
    BuildContext context,
  ) =>
      TextFormField(
        key: K.scannerCardExpDateField,
        controller: fieldState.controller,
        textInputAction: TextInputAction.next,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(4),
          CardMonthInputFormatter(),
        ],
        keyboardType: TextInputType.datetime,
        focusNode: _expDateFocusNode,
        onEditingComplete: () =>
            FocusScope.of(context).requestFocus(_cvvFocusNode),
        decoration: fieldState.decoration.copyWith(
          labelText: context.l10n.field.cardExpDate,
        ),
      );

  TextFormField _buildCardCVVField(
    RxTextFormFieldBuilderState<ScannerBlocType> fieldState,
    BuildContext context,
  ) =>
      TextFormField(
        key: K.scannerCardCVVField,
        controller: fieldState.controller,
        textInputAction: TextInputAction.done,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(4),
        ],
        keyboardType: TextInputType.number,
        focusNode: _cvvFocusNode,
        onEditingComplete: () => FocusScope.of(context).unfocus(),
        decoration: fieldState.decoration.copyWith(
          labelText: context.l10n.field.cardCVV,
        ),
      );

  GradientFillButton _buildSubmitButton(
    BuildContext context,
    AsyncSnapshot<bool> loadingState,
    ScannerBlocType bloc,
  ) =>
      GradientFillButton(
        key: K.scannerSubmitButton,
        state: loadingState.isLoading
            ? ButtonStateModel.loading
            : ButtonStateModel.enabled,
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          bloc.events.submitCard();
        },
        text: context.l10n.featureScanner.scannerPageSubmitButton,
      );
}
