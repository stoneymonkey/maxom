class ExampleController < ApplicationController

  def hello_ip
    location = @request.env["REMOTE_IP"]
    render_text "Hello stranger from #{location}"
  end

  def hi
  render_text "Hello..."
  end

end
