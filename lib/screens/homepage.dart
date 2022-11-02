import 'package:admob_app/screens/detailpage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../providers/adprovider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
     AdProvider adProvider = Provider.of<AdProvider>(context, listen: false);
    adProvider.initializeHomePageBanner();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Show ads')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const DetailsPage()));
                  },
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    height: 300,
                    width: double.infinity,
                    imageUrl:
                        'https://images.unsplash.com/photo-1550263305-c8851928f1f5?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 25,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 40,
                      color: Colors.grey.shade200,
                      child: Card(
                        child: Center(child: Text('Card Number : $index')),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ), bottomNavigationBar: Consumer<AdProvider>(
        builder: (context, adProvider, child) {

          if(adProvider.isHomePageBannerLoaded) {
            return Container(
              height: adProvider.homePageBanner.size.height.toDouble(),
              child: AdWidget(ad: adProvider.homePageBanner,),
            );
          }
          else {
            return Container(height: 0,);
          }

        },
      ),);
  }
}
