package mazes;

enum Direction {
    North;
    South;
    East;
    West;
}

class RecursiveBacktracker {
    
    public var grid:Array<Array<Int>> = [[]];
    var h:Int;
    var w:Int;
    var visitedX:Array<Int> = [];
    var visitedY:Array<Int> = [];
    var posX = 1;
    var posY = 1;
    // 1 = Wall, 0 = Path
    public function new(width:Int, height:Int) {
        this.w = width;
        this.h = height;
        for (x in 0...w-1){
            grid.push([]);
            for(y in 0...h-1){
                grid[x].push(1);
            }
        }
        grid[posX][posY] = 0;
        visitedX.push(posX);
        visitedY.push(posY);
        generateMaze();
    }

    function generateMaze() {
        var done = false;
        while (!done){
            if(visitedX.length == 0 && visitedY.length == 0) done = true;
            var dir = checkNeighbour(posX, posY);
            if(dir.length > 0){
                var neighbour = dir[Std.random(dir.length)];
                switch (neighbour){
                    case North:
                        grid[posX][posY-2] = 0;
                        grid[posX][posY-1] = 0;
                        posY -= 2;
                    case South:
                        grid[posX][posY+2] = 0;
                        grid[posX][posY+1] = 0;
                        posY += 2;
                    case East:
                        grid[posX+2][posY] = 0;
                        grid[posX+1][posY] = 0;
                        posX += 2;
                    case West:
                        grid[posX-2][posY] = 0;
                        grid[posX-1][posY] = 0;
                        posX -= 2;
                }
                visitedX.push(posX);
                visitedY.push(posY);
            }
            else {
                posX = visitedX.pop();
                posY = visitedY.pop();
            }
        }
    }

    function checkNeighbour(x:Int, y:Int){
        var dir:Array<Direction> = [];
        if(y - 2 > 0 && grid[x][y - 2] == 1) dir.push(North);
        if(y + 2 < h - 1 && grid[x][y + 2] == 1) dir.push(South);
        if(x + 2 < w - 1 && grid[x + 2][y] == 1) dir.push(East);
        if(x - 2 > 0 && grid[x - 2][y] == 1) dir.push(West);
        return dir;
    }
}