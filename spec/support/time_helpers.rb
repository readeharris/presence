module TimeHelpers
  def at_time(time, &block)
    Timecop.freeze(time, &block)
  end
end
