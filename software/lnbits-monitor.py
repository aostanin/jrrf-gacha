#!/usr/bin/env python3

import asyncio
import json
import os
import subprocess
import sys
import websockets

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))


async def monitor(base_url: str, api_key: str, min_sats: int, ln_address: str):
    ws_url = f"{base_url}/api/v1/ws/{api_key}"
    print(f"Connecting to {ws_url}")
    print(f"Filtering: ln_address={ln_address}, min_sats={min_sats}")

    while True:
        try:
            async with websockets.connect(ws_url) as ws:
                print("Connected, waiting for payments...")
                async for message in ws:
                    data = json.loads(message)
                    payment = data.get("payment", {})
                    extra = payment.get("extra", {})
                    amount_sats = payment.get("amount", 0) // 1000

                    addr = extra.get("lnaddress", "")
                    memo = payment.get("memo", "")
                    print(f"Payment received: {memo} - {amount_sats} sats (address: {addr})")

                    if ln_address and addr != ln_address:
                        print(f"  Skipped: address mismatch (want {ln_address})")
                        continue
                    if amount_sats < min_sats:
                        print(f"  Skipped: {amount_sats} sats < {min_sats} min")
                        continue

                    print("  Running motor...")
                    try:
                        subprocess.run([sys.executable, os.path.join(SCRIPT_DIR, "motor.py")], check=True)
                        print("  Motor run complete")
                    except subprocess.CalledProcessError as e:
                        print(f"  Motor script failed: {e}", file=sys.stderr)
        except websockets.ConnectionClosed:
            print("Connection closed, reconnecting in 5s...")
            await asyncio.sleep(5)
        except Exception as e:
            print(f"Error: {e}, reconnecting in 5s...", file=sys.stderr)
            await asyncio.sleep(5)


def main():
    base_url = os.environ.get("LNBITS_URL", "").rstrip("/")
    api_key = os.environ.get("LNBITS_API_KEY", "")
    min_sats = int(os.environ.get("LNBITS_MIN_SATS", "0"))
    ln_address = os.environ.get("LNBITS_LN_ADDRESS", "")

    if not base_url or not api_key:
        print("Set LNBITS_URL and LNBITS_API_KEY environment variables", file=sys.stderr)
        sys.exit(1)

    base_url = base_url.replace("https://", "wss://").replace("http://", "ws://")
    asyncio.run(monitor(base_url, api_key, min_sats, ln_address))


if __name__ == "__main__":
    main()
