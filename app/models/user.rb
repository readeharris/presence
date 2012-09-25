require 'active_support/core_ext'
require 'observer'

class User
  include Observable

  attr_writer :monitor
  attr_reader :last_reminded_at

  def initialize
    add_observer UserObserver
  end

  def monitored?
    @monitor.present?
  end

  def remind!
    @last_reminded_at = Time.now
  end
end
