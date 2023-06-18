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
      final request = http.MultipartRequest('POST', url);

      // Set the authorization header
      request.headers['Authorization'] = 'Bearer $token';

      // Add the JSON fields
      request.fields['data'] = jsonEncode({
        'jumlah': event.jumlahdana,
        'keterangan': event.keterangan,
        'jenis': event.jenis,
      });

      // Add the image file if available
      if (event.image != null) {
        final file =
            await http.MultipartFile.fromPath('image', event.image!.path);
        request.files.add(file);
      }

      final response = await http.Response.fromStream(await request.send());

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Cashflow added successfully
        // You can process the response body here if needed
        return;
      } else {
        // Handle different HTTP status codes
        final responseBody = jsonDecode(response.body);
        final errorMessage =
            responseBody['message'] ?? 'Failed to add cashflow';
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception('Failed to add cashflow: $e');
    }
  }

  Future<void> cashflowEdit(CashflowEventEdit event) async {
    try {
      final url = Uri.parse('$base_url/cashflow');
      final request = http.MultipartRequest('PUT', url);

      // Set the authorization header
      request.headers['Authorization'] = 'Bearer $token';

      // Add the JSON fields
      request.fields['data'] = jsonEncode({
        'id': event.id,
        'jumlah': event.jumlahdana,
        'keterangan': event.keterangan,
        'image_url': event.imageUrl,
      });

      // Add the new image file if available
      if (event.fileImage != null) {
        final file = await http.MultipartFile.fromPath(
            'newImage', event.fileImage!.path);
        request.files.add(file);
      }

      final response = await http.Response.fromStream(await request.send());

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Cashflow updated successfully
        // You can process the response body here if needed
        return;
      } else {
        // Handle different HTTP status codes
        final responseBody = jsonDecode(response.body);
        final errorMessage =
            responseBody['message'] ?? 'Failed to edit cashflow';
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception('Failed to edit cashflow: $e');
    }
  }

  Future<void> cashflowDelete(CashflowEventDelete event) async {
    try {
      final url = Uri.parse('$base_url/cashflow');
      final request = http.Request('DELETE', url);

      // Set the authorization header
      request.headers['Authorization'] = 'Bearer $token';

      // Add the JSON data
      request.body = jsonEncode({
        'id': event.id,
      });

      final response = await http.Client().send(request);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Cashflow deleted successfully
        // You can process the response body here if needed
        return;
      } else {
        // Handle different HTTP status codes
        final responseBody = await response.stream.bytesToString();
        final errorMessage =
            jsonDecode(responseBody)['message'] ?? 'Failed to delete cashflow';
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception('Failed to delete cashflow: $e');
    }
  }
}
