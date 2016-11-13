# Argon2

A simple Docker repository to compile and make available the [Argon2](https://github.com/P-H-C/phc-winner-argon2) hashing algorithm. It is built from the [Alpine Linux](https://hub.docker.com/_/alpine/) Docker base image to minimize the size.

## Docker Configuration

The `latest` image builds the [20161029](https://github.com/P-H-C/phc-winner-argon2/releases/tag/20161029) release of the P-H-C Winner Argon2 reference C implementation.

## Usage

To get up and running, simply pull the image from Docker Hub:

```
$ docker pull abstractvector/argon2
```

By default, running the container will launch you into an `sh` shell, from which you can call `argon2` or `bench`.

```
$ docker run -it --rm abstractvector/argon2
```

The container is just a wrapper for the Argon2 reference C implementation, so look at the help for more information. For instance, after running the container as above, you can see the usage of `argon2`:

```
# argon2 -h
Usage:  argon2 [-h] salt [-i|-d|-id] [-t iterations] [-m memory] [-p parallelism] [-l hash length] [-e|-r]
        Password is read from stdin
Parameters:
        salt            The salt to use, at least 8 characters
        -i              Use Argon2i (this is the default)
        -d              Use Argon2d instead of Argon2i
        -id             Use Argon2id instead of Argon2i
        -t N            Sets the number of iterations to N (default = 3)
        -m N            Sets the memory usage of 2^N KiB (default 12)
        -p N            Sets parallelism to N threads (default 1)
        -l N            Sets hash output length to N bytes (default 32)
        -e              Output only encoded hash
        -r              Output only the raw bytes of the hash
        -h              Print argon2 usage
```

You can generate a hash by:

```
# echo -n "my_password" | argon2 some_salt
Type:           Argon2i
Iterations:     3
Memory:         4096 KiB
Parallelism:    1
Hash:           d5368947e4fbe50fbd1a146bb94542f115171ef187813fa15fb0a793c95b887c
Encoded:        $argon2i$v=19$m=4096,t=3,p=1$c29tZV9zYWx0$1TaJR+T75Q+9GhRruUVC8RUXHvGHgT+hX7Cnk8lbiHw
0.002 seconds
Verification ok
```

Obviously the salt should be random and you'll want to specify some additional parameters. For example, to hash "password" with using a random salt and doing 10 iterations, consuming 64MB, using four parallel threads and an output hash of 32 bytes, you would execute:

```
# echo -n "password" | argon2 `head -c 32 /dev/urandom | base64` -t 10 -m 16 -p 4 -l 32
Type:           Argon2i
Iterations:     10
Memory:         65536 KiB
Parallelism:    4
Hash:           9dcadd305d341e192047dc68524f9cd67fc4ccbcca7fff7535969374dca220da
Encoded:        $argon2i$v=19$m=65536,t=10,p=4$eTllUmlGcVY5WXhmT00wbHJQd2JYVXF1UlpBQkwyU1Z0aWk5M2JVTGQyND0$ncrdMF00HhkgR9xoUk+c1n/EzLzKf/91NZaTdNyiINo
0.230 seconds
Verification ok
```

## Benchmarking

The Argon2 reference library also has a built-in benchmark suite. You can access this by running the `bench` command from within the container:

```
# bench
```

Or by passing it into `docker run` and overriding the command:

```
$ docker run -it --rm abstractvector/argon2 bench
```

The benchmark suite measures the execution time of different Argon2 configurations.