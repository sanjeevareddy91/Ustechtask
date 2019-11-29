-- TABLE
CREATE TABLE "auth_group" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(80) NOT NULL UNIQUE);
CREATE TABLE "auth_group_permissions" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "group_id" integer NOT NULL REFERENCES "auth_group" ("id") DEFERRABLE INITIALLY DEFERRED, "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE "auth_permission" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "content_type_id" integer NOT NULL REFERENCES "django_content_type" ("id") DEFERRABLE INITIALLY DEFERRED, "codename" varchar(100) NOT NULL, "name" varchar(255) NOT NULL);
CREATE TABLE "auth_user" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "password" varchar(128) NOT NULL, "last_login" datetime NULL, "is_superuser" bool NOT NULL, "username" varchar(150) NOT NULL UNIQUE, "first_name" varchar(30) NOT NULL, "email" varchar(254) NOT NULL, "is_staff" bool NOT NULL, "is_active" bool NOT NULL, "date_joined" datetime NOT NULL, "last_name" varchar(150) NOT NULL);
CREATE TABLE "auth_user_groups" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "user_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "group_id" integer NOT NULL REFERENCES "auth_group" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE "auth_user_user_permissions" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "user_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE "cricapp_matches" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "first_team_id" varchar(10) NOT NULL REFERENCES "cricapp_team" ("team_id") DEFERRABLE INITIALLY DEFERRED, "second_team_id" varchar(10) NOT NULL REFERENCES "cricapp_team" ("team_id") DEFERRABLE INITIALLY DEFERRED, "winner_id" varchar(10) NOT NULL REFERENCES "cricapp_team" ("team_id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE "cricapp_player" ("player_id" varchar(10) NOT NULL PRIMARY KEY, "first_name" varchar(30) NOT NULL, "last_name" varchar(30) NOT NULL, "player_image" varchar(100) NOT NULL, "player_jersey_number" integer NOT NULL, "player_country" varchar(25) NOT NULL, "player_team_id" varchar(10) NOT NULL REFERENCES "cricapp_team" ("team_id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE "cricapp_playerhistory" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "no_matches_played" integer NULL, "total_runs_scored" integer NULL, "highest_score" integer NULL, "fifties" integer NULL, "hundreds" integer NULL, "no_of_catches" integer NULL, "average" real NULL, "strike_rate" real NULL, "player_role" varchar(15) NOT NULL, "no_of_wickets" integer NULL, "player_id" varchar(10) NOT NULL REFERENCES "cricapp_player" ("player_id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE "cricapp_pointtable" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "points" integer NULL, "team_id" varchar(10) NOT NULL REFERENCES "cricapp_team" ("team_id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE "cricapp_team" ("team_id" varchar(10) NOT NULL PRIMARY KEY, "team_name" varchar(30) NOT NULL, "team_logo" varchar(100) NOT NULL, "club_state" varchar(25) NOT NULL);
CREATE TABLE "django_admin_log" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "object_id" text NULL, "object_repr" varchar(200) NOT NULL, "action_flag" smallint unsigned NOT NULL, "change_message" text NOT NULL, "content_type_id" integer NULL REFERENCES "django_content_type" ("id") DEFERRABLE INITIALLY DEFERRED, "user_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "action_time" datetime NOT NULL);
CREATE TABLE "django_content_type" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "app_label" varchar(100) NOT NULL, "model" varchar(100) NOT NULL);
CREATE TABLE "django_migrations" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "app" varchar(255) NOT NULL, "name" varchar(255) NOT NULL, "applied" datetime NOT NULL);
CREATE TABLE "django_session" ("session_key" varchar(40) NOT NULL PRIMARY KEY, "session_data" text NOT NULL, "expire_date" datetime NOT NULL);
CREATE TABLE sqlite_sequence(name,seq);
 
-- INDEX
CREATE INDEX "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" ("group_id");
CREATE UNIQUE INDEX auth_group_permissions_group_id_permission_id_0cd325b0_uniq ON "auth_group_permissions" ("group_id", "permission_id");
CREATE INDEX "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" ("permission_id");
CREATE INDEX "auth_permission_content_type_id_2f476e4b" ON "auth_permission" ("content_type_id");
CREATE UNIQUE INDEX auth_permission_content_type_id_codename_01ab375a_uniq ON "auth_permission" ("content_type_id", "codename");
CREATE INDEX "auth_user_groups_group_id_97559544" ON "auth_user_groups" ("group_id");
CREATE INDEX "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" ("user_id");
CREATE UNIQUE INDEX auth_user_groups_user_id_group_id_94350c0c_uniq ON "auth_user_groups" ("user_id", "group_id");
CREATE INDEX "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" ("permission_id");
CREATE INDEX "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" ("user_id");
CREATE UNIQUE INDEX auth_user_user_permissions_user_id_permission_id_14a6b632_uniq ON "auth_user_user_permissions" ("user_id", "permission_id");
CREATE INDEX "cricapp_matches_first_team_id_346de9d1" ON "cricapp_matches" ("first_team_id");
CREATE INDEX "cricapp_matches_second_team_id_e7216760" ON "cricapp_matches" ("second_team_id");
CREATE INDEX "cricapp_matches_winner_id_df50aa4f" ON "cricapp_matches" ("winner_id");
CREATE INDEX "cricapp_player_player_team_id_4a3ccde7" ON "cricapp_player" ("player_team_id");
CREATE INDEX "cricapp_playerhistory_player_id_8b9b69ce" ON "cricapp_playerhistory" ("player_id");
CREATE INDEX "cricapp_pointtable_team_id_a3ef35b3" ON "cricapp_pointtable" ("team_id");
CREATE INDEX "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" ("content_type_id");
CREATE INDEX "django_admin_log_user_id_c564eba6" ON "django_admin_log" ("user_id");
CREATE UNIQUE INDEX django_content_type_app_label_model_76bd3d3b_uniq ON "django_content_type" ("app_label", "model");
CREATE INDEX "django_session_expire_date_a5c62663" ON "django_session" ("expire_date");
 
-- TRIGGER
 
-- VIEW
 
