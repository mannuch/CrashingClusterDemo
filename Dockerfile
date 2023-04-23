# ================================
# Build image
# ================================
FROM swift:5.8-jammy as builder

# set up the workspace
RUN mkdir /workspace
WORKDIR /workspace

# copy the source to the docker image
COPY . /workspace

RUN swift build --sanitize=address -c release -Xswiftc -g --static-swift-stdlib

# ================================
# Run image
# ================================
FROM ubuntu:jammy

COPY --from=builder /workspace/.build/release/CrashingCluster /

# Let Docker bind to port 443
EXPOSE 443 7337

# set the entry point (application name)
ENTRYPOINT ["./CrashingCluster"]