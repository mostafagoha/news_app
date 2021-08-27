import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter_app/shared/components/components.dart';
import 'package:news_flutter_app/shared/cubit/cubit.dart';
import 'package:news_flutter_app/shared/cubit/states.dart';


class SearchScreen extends StatelessWidget {


  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit
            .get(context)
            .search;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Search',
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  label: 'Search',
                  controller: searchController,
                  type: TextInputType.text,
                  prefix: Icons.search,
                  onChanged: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Search must not be empty !';
                    }
                    return null;
                  },

                ),
              ),
              Expanded(
                child: articleBuilder(list, context,isSearch: true),
              ),
            ],
          ),
        );
      },
    );
  }

// class SearchScreen extends StatelessWidget {
//
//   var searchController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<NewsCubit,NewsStates>(
//       listener: (context,state){},
//       builder: (context,state){
//         var list = NewsCubit.get(context).search;
//         return Scaffold(
//           appBar: AppBar(),
//           body: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: defaultFormField(
//                     controller: searchController,
//                     type: TextInputType.text,
//                     validator: (String value){
//                       if(value.isEmpty){
//                         return 'search must not be empty';
//                       }else {return null;}
//                     },
//                     label: 'Search',
//                     prefix: Icons.search,
//                     onChanged: (value)
//                     {
//                       NewsCubit.get(context).getSearch(value);
//                     }
//                 ),
//               ),
//               Expanded(child: articleBuilder(list,context)),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
}
