from django.contrib import admin
from cricapp.models import *
# Register your models here.
admin.site.register(Team)
admin.site.register(Player)
admin.site.register(PlayerHistory)
admin.site.register(Matches)
admin.site.register(PointTable)