import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Model/artical_model.dart';
import 'package:news_app/Model/slider_model.dart';
import 'package:news_app/Screen/blogtitle.dart';
import 'package:news_app/Screen/breakingnews.dart';
import 'package:news_app/Services/Slider_data.dart';
import 'package:news_app/Services/data.dart';
import 'package:news_app/Services/news_api.dart';
import 'package:news_app/Widgets/categorytile.dart';
import 'package:news_app/Screen/trendingnews.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Model/category_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> categories =[];
  List<SliderModel> sliders = [];
  List<ArticalModel> articles = [];
  bool _loading = true;
  int activeindex=0;
  @override
  void initState() {
    getSlider();
    categories = getCategories().cast<CategoryModel>();
    getNews();
    super.initState();
  }
  getNews()async{
    NewsApi newsClass= NewsApi();
    await newsClass.getNews();
    articles= newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  getSlider()async{
    SliderData slider= SliderData();
    await slider.getNews();
    sliders = slider.sliders;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title:const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Flutter',style: TextStyle(
              color: Colors.black,fontWeight: FontWeight.bold
            )),
            Text(' News',style: TextStyle(
                color: Colors.blue,fontWeight: FontWeight.bold
            )),
          ],
        ),
      ),
      body: _loading? const Center(
        child:  CircularProgressIndicator(
          color: Colors.black,
        ),
      ) :
       SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              Container(
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: categories.length,
                    itemBuilder: (BuildContext,index){
                    return Categorytile(image: categories[index].Image,
                        CategoryName: categories[index].CategoryName);

                }),
              ),
              const SizedBox(height: 10,),


              //This is a button Section (Breaking News Section and View all button in this section);

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Breaking News!",style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 20
                  ),),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        Breakingnews()));
                  }, child: const Text("View all",style: TextStyle(
                    color: Colors.blue
                  )))
                ],
              ),
              //==========================End of o button section=======>

              // this is a Slider images section for a breaking news slider image
              const SizedBox(height: 10,),
              CarouselSlider.builder(
                  itemCount: sliders.length, itemBuilder: (context,index,realIndex ){
                String? res = sliders[index].urlToImage;
                String? res1 = sliders[index].Title;
                return buildImage(res!, index, res1!);

              },
                  options:CarouselOptions(height: 300,
                    clipBehavior: Clip.antiAlias,
                    autoPlay: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    enlargeCenterPage: true,
                    viewportFraction: 0.9,
                    aspectRatio: 16/9,
                    initialPage: 10,
                    onPageChanged: (index,reason){
                    setState(() {
                      activeindex = index;
                    });
                    }
                  )),
              // ===================== End of a slide image section=========>

              // this is a indicator section  with image slide with i indicator automatically slide with image
              const SizedBox(height: 8,),
               //
               buildIncator(),

              //=============End of indicator section =========>


              //===this is a  trending news section and view all button present in this section

              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   const Text("Trending News!",style: TextStyle(
                     fontWeight: FontWeight.bold,fontSize: 20
                   ),),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TrendingNews()));
                  }, child: const Text("View all",style: TextStyle(
                    color: Colors.blue
                  ),))
                ],
              ),
             const Divider(),

             //===============End of this section ==================>


             const SizedBox(height: 10),
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: articles.length,
                    itemBuilder: (context,index){
                    return Blogtitle(
                        url: articles[index].url!,
                        title: articles[index].Title!,
                        desc: articles[index].description!,
                        urlToImage: articles[index].urlToImage!);
                    }),
              )

            ],
          ),
        ),
      ),

    );

  }
  // This Widget work to image slider
  Widget buildImage(String image, int index, String name)=> Container(
    margin: const EdgeInsets.symmetric(horizontal: 5),
    child: Stack(
      children: [
        ClipRRect(
          borderRadius:  BorderRadius.circular(15),
          child: CachedNetworkImage(
            height: 250,width: MediaQuery.of(context).size.width,
            imageUrl: image,fit: BoxFit.cover,
            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 10,),
          margin:const  EdgeInsets.only(top: 205),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),bottomLeft:Radius.circular(10)),
            color: Colors.black26,
          ),
          child: Text(name,maxLines: 2,style: const TextStyle(
            color: Colors.white,fontSize: 14,fontWeight: FontWeight.w600
          ),),
        )
      ],
    ),
  );
  // Animated dot with a slider
  Widget buildIncator()=>AnimatedSmoothIndicator(
      activeIndex: activeindex, count: 5,effect: const JumpingDotEffect(
    activeDotColor: Colors.blueAccent,
    dotHeight: 8,
    dotWidth: 8,
    jumpScale: 1.0,
    verticalOffset: 2,
    spacing: 3,
  ),);
}
