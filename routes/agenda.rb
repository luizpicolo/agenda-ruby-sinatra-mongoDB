get '/' do
  redirect '/agenda'
end

get '/agenda' do
  if params[:busca] != "" && params[:busca]
    @dadosContatos = Agenda.all(:nome => /#{params[:busca]}/i)
  else
      
    qtdPorPagina = 10;  
    
    # Paginação
    if params[:pag] 
      pagina = params[:pag].to_i 
    else
      pagina = 1
    end
            
    # Setas para paginação
    if pagina <= (Agenda.count / qtdPorPagina).ceil
      @pagProximo = (pagina + 1)
    else
      @pagProximo = pagina;  
    end
    
    if pagina > 1
      @pagAnterior = (pagina - 1)
    else
      @pagAnterior = 1;    
    end
    
    # Query para o retorno dos dados
    @dadosContatos = Agenda.paginate({:order => :nome.asc, :per_page => qtdPorPagina, :page => pagina})
    
  end
  
  erb :agenda
  
end

get '/agenda/:id' do
  @dadosContato = Agenda.find(params[:id])
  erb :modal, :layout => false
end

# Salvar o Post
post '/agenda' do
  time = Time.new
  agenda = Agenda.create(:nome => params[:nome], :telefone => params[:telefone], :data => time.getlocal)
  agenda.save
  redirect '/agenda'
end

# Deleta os dados
delete '/agenda/:id' do
  Agenda.destroy(params[:id])
  redirect '/agenda'
end

# Atualiza os dados
put '/agenda' do
  Agenda.set({:_id => params[:id]}, :nome => params[:nome], :telefone => params[:telefone])
  redirect '/agenda'
end