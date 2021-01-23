import numpy as np
import scipy.io as spio
import os


def _check_keys( dict):
	for key in dict:
		if isinstance(dict[key], spio.matlab.mio5_params.mat_struct):
			dict[key] = _todict(dict[key])
	return dict


def _todict(matobj):
	dict = {}
	for strg in matobj._fieldnames:
		elem = matobj.__dict__[strg]
		if isinstance(elem, spio.matlab.mio5_params.mat_struct):
			dict[strg] = _todict(elem)
		else:
			dict[strg] = elem
	return dict


def loadmat(filename):
	data = spio.loadmat(filename, struct_as_record=False, squeeze_me=True)
	return _check_keys(data)


path_to_real_recordings = "G:\\real_recordings"
BIGLOG = 'bigLog'
BIGLOGMAT = 'bigLog.mat'
LOGXFID = 'logXFID'
F129 = 'f_129_estim'

def get_f_129_estim_from_biglog(biglog_dict):
	return biglog_dict[BIGLOG][LOGXFID][F129]

def get_all_data_from_run(run_path, what_func, before_after = 0):
	dirs_in_run = os.listdir(run_path)
	res = []
	counter = 1
	for dir_in_run in dirs_in_run:
		try:
			print("dealing with run: " + str(counter))
			counter += 1
			wps = os.listdir(os.path.join(run_path, dir_in_run,"WPS_before_and_after"))[before_after]
			path_to_biglog = os.path.join(run_path, dir_in_run,"WPS_before_and_after", wps, BIGLOGMAT)
			res.append(what_func(loadmat(path_to_biglog)))	
		except Exception as e:
			print(e)

	return res

def main():
	all_runs = os.listdir(path_to_real_recordings)
	run1_highs = all_runs[0]
	all_measurements_on_run1_highs = os.listdir(os.path.join(path_to_real_recordings, run1_highs))
	first_mes_path = os.path.join(path_to_real_recordings, run1_highs, all_measurements_on_run1_highs[0])
	print(first_mes_path)
	wps_before = os.listdir(os.path.join(first_mes_path, "WPS_before_and_after"))[0]
	path_wps_before = os.path.join(first_mes_path, "WPS_before_and_after", wps_before)
	
	print(loadmat(os.path.join(path_wps_before, "bigLog.mat")))
	return os.path.join(path_wps_before, "bigLog.mat")




if __name__ == '__main__':
	print('hello world gil and his thesis')
	main()
















