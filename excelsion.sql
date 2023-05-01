DROP DATABASE excelsior;

CREATE DATABASE excelsior;

USE excelsior;

CREATE TABLE storylines(
    storyline_title VARCHAR(255) NOT NULL,
    PRIMARY KEY(storyline_title)
);

CREATE TABLE collectables(
    collectable_id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    publisher VARCHAR(255) NOT NULL,
    PRIMARY KEY(collectable_id)
);

CREATE Table storyline_mappings(
    mapping_id INT NOT NULL AUTO_INCREMENT,
    storyline_title VARCHAR(255) NOT NULL,
    collectable_id INT NOT NULL,
    PRIMARY KEY(mapping_id),
    FOREIGN KEY(storyline_title) REFERENCES storylines(storyline_title) ON DELETE CASCADE,
    FOREIGN KEY(collectable_id) REFERENCES collectables(collectable_id) ON DELETE CASCADE
);

CREATE TABLE comics(
    collectable_id INT NOT NULL,
    issue_number INT NOT NULL,
    PRIMARY KEY(collectable_id),
    FOREIGN KEY(collectable_id) REFERENCES collectables(collectable_id) ON DELETE CASCADE
);

CREATE TABLE creators(
    creator_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    PRIMARY KEY(creator_id)
);

CREATE TABLE feature_work(
    feature_work_id INT NOT NULL AUTO_INCREMENT,
    creator_id INT NOT NULL,
    collectable_id INT NOT NULL,
    job VARCHAR(255) NOT NULL,
    PRIMARY KEY(feature_work_id),
    FOREIGN KEY(creator_id) REFERENCES creators(creator_id) ON DELETE CASCADE,
    FOREIGN KEY(collectable_id) REFERENCES collectables(collectable_id) ON DELETE CASCADE
);

CREATE TABLE characters(
    character_id INT NOT NULL AUTO_INCREMENT,
    character_name VARCHAR(255) NOT NULL,
    character_profession VARCHAR(255) NOT NULL,
    PRIMARY KEY(character_id)
);

CREATE TABLE character_appearances(
    character_appearing_id INT NOT NULL AUTO_INCREMENT,
    character_id INT NOT NULL,
    collectable_id INT NOT NULL,
    PRIMARY KEY(character_appearing_id),
    FOREIGN KEY(character_id) REFERENCES characters(character_id) ON DELETE CASCADE,
    FOREIGN KEY(collectable_id) REFERENCES collectables(collectable_id) ON DELETE CASCADE
);
CREATE TABLE condition_descriptions(
    textual_condition VARCHAR(255) NOT NULL,
    condition_description TEXT NOT NULL,
    PRIMARY KEY(textual_condition)
);

CREATE TABLE conditions(
    condition_id DECIMAL(3,1) NOT NULL,
    textual_condition VARCHAR(5) NOT NULL,
    PRIMARY KEY(condition_id),
    FOREIGN KEY(textual_condition) REFERENCES condition_descriptions(textual_condition)
);


CREATE TABLE stock(
    stock_id INT NOT NULL AUTO_INCREMENT,
    collectable_id INT NOT NULL,
    condition_id DECIMAL(3,1) NOT NULL,
    edition INT NOT NULL DEFAULT 1,
    buying_price DECIMAL(10,2) NOT NULL,
    selling_price DECIMAL(10,2) NOT NULL,
    format VARCHAR(255) NOT NULL,
    in_stock BOOLEAN NOT NULL,
    PRIMARY KEY(stock_id),
    FOREIGN KEY(collectable_id) REFERENCES collectables(collectable_id),
    FOREIGN KEY(condition_id) REFERENCES conditions(condition_id)
);

CREATE TABLE comments(
    stock_id INT NOT NULL,
    comment TEXT NOT NULL,
    PRIMARY KEY(stock_id),
    FOREIGN KEY(stock_id) REFERENCES stock(stock_id) ON DELETE CASCADE
);

CREATE TABLE addresses(
    address_id INT NOT NULL AUTO_INCREMENT,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    state VARCHAR(255) NOT NULL,
    zip_code VARCHAR(9) NOT NULL,
    PRIMARY KEY(address_id)
);

CREATE TABLE customers(
    customer_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    address_id INT NOT NULL,
    dob DATE NOT NULL,
    PRIMARY KEY(customer_id),
    FOREIGN KEY(address_id) REFERENCES addresses(address_id)
);

CREATE TABLE wishlist(
    wishlist_id INT NOT NULL AUTO_INCREMENT,
    customer_id INT NOT NULL,
    stock_id INT NOT NULL,
    PRIMARY KEY(wishlist_id),
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY(stock_id) REFERENCES stock(stock_id) ON DELETE CASCADE
);

CREATE TABLE shopping_cart(
    shopping_cart_id INT NOT NULL AUTO_INCREMENT,
    customer_id INT NOT NULL,
    stock_id INT NOT NULL,
    PRIMARY KEY(shopping_cart_id),
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY(stock_id) REFERENCES stock(stock_id) ON DELETE CASCADE
);

CREATE TABLE sold_items(
    stock_id INT NOT NULL,
    customer_id INT NOT NULL,
    sale_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    PRIMARY KEY(stock_id),
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY(stock_id) REFERENCES stock(stock_id)
);

-- From here on dummy data


