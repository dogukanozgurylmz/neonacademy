import 'package:comedy_club_app/home/home_view_model.dart';
import 'package:comedy_club_app/models/activity_model.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewModel viewModel = HomeViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff242424),
      appBar: AppBar(
        title: const Text(
          "Comedy Club",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff242424),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Yaklaşan etkinlikler",
                style: TextStyle(color: Colors.white),
              ),
              ActivitiesWidget(viewModel: viewModel),
              const SizedBox(height: 8),
              const Text(
                "Geçmiş etkinlik görselleri",
                style: TextStyle(color: Colors.white),
              ),
              ActivityImagesWidget(viewModel: viewModel),
            ],
          ),
        ),
      ),
    );
  }
}

class ActivityImagesWidget extends StatelessWidget {
  const ActivityImagesWidget({
    super.key,
    required this.viewModel,
  });

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: viewModel.activityImages.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 3,
        crossAxisSpacing: 3,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                viewModel.activityImages[index],
              ),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}

class ActivitiesWidget extends StatelessWidget {
  const ActivitiesWidget({
    super.key,
    required this.viewModel,
  });

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: viewModel.activities.length,
        itemBuilder: (context, index) {
          var activity = viewModel.activities[index];
          return ActivityWidget(activity: activity);
        },
      ),
    );
  }
}

class ActivityWidget extends StatelessWidget {
  const ActivityWidget({
    super.key,
    required this.activity,
  });

  final ActivityModel activity;

  void showTickets(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            color: Colors.amber.shade50,
          ),
          height: 300,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Biletler'),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: activity.tickets!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(activity.tickets![index].title!),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (var ticketNumber
                                    in activity.tickets![index].ticketNumbers!)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Chip(
                                          label: Text(ticketNumber),
                                          side: const BorderSide(
                                            width: 0,
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        Text(activity.tickets![index].price!),
                                      ],
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showTickets(context);
      },
      child: Container(
        height: 200,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
            topRight: Radius.circular(40),
            bottomLeft: Radius.zero,
          ),
          image: DecorationImage(
            image: NetworkImage(activity.image!),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Color.fromRGBO(0, 0, 0, 1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
              topRight: Radius.circular(40),
              bottomLeft: Radius.zero,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${activity.date!.day}.${activity.date!.month}.${activity.date!.year}",
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                activity.name!,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
