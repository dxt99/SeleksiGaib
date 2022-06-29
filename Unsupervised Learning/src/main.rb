require "./src/DBScan.rb"
require "csv"

def normalize(points)
    labels = points[0].length
    maxi = Array.new(labels, 0)
    mini = Array.new(labels, 1e9)
    # update max and mins
    for i in 0...points.length-1 do
        for j in 0...labels-1 do
            points[i][j] = points[i][j].to_f
            if points[i][j]>maxi[j]
                maxi[j] = points[i][j]
            end
            if points[i][j]<mini[j]
                mini[j] = points[i][j]
            end
        end
    end
    # normalize values
    for i in 0...points.length-1 do
        for j in 0...labels-1 do
            points[i][j] = points[i][j] - mini[j]
            points[i][j] = (points[i][j])/(maxi[j]-mini[j])
        end
    end
    return points
end

print "Masukkan nama file csv: "
file = gets[0...-1]
file = "./data/" + file
data = CSV.read(file)
data = normalize(data)
puts "Pilih metode: "
puts "1. DBScan"
puts "2. KMeans"
puts "3. KMedoids"
print ">> "
ch = gets[0...-1].to_i
if ch == 1
    print "Nilai eps: "
    eps = gets[0...-1].to_f
    print "Minimal points: "
    minPts = gets[0...-1].to_f
    DBScan(data, eps, minPts)
elsif ch == 2
    puts "KMeans"
elsif ch == 3
    puts "KMedoids"
else
    puts "Invalid command"
end