INSERT INTO condition_descriptions(textual_condition, condition_description) VALUES
    ("MT", "Mint: Near perfect in every way. Only the most subtle bindery or printing defects are allowed. Cover is flat with no surface wear. Cover inks are bright with high reflectivity and minimal fading. Corners are cut square and sharp. Staples are generally centered, clean with no rust. Cover is generally well centered and firmly secured to interior pages. Paper is supple and fresh. Spine is tight and flat."),
    ("NM/MT", "Near-Mint/Mint: A comic book that has enough positive qualities to make it better than a NM, but has enough detracting qualities to keep it from being a MT 9.9."),
    ("NM", "Near-Mint: Nearly perfect with only minor imperfections allowed. This grade should have no corner of impact creases, stress marks should be almost invisible, and bindery tears must be less than 1/16 inch. A couple of very tiny color flecks, or a combination of the above that keeps the book from being perfect, where the overall eye appeal is less than Mint drops the book into this grade. Only the most subtle binging and/or printing defects allowed. Cover is flat with no surface wear. Cover inks are bright with high reflectivity and minimum of fading. Corners are cut square and sharp with ever so slight blunting permitted. Staples are generally centered, clean with no rust. Cover is well centered and firmly secured to interior pages. Paper is supple and like new. Spine is tight and flat."),
    ("VF/NM", "Very-Fine/Near-Mint: A cominc book that has enough positive qualities to make it better than VF, but has enough detracting qualities to keep it from being a NM."),
    ("VF", "An excellent copy with outstanding eye appeal. Sharp, bright and clean with supple pages. Cover is relatively flat with almost no surface wear. Cover inks are generally bright with moderate to high reflectivity. Staples may show some discoloration. Spine may have a couple of almost insignificant transverse stress lines and is almost completely flat. A barely unnoticeable 1/4 inch crease is acceptable, if color is not broken. Pages and covers can be yellowish/tannish (at the least, but no brown and will usually be off-white to white)."),
    ("FN/VF", "Fine/Very-Fine: A cominc book that has enough positive qualities to make it better than F, but has enough detracting qualities to keep it from being a VF."),
    ("FN", "Fine: An above-average copy that shows minor wear but is still relatively flat and clean with no significant creasing or other serious defects. Eye appeal is somewhat reduced because of slight surface wear and possibly a small defect such as a few slight cross stress marks on spine or a very slight spine split 1/4 inch. A Fine condition comic book appears to have been read a few times and has been handled with moderate care. Compared to a VF, cover inks are beginning to show a significant reduction in reflectivity, but it is still a highly collectible and desirable book. Pages and interior covers may be tan, but pages must still be fairly supple with no signs of brittleness."),
    ("VG/FG", "Very Good/Fine: A cominc book that has enough positive qualities to make it better than VG, but has enough detracting qualities to keep it from being a F."),
    ("VG", "Very Good: The average used comic book. A comic in this grade shows some wear, can have a reading or center crease or a moderately rolled spine, but has not accumulated enough total defects to reduce eye appeal to the point that it is not a desirable copy. Some discoloration, fading and even minor soiling is allowed. As much as a 1/4 inch triangle can be missing out of the corner or edge. A missing square piece (1/8inch by 1/8inch) is also acceptable. Store stamps, name stamps, arrival dates, initials, etc. have no effect on this grade. Cover and interior pages can have some minor tears and folds and the centerfold may be detached at one staple. The cover may also be loose, but not completely detached. Common bindery and printing defects do not affect grade. Pages and inside covers may be brown but not brittle. Tape should never be used for comic book repair; however, many VG condition comics have minor tape repair."),
    ("GD/VG", "Good/Very Good: A cominc book that has enough positive qualities to make it better than G, but has enough detracting qualities to keep it from being a VG."),
    ("GD", "Good: A copy in this grade has all pages and covers, although There may be small pieces missing inside; the largest piece allowed from front or back cover is a 1/2 inch triangle or square 1/4 inch by 1/4 inch. Books in this grade are commonly creased, scuffed, abraded, soiled and may have as much as a 2 inch spine split, but are still completely readable. Often, paper quality is low but not brittle. Cover reflectivity is low, and in some cases, completely absent. This grade can have a moderate accumulation of defects, but still maintains its basic structural integrity."),
    ("FR/GD", "Fair/Good: A cominc book that has enough positive qualities to make it better than FR, but has enough detracting qualities to keep it from being a G."),
    ("FR", "Fair: A copy in this grade is usually soiled, ragged, and possibly unattractive. Creases, tears and/or folds are prevalent. Spine may be split up to 2/3rds its entire length. Staples may be gone. Up to 1/10th of the front cover may be missing. These books are readable, although soiling, staining, tears, markings or chunks missing may moderately interfere with reading the complete story. Some collectors consider this the lowest collectible grade because comic books in lesser condition are usually defaced and/or brittle. Very often paper quality is low and may have slight brittleness around the edges, but not in the central portions of the pages. Comic books in this grade may have a clipped coupon, so long as it is noted along side of the nomenclature, i.e.: Fair (1.0) Coupon Clipped. Valued at 50-70% of good."),
    ("PR/FR", "Poor/Fair: A cominc book that has enough positive qualities to make it better than PR, but has enough detracting qualities to keep it from being a FR."),
    ("PR", "Poor: Most comic books in this grade have been sufficiently degraded to the point that copies may have extremely severe stains, missing staples, brittleness, mildew or moderate to heavy cover abrasion to the point that some cover inks are indistinct/absent. Comic books in this grade can have small chunks missing and pieces out of pages. They may have been defaced with paints, varnishes, glues, oil, indelible markers or dyes. Covers may be split the entire length of the book, but both halves must be present and basically still there with some chunks missing. A page(s) may be missing as long as it is noted along side of the nomenclature; i.e.: POOR (0.5) 2nd Page Missing. Value depends on extent of defects, but would average about 1/3 of GOOD.");


