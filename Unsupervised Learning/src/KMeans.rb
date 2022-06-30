def add(a, b)
    # adds two points
    return [a,b].transpose.map(&:sum)
end

def div(a, b)
    # divide point by constant b
    return a.collect{|n| n / b}
end

def randomizeK(data, k)
    len = data.length
    indices = Array.new()
    meanPts = Array.new()
    k.times do
        n = rand(len)
        while indices.include? n
            n = rand(len)
        end
        indices.append(n)
        meanPts.append(data[n])
    end
    return meanPts
end

def assignPts(data, meanPts)
    ret = Array.new(data.length, -1)
    for i in 0...data.length do
        minDist = 1e9
        clustIdx = -1
        for j in 0...meanPts.length do
            dist = 0
            for k in 0...data[i].length do
                dist += (data[i][k] - meanPts[j][k]) ** 2
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

def KMeans(data, k, maxItr)
    clutsers = Array.new()
    meanPts = randomizeK(data, k)
    change = true
    while maxItr>0 and change
        #assign clusters
        change = false
        maxItr-=1
        clusters = assignPts(data, meanPts)
        #update means
        sum = Array.new(k, Array.new(data[0].length, 0))
        cnt = Array.new(k, 0)
        for i in 0...data.length do
            sum[clusters[i]] = add(sum[clusters[i]], data[i])
            cnt[clusters[i]]+=1
        end
        for i in 0...k do
            newMean = div(sum[i],cnt[i])
            if newMean != meanPts[i]
                change = true
            end
            meanPts[i] = newMean
        end
    end
    cnts = Array.new(k, 0)
    for i in 0...data.length do
        cnts[clusters[i]]+=1
    end
    puts "Banyak titik di masing-masing cluster: "
    for i in 0...k do
        puts "Cluster #{i+1}: #{cnts[i]}"
    end
end