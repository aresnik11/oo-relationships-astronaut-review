class Shuttle

  attr_reader :model, :capacity
  @@all = []

  def initialize(model, capacity)
    @model = model
    @capacity = capacity
    @@all << self
  end

  def self.all
    @@all
  end

  def self.find_by_model(model)
    #look thru all the shuttles
    Shuttle.all.find do |shuttle|
      shuttle.model == model
    end
  end

  # helper method
  def missions
    Mission.all.select do |mission|
      mission.shuttle == self
    end
  end

  def add_astronaut(launch_date, astronaut)
    # need to determine if the shuttle is at capacity
    # compare our capacity to the number of missions that we are assoc with
    if astronaut.age < minimum_age
      puts "sorry, you are too young"
    else
      if self.capacity > self.missions.count
        Mission.new(launch_date, astronaut, self)
      else
        puts "sorry no more space to go to mars, next time. seats are all full."
      end
    end
  end

  # use the helper method to return the astronauts currently on a shuttle 
  def current_astronauts
    missions.map do |mission|
      mission.astronaut
    end
  end

  def average_age
    total_ages = self.current_astronauts.sum do |astronaut|
      astronaut.age
    end
    total_ages.to_f / self.current_astronauts.count
  end

  def astronauts_specialties
    self.current_astronauts.each do |astronaut|
      puts astronaut.specialty
    end
  end

  def self.smallest_mission
    self.all.min_by do |shuttle|
      shuttle.current_astronauts.count
    end
  end

  def self.most_common_model
    all_models = self.all.map do |shuttle|
      shuttle.model
    end
    all_models.max_by do |model|
      all_models.count(model)
    end
  end

  def minimum_age
    18
  end

end
