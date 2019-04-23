
CREATE TABLE `Meta` (
  `meta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `foreign_table_id` bigint(20) UNSIGNED NOT NULL,
  `table_name` bigint(20) UNSIGNED NOT NULL,  
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (meta_id),
  UNIQUE KEY (foreign_table_id, table_name, meta_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `Term` (
  `term_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `slug` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `term_group` bigint(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (term_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Relationship` (
  `content_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `taxonomy_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `term_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (content_id, term_taxonomy_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `Taxonomy` (
  `taxonomy_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `term_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `taxonomy` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `parent` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `count` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (taxonomy_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `Content` (
  `content_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `text` longtext COLLATE utf8mb4_unicode_ci,
  `title` text COLLATE utf8mb4_unicode_ci,
  `parent` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (content_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

INSERT INTO `Content` (`content_id`, `date_gmt`, `text`, `title` ) VALUES
(1, '2014-06-30 20:22:30', "En informatique il est souvent nécessaire de pratiquer pour d'assimiler les différents concepts. Les exercices suivants couvrent les notions abordées dans la théorie.", 'SQL en pratique'),
(2, '2014-07-04 11:16:25', "Ce cours est destiné à quiconque s’intéresse au sujet. Il explique les divers concepts d'une manière aussi simple que possible. Aucune connaissance préalable n'est nécessaire.\r\n\r\nSont abordées, dans un premier temps, les notions d'entité, schéma de base de données, table, enregistrement, attribut, clé primaire, association, clé étrangère et typage de données.", 'Apprendre SQL'),
(3, '2014-10-09 19:27:08', "This course is intended for anyone with an interest in SQL. No prerequisites are needed. Explanations are made as simple as possible.\r\n\r\nFirst, we are going to cover the concepts of entity, database schema, table, record, attribute, primary key, association, foreign key and data type.", 'Learn SQL'),
(4, '2014-10-09 19:13:20', "The practice plays an important role in understanding the concepts. Doing the following exercises may help the progress in learning SQL. All the studied concepts are covered.", "Let's practice SQL");
(5, '2016-10-09 19:13:20', '', 'Thomas Rubattel'),
(6, '2015-04-10 08:13:20', '', 'Franz Sturzenegger');


INSERT INTO `Term` (`term_id`, `name`) VALUES
(1, 'ENG'),
(2, 'JPN'),
(3, 'FRA'),
(4, 'DEU'),
(6, 'Male'),
(6, 'Female'),
(7, 'IT'),
(8, 'Editing');


INSERT INTO `Taxonomy` (`taxonomy_id`, `term_id`, `taxonomy`, `parent`) VALUES
(1, (SELECT term_id FROM Term WHERE name = 'FRA'), 'Internationalization' ),
(2, (SELECT term_id FROM Term WHERE name = 'FRA'), 'Internationalization' ),
(3, (SELECT term_id FROM Term WHERE name = 'ENG'), 'Internationalization' ),
(4, (SELECT term_id FROM Term WHERE name = 'Male'), 'Person' ),
(5, (SELECT term_id FROM Term WHERE name = 'Female'), 'Person' ),
(6, (SELECT term_id FROM Term WHERE name = 'DEU'), 'Language' ),
(7, (SELECT term_id FROM Term WHERE name = 'FRA'), 'Language' ),
(8, (SELECT term_id FROM Term WHERE name = 'IT'), 'Employee', (SELECT taxonomy_id FROM Taxonomy WHERE taxonomy = 'Person' ) ),
(9, (SELECT term_id FROM Term WHERE name = 'Editing'), 'Employee', (SELECT taxonomy_id FROM Taxonomy WHERE taxonomy = 'Person' ) );


INSERT INTO `Relationship` (`content_id`, `taxonomy_id`) VALUES
((SELECT content_id FROM Content WHERE title = 'SQL en pratique'), (SELECT taxonomy_id FROM Taxonomy WHERE taxonomy ='Internationalization' AND term_id = (SELECT term_id FROM Term WHERE name='FRA' ) ) ),
((SELECT content_id FROM Content WHERE title = 'Apprendre SQL'), (SELECT taxonomy_id FROM Taxonomy WHERE taxonomy ='Internationalization' AND term_id = (SELECT term_id FROM Term WHERE name='FRA' ) ) );

