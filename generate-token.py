"""
Usage example:

$ python3 generate-token.py {issuer id} {key id} {private key path} [{expire_minutes}]
"""
# author: 2021-12-08 shawn.becker@angel.com

import sys
import datetime
import jwt


def generate(issuer_id, key_id, private_key_path, expire_mins):
    with open(private_key_path) as f:
        key = f.read()

    token_data = jwt.encode(
        {
            'iss': issuer_id,
            'aud': 'appstoreconnect-v1',
            'exp': datetime.datetime.utcnow() + datetime.timedelta(minutes=expire_mins)
        },
        key,
        algorithm='ES256',
        headers={
            'kid': key_id
        }
    )
    # print( str(expire_mins) + " minute token")
    print(token_data)


if __name__ == "__main__":
    if len(sys.argv) < 4:
        print("usage: generate-token.py {issuer id} {key id} {private key path} [expire_min]", file=sys.stderr)
        exit(-1)

    min_exp_mins = 5
    max_exp_mins = 20
    expire_minutes = max(min_exp_mins, min(int(sys.argv[4]), max_exp_mins)) if len(sys.argv) > 4 else min_exp_mins
    generate(sys.argv[1], sys.argv[2], sys.argv[3], expire_minutes)
