# ================================
# Build image
# ================================
FROM swift:5.8-jammy as builder

RUN mkdir /workspace
WORKDIR /workspace

COPY . /workspace

RUN swift build --sanitize=address -c release -Xswiftc -g --static-swift-stdlib

# ================================
# Run image
# ================================
FROM ubuntu:jammy

COPY --from=builder /workspace/.build/release/CrashingCluster /

EXPOSE 7337

ENTRYPOINT ["./CrashingCluster"]