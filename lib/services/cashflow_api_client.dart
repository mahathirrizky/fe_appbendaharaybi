import 'dart:convert';

import 'package:http/http.dart' as http;

import '../bloc/bloc.dart';
import '../constants/constants.dart';
import '../models/models.dart';

final authBloc = AuthBloc();
final token = authBloc.getToken();

class CashflowApiClient {
  Future<List<CashflowModel>> cashflowsget() async {
    final response = await http.get(
      Uri.parse('$base_url/cashflows'),
      headers: {'Authorization': 'Bearer $token'},
    );
    // final Map<String, dynamic> jsonResponse = json.decode(response.body);
    // print(jsonResponse['data']);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      // print(jsonResponse);
      final List<dynamic> jsonData = jsonResponse['data'];
      // print(jsonData);
      final List<CashflowModel> cashflowList =
          jsonData.map((json) => CashflowModel.fromJson(json)).toList();

      return cashflowList;
    } else {
      throw Exception('Failed to load cashflow data');
    }
  }

  Future<void> cashflowsadd(CashflowEventAdd event) async {
    try {
      final url = Uri.parse('$base_url/createcashflow');
      final response = await http.post(url,
          headers: {'Authorization': 'Bearer $token'},
          body: jsonEncode({
            'jumlah': event.jumlahdana,
            'keterangan': event.keterangan,
            'jenis': event.jenis,
          }));
      if (response.statusCode == 200) {
        // Cashflow added successfully
        return;
      } else {
        throw Exception('Failed to add cashflow');
      }
    } catch (e) {
      throw Exception('Failed to add cashflow: $e');
    }
  }
}
