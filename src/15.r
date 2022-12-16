
# the name r sucks, can't even properly search in the internet
# q() to exit R.exe...

big_number <- 500

rectangles_n <- 0 # This is a right expanding list
rectangles_start <- matrix(nrow=2, ncol=big_number)
rectangles_dimen <- matrix(nrow=2, ncol=big_number)

rectangles_n2 <- 0 # This is a stack
rectangles_start2 <- matrix(nrow=2, ncol=big_number)
rectangles_dimen2 <- matrix(nrow=2, ncol=big_number)

fake_beacons_n <- 0
fake_beacons <- matrix(nrow=2, ncol=big_number)

manhattan_dist <- function(first, second) {
    return(sum(abs(first - second)))
}

rotate_45_right <- function(vector) {
    return(c(vector[1]-vector[2], vector[1]+vector[2])) # Arrays start at 1!
}
rotate_45_left <- function(vector) {
    return(c((vector[1]+vector[2])/2, (vector[2]-vector[1])/2))
}

# Why TF does readLine don't work on Rscript
lines <- readLines("stdin")
for (line in lines) {
    #print(line)
    string_arr <- unlist(strsplit(substr(line, nchar("Sensor at x=") + 1,
            nchar(line)), ": closest beacon is at x="))
    sensor <- as.integer(unlist(strsplit(string_arr[1], ", y=")))
    beacon <- as.integer(unlist(strsplit(string_arr[2], ", y=")))

    rot_beacon = rotate_45_right(beacon)
    beacon_seen <- FALSE
    if (fake_beacons_n > 0) { # I cannot express how much I hate having to do this
        for (i in 1:fake_beacons_n) {
            if (all(rot_beacon==fake_beacons[, i])) {
                beacon_seen <- TRUE
                break
            }
        }
    }
    if (! beacon_seen) {
        fake_beacons_n <- fake_beacons_n + 1
        fake_beacons[, fake_beacons_n] <- rot_beacon
    }

    dist <- manhattan_dist(sensor, beacon)
    start_diag <- sensor - c(dist, 0)
    start <- rotate_45_right(start_diag)
    dimen <- c(2*dist + 1, 2*dist + 1)

    rectangles_n2 <- 1
    rectangles_start2[, rectangles_n2] <- start
    rectangles_dimen2[, rectangles_n2] <- dimen

    while (rectangles_n2 >= 1) {
        start <- rectangles_start2[, rectangles_n2]
        dimen <- rectangles_dimen2[, rectangles_n2]
        rectangles_n2 <- rectangles_n2 - 1

        i <- 1
        has_collision <- FALSE
        while (i <= rectangles_n) {
            other_start <- rectangles_start[, i]
            other_dimen <- rectangles_dimen[, i]
            if (all(start+dimen > other_start) && all(other_start+other_dimen > start)) {
                has_collision <- TRUE
                if (all(start >= other_start) && all(start+dimen <= other_start+other_dimen)) {
                    break
                }
                if (start[1] < other_start[1]) {
                    left_dimen <- c(other_start[1] - start[1], dimen[2])
                    rectangles_n2 <- rectangles_n2 + 1
                    rectangles_start2[, rectangles_n2] <- start
                    rectangles_dimen2[, rectangles_n2] <- left_dimen
                    rectangles_n2 <- rectangles_n2 + 1
                    rectangles_start2[, rectangles_n2] <- start + c(left_dimen[1], 0)
                    rectangles_dimen2[, rectangles_n2] <- dimen - c(left_dimen[1], 0)
                }
                else if (start[1]+dimen[1] > other_start[1]+other_dimen[1]) {
                    left_dimen <- c(dimen[1] - (start[1]+dimen[1] - (other_start[1]+other_dimen[1])), dimen[2])
                    rectangles_n2 <- rectangles_n2 + 1
                    rectangles_start2[, rectangles_n2] <- start
                    rectangles_dimen2[, rectangles_n2] <- left_dimen
                    rectangles_n2 <- rectangles_n2 + 1
                    rectangles_start2[, rectangles_n2] <- start + c(left_dimen[1], 0)
                    rectangles_dimen2[, rectangles_n2] <- dimen - c(left_dimen[1], 0)
                }
                else if (start[2] < other_start[2]) {
                    up_dimen <- c(dimen[1], other_start[2] - start[2])
                    rectangles_n2 <- rectangles_n2 + 1
                    rectangles_start2[, rectangles_n2] <- start
                    rectangles_dimen2[, rectangles_n2] <- up_dimen
                    rectangles_n2 <- rectangles_n2 + 1
                    rectangles_start2[, rectangles_n2] <- start + c(0, up_dimen[2])
                    rectangles_dimen2[, rectangles_n2] <- dimen - c(0, up_dimen[2])
                }
                else if (start[2]+dimen[2] > other_start[2]+other_dimen[2]) {
                    up_dimen <- c(dimen[1], dimen[2] - (start[2]+dimen[2] - (other_start[2]+other_dimen[2])))
                    rectangles_n2 <- rectangles_n2 + 1
                    rectangles_start2[, rectangles_n2] <- start
                    rectangles_dimen2[, rectangles_n2] <- up_dimen
                    rectangles_n2 <- rectangles_n2 + 1
                    rectangles_start2[, rectangles_n2] <- start + c(0, up_dimen[2])
                    rectangles_dimen2[, rectangles_n2] <- dimen - c(0, up_dimen[2])
                }
                else {
                    endifnot(FALSE)
                }
                break
            }
            i <- i + 1
        }
        if (!has_collision) {
            rectangles_n <- rectangles_n + 1
            rectangles_start[, rectangles_n] <- start
            rectangles_dimen[, rectangles_n] <- dimen
        }
    }
}

