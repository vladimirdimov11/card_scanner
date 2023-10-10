import 'package:credit_card_scanner/credit_card_scanner.dart';

class CardScannerService {
  Future<CardDetails?> scanCard() async => CardScanner.scanCard(
        scanOptions: const CardScanOptions(
          scanCardHolderName: true,
          validCardsToScanBeforeFinishingScan: 1,
          possibleCardHolderNamePositions: [
            CardHolderNameScanPosition.belowCardNumber,
          ],
        ),
      );
}
