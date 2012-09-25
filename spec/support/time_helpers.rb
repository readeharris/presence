module TimeHelpers
  def at_time(time, &block)
    Timecop.freeze(time) do
      yield
    end
  end
end
