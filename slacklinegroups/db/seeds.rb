require 'coordinate_generator'

# Start by removing all groups & admins
Group.in_batches(of: 100).destroy_all
Admin.all.each { |admin| admin.destroy }

# ----------------------------- Admin Account -----------------------------
Overseer.create(email: 'admin@localhost', password: 'admin').confirm
Moderator.create(email: 'mod@localhost', password: 'mod').confirm
# -------------------------------------------------------------------------

# ----------------------------- Specific Group Clusters -----------------------------
vegasSlacklife = Group.new(name: 'Vegas Slacklife', slug: 'vegas-slacklife', type: :facebook_group, approved: true)
vegasSlacklife.info = Info.new(link: 'https://www.facebook.com/groups/798358306957010', members: 15, is_regional: false)
vegasSlacklife.location = Location.new(lat: 36.019375, lon: -115.1116391)
vegasSlacklife.submitter = Submitter.new(email: 'john@localhost')
vegasSlacklife.save

lvSlacklineGroups = Group.new(name: 'LV Slackline Groups', slug: 'lv-slackline-group', type: :facebook_group, approved: true)
lvSlacklineGroups.info = Info.new(link: 'https://www.facebook.com/groups/522046384501227', members: 5, is_regional: false)
lvSlacklineGroups.location = Location.new(lat: 36.044763, lon: -115.268200)
lvSlacklineGroups.submitter = Submitter.new(email: 'jane@localhost')
lvSlacklineGroups.save

lvSlackers = Group.new(name: 'Las Vegas Slackers', slug: 'las-vegas-slackers', type: :facebook_page, approved: true)
lvSlackers.info = Info.new(link: 'https://www.grantmercer.dev/', members: 30, is_regional: false)
lvSlackers.location = Location.new(lat: 36.2185009, lon: -115.166914)
lvSlackers.submitter = Submitter.new(email: 'shane@localhost')
lvSlackers.save

wcSlackers = Group.create(name: 'West Coast Slackers', slug: 'west-coast-slackers', type: :facebook_group, approved: true)
wcSlackers.info = Info.new(link: 'https://www.grantmercer.dev/', members: 245, is_regional: true)
wcSlackers.location = Location.new(lat: 40.573865, lon: -114.170715)
wcSlackers.submitter = Submitter.new(email: 'sherry@localhost')
wcSlackers.save

sdSlackers = Group.create(name: 'San Diego Slackers', slug: 'san-diego-slackers', type: :facebook_group, approved: true)
sdSlackers.info = Info.new(link: 'https://www.grantmercer.dev/', members: 566, is_regional: false)
sdSlackers.location = Location.new(lat: 32.733892, lon: -117.169497)
sdSlackers.submitter = Submitter.new(email: 'shawn@localhost')
sdSlackers.save

# ----------------------------- Random Group Clusters -----------------------------

cord_generator = Slg::CoordinateGenerator.new
base_lat = 50.046596
base_lon = 13.519466

500.times do |n|
  cords = cord_generator.random_location(base_lon, base_lat, 1_300_000)

  random_group = Group.new(name: "Random Group #{n}", slug: ('a'..'z').to_a.shuffle[0,8].join, type: :facebook_group, approved: true)
  random_group.info = Info.new(link: 'https://www.facebook.com', members: n, is_regional: false)
  random_group.location = Location.new(lon: cords.first, lat: cords.second)
  random_group.submitter = Submitter.new(email: ('a'..'z').to_a.shuffle[0,8].join + '@gmail.com')
  random_group.save
end