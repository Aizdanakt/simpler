class TestsController < Simpler::Controller

  def index
    @time = Time.now

    status 201
    headers['Content-Type'] = 'application/json'
    render plain: "Work!\n"
  end

  def create; end

  def show
    @test_id = params[:id]
  end

end
