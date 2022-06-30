def getNeighbours(points, idx, eps)
    # returns indices of points that are < eps
    # uses euclidian dist
    indices = Array.new()
    for i in 0...points.length do
        if i==idx
            next
        end
        dist = 0
        for j in 0...points[0].length do
            dist += (points[i][j]-points[idx][j]) ** 2
        end
        if dist <= eps**2
            indices.append(i)
        end
    end
    return indices
end

def DBScan(points, eps, minPts)
    n = points.length
    label = Array.new(n, 0) #0 is undef, -1 is noise
    noiseCount = 0
    curCluster = 0
    for i in 0...n do
        if label[i] != 0
            next
        end
        adj = getNeighbours(points, i, eps)
        if adj.length+1 < minPts
            label[i] = -1
            noiseCount += 1
            next
        end
        curCluster +=1
        label[i] = curCluster
        for idx in adj do
            if label[idx]==-1
                label[idx]=curCluster
                noiseCount-=1
            end
            if label[idx]!=0 
                next
            end
            label[idx] = curCluster
            curAdj = getNeighbours(points, idx, eps)
            if curAdj.length+1 < minPts
                next
            end
            for newIdx in curAdj do
                if adj.include? newIdx
                    next
                end
                adj.append(newIdx)
            end
        end
    end
    # count points in each cluster
    cnts = Array.new(curCluster+1, 0)
    for i in 0...label.length do
        if label[i]!=-1
            cnts[label[i]]+=1
        end
    end
    puts "Banyak cluster: #{curCluster}"
    puts "Banyak noise: #{noiseCount}"
    puts "Banyak titik di masing-masing cluster: "
    for i in 0...curCluster do
        puts "Cluster #{i+1}: #{cnts[i+1]}"
    end
end