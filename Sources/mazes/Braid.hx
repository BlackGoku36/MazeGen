package mazes;

import mazes.RecursiveBacktracker.Direction;

class Braid {

    public static function eliminateDeadEnds(grid:Array<Array<Int>>, w:Int, h:Int) {
        for (x in 2...w){ // Start from 2 so that it doesn't touch border
            for(y in 2...h){
                var neighbours = checkNeighbour(grid, w, h, x, y);
                if(neighbours.length == 1 && grid[x][y] == 0){
                    if(neighbours[0] == North) if(y > 3) grid[x][y+1] = 0;
                    if(neighbours[0] == South) if(y < h - 3) grid[x][y-1] = 0;
                    if(neighbours[0] == East)  if(x < w - 3) grid[x-1][y] = 0;
                    if(neighbours[0] == West)  if(x > 3) grid[x+1][y] = 0;
                }
            }
        }
        grid[1][0] = 0; // Door
        grid[w-3][h-2] = 0; // Door
    }
    
    static function checkNeighbour(grid:Array<Array<Int>>, w:Int, h:Int, x:Int, y:Int):Array<Direction> {
        var dir:Array<Direction> = [];
        if(y - 2 > 0 && grid[x][y - 1] == 0) dir.push(North);
        if(y + 2 < h - 1 && grid[x][y + 1] == 0) dir.push(South);
        if(x + 2 < w - 1 && grid[x + 1][y] == 0) dir.push(East);
        if(x - 2 > 0 && grid[x - 1][y] == 0) dir.push(West);
        return dir;
    }

}