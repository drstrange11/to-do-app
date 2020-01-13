require 'sinatra'

def get_todos()
    @@todos ||= []
end

def add_todo(todo,days)
    get_todos().push({todo: todo,days: days})
end

def get_todo()
    get_todos()[@id - 1][:todo]
end

def update_todo()
    get_todos()[@id-1][:todo] = params[:title]
    get_todos()[@id-1][:days] = params[:days]
end

def delete_todo()
    get_todos().delete_at(@id-1)
end

def get_days()
    get_todos()[@id - 1][:days]
end

get "/todos" do
    @todos = get_todos()
    erb :todos    
end

post "/todos" do
    add_todo(params[:title],params[:days])
    redirect "/todos"
end

get "/todos/:id" do
    @id = params[:id].to_i
    @todo = get_todo()
    @days = get_days()
    erb :todo 
end

patch "/todos/:id" do
    @id = params[:id].to_i 
    update_todo()
    redirect "/todos"
end

delete "/todos/:id" do
    @id = params[:id].to_i
    delete_todo()
    redirect "/todos"
end