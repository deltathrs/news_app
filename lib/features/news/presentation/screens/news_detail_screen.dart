import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/utils/date_formatter.dart';
import 'package:news_app/features/news/domain/entities/news_entity.dart';
import 'package:sizer/sizer.dart';

class NewsDetailScreen extends StatefulWidget {
  final NewsEntity newsArticle;
  const NewsDetailScreen({super.key, required this.newsArticle});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Details',
          style: GoogleFonts.poppins(fontSize: 20.sp, color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.newsArticle.title,
                  style: GoogleFonts.poppins(
                      fontSize: 16.sp, fontWeight: FontWeight.w600))),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${widget.newsArticle.author}, ${DateFormatter.formatApiDate(widget.newsArticle.publishedAt.toString())}",
              style: GoogleFonts.poppins(
                  fontSize: 14.sp, fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: widget.newsArticle.url,
                fit: BoxFit.cover,
                errorWidget: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    height: 200,
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.newsArticle.content,
              style: GoogleFonts.poppins(fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }
}
