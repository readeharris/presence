step ':number_of minutes pass' do |number_of|
  Timecop.travel(number_of.minutes.from_now)
end
