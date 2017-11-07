CREATE TABLE quotes (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  philosopher_id INTEGER,

  FOREIGN KEY(philosopher_id) REFERENCES philosopher(id)
);

CREATE TABLE philosophers (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  school_id INTEGER,

  FOREIGN KEY(school_id) REFERENCES school(id)
);

CREATE TABLE schools (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

INSERT INTO
  schools (id, name)
VALUES
  (1, "Continental Philosophy"), (2, "Analytic Philosophy"),
  (3, "Chinese Philosophy"), (4, "Arctic Philosophy");

INSERT INTO
  philosophers (id, name, school_id)
VALUES
  (1, "de Beauvoir", 1),
  (2, "Sartre", 1),
  (3, "Nietzsche", 1),
  (4, "Kierkegaard", 1),
  (5, "Russell", 2),
  (6, "Frege", 2),
  (7, "Wittgenstein", 2),
  (8, "Rorty", 2),
  (9, "Confucius", 3),
  (10, "Laozi", 3),
  (11, "Zhuangzi", 3),
  (12, "Mozi", 3),
  (13, "Thimblarb", 4),
  (14, "Lottgarg", 4),
  (15, "Hippleblimp", 4),
  (16, "Flibglaarb", 4);


INSERT INTO
  quotes (id, name, philosopher_id)
VALUES
  (1, "The body is not a thing, it is a situation: it is our grasp on the world and our sketch of our project", 1),
  (2, "Hell is other people", 2),
  (3, "All truly great thoughts are conceived by walking", 3),
  (4, "Life is not a problem to be solved, but a reality to be experienced", 4),
  (5, "The world is full of magical things patiently waiting for our wits to grow sharper", 5),
  (6, "Your discovery of the contradiction caused me the greatest surprise and, I would almost say, consternation, since it has shaken the basis on which I intended to build arithmetic", 6),
  (7, "The limits of my language mean the limits of my world", 7),
  (8, "Always strive to excel, but only on weekends", 8),
  (9, "Freedom is the recognition of contingency", 8),
  (10, "To be wronged is nothing unless you continue to remember it", 9),
  (11, "To the mind that is still, the whole universe surrenders", 10),
  (12, "Where can I find a man who has forgotten words so I can talk with him?", 11),
  (13, "To accomplish anything whatsoever one must have standards", 12),
  (14, "The self is an ice cube relating itself to an icecube", 13),
  (15, "Building a life is like building an igloo -- it requires lots of ice", 14),
  (16, "There is but one form of Being -- that which, from Nothingness, manifests itself as Snow and Ice", 15),
  (17, "Existence precedes essence, and both are preceded by torrential ice storms", 16);
