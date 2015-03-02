import subscriber = require('./subscriber');
import d = require('./defs')

import Field = require('./field');

class MainContext extends Arda.Context<d.Props, d.State, d.ComponentProps> {
  static component = require('../../components/main');
  static subscribers = [
    subscriber
  ];

  public initState(props){
    return {field: new Field()};
  }

  public expandComponentProps(props, state): d.ComponentProps{
    return {
      tiles: state.field.tiles,
      selectedTile: state.selectedTile
    };
  }
}

export = MainContext;
