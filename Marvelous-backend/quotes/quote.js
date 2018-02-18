// Quote object definition

class Quote {
  constructor(quote, character='', image='') {
    this._quote = quote;
    this._character = character;
    this._image = image;
  }

  objectRep() {
    return {
      quote: this._quote,
      character: this._character,
      image: this._image
    }
  }

  jsonString() {
    return JSON.stringify(this.objectRep())
  }
}



