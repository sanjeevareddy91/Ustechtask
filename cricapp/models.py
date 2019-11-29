from django.db import models

# Create your models here.

class Team(models.Model):
    team_id = models.CharField(max_length=10,primary_key=True)
    team_name = models.CharField(max_length=30)
    team_logo = models.FileField()
    club_state = models.CharField(max_length=25)

    def __str__(self):
        return self.team_id

class Player(models.Model):
    player_id = models.CharField(max_length=10,primary_key=True)
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=30)
    player_image = models.FileField()
    player_jersey_number = models.IntegerField()
    player_country = models.CharField(max_length=25)
    player_team = models.ForeignKey(Team,on_delete=models.CASCADE)


    def __str__(self):
        return self.player_id


class PlayerHistory(models.Model):
    player = models.ForeignKey(Player,on_delete=models.CASCADE)
    no_matches_played = models.IntegerField(null=True,blank=True)
    total_runs_scored = models.IntegerField(null=True,blank=True)
    highest_score = models.IntegerField(null=True,blank=True)
    fifties = models.IntegerField(null=True,blank=True)
    hundreds = models.IntegerField(null=True,blank=True)
    no_of_catches = models.IntegerField(null=True,blank=True)
    average = models.FloatField(null=True,blank=True)
    strike_rate = models.FloatField(null=True,blank=True)
    player_role = models.CharField(max_length=15)
    no_of_wickets = models.IntegerField(null=True,blank=True)

    def __str__(self):
        return self.player.first_name

class Matches(models.Model):
    first_team = models.ForeignKey(Team,on_delete=models.CASCADE,related_name='first_team')
    second_team = models.ForeignKey(Team,on_delete=models.CASCADE,related_name='second_team')
    winner = models.ForeignKey(Team,on_delete=models.CASCADE,related_name='team_winner')

    def __str__(self):
        return str(self.id)

class PointTable(models.Model):
    team = models.ForeignKey(Team,on_delete=models.CASCADE)
    points = models.IntegerField(null=True,blank=True)

    def __str__(self):
        return self.team.team_name