import 'package:flutter/material.dart';
import 'package:myapprandom/model/card_detail.dart';
import 'package:myapprandom/pages/card_detail_page.dart';
import 'package:myapprandom/repository/card_detail_repository.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  CardDetail? cardDetail;

  var cardDetailRepository = CardDetailRepository();

  void carregarDados() async {
    cardDetail = await cardDetailRepository.get();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          width: double.infinity,
          child: cardDetail == null
              ? LinearProgressIndicator()
              : InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CardDetailPage(
                            cardDetail: cardDetail!,
                          ),
                        ));
                  },
                  child: Card(
                    elevation: 8,
                    shadowColor: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.network(
                                cardDetail!.url,
                                height: 20,
                              ),
                              Text(
                                cardDetail!.title,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            cardDetail!.text,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text("Leia mais..."),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
