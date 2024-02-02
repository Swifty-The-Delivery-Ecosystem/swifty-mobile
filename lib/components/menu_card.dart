import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:swifty_mobile/models/menuItemModel.dart";

class MenuCard extends StatelessWidget {
  final MenuItem item;
  final int quantityInCart;
  final VoidCallback onAddToCart;
  final VoidCallback onRemoveFromCart;
  final VoidCallback onUpdateQuantity;

  MenuCard({
    required this.item,
    required this.quantityInCart,
    required this.onAddToCart,
    required this.onRemoveFromCart,
    required this.onUpdateQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 2,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ...

                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _getColorForItemType(item.is_veg),
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    width: 15,
                    height: 15,
                    child: Container(
                      width: 2,
                      height: 2,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _getColorForItemType(item.is_veg),
                      ),
                    ),
                  ),

                  SizedBox(height: 5),
                  Container(
                    child: Text(
                      this.item.name,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  ),
                  Container(
                    child: Text(
                      this.item.price.toString(),
                      style:
                          GoogleFonts.poppins(color: Colors.grey, fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(width: 4), // Add some space between the expanded widgets
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ClipOval(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2)),
                      child: Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTIKBQ1QsbsgJfhfCgWdmw7EA4pakpwVG0lVC4p-U6CGg&s',
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: onRemoveFromCart,
                        child: Container(
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Icon(Icons.remove, color: Colors.grey),
                        ),
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent),
                      ),
                      Text(quantityInCart.toString()),
                      TextButton(
                        onPressed: onAddToCart,
                        child: Container(
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Icon(Icons.add, color: Colors.redAccent),
                        ),
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Color _getColorForItemType(bool itemType) {
  switch (itemType) {
    case true:
      return Colors.green;
    case false:
      return Colors.red;
    default:
      return Colors
          .transparent; // You can set a default color or handle it as per your requirement
  }
}
