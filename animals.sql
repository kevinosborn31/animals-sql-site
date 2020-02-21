	DROP TABLE IF EXISTS animals; -- nuke the table! start again

	CREATE TABLE animals (
		id INTEGER PRIMARY KEY AUTOINCREMENT, -- take care of IDs automatically
		name TEXT,
		species TEXT,
		description TEXT,
		roundness INTEGER,
		alive BOOLEAN,
		age INTEGER,
		image_url TEXT
	);

	INSERT INTO animals ( name, species, description, roundness, alive, age, image_url )
		VALUES (
			'Clarence Boddicker',
			'Human',
			'Baddie',
			8,
			0,
			50,
			'http://www.fillmurray.com/300/300'
		);

	INSERT INTO animals ( name, species, description, roundness, alive, age, image_url )
		VALUES (
			'Ruby',
			'Canine',
			'The best dog',
			3,
			1,
			2,
			'http://www.fillmurray.com/300/300'
		);

	INSERT INTO animals ( name, species, description, roundness, alive, age, image_url )
		VALUES (
			'Kermit',
			'Desert',
			'Extremely Round, also quite squeaky',
			9,
			1,
			2,
			'http://www.fillmurray.com/300/300'
		);

		SELECT * FROM animals;