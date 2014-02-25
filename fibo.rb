class Fibo < Sinatra::Base
  get '/fib/:num' do
    num = params[:num].to_i
    t1 = Time.now
    x =  fibo(num)
    t2 = Time.now
    $stderr.puts("fibo(#{num}) => #{x}")
    return "fib(#{num}) => #{x} | #{t2 - t1} secs\n"
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