INSERT INTO conditions(condition_id, textual_condition) VALUES
    (0.0, "PR"),
    (0.1, "PR"),
    (0.2, "PR"),
    (0.3, "PR"),
    (0.4, "PR"),
    (0.5, "PR"),
    (0.6, "PR/FR"),
    (0.7, "PR/FR"),
    (0.8, "PR/FR"),
    (0.9, "PR/FR"),
    (1.0, "FR"),
    (1.1, "FR/GD"),
    (1.2, "FR/GD"),
    (1.3, "FR/GD"),
    (1.4, "FR/GD"),
    (1.5, "FR/GD"),
    (1.6, "FR/GD"),
    (1.7, "FR/GD"),
    (1.8, "FR/GD"),
    (1.9, "FR/GD"),
    (2.0, "FR/GD"),
    (2.1, "FR/GD"),
    (2.2, "GD"),
    (2.3, "GD/VG"),
    (2.4, "GD/VG"),
    (2.5, "GD/VG"),
    (2.6, "GD/VG"),
    (2.7, "GD/VG"),
    (2.8, "GD/VG"),
    (2.9, "GD/VG"),
    (3.0, "GD/VG"),
    (3.1, "GD/VG"),
    (3.2, "GD/VG"),
    (3.3, "GD/VG"),
    (3.4, "GD/VG"),
    (3.5, "GD/VG"),
    (3.6, "GD/VG"),
    (3.7, "GD/VG"),
    (3.8, "GD/VG"),
    (3.9, "GD/VG"),
    (4.0, "VG"),
    (4.1, "VG/FG"),
    (4.2, "VG/FG"),
    (4.3, "VG/FG"),
    (4.4, "VG/FG"),
    (4.5, "VG/FG"),
    (4.6, "VG/FG"),
    (4.7, "VG/FG"),
    (4.8, "VG/FG"),
    (4.9, "VG/FG"),
    (5.0, "VG/FG"),
    (5.1, "VG/FG"),
    (5.2, "VG/FG"),
    (5.3, "VG/FG"),
    (5.4, "VG/FG"),
    (5.5, "VG/FG"),
    (5.6, "VG/FG"),
    (5.7, "VG/FG"),
    (5.8, "VG/FG"),
    (5.9, "VG/FG"),
    (6.0, "FN"),
    (6.1, "FN/VF"),
    (6.2, "FN/VF"),
    (6.3, "FN/VF"),
    (6.4, "FN/VF"),
    (6.5, "FN/VF"),
    (6.6, "FN/VF"),
    (6.7, "FN/VF"),
    (6.8, "FN/VF"),
    (6.9, "FN/VF"),
    (7.0, "FN/VF"),
    (7.1, "FN/VF"),
    (7.2, "FN/VF"),
    (7.3, "FN/VF"),
    (7.4, "FN/VF"),
    (7.5, "FN/VF"),
    (7.6, "FN/VF"),
    (7.7, "FN/VF"),
    (7.8, "FN/VF"),
    (7.9, "FN/VF"),
    (8.0, "VF"),
    (8.1, "VF/NM"),
    (8.2, "VF/NM"),
    (8.3, "VF/NM"),
    (8.4, "VF/NM"),
    (8.5, "VF/NM"),
    (8.6, "VF/NM"),
    (8.7, "VF/NM"),
    (8.8, "VF/NM"),
    (8.9, "VF/NM"),
    (9.0, "VF/NM"),
    (9.1, "VF/NM"),
    (9.2, "VF/NM"),
    (9.3, "VF/NM"),
    (9.4, "VF/NM"),
    (9.5, "NM"),
    (9.6, "NM/MT"),
    (9.7, "NM/MT"),
    (9.8, "NM/MT"),
    (9.9, "NM/MT"),
    (10.0, "MT");


INSERT INTO storylines(storyline_title) VALUES
    ("Amazing Spider-Man"), -- 1
    ("X-Men"),               -- 2
    ("The Infinity Gauntlet"),    -- 3
    ("Watchmen"),              -- 4
    ("Batman"), -- 5
    ("V for Vendetta"), -- 6
    ("East of West"), -- 7
    ("Hawkeye"), -- 8
    ("The Sandman"), -- 9
    ("Hellboy"); -- 10

