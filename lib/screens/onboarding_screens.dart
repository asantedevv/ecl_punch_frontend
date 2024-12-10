// import 'package:card_swiper/card_swiper.dart';
// import 'package:ecl_punchin/screens/intro_1.dart';
// import 'package:ecl_punchin/screens/intro_2.dart';
// import 'package:ecl_punchin/screens/intro_3.dart';
// import 'package:flutter/material.dart';

// class OnboardingScreens extends StatefulWidget {
//   const OnboardingScreens({super.key});

//   @override
//   State<OnboardingScreens> createState() => _OnboardingScreensState();
// }

// class _OnboardingScreensState extends State<OnboardingScreens> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Swiper(
//         itemBuilder: (BuildContext context,int index){
//           return Intro1();
//         },
//         itemCount: 3,
//         pagination: SwiperCustomPagination(
//         builder:(BuildContext context, SwiperPluginConfig config){
//             return const Intro1();
//         },
//     ),
    
//         ),
//     );
//   }
// }

import 'package:card_swiper/card_swiper.dart';
import 'package:ecl_punchin/screens/intro_1.dart';
import 'package:ecl_punchin/screens/intro_2.dart';
import 'package:ecl_punchin/screens/intro_3.dart';
import 'package:flutter/material.dart';

class OnboardingScreens extends StatefulWidget {
  const OnboardingScreens({super.key});

  @override
  State<OnboardingScreens> createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Swiper(
        loop: false,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return const Intro1(); 
          } else if (index == 1) {
            return const Intro2(); 
          } else {
            return const Intro3(); 
          }
        },
        itemCount: 3, 
        pagination: const SwiperPagination(), 
        // control: const SwiperControl(), // Add navigation controls (optional)
      ),
    );
  }
}
