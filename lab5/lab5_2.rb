module Resource
  def connection(routes)
    if routes.nil?
      puts "No route matches for #{self}"
      return
    end

    loop do
      print 'Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: '
      verb = gets.chomp
      break if verb == 'q'

      action = nil

      if verb == 'GET'
        print 'Choose action (index/show) / q to exit: '
        action = gets.chomp
        break if action == 'q'
      end

      if verb == 'GET' || verb == 'POST' || verb == 'PUT' || verb == 'DELETE'
        if action == nil || action == 'index' || action == 'show'
          action.nil? ? routes[verb].call : routes[verb][action].call
        else 
          puts 'Error: Please select the correct menu item'  
        end
      else 
        puts 'Error: Please select the correct menu item'
      end
    end
  end
end

class PostsController
  extend Resource

  def initialize(post)
    @posts = post
  end

  def index
    puts 'index'
    @posts.each_with_index do |post, index|
      if post != nil
        puts "#{index}. #{@posts[index]}"
      end
    end
  end

  def show
    print 'Enter post id: '
    id = gets.chomp
    if @posts[id.to_i] != nil && id[/\A\d+\Z/]
      puts "#{id.to_i}. #{@posts[id.to_i]}"
    else    
      puts "Post doesn't exist"
    end
  end

  def create
    print 'Enter the post text: '
    input = gets.chomp
    x = true
    @posts.each_with_index do |post, index|
      if post == nil
        @posts[index] = input
        puts "#{index}. #{@posts[index]}"
        x = false
        break
      end
    end
    if x 
      @posts.push(input)
      puts "#{@posts.length - 1}. #{@posts[-1]}"
    end
  end

  def update
    print 'Enter post id: '
    id = gets.chomp
    if @posts[id.to_i] != nil && id[/\A\d+\Z/]
      id = id.to_i
      print 'Enter the post text: '
      input = gets.chomp
      @posts[id] = input
      puts "#{id}. #{@posts[id]}"
    else    
      puts "Post doesn't exist"
    end
  end

  def destroy
    print 'Enter post id: '
    id = gets.chomp
    if @posts[id.to_i] != nil && id[/\A\d+\Z/]
      @posts[id.to_i] = nil
      puts "Post has been deleted"
    else    
      puts "Post doesn't exist"
    end
  end
end

class CommentsController
  extend Resource

  def initialize(post)
    @posts = post
  end

  def index
    puts 'index'
    @posts.each_with_index do |post, index|
      if post != nil
        puts "#{index}. #{@posts[index]}"
      end
    end
  end

  def show
    print 'Enter comment id: '
    id = gets.chomp
    if @posts[id.to_i] != nil && id[/\A\d+\Z/]
      puts "#{id.to_i}. #{@posts[id.to_i]}" 
    else    
      puts "Comment doesn't exist"
    end
  end

  def create
    print 'Enter the comment text: '
    input = gets.chomp
    x = true
    @posts.each_with_index do |post, index|
      if post == nil
        @posts[index] = input
        puts "#{index}. #{@posts[index]}"
        x = false
        break
      end
    end
    if x 
      @posts.push(input)
      puts "#{@posts.length - 1}. #{@posts[-1]}"
    end
  end

  def update
    print 'Enter comment id: '
    id = gets.chomp
    if @posts[id.to_i] != nil && id[/\A\d+\Z/]
      id = id.to_i
      print 'Enter the comment text: '
      input = gets.chomp
      @posts[id] = input
      puts "#{id}. #{@posts[id]}" 
    else    
      puts "Comment doesn't exist"
    end
  end

  def destroy
    print 'Enter comment id: '
    id = gets.chomp
    if @posts[id.to_i] != nil && id[/\A\d+\Z/]
      @posts[id.to_i] = nil
      puts "Comment has been deleted"
    else    
      puts "Comment doesn't exist"
    end
  end
end

class Router
  def initialize
    @routes = {}
  end

  def init
    resources(PostsController, 'posts')
    resources(CommentsController, 'comments')

    loop do
      print 'Choose resource you want to interact (1 - Posts, 2 - Comments, q - Exit): '
      choice = gets
      choice ||= 'q'
      choice = choice.chomp
      PostsController.connection(@routes['posts']) if choice == '1'
      CommentsController.connection(@routes['comments']) if choice == '2'
      break if choice == 'q'
    end

    puts 'Good bye!'
  end

  def resources(klass, keyword)
    controller = klass.new([])
    @routes[keyword] = {
      'GET' => {
        'index' => controller.method(:index),
        'show' => controller.method(:show)
      },
      'POST' => controller.method(:create),
      'PUT' => controller.method(:update),
      'DELETE' => controller.method(:destroy)
    }
  end
end

router = Router.new

router.init