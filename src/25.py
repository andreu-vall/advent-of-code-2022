import functools as ft
import sys

snafu_dic = {'0': 0, '1': 1, '2': 2, '-': -1, '=': -2}
rev_snafu_dic = {v: k for k, v in snafu_dic.items()}

def from_snafu(snafu: str) -> int:
    return ft.reduce(lambda x, y: 5*x + snafu_dic[y], snafu, 0)

def to_snafu(number: int) -> str:
    snafu = ''
    while number:
        mod = number % 5 - 5 * (number % 5 > 2)
        snafu = rev_snafu_dic[mod] + snafu
        number = (number - mod) // 5
    return snafu

print(to_snafu(sum(from_snafu(line.rstrip()) for line in sys.stdin)))
