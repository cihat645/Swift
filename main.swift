//
//  main.swift
//  MyToolBox
//
//  Created by Thomas Ciha on 6/5/17.
//  Copyright © 2017 Thomas Ciha. All rights reserved.
//

import Foundation

//write a program to store your set of tools in a collection called ToolBox. Then create a few projects that require a list of tools to complete. Develop a way of testing whether or not you can complete these projects with the tools you currently have. Print all projects you have the tools to complete and if you only need one or two more tools to complete a project, suggest you buy the required tool(s) to complete it.

class ToolBox{
    var Box : [String] = []
}

class Project{
    var RequiredTools : [String] = []
    var time_to_complete = 0.0
    init(tools: [String], time: Double){
        self.time_to_complete = time
        self.RequiredTools = tools
    }
}

let myToolBox = ToolBox()
myToolBox.Box = ["Hammer", "Saw", "Level", "Sand Paper", "Nails", "Paint", "Shovel"]

let ConstructCabinet = Project(tools: ["Glue", "Paint", "Wood", "Nails"], time: 1)
let FixDoor = Project(tools: ["Hammer", "Nails"], time: 0.25)
let buildFirePit = Project(tools: ["Bricks", "Shovel"], time: 4.5)
let RedoDeck = Project(tools: ["Sand Paper", "Paint", "Drill", "Sander", "Building Permit"], time: 7.5)

func DetermineProject(toolbox: ToolBox, project: Project){
    let ToolSet = Set(toolbox.Box)
    let ProjectTools = Set(project.RequiredTools)
    if(ProjectTools.isSubset(of: ToolSet)){
        print("You have all the tools to complete this project, but get working because it'll take \(project.time_to_complete) hours!")
    } else {
        let missing_tools = FindTool(toolbox, project)
        missing_tools <= 2 ?  print("Go to the store, you only need \(missing_tools) more tool(s) to get the job done.")
        : print("You don't have the tools for the job")
    }
}

func FindTool(_ toolbox: ToolBox, _ project: Project) -> Int {
    var count = 0
    for tool in project.RequiredTools{
        var we_have_the_tool = false
        for my_tool in toolbox.Box {
            if(tool == my_tool){
                we_have_the_tool = true
            }
        }
        if(!we_have_the_tool){
            count += 1
        }
    }
    return count
}


print("Can I repair my deck?")
DetermineProject(toolbox: myToolBox, project: RedoDeck)

print("What about my door?")
DetermineProject(toolbox: myToolBox, project: FixDoor)

print("Do we have the supplies to build a firepit?")
DetermineProject(toolbox: myToolBox, project: buildFirePit)

print("I'm thinking about building a cabinet, do I have all the tools?")
DetermineProject(toolbox: myToolBox, project: ConstructCabinet)



