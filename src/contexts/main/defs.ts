export interface Props {
}

import Field = require('./field');

export interface Tile {
  x: number;
  y: number;
  val: number;
  visible: boolean;
  discoveryRate: number;
}

export interface State {
  field: Field;
}

export interface ComponentProps {
  tiles: Tile[];
}
