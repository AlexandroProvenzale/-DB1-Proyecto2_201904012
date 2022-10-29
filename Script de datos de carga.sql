/* Ingreso de carreras */
CALL CrearCarrera('Ciencias y Sistemas');
CALL CrearCarrera('Civil');
CALL CrearCarrera('Industrial');
CALL CrearCarrera('Química');

/* Ingreso de docentes */
CALL RegistrarDocente('Sergio Leonel', 'Gómez Bravo', '1971-01-01', 'soychocomax@gmail.com', 55096811, 'Ciudad de Guatemala 1', 3056350180111, 201011111);
CALL RegistrarDocente('Luis Fernando', 'Espino Barrios', '1975-01-01', 'usac.sistemas@gmail.com', 21212121, 'Ciudad de Guatemala 2', 3056350180222, 201022222);
CALL RegistrarDocente('Sergio Arnaldo', 'Méndez Aguilar', '1985-01-01', 'sergioarm.gpl@gmail.com', 50537711, '50 av. 3-79 zone 2 Mixco Col. molino de las Flores', 2641183830101, 201033333);
CALL RegistrarDocente('Herman Igor', 'Véliz Linares', '1980-01-01', 'hermanveliz@gmail.com', 54022579, 'Ciudad de Guatemala 4', 3056350180444, 201044444);
CALL RegistrarDocente('Renaldo', 'Giron', '1977-01-01', 'renaldoing@gmail.com', 55170655, 'Ciudad de Guatemala 5', 3056350180555, 201055555);

/* Ingreso de estudiantes */
CALL RegistrarEstudiante(201700569, 'Keila Avril', 'Vilchez Suárez', '1998-01-01', 'keilavilchez@gmail.com', 54384690, 'Ciudad de Guatemala 1.1', 3056350180121, 1);
CALL RegistrarEstudiante(201480017, 'Erick Javier', 'Bernal Orellana', '1998-02-02', 'erickbernal@gmail.com', 35542620, 'Ciudad de Guatemala 1.2', 3056350180122, 1);
CALL RegistrarEstudiante(201903848, 'Emiliano José Alexander', 'Velásquez Nájera', '2000-10-07', 'emivelasquez@gmail.com', 30458221, 'Antigua Gardens, Alotenango', 3059296900301, 1);
CALL RegistrarEstudiante(201903849, 'Jackeline Gabriela', 'Salazar Monterroso', '2001-01-03', 'jsalazarmonterroso@gmail.com', 56293090, 'Santiago Sacatepéquez', 2999424650101, 2);
CALL RegistrarEstudiante(201905919, 'Carlos José', 'Medina Grajeda', '2000-04-18', 'carlosmedina@gmail.com', 33369982, 'Alotenango Sacatepéquez', 3059295180301, 2);
CALL RegistrarEstudiante(201904012, 'Alexandro', 'Provenzale Pérez', '2001-10-08', 'alexprovenzale@gmail.com', 42146904, 'Jocotenango Sacatepéquez', 3056350180301, 2);
CALL RegistrarEstudiante(201901557, 'Jeffry Emanuel', 'Méndez Díaz', '2001-09-09', 'jeffrymendez@gmail.com', 41140837, 'Ciudad de Guatemala 1.3', 3056350180234, 3);
CALL RegistrarEstudiante(201901816, 'Angel Oswaldo', 'Arteaga Garcia', '2000-08-24', 'angelartega@gmail.com', 33559901, 'Ciudad de Guatemala 1.4', 3056350180123, 3);
CALL RegistrarEstudiante(201709073, 'Walter Alexander', 'Guerra Duque', '2001-03-11', 'walterguerra@gmail.com', 35712893, 'Ciudad de Guatemala 1.5', 3056350180133, 4);
CALL RegistrarEstudiante(201902425, 'Ronal Rodrigo', 'Marín Salas', '2001-05-08', 'ronaldmarin@gmail.com', 43562323, 'Ciudad de Guatemala 1.6', 3056350180454, 4);

/* Ingreso de estudiantes */
/* Ciencias y Sistemas */
CALL CrearCurso(774, 'Sistemas de Bases de Datos uno', 15, 6, 1, 1);
CALL CrearCurso(795, 'Lógica de Sistemas', 5, 3, 1, 1);
CALL CrearCurso(796, 'Lenguajes Formales y de Programación', 10, 4, 1, 1);
CALL CrearCurso(960, 'Matemática para Computación uno', 5, 5, 1, 1);
CALL CrearCurso(776, 'Bases de Datos Avanzadas', 15, 5, 1, 0);
/* Civil */
CALL CrearCurso(254, 'Hidrología', 10, 5, 2, 1);
CALL CrearCurso(453, 'Materiales de construcción uno', 5, 4, 2, 1);
CALL CrearCurso(687, 'Geologia estructural', 5, 3, 2, 0);
CALL CrearCurso(458, 'Mecanica de suelos', 10, 4, 2, 1);
CALL CrearCurso(262, 'Aguas subterraneas', 15, 3, 2, 0);
/* Industrial */
CALL CrearCurso(090, 'Programación de computadoras uno', 5, 3, 3, 1);
CALL CrearCurso(073, 'Dibujo técnico mecánico', 0, 3, 3, 1);
CALL CrearCurso(300, 'Resistencia de materiales uno', 5, 5, 3, 1);
CALL CrearCurso(172, 'Mecanica analítica dos', 5, 5, 3, 0);
CALL CrearCurso(665, 'Microeconomía', 10, 3, 3, 1);
/* Química */
CALL CrearCurso(354, 'Química tres', 0, 5, 4, 1);
CALL CrearCurso(356, 'Química cuatro', 5, 5, 4, 1);
CALL CrearCurso(362, 'Analisis Cualitativo uno', 10, 5, 4, 1);
CALL CrearCurso(250, 'Mecanica de fluidos', 10, 6, 4, 0);
CALL CrearCurso(335, 'Gestión de desastres', 15, 3, 4, 0);
/* Área común */
CALL CrearCurso(006, 'Idioma técnico uno', 0, 2, 0, 0);
CALL CrearCurso(101, 'Mate básica uno', 0, 7, 0, 1);
CALL CrearCurso(147, 'Física básica', 5, 5, 0, 1);
CALL CrearCurso(010, 'Lógica', 5, 2, 0, 0);
CALL CrearCurso(018, 'Filosofía de la ciencia', 10, 3, 0, 0);