var map = new L.Map('introMap', { zoomControl: false }).setView([55.745, 37.606], 17);


/*
 * Init layers
 */

var
	lt_mbox = new L.TileLayer(
		'http://{s}.tiles.mapbox.com/v3/mapbox.mapbox-streets/{z}/{x}/{y}.png',
		{
			attribution: 'Данные карты &copy; участники <a href="http://openstreetmap.org">OpenStreetMap</a>, рендер &copy; <a href="http://mapbox.com">MapBox</a>',
			maxZoom: 17
		}
	),

	lt_cmade = L.tileLayer('http://{s}.tile.cloudmade.com/324b77d6f6774461a4ba74d61caba29b/997/256/{z}/{x}/{y}.png',
		{
			attribution: 'Данные карты &copy; участники <a href="http://openstreetmap.org">OpenStreetMap</a>, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, рендер © <a href="http://cloudmade.com">CloudMade</a>',
			maxZoom: 18
		}
	),

	lt_mapnik = L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
		{
			attribution: 'Данные карты &copy; участники <a href="http://openstreetmap.org">OpenStreetMap</a>, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>',
			maxZoom: 18
		}
	),

	l_3d = new L.BuildingsLayer({ url: 'http://osmbuildings.ru/server/?w={w}&n={n}&e={e}&s={s}&z={z}' }),
	l_3d_alt = new L.BuildingsLayer({ url: 'http://osmbuildings.ru/server/index_alt.php?w={w}&n={n}&e={e}&s={s}&z={z}' }),
	l_3d_test = new L.BuildingsLayer({ url: 'http://osmbuildings.ru/server/index_test.php?w={w}&n={n}&e={e}&s={s}&z={z}' });


/*
 * Add layers
 */

l_3d
	.addTo(map)
	.setStyle({ strokeRoofs: true });

lt_mbox.addTo(map);


/*
 * Add controls
 */

new L.Control.ZoomFS().addTo(map);
new L.Control.Permalink().addTo(map).setPosition('bottomleft');

L.control.layers(
	{
		'MapBox': lt_mbox,
		'CloudMade': lt_cmade,
		'Mapnik': lt_mapnik
	},
	{
		'3D-здания': l_3d,
		'3D-здания (другая перспектива)': l_3d_alt,
		'3D-здания (test)': l_3d_test
	}
).addTo(map);
