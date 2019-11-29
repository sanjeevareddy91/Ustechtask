from django.urls import path,include

from . import views
urlpatterns = [
    path('',views.TeamCreateView.as_view(),name="team_create"),
    path('team_list/',views.TeamListView.as_view(),name="team_list"),
    path('add_player/',views.add_player,name="add_player"),
    path('create_fixtures/',views.create_fixtures,name="create_fixtures"),
    path('single_players/<team_id>/',views.single_players,name="single_players"),
    path('single_matches/<team_id>/',views.single_matches,name="single_matches"),
    path('matches_list/',views.MatchesListView.as_view(),name="matches_list"),
    path('points_table/',views.PointTableListView.as_view(),name="points_table"),

]
