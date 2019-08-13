class Mission

  attr_reader :launch_date, :shuttle, :astronaut
  @@all = []

  def initialize(launch_date, astronaut, shuttle)
    @launch_date = launch_date
    @astronaut = astronaut
    @shuttle = shuttle

    @@all << self
  end

  def self.all
    @@all
  end

  def self.first_launch
    first_mission = self.all.first
    all_first_mission = self.all.select do |mission|
      mission.shuttle == first_mission.shuttle
      mission.launch_date == first_mission.launch_date
    end
    all_first_mission.map do |mission|
      mission.astronaut
    end
  end

end