INSERT INTO collectables(title, publisher) VALUES
    ("Amazing Spider-Man (1999)", "Marvel"), -- 1
    ("Amazing Spider-Man (1999)", "Marvel"), -- 2
    ("Amazing Spider-Man (1999)", "Marvel"), -- 3
    ("Amazing Spider-Man (1999)", "Marvel"), -- 4
    ("Amazing Spider-Man (1999)", "Marvel"), -- 5

    -- some xmen comics
    ("X-Men (1991)", "Marvel"), -- 6
    ("X-Men (1991)", "Marvel"), -- 7
    ("X-Men (1991)", "Marvel"), -- 8
    ("X-Men (1991)", "Marvel"), -- 9

    -- some graphic novels
    ("The Infinity Gauntlet", "Marvel"), -- 10
    ("Watchmen", "DC Comics"),          -- 11
    ("Batman: The Dark Knight Returns", "DC Comics"), -- 12
    ("V for Vendetta", "DC Comics"), -- 13

    -- some dc comics
    ("Batman: The Dark Knight (2011)", "DC Comics"), -- 14
    ("V for Vendetta (1988)", "DC Comics"), -- 15
    ("V for Vendetta (1988)", "DC Comics"), -- 16
    ("V for Vendetta (1988)", "DC Comics"), -- 17

    -- some more graphic novels
    ("East of West (2013)", "Image Comics"), -- 18
    ("Old Man Hawkeye (2018)", "Marvel"), -- 19
    ("The Sandman: Season of Mists (1990)", "DC Comics"), -- 20
    ("Hellboy: The Chained Coffin and Others (1998)", "Dark Horse Comics"), -- 21
    ("Batman: The Black Mirror (2011)", "DC Comics"); -- 22




INSERT INTO storyline_mappings(storyline_title, collectable_id) VALUES
    ("Amazing Spider-Man", 1),
    ("Amazing Spider-Man", 2),
    ("Amazing Spider-Man", 3),
    ("Amazing Spider-Man", 4),
    ("Amazing Spider-Man", 5),
    ("X-Men", 6),
    ("X-Men", 7),
    ("X-Men", 8),
    ("X-Men", 9),
    ("The Infinity Gauntlet", 10),
    ("Watchmen", 11),
    ("Batman", 12),
    ("V for Vendetta", 13),
    ("Batman", 14),
    ("V for Vendetta", 15),
    ("V for Vendetta", 16),
    ("V for Vendetta", 17),
    ("East of West", 18),
    ("Hawkeye", 19),
    ("The Sandman", 20),
    ("Hellboy", 21),
    ("Batman", 22);




INSERT INTO comics(collectable_id, issue_number) VALUES
    (1, 1), -- spiderman(1999) #1
    (2, 2), -- spiderman(1999) #2
    (3, 3), -- spiderman(1999) #3
    (4, 4), -- spiderman(1999) #4
    (5, 5), -- spiderman(1999) #5

    (6, 1), -- xmen(1991) #1
    (7, 2), -- xmen(1991) #2
    (8, 3), -- xmen(1991) #3
    (9, 4), -- xmen(1991) #4

    (14, 1), -- batman: the dark knight returns

    (15, 1), -- v for vendetta
    (16, 2), -- v for vendetta
    (17, 3); -- v for vendetta


INSERT INTO characters(character_name, character_profession) VALUES
    ("Spider-Man", "Superhero"), -- 1
    ("Wolverine", "Superhero"), -- 2
    ("Jean Grey", "Superhero"), -- 3
    ("Cyclops", "Superhero"), -- 4
    ("Professor X", "Superhero"), -- 5
    ("Thanos", "Supervillain"), -- 6
    ("Batman", "Superhero"), -- 7
    ("V", "Antihero"), -- 8
    ("Captain Metropolis", "Superhero"), -- 9
    ("Night Owl", "Superhero"), -- 10

    ("Caitlin Fairchild", "Person"), -- 11
    ("Roxanne Spaulding", "Person"), -- 12
    ("Sarah Rainmaker", "Person"), -- 13

    ("Hawkeye", "Superhero"), -- 14
    ("Sandman", "Superhero"), -- 15
    ("Hellboy", "Superhero"); -- 16

INSERT INTO character_appearances(character_id, collectable_id) VALUES
    (1, 1), -- spiderman -> spiderman(1999) #1
    (1, 2), -- spiderman -> spiderman(1999) #2
    (1, 3), -- spiderman -> spiderman(1999) #3
    (1, 4), -- spiderman -> spiderman(1999) #4
    (1, 5), -- spiderman -> spiderman(1999) #5

    (2, 6), -- wolverine -> xmen(1991) #1
    (3, 6), -- jean grey -> xmen(1991) #1
    (4, 6), -- cyclops -> xmen(1991) #1
    (5, 6), -- professor x -> xmen(1991) #1

    (2, 7), -- wolverine -> xmen(1991) #2
    (3, 7), -- jean grey -> xmen(1991) #2
    (4, 7), -- cyclops -> xmen(1991) #2
    (5, 7), -- professor x -> xmen(1991) #2

    (2, 8), -- wolverine -> xmen(1991) #3
    (3, 8), -- jean grey -> xmen(1991) #3
    (4, 8), -- cyclops -> xmen(1991) #3
    (5, 8), -- professor x -> xmen(1991) #3

    (2, 9), -- wolverine -> xmen(1991) #4
    (3, 9), -- jean grey -> xmen(1991) #4
    (4, 9), -- cyclops -> xmen(1991) #4
    (5, 9), -- professor x -> xmen(1991) #4

    (6, 10), -- thanos -> infinity gauntlet
    (7, 12), -- batman -> batman
    (8, 13), -- v -> v for vendetta
    (9, 11), -- captain metropolis -> watchmen
    (10, 11), -- night owl -> watchmen

    (7, 14), -- batman -> batman: the dark knight returns
    (8, 15), -- v -> v for vendetta
    (8, 16), -- v -> v for vendetta
    (8, 17), -- v -> v for vendetta
    (9, 15), -- captain metropolis -> v for vendetta
    (9, 16), -- captain metropolis -> v for vendetta
    (9, 17), -- captain metropolis -> v for vendetta
    (10, 15), -- night owl -> v for vendetta
    (10, 16), -- night owl -> v for vendetta
    (10, 17), -- night owl -> v for vendetta

    (11, 18), -- caitlin fairchild -> east of west
    (12, 18), -- roxanne spaulding -> east of west
    (13, 18), -- sarah rainmaker -> east of west

    (14, 19), -- hawkeye -> hawkeye
    (15, 20), -- sandman -> the sandman
    (16, 21), -- hellboy -> hellboy
    (7, 22); -- batman -> batman


