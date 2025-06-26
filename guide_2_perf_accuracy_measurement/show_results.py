import json
from pathlib import Path
import os

path = "./results"
for result in sorted(os.listdir(path)):

    print(result)
    rpt_file = Path(path+"/"+result)

    fields = ['median_ttft_ms', 'median_tpot_ms', 'median_itl_ms', 'median_e2el_ms', 'total_token_throughput']
    print(f', '.join(f'{f:>30}' for f in fields))
    with open(rpt_file) as f:
        results = json.load(f)
    print(f', '.join(f'{results[f]:>30.2f}' for f in fields))
