// Marvel API handler
'use strict';
var api = require('marvel-api');

const spiderman = require('./spider-man')

var marvel = api.createClient({
  publicKey: 'c85fb470f52c2f0fadc9cf7b2383414d',
  privateKey: 'da0da9c53718269ad9056277e226a9937c0c23e9'
});

var getCharacterInfo = function(character_id) {
  return marvel.characters.find(character_id)
  .then(function(res) {
    var thumbnail = res.data[0].thumbnail
    var imageUrl = thumbnail.path + '.' + thumbnail.extension;
    // Call .then on
    return {
      id: res.data[0].id,
      image: imageUrl,
      name: res.data[0].name
    }
  })
  .fail(console.error);
};

var getInfoByName = function (name) {
  return marvel.characters.findByName(name)
  .then((res) => getCharacterInfo(res.data[0].id))
  .fail(function (res) {
    console.log("Error!")
    console.error(JSON.stringify(res))
  });
}

var getAssociatedCharacters = function(character_id) {
  return marvel.characters.events(character_id, 5)
  .then(function(res) {
    var character_list = res.data.map(function (event) {
      return event.characters.items.map(function(character) {
        return character.name;
      });
    });
    character_list = [].concat.apply([], character_list)

    return Promise.all(Array.from(new Set(character_list))
      .map((c) => getInfoByName(c))
    );
  })
  .then()
  .fail(console.error); 
}


// Main
var character_id = '1009610'
var name = 'spider-man'
// getCharacterInfo(character_id).then(console.log)
// getInfoByName(name).then(console.log)

getAssociatedCharacters(character_id).then(console.log)


// export
module.exports = {
  getAssociatedCharacters: getAssociatedCharacters
}