INSERT INTO creators(first_name, last_name) VALUES
    ("Stan", "Lee"), -- 1
    ("Steve", "Ditko"), -- 2
    ("Chris", "Claremont"), -- 3
    ("Jim", "Lee"), -- 4
    ("Jim", "Starlin"), -- 5
    ("George", "Pérez"), -- 6
    ("Alan", "Moore"), -- 7
    ("Frank", "Miller"), -- 8
    ("David", "Lloyd"), -- 9
    ("Dave", "Gibbons"), -- 10
    ("Alan", "Moore"), -- 11
    ("Brian", "Bolland"), -- 12
    ("Scott", "Snyder"), -- 13
    ("Mike", "Mignola"); -- 14

INSERT INTO feature_work(creator_id, collectable_id, job) VALUES
    (1, 1, "Writer"), -- stan lee -> spiderman(1999) #1
    (2, 1, "Artist"), -- steve ditko -> spiderman(1999) #1
    (1, 2, "Writer"), -- stan lee -> spiderman(1999) #2
    (2, 2, "Artist"), -- steve ditko -> spiderman(1999) #2
    (1, 3, "Writer"), -- stan lee -> spiderman(1999) #3
    (2, 3, "Artist"), -- steve ditko -> spiderman(1999) #3
    (1, 4, "Writer"), -- stan lee -> spiderman(1999) #4
    (2, 4, "Artist"), -- steve ditko -> spiderman(1999) #4
    (1, 5, "Writer"), -- stan lee -> spiderman(1999) #5
    (2, 5, "Artist"), -- steve ditko -> spiderman(1999) #5

    (3, 6, "Writer"), -- chris claremont -> xmen(1991) #1
    (6, 6, "Artist"), -- george pérez -> xmen(1991) #1
    (3, 7, "Writer"), -- chris claremont -> xmen(1991) #2
    (6, 7, "Artist"), -- george pérez -> xmen(1991) #2
    (3, 8, "Writer"), -- chris claremont -> xmen(1991) #3
    (6, 8, "Artist"), -- george pérez -> xmen(1991) #3
    (3, 9, "Writer"), -- chris claremont -> xmen(1991) #4
    (6, 9, "Artist"), -- george pérez -> xmen(1991) #4

    (5, 10, "Writer"), -- jim starlin -> infinity gauntlet
    (4, 10, "Artist"), -- jim lee -> infinity gauntlet
    (7, 11, "Writer"), -- alan moore -> watchmen
    (9, 11, "Artist"), -- david lloyd -> watchmen
    (8, 12, "Writer"), -- frank miller -> batman
    (4, 12, "Artist"), -- jim lee -> batman
    (7, 13, "Writer"), -- alan moore -> v for vendetta
    (8, 13, "Artist"), -- frank miller -> v for vendetta

    (7, 14, "Writer"), -- alan moore -> batman: the dark knight returns
    (8, 14, "Artist"), -- frank miller -> batman: the dark knight returns
    (7, 15, "Writer"), -- alan moore -> v for vendetta
    (9, 15, "Artist"), -- david lloyd -> v for vendetta
    (7, 16, "Writer"), -- alan moore -> v for vendetta
    (9, 16, "Artist"), -- david lloyd -> v for vendetta
    (7, 17, "Writer"), -- alan moore -> v for vendetta
    (9, 17, "Artist"), -- david lloyd -> v for vendetta

    (7, 18, "Writer"), -- Alan moore - v for vendetta
    (9, 18, "Artist"), -- David lloyd - v for vendetta

    (10, 19, "Artist"), -- mike mignola -> hawkeye
    (11, 20, "Writer"), -- scott snyder -> the sandman
    (12, 21, "Writer"), -- brian bolland -> hellboy

    (4, 22, "Writer"); -- Jim Lee -> Batman



INSERT INTO addresses(street, city, state, zip_code) VALUES
    ("Musterstraße", "Stuttgart", "Germany", "70701"), -- 1
    ("Keinestaße", "Maisenbach", "Germany", "73469"), -- 2
    ("Irgendwostraße", "Lautern", "Germany", "66666"), -- 3
    ("UCD Belfield", "Dublin", "Ireland", "D04 E021"), -- 4
    ("Gibtsnichtallee", "Fellbach", "Germany", "70702"), -- 5
    ("Hauptstraße", "Stuttgart", "Germany", "70701"), -- 6
    ("Oberhofstraße", "Munich", "Germany", "80331"), -- 7
    ("Burgweg", "Frankfurt", "Germany", "60311"), -- 8
    ("Bryson Road", "London", "United Kingdom", "SW19 1EX"), -- 9
    ("Bismarckstraße", "Dresden", "Germany", "01097"), -- 10
    ("Rue du Bac", "Paris", "France", "75007"), -- 11
    ("Via Garibaldi", "Rome", "Italy", "00153"); -- 12

