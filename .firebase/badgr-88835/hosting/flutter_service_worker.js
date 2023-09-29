'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "548b75f4c5132c96029ee5c06117bd8d",
"assets/AssetManifest.json": "7f716c4f6a7017cb495b2f1b5877a77f",
"assets/assets/badgeReqs.json": "ea40b6cbc970d925ed226690e0fe48ca",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "a694848ce82e8e8c147c994515e3a0ab",
"assets/images/appstore.png": "3860c4c33021599724f5576cb3ed3c19",
"assets/images/app_full_pic_blue.png": "d7347cf4d6d01f16465d3ff13986b3d7",
"assets/images/app_full_pic_pink.png": "28236b12efc9466ebf360460bde990c6",
"assets/images/badges/AmericanBusiness.png": "e9fefdb28bd01505ed1da7bfee13fec7",
"assets/images/badges/AmericanCultures.png": "c8f1c53554e4595cfa5c9f3acd35e35f",
"assets/images/badges/AmericanHeritage.png": "cc14d271d297fc199286c6a8b99ff693",
"assets/images/badges/AmericanLabor.png": "cc2f2be5561f0eabe309eaa013e5d583",
"assets/images/badges/AnimalScience.png": "da3d1170ffd8c9fd6b6db19cf7517ab2",
"assets/images/badges/Animation.png": "1754765935e00a54e411a86dc98b40d1",
"assets/images/badges/Archaeology.png": "35e5028c77cbc161528e0d974c2acf83",
"assets/images/badges/Archery.png": "6156b9200ee249332a69f0614c6d8e43",
"assets/images/badges/Architecture.png": "4c594ff09a70707522b5fd9b81dd34eb",
"assets/images/badges/Art.png": "958e36b0cb2188d57e67880bf8a2f71d",
"assets/images/badges/Astronomy.png": "8d40a2ba0f0655ffe78655ef4bcec95e",
"assets/images/badges/Athletics.png": "ff564dc307e1271f9674b9af0a0aefb9",
"assets/images/badges/AutomotiveMaintenance.png": "6423bc604c190f0b6763fc7995eb7ba1",
"assets/images/badges/Aviation.png": "a59a63aba6e71229bd3dacf4e70188cf",
"assets/images/badges/Backpacking.png": "049b9c1f79fc68f5b5e94342b6c7cb6d",
"assets/images/badges/Basketry.png": "f39abe01e267a79a29cf4ae6c6b4828a",
"assets/images/badges/BirdStudy.png": "4439e7bd3fb694513738e5e358568111",
"assets/images/badges/Bugling.png": "64c14eeb09326b398849c634243a9347",
"assets/images/badges/Camping.png": "98edcc3e3e38801db5d78c14f7e783f1",
"assets/images/badges/Canoeing.png": "55dbae470c02c6899dd3f366540ada33",
"assets/images/badges/Chemistry.png": "643d52aae0e33b32a45344877205b7e1",
"assets/images/badges/Chess.png": "00a54596060a5ef235c8b134be331c57",
"assets/images/badges/CitizenshipInSociety.png": "717b1fd57fc309cb594fe9429b9abba1",
"assets/images/badges/CitizenshipInTheCommunity.png": "c2225f10972eb95b99abfcd15f424a50",
"assets/images/badges/CitizenshipInTheNation.png": "a57f9331e9d553cb455aeeec6399dca4",
"assets/images/badges/CitizenshipInTheWorld.png": "0d01c95b0f5707624c4120ca8817e131",
"assets/images/badges/Climbing.png": "43eb7361c4b8ad4c8f98863c9e4112d7",
"assets/images/badges/CoinCollecting.png": "525a5ae5b8810578ebcb4b0663c0cbde",
"assets/images/badges/Collections.png": "60da51f088259b388420ffb8d0c8fcc6",
"assets/images/badges/Communications.png": "a5dcb054799f522ac1a371d94a65906e",
"assets/images/badges/CompositeMaterials.png": "6905bd30947ca6a516f9c2727f94aa38",
"assets/images/badges/Cooking.png": "7c934f24fef5faee335597cb32c19f2f",
"assets/images/badges/CrimePrevention.png": "275c80b7cb70abb2b8a18730787e16a1",
"assets/images/badges/Cycling.png": "075a34f8c49029cd29bd0027e9701a3a",
"assets/images/badges/Dentistry.png": "111bab461ad1bbfca92a8575540fbd70",
"assets/images/badges/DigitalTechnology.png": "39bf8411e72c49efb468ee3de3dbcb9a",
"assets/images/badges/DisabilitiesAwareness.png": "4cd422e315c13bb960969fcc87999bf3",
"assets/images/badges/DogCare.png": "59e24416e6ea808fe10bd5d989a71851",
"assets/images/badges/Drafting.png": "933b301133685f5e72390894cdea3a3a",
"assets/images/badges/Electricity.png": "72d4979ccf2cdfc1b6c38e58089f4702",
"assets/images/badges/Electronics.png": "6eba047bc50ba3f407644f29d18e9066",
"assets/images/badges/EmergencyPreparedness.png": "d93cb59c13854d1d32032ae0dfe791d4",
"assets/images/badges/Energy.png": "7c35e87be60c3a824c73e6b8e6418a8a",
"assets/images/badges/Engineering.png": "d87dcd18ca4733e0a4d7f9ef49803cd2",
"assets/images/badges/Entrepreneurship.png": "83bf8461cca2ffd36b54a507aa427e49",
"assets/images/badges/EnvironmentalScience.png": "0f334725942b76243b1233356aacbbf5",
"assets/images/badges/Exploration.png": "2b3391deadc6a695ffa5c74724eb11f1",
"assets/images/badges/FamilyLife.png": "46073067f2377ace5f440875375121f4",
"assets/images/badges/FarmMechanics.png": "970496227ec758c74fd4982008b14f29",
"assets/images/badges/Fingerprinting.png": "e292ca5386398f713788579a9c3f26d4",
"assets/images/badges/FireSafety.png": "9d6a9b99d641afb8baa8c3aa60f2fad6",
"assets/images/badges/FirstAid.png": "f615eb64e9f700229dbaec9ce4e7eccd",
"assets/images/badges/FishAndWildlifeManagement.png": "f75533e7a15b5b0118e6114bbb74a5cc",
"assets/images/badges/Fishing.png": "83c47c1bbfc8e089b11237f4923d959d",
"assets/images/badges/FlyFishing.png": "518ed6c0e0102e6035e365f9a6a20680",
"assets/images/badges/Forestry.png": "e7cc3afbae221ff5cd0149599413a95a",
"assets/images/badges/GameDesign.png": "b2e5852307285c110ed82d4c1d52fed9",
"assets/images/badges/Gardening.png": "61ebb1b95553ca9004aba0dfebcbd7d2",
"assets/images/badges/Genealogy.png": "477e1dcfde5445ef63a573e1339e90dc",
"assets/images/badges/Geocaching.png": "f1c46f48e3e83a0155c7feabd446dea5",
"assets/images/badges/Geology.png": "7d8bc3f3b313d2eee5282eeeade68f7c",
"assets/images/badges/Golf.png": "0c730c5bcf0e4bdd32ec753d8a54d4fe",
"assets/images/badges/GraphicArts.png": "d786b2e0416512f5fc7ccdf3b7ee1053",
"assets/images/badges/HealthcareProfessions.png": "d7ed193d5c1eadc7b7779ede13127b3d",
"assets/images/badges/Hiking.png": "eb197b46c2c8e5f0bb8e4209c050f7fa",
"assets/images/badges/HomeRepairs.png": "35df806a5dc95cebe60b5223680b8470",
"assets/images/badges/Horsemanship.png": "8ed537118e033a29d7abd46917c25ef2",
"assets/images/badges/IndianLore.png": "92c0716906b0931460fffe6934c91bef",
"assets/images/badges/InsectStudy.png": "8c599bea1db49a8b610a6803261d7a7d",
"assets/images/badges/Inventing.png": "59482df15a436250946bbca7c9f83e97",
"assets/images/badges/Journalism.png": "6955c05ac54349c02ba184b98e290635",
"assets/images/badges/Kayaking.png": "2b5fc4556994f9dbb8f8569565809576",
"assets/images/badges/LandscapeArchitecture.png": "64b4ce3d2a71d770b5bb0632512cb833",
"assets/images/badges/Law.png": "72600f6c917880ce8391e8d55217cbec",
"assets/images/badges/Leatherwork.png": "3b1a0284535a89432977e315852befb2",
"assets/images/badges/Lifesaving.png": "884d24a41c9abf8da648d71672b1da98",
"assets/images/badges/MammalStudy.png": "58a64d85c5a271e06e4803febf101002",
"assets/images/badges/Metalwork.png": "a201c2cafd3c5b58b4a708bb71e7d504",
"assets/images/badges/MiningInSociety.png": "20c676496b71ff805470d82baaed46ce",
"assets/images/badges/ModelDesignAndBuilding.png": "904ddba0ac3f5137d14e1b09074239c7",
"assets/images/badges/Motorboating.png": "84738387b19ffa4c0389a55427c48bd9",
"assets/images/badges/Moviemaking.png": "889c7d299924fa39947552ef41835ad6",
"assets/images/badges/Music.png": "bf5ec0fdd9ce85b14c5bfe7020e837cd",
"assets/images/badges/Nature.png": "a5cc4e3851408176acfa8c1c8dfe3dfe",
"assets/images/badges/NuclearScience.png": "fbe6aac86eacb8a592741784bf9c16f7",
"assets/images/badges/Oceanography.png": "4130f36d6c94b1fdb4ef63cae585bbe5",
"assets/images/badges/Orienteering.png": "81600458a3e3dbd17d3909513f96b477",
"assets/images/badges/Painting.png": "10b39bfa98e2bdc52243bad198a7bc2c",
"assets/images/badges/PersonalFitness.png": "af0b604228967a8f0c6ae12e6c3e13a6",
"assets/images/badges/PersonalManagement.png": "3e1364e9f6efdccffb4ea7ef655b9c9c",
"assets/images/badges/Pets.png": "8a4d04c11ec4715ea1d818a1658d1579",
"assets/images/badges/Photography.png": "9c8290f3538f13a0d8cffc2f12e1c2a7",
"assets/images/badges/Pioneering.png": "d469fe3ee50227118f57a78db6f4892d",
"assets/images/badges/PlantScience.png": "858c3dd985c953ca5e44066e01038e3a",
"assets/images/badges/Plumbing.png": "8ab1e418ecdcfd8b6ccc53c8d6300761",
"assets/images/badges/Pottery.png": "38257b84622512b4f11ce30c88f83da4",
"assets/images/badges/Programming.png": "89c96193b4304b29f9733633bb418f0d",
"assets/images/badges/PublicHealth.png": "1a461e2a05464cd99a12769908f7f261",
"assets/images/badges/PublicSpeaking.png": "f9df17f9830d6a8c9a0e64d768fb3def",
"assets/images/badges/PulpAndPaper.png": "1c5bb41bc66cda6fcfd6d32bd4cba72e",
"assets/images/badges/Radio.png": "0d879b1d3d48200048086e81edce9d6d",
"assets/images/badges/Railroading.png": "1acb3ed63fe14f8efa0669b0c41d01ea",
"assets/images/badges/Reading.png": "76c250ddcabd3fcca1797cc2e48c7c1f",
"assets/images/badges/ReptileAndAmphibianStudy.png": "cada028456f79985b1bcd3523c832247",
"assets/images/badges/RifleShooting.png": "99910fb57f1e0b79e5ef44e5c4e749d5",
"assets/images/badges/Robotics.png": "1905e21ac3f90269f798a30f8895b92a",
"assets/images/badges/Rowing.png": "a305b6bdeecaee5c607566ee4653c259",
"assets/images/badges/Safety.png": "7f12f9953b2f6bc7d0fe8762a990fabe",
"assets/images/badges/Salesmanship.png": "2166432424c895c45cdf9567ed973109",
"assets/images/badges/Scholarship.png": "e4bc7904f1f22c29c28716036fff9fb8",
"assets/images/badges/ScoutingHeritage.png": "716d38dd590681b48aaab668d931d19a",
"assets/images/badges/ScubaDiving.png": "1e5c3cc75be7fd23a16ca8654d5e507c",
"assets/images/badges/Sculpture.png": "c0302ea3928e789b3fa585a2b962f7e2",
"assets/images/badges/SearchAndRescue.png": "f410f6b792fbe01794f38d1e6b94bec7",
"assets/images/badges/ShotgunShooting.png": "757e5e072b8fb860e31759f87642d136",
"assets/images/badges/SignsSignalsAndCodes.png": "4c2fbb306fe666fd77393bcb34d99a97",
"assets/images/badges/Skating.png": "406c825733a21c037c677055d976f670",
"assets/images/badges/SmallBoatSailing.png": "b00017a3863879e36acf2a7251a03823",
"assets/images/badges/SnowSports.png": "5836a483927c02125c51178ca94885ba",
"assets/images/badges/SoilAndWaterConservation.png": "2dd5e39e4ae7ff7374ee1a70648a5852",
"assets/images/badges/SpaceExploration.png": "5ffa5a9d359131f2a51cf9be3c5ce92a",
"assets/images/badges/Sports.png": "b59eab8b4414e9bffb0d583fb38b47c1",
"assets/images/badges/StampCollecting.png": "5dc7db458286a341ab6ae001756ff0c6",
"assets/images/badges/Surveying.png": "86cd8e96238b11fa736adbd7ae77afb2",
"assets/images/badges/Sustainability.png": "6e7cc621d3848ebdd426378fa4468cc1",
"assets/images/badges/Swimming.png": "c4a05e7fdfe368f86342211f08a9f08a",
"assets/images/badges/Textile.png": "77a2c43f3a44e03b24618f3f47e06d59",
"assets/images/badges/Theater.png": "1427c4565573ab1e4420f1f8fc13aeaf",
"assets/images/badges/TrafficSafety.png": "308fe823e3d49e63c59c102ca64d96fe",
"assets/images/badges/TruckTransportation.png": "c2e599185ef09ec41e144ede39207f0f",
"assets/images/badges/VeterinaryMedicine.png": "d33b83a4777c68ea38c769cc719c7045",
"assets/images/badges/WaterSports.png": "2fcc2a210cd9217f1600f96a6087a6c8",
"assets/images/badges/Weather.png": "efe11c7276509f076ef4e3d16eba9250",
"assets/images/badges/Welding.png": "d145498d67dab473541f31fd8d1f57dd",
"assets/images/badges/Whitewater.png": "0374509c2fac970790095849f2c4b7ce",
"assets/images/badges/WildernessSurvival.png": "0479cfd4840c4fdfe5679d39a84f1fe7",
"assets/images/badges/WoodCarving.png": "3411bab41a345c01878fb5b103d09301",
"assets/images/badges/Woodwork.png": "29f56d6a7d0a767ac2f3b1a3f4b3044d",
"assets/images/BadgRHead.png": "73747231ee695000c00c848babe31303",
"assets/images/playstore.png": "69d1e0f43d88dee99c4dad4162eac779",
"assets/NOTICES": "0784dd59136abaaaea90a395bcda62cb",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "57d849d738900cfd590e9adc7e208250",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"canvaskit/canvaskit.js": "76f7d822f42397160c5dfc69cbc9b2de",
"canvaskit/canvaskit.wasm": "f48eaf57cada79163ec6dec7929486ea",
"canvaskit/chromium/canvaskit.js": "8c8392ce4a4364cbb240aa09b5652e05",
"canvaskit/chromium/canvaskit.wasm": "fc18c3010856029414b70cae1afc5cd9",
"canvaskit/skwasm.js": "1df4d741f441fa1a4d10530ced463ef8",
"canvaskit/skwasm.wasm": "6711032e17bf49924b2b001cef0d3ea3",
"canvaskit/skwasm.worker.js": "19659053a277272607529ef87acf9d8a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "a097b5edf3cda0d5a851831d188353c4",
"/": "a097b5edf3cda0d5a851831d188353c4",
"main.dart.js": "65af2a378bfe107f52a553af4c4bb808",
"manifest.json": "0d203e1ff4e49e1c3872b7d03007e3cd",
"version.json": "ec1c9e9776b1bb052aba398f8bc76795"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
