<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfoutput>
<cfparam name="locations">
<cfparam name="params.key" default="">

<!--- Get Buildings --->
<cfquery dbtype="query" name="buildings">
	SELECT DISTINCT building FROM locations WHERE building IS NOT NULL;
</cfquery>

<!--- Inline CSS--->
<cfif application.rbs.setting.showlocationcolours>
<style>
<cfloop query="locations"><cfif len(colour)>.#class# {background: #colour#; border-color: #colour#;}</cfif>
</cfloop>
</style>
</cfif>
<div id="location-filter">
	<div class="btn-group btn-group-justified building-row">
	#linkTo(action="index",  class="btn btn-primary btn-sm location-filter", data_id="all", text="All")#
	<cfif buildings.recordcount>
		<cfloop query="buildings">
			#linkTo(controller="bookings", action="building", key=toTagSafe(building), class="#iif(params.key EQ toTagSafe(building), '"active"', '')# btn btn-sm btn-primary location-filter", data_id="#toTagSafe(building)#", text="#building#")#
		</cfloop>
	</cfif>
	</div>
	<div class="btn-group  btn-group-justified location-row">
		<cfloop query="locations">
			#linkTo(controller="bookings", action="location", key=id, class="all  #toTagSafe(building)# btn btn-sm location-filter btn-default #class# location#id#", text="#name#<br /><small>#description#</small>")#
		</cfloop>
	</div>
</div>

<cfsavecontent variable="request.js.locationnav">
	<script>
		$(document).ready(function(){
			$(".building-row a").on("mouseenter", function(e){
				var id=$(this).data("id");
				$(".location-row").find("a").addClass("hidden").end()
								  .find("a" +"." + id).removeClass("hidden");
			}).on("mouseleave", function(e){
			});
		});
	</script>
</cfsavecontent>
</cfoutput>