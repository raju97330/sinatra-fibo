class Fibo < Sinatra::Base
  get '/fib/:num' do
    fiboWrapper
  end
  
  get '/fibo/:num' do
    fiboWrapper
  end
  
  def fiboWrapper
    num = params[:num].to_i
    t1 = Time.now
    x =  fibo(num)
    t2 = Time.now
    return "Rajeev  Fibonacci - fib(#{num}) => #{x} | #{t2 - t1} secs\n"
  end
  
  get '/' do
    url = request.url
    url.chop! if url[-1] == '/'
    return "Rajeev Fibonacci Demo - Usage: #{url}/fib/[NUMBER]"
  end

  def fibo(num)
    # Deliberately slow.
    if num <= 0
      return 0
    elsif num == 1
      return 1
    end
    return fibo(num - 1) + fibo(num - 2)
  end
end