INSERT INTO customers(first_name, last_name, address_id, dob) VALUES
    ("Korenz", "Lause", 1, "2002-12-13"), -- 1
    ("Kario", "Moepcke", 2, "2003-01-01"), -- 2
    ("Jonas", "Sichel", 3,"2002-03-11"), -- 3
    ("Bert", "Beispiel", 4, "2000-01-01"), -- 4
    ("Max", "Mustermann", 5, "2001-01-01"), -- 5
    ("Erika", "Mustermann", 6, "2001-01-01"), -- 6
    ("Oliver", "Meier", 7, "1999-12-05"), -- 7
    ("Lena", "Schmidt", 8, "2000-02-14"), -- 8
    ("Maximilian", "Schulze", 9, "1998-05-31"), -- 9
    ("Anna", "Müller", 10, "2003-08-23"), -- 10
    ("Julia", "König", 11, "1999-10-15"), -- 11
    ("Niklas", "Schneider", 12, "2001-04-02"); -- 12


INSERT INTO stock(collectable_id, condition_id, edition, buying_price, selling_price, format, in_stock) VALUES
    (1, 6.5, 1, 5.93, 69.91, "paperback", True ), -- stock_id: 1
    (2, 3.2, 1, 3448.57, 4310.71, "paperback", True ), -- stock_id: 2
    (3, 3.2, 1, 1681.42, 2101.78, "paperback", True ), -- stock_id: 3
    (3, 6.3, 1, 9580.67, 11975.84, "paperback", True ), -- stock_id: 4
    (4, 9.0, 1, 6174.97, 7718.71, "paperback", True ), -- stock_id: 5
    (4, 3.7, 1, 7650.70, 9563.38, "paperback", True ), -- stock_id: 6
    (5, 10.0, 1, 2012.67, 2515.84, "paperback, jumbo sized cover", False ), -- stock_id: 7
    (6, 0.3, 1, 9121.51, 11401.89, "paperback, jumbo sized cover", False ), -- stock_id: 8
    (7, 2.0, 1, 8986.38, 11232.97, "paperback, jumbo sized cover", True ), -- stock_id: 9
    (8, 1.2, 1, 6736.53, 8420.66, "paperback", True ), -- stock_id: 10
    (9, 1.3, 1, 600.78, 750.97, "paperback, jumbo sized cover", True ), -- stock_id: 11
    (9, 0.5, 1, 1932.36, 2415.45, "paperback", False ), -- stock_id: 12
    (10, 3.0, 1, 1341.74, 1677.17, "paperback, jumbo sized cover", True ), -- stock_id: 13
    (11, 9.3, 1, 2550.64, 3188.30, "paperback, jumbo sized cover", True ), -- stock_id: 14
    (11, 1.1, 1, 9442.03, 11802.54, "hardcover", True ), -- stock_id: 15
    (12, 5.0, 1, 4087.74, 5109.67, "hardcover", True ), -- stock_id: 16
    (13, 8.9, 1, 460.50, 5763.12, "hardcover", False ), -- stock_id: 17
    (13, 1.3, 1, 7019.78, 8774.73, "paperback", True ), -- stock_id: 18
    (14, 2.9, 1, 3970.14, 4962.68, "hardcover", True ), -- stock_id: 19
    (14, 6.2, 1, 9078.98, 11348.72, 'Owned by Stan Lee', False ), -- stock_id: 20
    (15, 4.9, 1, 7924.99, 9906.24, "hardcover", False ), -- stock_id: 21
    (16, 6.1, 1, 91.19, 115.24, "hardcover", True ), -- stock_id: 22
    (17, 9.5, 1, 5265.84, 6582.30, "paperback", True ), -- stock_id: 23
    (18, 9.1, 1, 3051.89, 3814.86, "paperback", True ), -- stock_id: 24
    (19, 7.8, 1, 458.23, 5734.04, "hardcover", True ), -- stock_id: 25
    (20, 2.0, 1, 6778.95, 8473.69, "hardcover", True ), -- stock_id: 26
    (21, 6.5, 1, 8429.73, 10537.16, "paperback", True ), -- stock_id: 27
    (22, 3.2, 1, 4428.73, 5535.91, "hardcover", False ); -- stock_id: 28

INSERT INTO comments(stock_id, comment) VALUES
    (1, "Signed by Stan Lee"),
    (2, "Very bad water damage"),
    (7, "Signed by Mac Miller"),
    (11, "Excellent condition"),
    (4, "Comes in plastic box"),
    (3, "Owned by Robert Downey JR"),
    (8, "Signed by Bret Easton Ellis"),
    (13, "Almost falling apart"),
    (18, "Signed by Stephen King"),
    (22, "Signed by J.K. Rowling");


INSERT INTO sold_items(stock_id, customer_id) VALUES
    (8, 2 ),
    (12, 1),
    (17, 3),
    (25, 1),
    (28, 4),
    (5, 1),
    (6, 2),
    (15, 4),
    (20, 4),
    (21, 3);



INSERT INTO wishlist(customer_id, stock_id) VALUES
    (5, 3),
    (5, 19),
    (5, 9),
    (6, 1),
    (1, 7),
    (4, 3),
    (3, 19),
    (2, 9),
    (1, 1),
    (3, 7),
    (3, 4);

INSERT INTO shopping_cart(customer_id, stock_id) VALUES
    (5, 3),
    (5, 19),
    (5, 9),
    (6, 1),
    (1, 7),
    (4, 3),
    (3, 19),
    (2, 9),
    (1, 1),
    (3, 7),
    (3, 4);