real_dimens <- rectangles_dimen[, 1:rectangles_n]
cat("Areas sum: ", sum(apply(real_dimens, 2, prod))) # Sum of areas

diagonal = c(0, 2000000)
trans = rotate_45_right(diagonal)
print(trans)

diag1 <- function(vector) {
    return(vector[1] - vector[2])
}

diag2 <- function(vector) {
    return(vector[1] + vector[2])
}

start_time <- Sys.time()
answer <- 0
for (i in 1:rectangles_n) {
    start <- rectangles_start[, i]
    dimen <- rectangles_dimen[, i] - 1
    if (diag1(start + c(0, dimen[2])) <= diag1(trans) && diag1(trans) <= diag1(start + c(dimen[1], 0))) {
        u_up <- diag1(trans) + start[2]
        if (u_up >= start[1]) {
            enter <- c(u_up, start[2])
        }
        v_left <- start[1] - diag1(trans)
        if (v_left >= start[2]) {
            enter <- c(start[1], v_left)
        }
        u_down <- diag1(trans) + start[2] + dimen[2]
        if (u_down <= start[1] + dimen[1]) {
            leave <- c(u_down, start[2] + dimen[2])
        }
        v_right <- start[1] + dimen[1] - diag1(trans)
        if (v_right <= start[2] + dimen[2]) {
            leave <- c(start[1] + dimen[1], v_right)
        }
        for (i in 1:fake_beacons_n) {
            beacon = fake_beacons[, i]
            if (diag1(beacon) == diag1(trans) && beacon[1] >= enter[1] && beacon[1] <= leave[1]) {
                answer <- answer - 1
            }
        }
        answer <- answer + leave[1] - enter[1] + 1
    }
}

end_time <- Sys.time()
cat("Time1: ", end_time - start_time)

print(answer)

point_in_rectangle <- function(point, start, dimen) {
    return(all(point >= start) && all(point <= start+dimen-1))
}

start_time <- Sys.time()
for (i in 1:rectangles_n) {
    start <- rectangles_start[, i]
    dimen <- rectangles_dimen[, i] - 1

    possible1 <- start - c(1, 0)
    real1 <- rotate_45_left(possible1)
    if (all(real1 >= 0) && all(real1 <= 4000000)) {
        outside <- TRUE
        for (j in 1:rectangles_n) {
            if (point_in_rectangle(possible1, rectangles_start[, j], rectangles_dimen[, j])) {
                outside <- FALSE
                break
            }
        }
        if (outside) {
            cat(real1[1]*4000000 + real1[2])
            break
        }
    }

    
    possible2 <- start + dimen + c(0, 1)
    real2 <- rotate_45_left(possible2)
    if (all(real2 >= 0) && all(real2 <= 4000000)) {
        outside <- TRUE
        for (j in 1:rectangles_n) {
            if (point_in_rectangle(possible2, rectangles_start[, j], rectangles_dimen[, j])) {
                outside <- FALSE
                break
            }
        }
        if (outside) {
            print(real2[1]*4000000 + real2[2], digits=16)
            break
        }
    }
}

end_time <- Sys.time()
cat("Time1: ", end_time - start_time)
