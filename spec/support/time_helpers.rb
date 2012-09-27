module TimeHelpers
  def freeze_time(&block)
    Timecop.freeze(&block)
  end

  def at_time(time, &block)
    Timecop.freeze(time, &block)
  end
end
