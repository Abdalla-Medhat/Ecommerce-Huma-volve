import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'products_details_states.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  // final GetProductDetailsUseCase getProductDetailsUseCase; // ضع الـ UseCase هنا

  ProductDetailsCubit(/* {required this.getProductDetailsUseCase} */)
    : super(ProductDetailsInitial());

  Future<void> getProductDetails(int productId) async {
    emit(ProductDetailsLoading());

    // استبدل هذا السعر/الاستدعاء بالـ UseCase الحقيقي لديك
    // final result = await getProductDetailsUseCase.invoke(productId);

    // محاكاة لطلب الـ API (استبدلها بالنتيجة الفعلية من الـ UseCase أو الـ Repository)
    await Future.delayed(const Duration(milliseconds: 500));

    // فرضيًا لو رجعت البيانات بنجاح:
    // result.fold(
    //   (failure) => emit(ProductDetailsError(failure.failureMessage)),
    //   (product) => emit(ProductDetailsSuccess(product)),
    // );
  }
}
