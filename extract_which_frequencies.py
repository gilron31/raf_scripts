import numpy as np
import scipy.io as spio
import os

print('hello world gil and his thesis')


path_to_real_recordings = "G:\\real_recordings"

def main():
	all_runs = os.listdir(path_to_real_recordings)
	run1_highs = all_runs[0]
	all_measurements_on_run1_highs = os.listdir(os.path.join(path_to_real_recordings, run1_highs))
	first_mes_path = os.path.join(path_to_real_recordings, run1_highs, all_measurements_on_run1_highs[0])
	print(first_mes_path)



if __name__ == '__main__':
	main()
