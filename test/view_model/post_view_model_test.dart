import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:practice/models/post_model.dart';
import 'package:practice/viewModels/post_view_model.dart';
import '../mocks.mocks.dart'; // Import the generated mock class

void main() {
  late PostViewModel viewModel;
  late MockPostRepository mockRepository;

  setUp(() {
    mockRepository = MockPostRepository();
    viewModel = PostViewModel(mockRepository);
  });

  test("Fetch posts successfully", () async {
    // Arrange: Define expected behavior
    when(mockRepository.fetchPosts()).thenAnswer(
      (_) async => [
        PostModel(id: 1, title: "Test Post", body: "Test Body"),
      ],
    );

    // Act: Call the method
    await viewModel.fetchPosts();

    // Assert: Verify results
    expect(viewModel.posts.length, 1);
    expect(viewModel.posts.first.title, "Test Post");
    expect(viewModel.errorMessage, isNull);
    expect(viewModel.isLoading, false);
  });

  test("Handle API failure", () async {
    // Arrange: Simulate an API error
    when(mockRepository.fetchPosts())
        .thenThrow(Exception("Failed to fetch posts"));

    // Act: Call the method
    await viewModel.fetchPosts();

    // Assert: Verify error handling
    expect(viewModel.posts.isEmpty, true);
    expect(viewModel.errorMessage, "Exception: Failed to fetch posts");
    expect(viewModel.isLoading, false);
  });

  test("Loading state should update correctly", () async {
    // Arrange: Simulate a delay in API response
    when(mockRepository.fetchPosts()).thenAnswer((_) async {
      await Future.delayed(Duration(milliseconds: 500));
      return [PostModel(id: 1, title: "Delayed Post", body: "Delayed Body")];
    });

    // Act: Call the method
    final future = viewModel.fetchPosts();

    // Assert loading state before response
    expect(viewModel.isLoading, true);

    await future; // Wait for the method to complete

    // Assert: Verify final state
    expect(viewModel.isLoading, false);
  });
}
