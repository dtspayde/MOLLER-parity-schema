-- SQL dump generated using DBML (dbml.dbdiagram.io)
-- Database: MySQL
-- Generated at: 2025-11-01T15:45:54.401Z

CREATE TABLE `db_schema` (
  `db_schema_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `major_release_number` CHAR(2) NOT NULL,
  `minor_release_number` CHAR(2) NOT NULL,
  `point_release_number` CHAR(4) NOT NULL,
  `time` TIMESTAMP NOT NULL,
  `script_name` TEXT
);

CREATE TABLE `good_for` (
  `good_for_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `type` TEXT
);

CREATE TABLE `run_quality` (
  `run_quality_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `type` TEXT
);

CREATE TABLE `run` (
  `run_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `run_number` INT NOT NULL,
  `slug` INT NOT NULL,
  `wien_slug` INT NOT NULL,
  `injector_slug` INT NOT NULL,
  `run_type` TEXT,
  `start_time` DATETIME,
  `end_time` DATETIME,
  `n_mps` INT NOT NULL,
  `n_qrt` INT NOT NULL,
  `comment` TEXT
);

CREATE TABLE `runlet` (
  `runlet_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `run_id` INT NOT NULL,
  `run_number` INT NOT NULL,
  `segment_number` INT,
  `full_run` ENUM ('false', 'true') NOT NULL,
  `start_time` DATETIME,
  `end_time` DATETIME,
  `first_mps` INT NOT NULL,
  `last_mps` INT NOT NULL,
  `comment` TEXT
);

CREATE TABLE `seeds` (
  `seed_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `first_run_id` INT NOT NULL,
  `last_run_id` INT NOT NULL,
  `seed` TEXT,
  `comment` TEXT
);

CREATE TABLE `analysis` (
  `analysis_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `runlet_id` INT NOT NULL,
  `seed_id` INT NOT NULL,
  `time` DATETIME,
  `bf_checksum` TEXT,
  `beam_mode` ENUM ('nbm', '1', '2', '3') NOT NULL,
  `n_mps` INT NOT NULL,
  `n_qrt` INT NOT NULL,
  `first_event` INT,
  `last_event` INT,
  `segment` INT,
  `slope_calculation` ENUM ('off', 'on'),
  `slope_correction` ENUM ('off', 'on'),
  `root_version` TEXT NOT NULL,
  `root_file_time` TEXT NOT NULL,
  `root_file_host` TEXT NOT NULL,
  `root_file_user` TEXT NOT NULL,
  `analyzer_name` TEXT NOT NULL,
  `analyzer_argv` TEXT NOT NULL,
  `analyzer_svn_rev` TEXT NOT NULL,
  `analyzer_svn_lc_rev` TEXT NOT NULL,
  `analyzer_svn_url` TEXT NOT NULL,
  `roc_flags` TEXT NOT NULL
);

CREATE TABLE `parameter_files` (
  `parameter_file_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `analysis_id` INT NOT NULL,
  `filename` TEXT NOT NULL
);

CREATE TABLE `error_code` (
  `error_code_id` TINYINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `quantity` TEXT NOT NULL
);

CREATE TABLE `general_errors` (
  `general_errors_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `analysis_id` INT NOT NULL,
  `error_code_id` TINYINT NOT NULL,
  `n` INT NOT NULL
);

CREATE TABLE `measurement_type` (
  `measurement_type_id` CHAR(3) PRIMARY KEY NOT NULL,
  `units` TEXT NOT NULL,
  `title` TEXT NOT NULL
);

CREATE TABLE `slope_type` (
  `slope_type_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `slope` TEXT NOT NULL,
  `units` TEXT NOT NULL,
  `title` TEXT NOT NULL
);

CREATE TABLE `monitor` (
  `monitor_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `quantity` TEXT NOT NULL,
  `title` TEXT NOT NULL
);

CREATE TABLE `main_detector` (
  `main_detector_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `quantity` TEXT NOT NULL,
  `title` TEXT NOT NULL
);

CREATE TABLE `lumi_detector` (
  `lumi_detector_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `quantity` TEXT NOT NULL,
  `title` TEXT NOT NULL
);

CREATE TABLE `md_data` (
  `md_data_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `analysis_id` INT NOT NULL,
  `main_detector_id` INT,
  `measurement_type_id` CHAR(3) NOT NULL,
  `subblock` TINYINT NOT NULL,
  `n` INT NOT NULL,
  `value` FLOAT NOT NULL,
  `error` FLOAT NOT NULL
);

CREATE TABLE `md_errors` (
  `md_errors_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `analysis_id` INT NOT NULL,
  `main_detector_id` INT NOT NULL,
  `error_code_id` TINYINT NOT NULL,
  `n` INT NOT NULL
);

CREATE TABLE `lumi_data` (
  `lumi_data_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `analysis_id` INT NOT NULL,
  `lumi_detector_id` INT,
  `measurement_type_id` CHAR(3) NOT NULL,
  `subblock` TINYINT NOT NULL,
  `n` INT NOT NULL,
  `value` FLOAT NOT NULL,
  `error` FLOAT NOT NULL
);

