import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../providers/adprovider.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();

    AdProvider adProvider = Provider.of<AdProvider>(context, listen: false);
    adProvider.initializeDetailsPageBanner();
    adProvider.initializeFullPageAd();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        AdProvider adProvider = Provider.of<AdProvider>(context, listen: false);

        if (adProvider.isFullPageAdLoaded) {
          adProvider.fullPageAd.show();
        }

        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(title: const Text('DetailPage')),
        body: const Center(
          child: Text('DetailsPage is here..!'),
        ),
        bottomNavigationBar: Consumer<AdProvider>(
          builder: (context, adProvider, child) {
            if (adProvider.isDetailsPageBannerLoaded) {
              return Container(
                height: adProvider.detailsPageBanner.size.height.toDouble(),
                child: AdWidget(
                  ad: adProvider.detailsPageBanner,
                ),
              );
            } else {
              return Container(
                height: 0,
              );
            }
          },
        ),
      ),
    );
  }
}
