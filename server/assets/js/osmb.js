var map = new L.Map('introMap', { zoomControl: false }).setView([55.745, 37.606], 17);


/*
 * Init layers
 */

var
	lt_mbox = new L.TileLayer(
		'http://{s}.tiles.mapbox.com/v3/mapbox.mapbox-streets/{z}/{x}/{y}.png',
		{
			attribution: 'Данные карты &copy; участники <a href="http://openstreetmap.org">OpenStreetMap</a>, рендер &copy; <a href="http://mapbox.com">MapBox</a>',
			maxZoom: 17,
			alias: 'MB'
		}
	),

	lt_cmade = L.tileLayer('http://{s}.tile.cloudmade.com/324b77d6f6774461a4ba74d61caba29b/997/256/{z}/{x}/{y}.png',
		{
			attribution: 'Данные карты &copy; участники <a href="http://openstreetmap.org">OpenStreetMap</a>, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, рендер © <a href="http://cloudmade.com">CloudMade</a>',
			maxZoom: 18,
			alias: 'CM'
		}
	),

	lt_mapnik = L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
		{
			attribution: 'Данные карты &copy; участники <a href="http://openstreetmap.org">OpenStreetMap</a>, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>',
			maxZoom: 18,
			alias: 'M'
		}
	),

	l_3d = new L.BuildingsLayer({ url: 'http://data.osmbuildings.ru/?w={w}&n={n}&e={e}&s={s}&z={z}', alias: '3D' }),
	l_3d_test = new L.BuildingsLayer({ url: 'http://test.osmbuildings.ru/?w={w}&n={n}&e={e}&s={s}&z={z}', alias: '3T' });


/*
 * Add layers
 */

l_3d
	.addTo(map)
	.setStyle({ strokeRoofs: true });

lt_cmade.addTo(map);


/*
 * Add controls
 */
var c_layers = L.control.layers(
	{
		'CloudMade': lt_cmade,
		'MapBox': lt_mbox,
		'Mapnik': lt_mapnik
	},
	{
		'3D-здания': l_3d,
		'3D-здания (test)': l_3d_test
	}
).addTo(map);


new L.Control.ZoomFS().addTo(map);
new L.Control.Locate().addTo(map);
new L.Control.Permalink(c_layers).addTo(map).setPosition('bottomleft');