CREATE TABLE `lumi_errors` (
  `lumi_errors_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `analysis_id` INT NOT NULL,
  `lumi_detector_id` INT NOT NULL,
  `error_code_id` TINYINT NOT NULL,
  `n` INT NOT NULL
);

CREATE TABLE `beam` (
  `beam_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `analysis_id` INT NOT NULL,
  `monitor_id` INT NOT NULL,
  `measurement_type_id` CHAR(3) NOT NULL,
  `subblock` TINYINT NOT NULL,
  `n` INT NOT NULL,
  `value` FLOAT NOT NULL,
  `error` FLOAT NOT NULL
);

CREATE TABLE `beam_errors` (
  `beam_errors_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `analysis_id` INT NOT NULL,
  `monitor_id` INT NOT NULL,
  `error_code_id` TINYINT NOT NULL,
  `n` INT NOT NULL
);

CREATE TABLE `md_slope` (
  `md_slope_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `analysis_id` INT NOT NULL,
  `slope_type_id` INT NOT NULL,
  `measurement_type_id` CHAR(3) NOT NULL,
  `main_detector_id` INT NOT NULL,
  `subblock` TINYINT NOT NULL,
  `n` INT NOT NULL,
  `value` FLOAT NOT NULL,
  `error` FLOAT NOT NULL
);

CREATE TABLE `lumi_slope` (
  `lumi_slope_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `analysis_id` INT NOT NULL,
  `slope_type_id` INT NOT NULL,
  `measurement_type_id` CHAR(3) NOT NULL,
  `lumi_detector_id` INT NOT NULL,
  `subblock` TINYINT NOT NULL,
  `n` INT NOT NULL,
  `value` FLOAT NOT NULL,
  `error` FLOAT NOT NULL
);

CREATE TABLE `slow_controls_settings` (
  `slow_controls_settings_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `runlet_id` INT NOT NULL,
  `slow_helicity_plate` ENUM ('0', '1'),
  `passive_helicity_plate` ENUM ('0', '1'),
  `wien_reversal` ENUM ('indeterminate', 'normal', 'reverse', 'transverse_vertical', 'transverse_horizontal'),
  `precession_reversal` ENUM ('CCW', 'CW', 'reverse', 'normal'),
  `helicity_length` INT,
  `charge_feedback` ENUM ('0', '1'),
  `position_feedback` ENUM ('0', '1'),
  `qtor_current` FLOAT,
  `target_position` TEXT
);

CREATE TABLE `sc_detector` (
  `sc_detector_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` TEXT NOT NULL,
  `units` TEXT NOT NULL,
  `comment` TEXT NOT NULL
);

CREATE TABLE `slow_controls_data` (
  `slow_controls_data_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `runlet_id` INT NOT NULL,
  `sc_detector_id` INT NOT NULL,
  `n` INT NOT NULL,
  `value` FLOAT NOT NULL,
  `error` FLOAT NOT NULL,
  `min_value` FLOAT NOT NULL,
  `max_value` FLOAT NOT NULL
);

CREATE TABLE `slow_controls_strings` (
  `slow_controls_strings_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `runlet_id` INT NOT NULL,
  `sc_detector_id` INT NOT NULL,
  `value` TEXT NOT NULL
);

CREATE TABLE `bf_test` (
  `bf_test_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `analysis_id` INT NOT NULL,
  `test_number` INT,
  `test_value` FLOAT
);

CREATE TABLE `modulation_type` (
  `modulation_type_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `type` TEXT
);

