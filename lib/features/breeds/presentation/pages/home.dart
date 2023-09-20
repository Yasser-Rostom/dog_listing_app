import 'package:dog_listing_app/features/breeds/presentation/bloc/bloc.dart';
import 'package:dog_listing_app/features/breeds/presentation/bloc/event.dart';
import 'package:dog_listing_app/features/breeds/presentation/bloc/state.dart';
import 'package:dog_listing_app/features/breeds/presentation/widgets/breed_list/breed_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Breed Listing"),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.blue.withOpacity(0.1),
        child: Column(children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 30, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
            child: TabBar(
              controller: _tabController,
              isScrollable: false,
              physics: const NeverScrollableScrollPhysics(),
              indicator: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                  ),
                ],
                borderRadius: BorderRadius.circular(16),
                color: Colors.blue,
              ),
              labelColor: Colors.white,
              dividerColor: Colors.transparent,
              unselectedLabelColor: Colors.blue,
              unselectedLabelStyle:
                  const TextStyle(color: Colors.blue, fontSize: 14),
              labelStyle: const TextStyle(color: Colors.white, fontSize: 14),
              tabs: const [
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Tab(
                    text: 'All Breeds',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Tab(
                    text: 'Favorite',
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
              child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.75,
            margin: const EdgeInsets.only(bottom: 5),
            child:
                BlocBuilder<BreedBloc, BreedState>(builder: (context, state) {
              if (state is BreedStateLoading) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.blue,
                ));
              }
              if (state is BreedStateSuccess) {
                return BreeedList(
                  isFetchingFromApi: _tabController.index==0,
                  breedList: state.breedList,
                );
              }
              if (state is BreedStateFailure) {
                return Center(
                    child: Column(
                  children: [
                    const Text("Failed to Fetch"),
                    TextButton(onPressed: () => {}, child: const Text("RETRY"))
                  ],
                ));
              }
              return Container();
            }),
          ))
        ]),
      ),
    );
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        context.read<BreedBloc>().add(BreedEventFetched(
              isFetchingFromAPI: _tabController.index == 0,
            ));
      }
    });
    context.read<BreedBloc>().add(BreedEventFetched(
          isFetchingFromAPI: true,
        ));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}
