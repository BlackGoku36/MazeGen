let project = new Project('Maze');
project.addAssets('Assets/**');
project.addShaders('Shaders/**');
project.addSources('Sources');
resolve(project);