CREATE TABLE `beam_optics` (
  `beam_optics_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `analysis_id` INT NOT NULL,
  `monitor_id` INT NOT NULL,
  `modulation_type_id` INT NOT NULL,
  `n` INT NOT NULL,
  `amplitude` FLOAT NOT NULL,
  `phase` FLOAT NOT NULL,
  `offset` FLOAT NOT NULL,
  `a_error` FLOAT NOT NULL,
  `p_error` FLOAT NOT NULL,
  `o_error` FLOAT NOT NULL,
  `gof_para` FLOAT NOT NULL
);

ALTER TABLE `runlet` ADD FOREIGN KEY (`run_id`) REFERENCES `run` (`run_id`);

ALTER TABLE `seeds` ADD FOREIGN KEY (`first_run_id`) REFERENCES `run` (`run_id`);

ALTER TABLE `seeds` ADD FOREIGN KEY (`last_run_id`) REFERENCES `run` (`run_id`);

ALTER TABLE `analysis` ADD FOREIGN KEY (`runlet_id`) REFERENCES `runlet` (`runlet_id`);

ALTER TABLE `parameter_files` ADD FOREIGN KEY (`analysis_id`) REFERENCES `analysis` (`analysis_id`);

ALTER TABLE `general_errors` ADD FOREIGN KEY (`analysis_id`) REFERENCES `analysis` (`analysis_id`);

ALTER TABLE `general_errors` ADD FOREIGN KEY (`error_code_id`) REFERENCES `error_code` (`error_code_id`);

ALTER TABLE `md_data` ADD FOREIGN KEY (`analysis_id`) REFERENCES `analysis` (`analysis_id`);

ALTER TABLE `md_data` ADD FOREIGN KEY (`main_detector_id`) REFERENCES `main_detector` (`main_detector_id`);

ALTER TABLE `md_errors` ADD FOREIGN KEY (`analysis_id`) REFERENCES `analysis` (`analysis_id`);

ALTER TABLE `md_errors` ADD FOREIGN KEY (`main_detector_id`) REFERENCES `main_detector` (`main_detector_id`);

ALTER TABLE `lumi_data` ADD FOREIGN KEY (`analysis_id`) REFERENCES `analysis` (`analysis_id`);

ALTER TABLE `lumi_data` ADD FOREIGN KEY (`lumi_detector_id`) REFERENCES `lumi_detector` (`lumi_detector_id`);

ALTER TABLE `lumi_errors` ADD FOREIGN KEY (`analysis_id`) REFERENCES `analysis` (`analysis_id`);

ALTER TABLE `lumi_errors` ADD FOREIGN KEY (`lumi_detector_id`) REFERENCES `lumi_detector` (`lumi_detector_id`);

ALTER TABLE `beam` ADD FOREIGN KEY (`analysis_id`) REFERENCES `analysis` (`analysis_id`);

ALTER TABLE `beam` ADD FOREIGN KEY (`monitor_id`) REFERENCES `monitor` (`monitor_id`);

ALTER TABLE `beam` ADD FOREIGN KEY (`measurement_type_id`) REFERENCES `measurement_type` (`measurement_type_id`);

ALTER TABLE `beam_errors` ADD FOREIGN KEY (`analysis_id`) REFERENCES `analysis` (`analysis_id`);

ALTER TABLE `beam_errors` ADD FOREIGN KEY (`monitor_id`) REFERENCES `monitor` (`monitor_id`);

ALTER TABLE `beam_errors` ADD FOREIGN KEY (`error_code_id`) REFERENCES `error_code` (`error_code_id`);

ALTER TABLE `md_slope` ADD FOREIGN KEY (`analysis_id`) REFERENCES `analysis` (`analysis_id`);

ALTER TABLE `md_slope` ADD FOREIGN KEY (`slope_type_id`) REFERENCES `slope_type` (`slope_type_id`);

ALTER TABLE `md_slope` ADD FOREIGN KEY (`measurement_type_id`) REFERENCES `measurement_type` (`measurement_type_id`);

ALTER TABLE `md_slope` ADD FOREIGN KEY (`main_detector_id`) REFERENCES `main_detector` (`main_detector_id`);

ALTER TABLE `lumi_slope` ADD FOREIGN KEY (`analysis_id`) REFERENCES `analysis` (`analysis_id`);

ALTER TABLE `lumi_slope` ADD FOREIGN KEY (`slope_type_id`) REFERENCES `slope_type` (`slope_type_id`);

ALTER TABLE `lumi_slope` ADD FOREIGN KEY (`measurement_type_id`) REFERENCES `measurement_type` (`measurement_type_id`);

ALTER TABLE `lumi_slope` ADD FOREIGN KEY (`lumi_detector_id`) REFERENCES `lumi_detector` (`lumi_detector_id`);

ALTER TABLE `slow_controls_settings` ADD FOREIGN KEY (`runlet_id`) REFERENCES `runlet` (`runlet_id`);

ALTER TABLE `slow_controls_data` ADD FOREIGN KEY (`runlet_id`) REFERENCES `runlet` (`runlet_id`);

ALTER TABLE `slow_controls_data` ADD FOREIGN KEY (`sc_detector_id`) REFERENCES `sc_detector` (`sc_detector_id`);

ALTER TABLE `slow_controls_strings` ADD FOREIGN KEY (`runlet_id`) REFERENCES `runlet` (`runlet_id`);

ALTER TABLE `slow_controls_strings` ADD FOREIGN KEY (`sc_detector_id`) REFERENCES `sc_detector` (`sc_detector_id`);

ALTER TABLE `bf_test` ADD FOREIGN KEY (`analysis_id`) REFERENCES `analysis` (`analysis_id`);

ALTER TABLE `beam_optics` ADD FOREIGN KEY (`analysis_id`) REFERENCES `analysis` (`analysis_id`);

ALTER TABLE `beam_optics` ADD FOREIGN KEY (`monitor_id`) REFERENCES `monitor` (`monitor_id`);

ALTER TABLE `beam_optics` ADD FOREIGN KEY (`modulation_type_id`) REFERENCES `modulation_type` (`modulation_type_id`);
