import 'dart:developer';

import 'package:algo_botix_assignment/screens/home/widgets/custom_fab.dart';
import 'package:algo_botix_assignment/core/widgets/custom_snack_bar.dart';
import 'package:algo_botix_assignment/screens/scanner/qr_scanner_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:algo_botix_assignment/blocs/product/product_bloc.dart';
import 'package:algo_botix_assignment/blocs/product/product_event.dart';
import 'package:algo_botix_assignment/blocs/add_edit/add_edit_product_cubit.dart';
import 'package:algo_botix_assignment/blocs/image_picker/image_picker_cubit.dart';
import 'package:algo_botix_assignment/screens/add_edit/add_edit_product_screen.dart';

class HomeFloatingActionButtons extends StatelessWidget {
  const HomeFloatingActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomFloatingActionButton(
          heroTag: 'scan_qr',
          icon: const Icon(Icons.qr_code_scanner),
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const QRScannerScreen()),
            );
            log(result);
            if (result != null && result is String) {
              if (context.mounted) {
                context.read<ProductBloc>().add(
                  SearchProducts(query: result, isFromQrScan: true),
                );
                CustomSnackBar.showSuccess(
                  context,
                  message: "Scanned: $result",
                );
              }
            }
          },
        ),
        const SizedBox(height: 16),
        CustomFloatingActionButton(
          heroTag: 'add_product',
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (_) => ImagePickerCubit()),
                      BlocProvider(create: (_) => AddEditProductCubit()),
                    ],
                    child: AddEditProductScreen(),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
