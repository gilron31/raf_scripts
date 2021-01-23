import numpy as np
import scipy.io as spio
import os


def _check_keys( dict):
"""
checks if entries in dictionary are mat-objects. If yes
todict is called to change them to nested dictionaries
"""
	for key in dict:
		if isinstance(dict[key], sio.matlab.mio5_params.mat_struct):
			dict[key] = _todict(dict[key])
	return dict


def _todict(matobj):
    """
    A recursive function which constructs from matobjects nested dictionaries
    """
	dict = {}
	for strg in matobj._fieldnames:
		elem = matobj.__dict__[strg]
		if isinstance(elem, sio.matlab.mio5_params.mat_struct):
			dict[strg] = _todict(elem)
		else:
			dict[strg] = elem
	return dict


def loadmat(filename):
    """
    this function should be called instead of direct scipy.io .loadmat
    as it cures the problem of not properly recovering python dictionaries
    from mat files. It calls the function check keys to cure all entries
    which are still mat-objects
    """
	data = sio.loadmat(filename, struct_as_record=False, squeeze_me=True)
	return _check_keys(data)


path_to_real_recordings = "G:\\real_recordings"

def main():
	all_runs = os.listdir(path_to_real_recordings)
	run1_highs = all_runs[0]
	all_measurements_on_run1_highs = os.listdir(os.path.join(path_to_real_recordings, run1_highs))
	first_mes_path = os.path.join(path_to_real_recordings, run1_highs, all_measurements_on_run1_highs[0])
	print(first_mes_path)
	wps_before = os.listdir(os.path.join(first_mes_path, "WPS_before_and_after"))[0]
	path_wps_before = os.path.join(first_mes_path, "WPS_before_and_after", wps_before)
	
	print(loadmat(os.path.join(path_wps_before, "bigLog.mat")))
	 



if __name__ == '__main__':
	print('hello world gil and his thesis')
	main()
