--

CREATE VIEW extended_shopping_cart AS
    SELECT cl.title, cm.issue_number, st.format, st.condition_id, cd.textual_condition, st.buying_price, st.selling_price, cst.first_name, cst.last_name
        FROM stock st
        JOIN shopping_cart sc ON st.stock_id = sc.stock_id
        JOIN collectables cl ON st.collectable_id = cl.collectable_id
        JOIN conditions cd ON st.condition_id = cd.condition_id
        JOIN customers cst ON sc.customer_id = cst.customer_id
        LEFT JOIN comics cm ON cl.collectable_id = cm.collectable_id;

CREATE VIEW available_stock AS
    SELECT cl.title, cm.issue_number, s.format ,s.condition_id, cd.textual_condition, s.buying_price, s.selling_price, c.comment,s.stock_id, cl.collectable_id
    FROM stock s
    JOIN collectables cl ON s.collectable_id = cl.collectable_id
    JOIN conditions cd ON s.condition_id = cd.condition_id
    LEFT JOIN comics cm ON cl.collectable_id = cm.collectable_id
    LEFT JOIN comments c ON s.stock_id = c.stock_id
    WHERE s.in_stock = True;

CREATE VIEW storyline_character_appearances AS
    SELECT s.storyline_title AS name, c.character_name, COUNT(*) AS num_appearances
    FROM character_appearances ca
    JOIN collectables co ON ca.collectable_id = co.collectable_id
    JOIN storyline_mappings sm ON co.collectable_id = sm.collectable_id
    JOIN storylines s ON sm.storyline_title = s.storyline_title
    JOIN characters c ON ca.character_id = c.character_id
    GROUP BY s.storyline_title, c.character_id
    ORDER BY name ASC;


CREATE VIEW sold_stock AS
    SELECT cl.title, cm.issue_number ,st.condition_id, cd.textual_condition, st.buying_price, st.selling_price, c.comment, cst.first_name, cst.last_name
        FROM stock st
        JOIN collectables cl ON st.collectable_id = cl.collectable_id
        JOIN conditions cd ON st.condition_id = cd.condition_id
        LEFT JOIN comics cm ON cl.collectable_id = cm.collectable_id
        LEFT JOIN comments c ON st.stock_id = c.stock_id
        JOIN sold_items si ON st.stock_id = si.stock_id
        JOIN customers cst ON si.customer_id = cst.customer_id;


CREATE VIEW best_customers AS
    SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, SUM(selling_price) AS total_spent
        FROM customers c
        JOIN sold_items s ON c.customer_id = s.customer_id
        JOIN stock st ON s.stock_id = st.stock_id
        GROUP BY c.customer_id
        ORDER BY total_spent DESC;

--  from here on some queries

-- stan lee comics
SELECT avs.stock_id, avs.title, avs.format, avs.issue_number, avs.condition_id, avs.textual_condition, avs.selling_price, avs.comment
    FROM available_stock avs
    JOIN feature_work fw ON fw.collectable_id = avs.collectable_id
    WHERE fw.creator_id = 1;


-- condition descriptions
SELECT conditions.textual_condition, MIN(condition_id) AS minimal_rating, MAX(condition_id) AS maximal_rating, condition_description
    FROM conditions
    JOIN condition_descriptions ON conditions.textual_condition = condition_descriptions.textual_condition
    GROUP BY textual_condition
    ORDER BY maximal_rating DESC;


-- shows customers who havent bought something in a given time
SELECT c.first_name, c.last_name, MAX(si.sale_date) AS last_purchase_date, DATEDIFF(CURRENT_DATE, MAX(si.sale_date)) AS days_since_last_purchase
    FROM customers c
    JOIN sold_items si ON c.customer_id = si.customer_id
    GROUP BY c.customer_id
    HAVING days_since_last_purchase >= 0;

-- sales count and total amount per storyline
SELECT s.storyline_title, COUNT(*) AS sales_count, SUM(st.selling_price) AS total_amount
    FROM storylines s
    JOIN storyline_mappings sm ON s.storyline_title = sm.storyline_title
    JOIN collectables c ON sm.collectable_id = c.collectable_id
    JOIN stock st ON c.collectable_id = st.collectable_id
    JOIN sold_items si ON st.stock_id = si.stock_id
    GROUP BY s.storyline_title
    ORDER BY total_amount DESC;

-- view with wishlist counts
SELECT st.stock_id, cl.title, cm.issue_number, st.buying_price, st.selling_price, st.format, st.in_stock, COUNT(*) AS wishlist_count
    FROM stock st
    JOIN wishlist w ON st.stock_id = w.stock_id
    JOIN collectables cl ON st.collectable_id = cl.collectable_id
    LEFT JOIN comics cm ON cl.collectable_id = cm.collectable_id
    GROUP BY st.stock_id, cm.issue_number, cl.title, st.buying_price, st.selling_price, st.format, st.in_stock
    ORDER BY wishlist_count DESC;
-- from here on some functions

-- function to create a storyline if it doesn't already exist
DELIMITER //
CREATE PROCEDURE create_storyline(
    storyline_name VARCHAR(255)
)
BEGIN

    -- check if storyline exists if it doesn't exist, create a new one
    IF (SELECT * FROM storylines WHERE name = storyline_name) = NULL THEN
        INSERT INTO storylines(storyline_name) VALUES (storyline_name);
    END IF;
