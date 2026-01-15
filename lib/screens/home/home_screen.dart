import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:algo_botix_assignment/blocs/product/product_bloc.dart';
import 'package:algo_botix_assignment/blocs/product/product_event.dart';
import 'package:algo_botix_assignment/blocs/product/product_state.dart';
import 'package:algo_botix_assignment/screens/home/widgets/product_card.dart';
import 'package:algo_botix_assignment/screens/home/widgets/empty_product_state_widget.dart';
import 'package:algo_botix_assignment/core/widgets/custom_app_bar.dart';
import 'package:algo_botix_assignment/screens/home/widgets/custom_search_bar.dart';
import 'package:algo_botix_assignment/screens/home/widgets/home_fabs.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Inventory'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomSearchBar(
              hintText: "Product name or ID",
              onChanged: (value) {
                context.read<ProductBloc>().add(SearchProducts(query: value));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProductError) {
                  return Center(child: Text("Error: ${state.message}"));
                } else if (state is ProductLoaded) {
                  if (state.filteredProducts.isEmpty) {
                    if (state.isFromQrScan) {
                      return EmptyProductScreen(
                        onRetry: () {
                          context.read<ProductBloc>().add(LoadProducts());
                        },
                      );
                    } else {
                      return Center(child: Text("No products found."));
                    }
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<ProductBloc>().add(LoadProducts());
                    },
                    child: ListView.builder(
                      itemCount: state.filteredProducts.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          product: state.filteredProducts[index],
                        );
                      },
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: const HomeFloatingActionButtons(),
    );
  }
}
