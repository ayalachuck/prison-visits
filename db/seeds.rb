Prison.transaction do
  Dir[Rails.root.join('db', 'seeds', 'prisons', '*.yml')].each do |path|
    hash = YAML.load(File.read(path))

    Prison.create!(
      name: hash.fetch('name'),
      nomis_id: hash.fetch('nomis_id'),
      address: hash.fetch('address', []).join("\n"),
      booking_window: hash.fetch('booking_window', 28),
      email_address: hash.fetch('email', nil),
      enabled: hash.fetch('enabled', true),
      phone_no: hash.fetch('phone', nil),
      slot_details: {
        'recurring' => hash.fetch('slots', {}),
        'anomalous' => hash.fetch('slot_anomalies', {}),
        'unbookable' => hash.fetch('unbookable', [])
      }
    )
  end
end