END //


-- function to create a collectable if it doesn't already exist
CREATE FUNCTION create_collectable(
    title VARCHAR(255),
    publisher VARCHAR(255),
    storyline_id INT,
    issue_number INT
)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE collectable_id INT;

    -- check if collectable exists
    SELECT collectable_id INTO collectable_id FROM collectables WHERE title = title AND publisher = publisher AND storyline_id = storyline_id LIMIT 1;

    -- if it doesn't exist, create a new one
    IF collectable_id IS NULL THEN
        IF issue_number IS NULL THEN
            INSERT INTO collectables(title, publisher, storyline_id) VALUES (title, publisher, storyline_id);
        ELSE
            INSERT INTO collectables(title, publisher, storyline_id) VALUES (title, publisher, storyline_id);
            SET collectable_id = LAST_INSERT_ID();
            INSERT INTO comics(collectable_id, issue_number) VALUES (collectable_id, issue_number);
        END IF;
        SET collectable_id = LAST_INSERT_ID();
    END IF;

    RETURN collectable_id;
END //

-- function to create a comment for a stock item

CREATE PROCEDURE create_comment(
IN stock_id INT,
IN comment_text TEXT
)
BEGIN
-- add comment if given
IF comment_text IS NOT NULL THEN
INSERT INTO comments(stock_id, comment) VALUES (stock_id, comment_text);
END IF;
END //


-- main function to create a new stock item
CREATE FUNCTION create_stock(
    title VARCHAR(255),
    condition_id DECIMAL(3,1),
    buying_price DECIMAL(10,2),
    selling_price DECIMAL(10,2),
    format VARCHAR(255),
    in_stock BOOLEAN,
    comment_text TEXT,
    storyline_name VARCHAR(255),
    publisher VARCHAR(255),
    issue_number INT
)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE storyline_id INT;
    DECLARE collectable_id INT;
    DECLARE stock_id INT;

    -- create or retrieve storyline
    SET storyline_id = create_storyline(storyline_name);

    -- create or retrieve collectable
    SET collectable_id = create_collectable(title, publisher, storyline_id, issue_number);

    -- create new stock item
    INSERT INTO stock(collectable_id, condition_id, buying_price, selling_price, format, in_stock)
    VALUES (collectable_id, condition_id, buying_price, selling_price, format, in_stock);
    SET stock_id = LAST_INSERT_ID();

    -- add comment if given
    CALL create_comment(stock_id, comment_text);

    RETURN stock_id;
END //

DELIMITER ;


SELECT create_stock('The Avengers (1999)', 8.5, 4.5, 19.99, 'paperback', True, NULL, 'The Infinity Gauntlet', 'Marvel', NULL);


DELIMITER //
CREATE PROCEDURE create_discount(IN discount DECIMAL(5,2), IN stock_id INT)
BEGIN
    IF stock_id IS NULL THEN
        UPDATE stock SET selling_price = selling_price * (1 - discount / 100) WHERE in_stock IS TRUE;
    ELSE
        UPDATE stock SET selling_price = selling_price * (100 - discount/100) WHERE stock_id = stock_id AND in_stock IS TRUE;
    END IF;
END //
DELIMITER ;

CALL create_discount(10, NULL);

DELIMITER //
CREATE PROCEDURE revert_discount(IN discount INT, IN stock_id INT)
BEGIN
    DECLARE discount_factor DECIMAL(10, 2);

    SET discount_factor = 1 - (discount / 100);

    IF stock_id IS NULL THEN
        UPDATE stock SET selling_price = selling_price / discount_factor WHERE in_stock IS True;
    ELSE
        UPDATE stock SET selling_price = selling_price / discount_factor WHERE stock_id = stock_id AND in_stock IS True;
    END IF;
END //
DELIMITER ;

CALL revert_discount(10, NULL);



DELIMITER //
CREATE PROCEDURE create_purchase(IN cs_id INT, IN st_id INT)
BEGIN

    -- check if customer exists and if stock item is exists and is in stock

    IF (SELECT COUNT(*) FROM customers WHERE customer_id = cs_id) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Customer does not exist';
    END IF;

    IF (SELECT COUNT(*) FROM stock WHERE stock_id = st_id) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Stock item does not exist or is not in stock';
    END IF;

    UPDATE stock SET in_stock = False WHERE stock_id = st_id;
    INSERT INTO sold_items (customer_id, stock_id) VALUES (cs_id, st_id);

    DELETE FROM shopping_cart WHERE stock_id = st_id;
END //
DELIMITER ;


CALL create_purchase(1, 29);


--  trigger to update stock and shopping cart when an item is sold
DELIMITER //
CREATE PROCEDURE update_stock_and_carts()
BEGIN
    DECLARE sold_stock_id INT;
    DECLARE sold_customer_id INT;

    SELECT NEW.stock_id, NEW.customer_id INTO sold_stock_id, sold_customer_id;

    -- set the corresponding stock item's in_stock column to false
    UPDATE stock SET in_stock = FALSE WHERE stock_id = sold_stock_id;

    -- delete the item from all shopping carts
    DELETE FROM shopping_cart WHERE stock_id = sold_stock_id;
END //

CREATE TRIGGER sold_items_trigger AFTER INSERT ON sold_items
FOR EACH ROW
BEGIN
    CALL update_stock_and_cart();
END //

DELIMITER ;








