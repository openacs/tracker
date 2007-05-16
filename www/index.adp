<master>

<ul>
<multiple name=users>
 <li> <h2> @users.first_names@ @users.last_name@ </h2> </li>
    <include src="visits" user_id="@users.user_id@">
</multiple>
</ul>
<br>

</table>
