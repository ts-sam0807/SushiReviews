//
//  main.swift
//  SushiReviews
//
//  Created by Ts SaM on 9/8/2023.
//

import Foundation

let inputNM = readLine()!.split(separator: " ").map { Int($0)! }
let N = inputNM[0]
let M = inputNM[1]

let realSushiRestaurants = Set(readLine()!.split(separator: " ").map { Int($0)! })

var graph: [Int: [Int]] = [:]

for _ in 0..<N-1 {
    let edge = readLine()!.split(separator: " ").map { Int($0)! }
    let u = edge[0]
    let v = edge[1]

    if graph[u] == nil {
        graph[u] = []
    }
    graph[u]?.append(v)

    if graph[v] == nil {
        graph[v] = []
    }
    graph[v]?.append(u)
}

var visited: [Bool] = Array(repeating: false, count: N)
var leafNodes: [Int] = []


func findLeafNodes(_ node: Int) {
    visited[node] = true
    var isLeaf = true
    
    if let neighbors = graph[node] {
        for neighbor in neighbors {
            if !visited[neighbor] {
                isLeaf = false
                findLeafNodes(neighbor)
            }
        }
    }
    
    if isLeaf && !realSushiRestaurants.contains(node) {
        leafNodes.append(node)
    }
}

findLeafNodes(0)


var maxDist: [Int] = Array(repeating: 0, count: N)

func dfs(_ node: Int, _ parent: Int, _ depth: Int) {
    visited[node] = true
    maxDist[node] = depth
    
    if let neighbors = graph[node] {
        for neighbor in neighbors {
            if neighbor != parent {
                dfs(neighbor, node, depth + 1)
            }
        }
    }
}

for leafNode in leafNodes {
    visited = Array(repeating: false, count: N)
    dfs(leafNode, -1, 0)
}


var longestDiameter = 0
var startingNode = 0

for i in 0..<N {
    if maxDist[i] > longestDiameter {
        longestDiameter = maxDist[i]
        startingNode = i
    }
}


let remainingEdges = N - 1 - leafNodes.count
let answer = (remainingEdges * 2) - longestDiameter
print(answer)
