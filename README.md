# bitcoingod-docker
Dockerfile for bitcoingod


# Building

```bash
docker build -t bitcoingod .
```

# Running

Customize config file `coin.conf` first.

```bash
# block dir
mkdir data
docker run --rm -itd --name igod -p 18886:18886 -v `pwd`/data:/opt/coin/data -v `pwd`/coin.conf:/opt/coin/coin.conf bitcoingod
```

# Using pre-built docker image

```bash
docker run --rm -itd --name igod -p 18886:18886 -v `pwd`/data:/opt/coin/data -v `pwd`/coin.conf:/opt/coin/coin.conf mixhq/bitcoingod:latest
```
