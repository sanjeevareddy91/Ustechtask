from django.shortcuts import render,redirect

from cricapp.models import *
from django.views.generic.list import ListView
from django.views.generic.edit import CreateView
from django.urls import reverse_lazy
import random
from django.db.models import Q

class TeamCreateView(CreateView):
    model = Team
    template_name = 'add_team.html'
    fields="__all__" 
    success_url = reverse_lazy('team_create')


class TeamListView(ListView):
    model = Team
    template_name = 'team_list.html'

def add_player(request):
    if request.method=="POST" and request.FILES:
        player_id = request.POST['player_id']
        first_name = request.POST['first_name']
        last_name = request.POST['last_name']
        player_image = request.FILES['player_image']
        player_jersey_number = request.POST['player_jersey_number']
        player_country = request.POST['player_country']
        player_team = request.POST['player_team']
        team_data = Team.objects.get(team_name = player_team)
        player_data = Player.objects.create(player_id=player_id,first_name=first_name,last_name=last_name,player_image=player_image,player_jersey_number=player_jersey_number,player_country=player_country,player_team=team_data)
        PlayerHistory.objects.create(player=player_data,no_matches_played = request.POST['no_matches_played'],total_runs_scored=request.POST['total_runs_scored'],highest_score=request.POST['highest_score'],fifties=request.POST['fifties'],hundreds = request.POST['hundreds'],no_of_catches=request.POST['no_of_catches'],average=request.POST['average'],strike_rate = request.POST['strike_rate'],player_role = request.POST['player_role'],no_of_wickets = request.POST['no_of_wickets'])
        return redirect('add_player')
    else:
        return render(request,'add_player.html')


def create_fixtures(request):
    team_data = list(Team.objects.all().values_list('team_id',flat=True))
    for id in range(len(team_data)):
        for new_id in range(id,len(team_data)-1):
            winner = random.choice([team_data[id],team_data[new_id+1]])
            team_1 = Team.objects.get(team_id=team_data[id])
            team_2 = Team.objects.get(team_id=team_data[new_id+1])
            winner = Team.objects.get(team_id=winner)
            Matches.objects.create(first_team=team_1,second_team=team_2,winner=winner)
            try:
                won_match = PointTable.objects.get(team=winner)
                won_match.points = won_match.points+2
                won_match.save()
            except:
                PointTable.objects.create(team=winner,points=2)
    return redirect('team_create')


def single_players(request,team_id):
    team_players = Player.objects.filter(player_team__team_id=team_id)
    team_name = Team.objects.get(team_id=team_id)
    return render(request,'players_list.html',{'objects_list':team_players,'team_name':team_name})


def single_matches(request,team_id):
    team_matches = Matches.objects.filter(Q(first_team__team_id=team_id) | Q(second_team__team_id=team_id)).order_by('id')
    team_name = Team.objects.get(team_id=team_id)
    return render(request,'single_matches.html',{'objects_list':team_matches,'team_name':team_name})


class MatchesListView(ListView):
    model = Matches
    template_name = 'matches_list.html'


class PointTableListView(ListView):
    model = PointTable
    template_name = 'point_table.html'