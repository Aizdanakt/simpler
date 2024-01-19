require_relative 'config/environment'
require_relative 'lib/middleware/logger'

use LogMiddleware, logdev: File.expand_path('log/app.log', __dir__)
run Simpler.application
