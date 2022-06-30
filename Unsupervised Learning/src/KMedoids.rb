def randomizeKMed(data, k)
    len = data.length
    indices = Array.new()
    k.times do
        n = rand(len)
        while indices.include? n
            n = rand(len)
        end
        indices.append(n)
    end
    return indices
end

def calcCost(data, medIdx)
    cost = 0
    for i in 0...data.length do
        if medIdx.include? i
            next
        end
        curCost = 1e9
        for j in 0...medIdx.length
            dist = 0
            for k in 0...data[i].length do
                dist += (data[i][k] - data[medIdx[j]][k]) ** 2
            end
            dist = dist ** (0.5)
            if dist<curCost
                curCost = dist
            end
        end
        cost += curCost
    end
    return cost
end

def assignPtsMed(data, medIdx)
    ret = Array.new(data.length, -1)
    for i in 0...data.length do
        minDist = 1e9
        clustIdx = -1
        for j in 0...medIdx.length do
            dist = 0
            for k in 0...data[i].length do
                dist += (data[i][k] - data[medIdx[j]][k]) ** 2
            end
            dist = dist ** (0.5)
            if dist<minDist
                minDist = dist
                clustIdx = j
            end
        end
        ret[i] = clustIdx
    end
    return ret
end

def KMedoids(data, k)
    medIdx = randomizeKMed(data, k)
    curCost = calcCost(data, medIdx)
    for i in 0...k do
        for j in 0...data.length do
            if medIdx.include? j
                next
            end
            temp = medIdx[i]
            medIdx[i] = j
            newCost = calcCost(data, medIdx)
            if newCost<curCost
                curCost = newCost
            else
                medIdx[i] = temp
            end
        end
    end
    clusters = assignPtsMed(data, medIdx)
    cnts = Array.new(k, 0)
    for i in 0...data.length do
        cnts[clusters[i]]+=1
    end
    puts "Banyak titik di masing-masing cluster: "
    for i in 0...k do
        puts "Cluster #{i+1}: #{cnts[i]}"
    end
end