import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:swifty_mobile/models/menuItemModel.dart";

class MenuCard extends StatelessWidget {
  MenuItem item;
  MenuCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(2)),
                    width: 15,
                    height: 15,
                    child: Container(
                      width: 2,
                      height: 2,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    child: Text(this.item.name, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 20,)),
                  ),
                  Container(
                    child: Text(this.item.price.toString(), style: GoogleFonts.poppins(color: Colors.grey, fontSize: 15),),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ClipOval(child: Card(shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTIKBQ1QsbsgJfhfCgWdmw7EA4pakpwVG0lVC4p-U6CGg&s', height: 100,width: 100, fit: BoxFit.cover,))),
                  
                ],
              )
            ],
          )),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 2,
    );
  }
}