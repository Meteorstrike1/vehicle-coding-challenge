describe Vehicle do

  it 'successfully generates a Vehicle object' do
    record = {
      make: 'ford',
      colour: 'blue',
      date_of_manufacture: '20-10-2012',
      vin: 'AB1234CD',
      registration_area: 'swansea'
    }
    expect(Vehicle.new(record)).to be_a Vehicle
  end

  it 'does not successfully generate a Vehicle object due to invalid date' do
    record = {
      make: 'ford',
      colour: 'blue',
      date_of_manufacture: '32-10-2012',
      vin: 'AB1234CD',
      registration_area: 'swansea'
    }
    expect { Vehicle.new(record) }.to raise_error(Errors::InvalidDate)
  end

  it 'does not successfully generate a Vehicle object due to invalid area' do
    record = {
      make: 'ford',
      colour: 'blue',
      date_of_manufacture: '20-10-2012',
      vin: 'AB1234CD',
      registration_area: 'madeuptown'
    }
    expect { Vehicle.new(record) }.to raise_error(Errors::InvalidRegistrationArea)
  end

end
