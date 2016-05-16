get '/' do
  redirect '/phone_book'
end

get '/phone_book' do
  if params[:search] != "" && params[:search]
    @contacts = PhoneBook.all(:name => /#{params[:search]}/i)
  else

    per_page = 10;

    # Pagination
    if params[:pag]
      page = params[:pag].to_i
    else
      page = 1
    end

    if page <= (PhoneBook.count / per_page).ceil
      @next_page = (page + 1)
    else
      @next_page = page;
    end

    if page > 1
      @prev_page = (page - 1)
    else
      @prev_page = 1;
    end

    # return data
    @contacts = PhoneBook.paginate({:order => :name.asc, :per_page => per_page, :page => page})

  end

  erb :phone_book

end

get '/phone_book/:id' do
  @contact = PhoneBook.find(params[:id])
  erb :modal, :layout => false
end

# Save
post '/phone_book' do
  time = Time.new
  phone_book = PhoneBook.create(:name => params[:name], :phone => params[:phone], :date => time.getlocal)
  phone_book.save
  redirect '/phone_book'
end

# Delete
delete '/phone_book/:id' do
  PhoneBook.destroy(params[:id])
  redirect '/phone_book'
end

# Update
put '/phone_book' do
  PhoneBook.set({:_id => params[:id]}, :name => params[:name], :phone => params[:phone])
  redirect '/phone_book'
end
