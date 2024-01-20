require 'logger'

class LogMiddleware

  def initialize(app, **options)
    @app = app
    @logger = Logger.new(options[:logdev] || STDOUT)
  end

  def call(env)
    status, headers, body = @app.call(env)
    @logger.info(build_log(env, status, headers))
    [status, headers, body]
  end

  private

  def build_log(env, status, headers)
    template = ->(action) { action ? "#{get_controller_name(env['REQUEST_PATH'])}/#{action}.html.erb" : 'none' }
    handler = ->(controller) { controller ? "#{controller.class}##{env['simpler.action']}" : 'none' }
    parameters = ->(params) { params&.any? ? params : 'none' }
    record = ["\nRequest: #{env['REQUEST_METHOD']} #{env['REQUEST_PATH']}\n",
              "Handler: #{handler.call(env['simpler.controller'])}\n",
              "Parameters: #{parameters.call(env['simpler.params'])}\n",
              "Response: #{status} [#{headers['Content-Type']}] #{template.call(env['simpler.action'])}\n"]
    record.join('').to_s
  end

  def get_controller_name(path)
    elements = path.split('/')
    elements.delete('')
    elements.first
  end
end
