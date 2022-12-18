
# the name r sucks, can't even properly search in the internet
# q() to exit R.exe...

big_number <- 500

rect_n <- 0 # This is a right expanding list of rectangles
rect_start <- matrix(nrow=2, ncol=big_number)
rect_dimen <- matrix(nrow=2, ncol=big_number)

rect_n2 <- 0 # This is a stack
rect_start2 <- matrix(nrow=2, ncol=big_number)
rect_dimen2 <- matrix(nrow=2, ncol=big_number)

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
    if (!beacon_seen) {
        fake_beacons_n <- fake_beacons_n + 1
        fake_beacons[, fake_beacons_n] <- rot_beacon
    }
    dist <- manhattan_dist(sensor, beacon)
    start_diag <- sensor - c(dist, 0)
    start <- rotate_45_right(start_diag)
    dimen <- c(2*dist + 1, 2*dist + 1)

    rect_n2 <- 1
    rect_start2[, rect_n2] <- start
    rect_dimen2[, rect_n2] <- dimen

    while (rect_n2 >= 1) {
        start <- rect_start2[, rect_n2]
        dimen <- rect_dimen2[, rect_n2]
        rect_n2 <- rect_n2 - 1

        i <- 1
        has_collision <- FALSE
        while (i <= rect_n) {
            other_start <- rect_start[, i]
            other_dimen <- rect_dimen[, i]
            if (all(start+dimen > other_start) && all(other_start+other_dimen > start)) {
                has_collision <- TRUE
                if (all(start >= other_start) && all(start+dimen <= other_start+other_dimen)) {
                    break
                }
                if (start[1] < other_start[1]) {
                    first_dimen <- c(other_start[1] - start[1], dimen[2])
                    other_position <- c(first_dimen[1], 0)
                }
                else if (start[1]+dimen[1] > other_start[1]+other_dimen[1]) {
                    first_dimen <- c(dimen[1] - (start[1]+dimen[1] - (other_start[1]+other_dimen[1])), dimen[2])
                    other_position <- c(first_dimen[1], 0)
                }
                else if (start[2] < other_start[2]) {
                    first_dimen <- c(dimen[1], other_start[2] - start[2])
                    other_position <- c(0, first_dimen[2])
                }
                else if (start[2]+dimen[2] > other_start[2]+other_dimen[2]) {
                    first_dimen <- c(dimen[1], dimen[2] - (start[2]+dimen[2] - (other_start[2]+other_dimen[2])))
                    other_position <- c(0, first_dimen[2])
                }
                else {
                    endifnot(FALSE)
                }
                rect_n2 <- rect_n2 + 1
                rect_start2[, rect_n2] <- start
                rect_dimen2[, rect_n2] <- first_dimen
                rect_n2 <- rect_n2 + 1
                rect_start2[, rect_n2] <- start + other_position
                rect_dimen2[, rect_n2] <- dimen - other_position
                break
            }
            i <- i + 1
        }
        if (!has_collision) {
            rect_n <- rect_n + 1
            rect_start[, rect_n] <- start
            rect_dimen[, rect_n] <- dimen
        }
    }
}
real_dimens <- rect_dimen[, 1:rect_n]
cat("Extra: areas sum: ", sum(apply(real_dimens, 2, prod)), "\n") # Sum of areas

diagonal = c(0, 2000000)
trans = rotate_45_right(diagonal)

diag1 <- function(vector) {
    return(vector[1] - vector[2])
}

diag2 <- function(vector) {
    return(vector[1] + vector[2])
}

start_time <- Sys.time()
answer <- 0
for (i in 1:rect_n) {
    start <- rect_start[, i]
    dimen <- rect_dimen[, i] - 1
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
cat("Part 1: ", answer, "\n")
cat("Time1: ", end_time - start_time, "\n")

point_in_rectangle <- function(point, start, dimen) {
    return(all(point >= start) && all(point <= start+dimen-1))
}

start_time <- Sys.time()
for (i in 1:rect_n) {
    start <- rect_start[, i]
    dimen <- rect_dimen[, i] - 1

    possibles <- matrix(c(start - c(1, 0), start + dimen + c(0, 1)), nrow=2)

    for (possible_n in 1:2) {
        possible <- possibles[, possible_n]
        real <- rotate_45_left(possible)
        if (all(real >= 0) && all(real <= 4000000)) {
            outside <- TRUE
            for (j in 1:rect_n) {
                if (point_in_rectangle(possible, rect_start[, j], rect_dimen[, j])) {
                    outside <- FALSE
                    break
                }
            }
            if (outside) {
                cat("Part 2: ")
                print(real[1]*4000000 + real[2], digits=16)
                break
            }
        }
    }
}
end_time <- Sys.time()
cat("Time2: ", end_time - start_time, "\n")
