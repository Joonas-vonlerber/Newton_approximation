using Combinatorics
include("Newt_approximation.jl")

function calc_distance(((root1, accuracy1, index1), (root2, accuracy2, index2)))
    more_accurate = accuracy1 > accuracy2
    more_accurate_root = more_accurate ? root2 : root1
    (more_accurate_index, less_accurate_index) = more_accurate ? (index2, index1) : (index1, index2)
    distance = @fastmath abs(root1 - root2)
    return (distance, more_accurate_root, more_accurate_index, less_accurate_index)
end
function Newt_roots(f::Function, search_area::Integer, iterat::Integer)
    rootlist = vec([Newt_aprx(f, iterat, Complex(i, j)) for i in -search_area:search_area, j in -search_area:search_area]) #luodaan pisteet
    filter!(e -> e[2] < 0.001, rootlist) #löydetään epätarkat ja NaN 
    # index_rootlist = map(x -> (x[2][1], x[2][2], x[1]), enumerate(rootlist)) # järjestys (juuri, tarkkuus, indeksi)
    # good_roots = filter(x -> x[1] <= 0.01, map(calc_distance, combinations(index_rootlist, 2))) # laske kaikki mahdolliset juurten etäisyydet ja filtteröi kaikki <=0.01
    # good_roots_bad_index = map(x -> x[4], good_roots) # vähemmän tarkkojen juurten indeksit
    # [filter!(x -> x[3] != c, good_roots) for c in good_roots_bad_index]
    # unique!(x -> x[3], good_roots)
    # return [x[2] for x in good_roots]
    i = 1
    while i < length(rootlist)
        j = i + 1
        while j < length(rootlist) + 1 #+1 varmistaa, että ei hypätä yli
            distance = @fastmath abs(rootlist[i][1] - rootlist[j][1]) #mittaa kahden pisteen etäisyyden
            if distance <= 0.01
                if rootlist[i][2] <= rootlist[j][2] #tarkempi luku jää
                    popat!(rootlist, j)
                    j -= 1 #ei hypätä asioiden yli
                else
                    popat!(rootlist, i)
                    j = i
                end
            end
            j += 1
        end
        i += 1
    end
    return [x[1] for x in rootlist] #palautetaan vain juuret ja ei tarkkuuksia
end