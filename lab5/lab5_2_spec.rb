require 'rspec'
require './lab5_2.rb'

RSpec.describe PostsController do
  let(:posts_controller1){PostsController.new(['post1', 'comment2', 'comment3'])}
  let(:posts_controller2){PostsController.new(['post1', nil, 'comment3'])}
  let(:posts_controller3){PostsController.new([])}
  let(:test_routes1){{
      'GET' => {
        'index' => posts_controller1.method(:index),
        'show' => posts_controller1.method(:show)
      },
      'POST' => posts_controller1.method(:create),
      'PUT' => posts_controller1.method(:update),
      'DELETE' => posts_controller1.method(:destroy)
    }}
  let(:test_routes2){}  

  describe 'index' do
    context 'when there are posts in the array' do
      it 'outputs posts and their indexes in the array' do
        expect{posts_controller1.index}.to output("index\n0. post1\n1. comment2\n2. comment3\n").to_stdout
      end
    end

    context 'when there are posts in the array' do
      it 'outputs posts and their indexes in the array' do
        expect{posts_controller2.index}.to output("index\n0. post1\n2. comment3\n").to_stdout
      end
    end

    context 'when there are no posts in the array' do
      it 'does not output posts and their indexes in the array' do
        expect{posts_controller3.index}.to output("index\n").to_stdout
      end
    end
  end  

  describe 'show' do
    context 'when post exists' do
      it 'outputs the post and its index' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("1")
        expect{posts_controller1.show}.to output("Enter post id: 1. comment2\n").to_stdout
      end
    end

    context 'when post does not exist' do
      it 'outputs a message' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("5")
        expect{posts_controller1.show}.to output("Enter post id: Post doesn't exist\n").to_stdout
      end
    end

    context 'when input is not a number' do
      it 'outputs a message' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("aaa")
        expect{posts_controller1.show}.to output("Enter post id: Post doesn't exist\n").to_stdout
      end
    end
  end  

  describe 'create' do
    context 'when there are no nil elements in the array' do
      it 'adds a new post to the end of the array' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("post4")
        expect{posts_controller1.create}.to output("Enter the post text: 3. post4\n").to_stdout
      end
    end

    context 'when there are nil elements in the array' do
      it 'replaces the first nil element' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("post5")
        expect{posts_controller2.create}.to output("Enter the post text: 1. post5\n").to_stdout
      end
    end

    context 'when the array is empty' do
      it 'adds a new post' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("post6")
        expect{posts_controller3.create}.to output("Enter the post text: 0. post6\n").to_stdout
      end
    end
  end

  describe 'update' do
    context 'when post exists' do
      it 'updates the post' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("0", "post7")
        expect{posts_controller1.update}.to output("Enter post id: Enter the post text: 0. post7\n").to_stdout
      end
    end

    context 'when post does not exist' do
      it 'outputs a message' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("1", "post8")
        expect{posts_controller2.update}.to output("Enter post id: Post doesn't exist\n").to_stdout
      end
    end

    context 'when input is not a number' do
      it 'outputs a message' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("a", "post9")
        expect{posts_controller3.update}.to output("Enter post id: Post doesn't exist\n").to_stdout
      end
    end
  end

  describe 'destroy' do
    context 'when post exists' do
      it 'deletes the post' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("0")
        expect{posts_controller1.destroy}.to output("Enter post id: Post has been deleted\n").to_stdout
      end
    end

    context 'when post does not exist' do
      it 'outputs a message' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("1")
        expect{posts_controller2.destroy}.to output("Enter post id: Post doesn't exist\n").to_stdout
      end
    end

    context 'when input is not a number' do
      it 'outputs a message' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("a", "post9")
        expect{posts_controller3.destroy}.to output("Enter post id: Post doesn't exist\n").to_stdout
      end
    end
  end

  describe 'connection' do
    context 'when there are no routes' do
      it 'outputs a message' do
        posts_controller1.extend Resource
        expect{posts_controller1.connection(test_routes2)}.to output("No route matches for #{posts_controller1}\n").to_stdout
      end
    end

    context 'when the index method is called' do
      it 'outputs posts and their indexes in the array' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("GET", "index", "q")
        posts_controller1.extend Resource
        expect{posts_controller1.connection(test_routes1)}.to output("Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: "+
          "Choose action (index/show) / q to exit: index\n0. post1\n1. comment2\n2. comment3\nChoose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: ").to_stdout
      end
    end

    context 'when the show method is called' do
      it 'outputs the post and its index' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("GET", "show", "0", "q")
        posts_controller1.extend Resource
        expect{posts_controller1.connection(test_routes1)}.to output("Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: "+
          "Choose action (index/show) / q to exit: Enter post id: 0. post1\nChoose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: ").to_stdout
      end
    end

    context 'when the create method is called' do
      it 'creates the post' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("POST", "test", "q")
        posts_controller1.extend Resource
        expect{posts_controller1.connection(test_routes1)}.to output("Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: "+
          "Enter the post text: 3. test\nChoose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: ").to_stdout
      end
    end

    context 'when the create method is called' do
      it 'creates the post' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("POST", "test", "q")
        posts_controller1.extend Resource
        expect{posts_controller1.connection(test_routes1)}.to output("Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: "+
          "Enter the post text: 3. test\nChoose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: ").to_stdout
      end
    end

    context 'when the update method is called' do
      it 'updates the post' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("PUT","1", "test", "q")
        posts_controller1.extend Resource
        expect{posts_controller1.connection(test_routes1)}.to output("Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: "+
          "Enter post id: Enter the post text: 1. test\nChoose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: ").to_stdout
      end
    end

    context 'when the destroy method is called' do
      it 'deletes the post' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("DELETE","1", "q")
        posts_controller1.extend Resource
        expect{posts_controller1.connection(test_routes1)}.to output("Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: "+
          "Enter post id: Post has been deleted\nChoose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: ").to_stdout
      end
    end
  end
end

RSpec.describe CommentsController do
  let(:comments_controller1){CommentsController.new(['comment1', 'comment2', 'comment3'])}
  let(:comments_controller2){CommentsController.new(['comment1', nil, 'comment3'])}
  let(:comments_controller3){CommentsController.new([])}
  let(:test_routes1){{
      'GET' => {
        'index' => comments_controller1.method(:index),
        'show' => comments_controller1.method(:show)
      },
      'POST' => comments_controller1.method(:create),
      'PUT' => comments_controller1.method(:update),
      'DELETE' => comments_controller1.method(:destroy)
    }}
  let(:test_routes2){}  

  describe 'index' do
    context 'when there are comments in the array' do
      it 'outputs comments and their indexes in the array' do
        expect{comments_controller1.index}.to output("index\n0. comment1\n1. comment2\n2. comment3\n").to_stdout
      end
    end

    context 'when there are comments in the array' do
      it 'outputs comments and their indexes in the array' do
        expect{comments_controller2.index}.to output("index\n0. comment1\n2. comment3\n").to_stdout
      end
    end

    context 'when there are no comments in the array' do
      it 'does not output comments and their indexes in the array' do
        expect{comments_controller3.index}.to output("index\n").to_stdout
      end
    end
  end  

  describe 'show' do
    context 'when comments exists' do
      it 'outputs the comments and its index' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("1")
        expect{comments_controller1.show}.to output("Enter comment id: 1. comment2\n").to_stdout
      end
    end

    context 'when comments does not exist' do
      it 'outputs a message' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("5")
        expect{comments_controller1.show}.to output("Enter comment id: Comment doesn't exist\n").to_stdout
      end
    end

    context 'when input is not a number' do
      it 'outputs a message' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("aaa")
        expect{comments_controller1.show}.to output("Enter comment id: Comment doesn't exist\n").to_stdout
      end
    end
  end  

  describe 'create' do
    context 'when there are no nil elements in the array' do
      it 'adds a new comment to the end of the array' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("comment4")
        expect{comments_controller1.create}.to output("Enter the comment text: 3. comment4\n").to_stdout
      end
    end

    context 'when there are nil elements in the array' do
      it 'replaces the first nil element' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("comment5")
        expect{comments_controller2.create}.to output("Enter the comment text: 1. comment5\n").to_stdout
      end
    end

    context 'when the array is empty' do
      it 'adds a new comment' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("comment6")
        expect{comments_controller3.create}.to output("Enter the comment text: 0. comment6\n").to_stdout
      end
    end
  end

  describe 'update' do
    context 'when comment exists' do
      it 'updates the comment' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("0", "comment7")
        expect{comments_controller1.update}.to output("Enter comment id: Enter the comment text: 0. comment7\n").to_stdout
      end
    end

    context 'when comment does not exist' do
      it 'outputs a message' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("1", "comment8")
        expect{comments_controller2.update}.to output("Enter comment id: Comment doesn't exist\n").to_stdout
      end
    end

    context 'when input is not a number' do
      it 'outputs a message' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("a", "comment9")
        expect{comments_controller3.update}.to output("Enter comment id: Comment doesn't exist\n").to_stdout
      end
    end
  end

  describe 'destroy' do
    context 'when comment exists' do
      it 'deletes the comment' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("0")
        expect{comments_controller1.destroy}.to output("Enter comment id: Comment has been deleted\n").to_stdout
      end
    end

    context 'when comment does not exist' do
      it 'outputs a message' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("1")
        expect{comments_controller2.destroy}.to output("Enter comment id: Comment doesn't exist\n").to_stdout
      end
    end

    context 'when input is not a number' do
      it 'outputs a message' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("a")
        expect{comments_controller3.destroy}.to output("Enter comment id: Comment doesn't exist\n").to_stdout
      end
    end
  end

  describe 'connection' do
    context 'when there are no routes' do
      it 'outputs a message' do
        comments_controller1.extend Resource
        expect{comments_controller1.connection(test_routes2)}.to output("No route matches for #{comments_controller1}\n").to_stdout
      end
    end

    context 'when the index method is called' do
      it 'outputs comments and their indexes in the array' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("GET", "index", "q")
        comments_controller1.extend Resource
        expect{comments_controller1.connection(test_routes1)}.to output("Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: "+
          "Choose action (index/show) / q to exit: index\n0. comment1\n1. comment2\n2. comment3\nChoose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: ").to_stdout
      end
    end

    context 'when the show method is called' do
      it 'outputs comments and their indexes' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("GET", "show", "0", "q")
        comments_controller1.extend Resource
        expect{comments_controller1.connection(test_routes1)}.to output("Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: "+
          "Choose action (index/show) / q to exit: Enter comment id: 0. comment1\nChoose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: ").to_stdout
      end
    end

    context 'when the create method is called' do
      it 'creates the comment' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("POST", "test", "q")
        comments_controller1.extend Resource
        expect{comments_controller1.connection(test_routes1)}.to output("Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: "+
          "Enter the comment text: 3. test\nChoose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: ").to_stdout
      end
    end

    context 'when the create method is called' do
      it 'creates the comment' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("POST", "test", "q")
        comments_controller1.extend Resource
        expect{comments_controller1.connection(test_routes1)}.to output("Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: "+
          "Enter the comment text: 3. test\nChoose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: ").to_stdout
      end
    end

    context 'when the update method is called' do
      it 'updates the comment' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("PUT","1", "test", "q")
        comments_controller1.extend Resource
        expect{comments_controller1.connection(test_routes1)}.to output("Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: "+
          "Enter comment id: Enter the comment text: 1. test\nChoose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: ").to_stdout
      end
    end

    context 'when the destroy method is called' do
      it 'deletes the comment' do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("DELETE","1", "q")
        comments_controller1.extend Resource
        expect{comments_controller1.connection(test_routes1)}.to output("Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: "+
          "Enter comment id: Comment has been deleted\nChoose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: ").to_stdout
      end
    end
  end
end