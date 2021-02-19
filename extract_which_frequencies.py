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
path_to_tempdir = "G:\\random_sampling_biglogs"
LOGSXMAGS = "logSXMAGS"


# %xconfig IPCompleter.use_jedi = False.
def get_f_129_and_G2_from_biglog_path(path_to_biglog):
	logsxmags = loadmat(path_to_biglog)[BIGLOG][LOGSXMAGS]
	return logsxmags['f_0'], logsxmags['G2estim']

def get_f_129_estim_from_biglog(path_to_biglog_dict):
	return loadmat(path_to_biglog_dict)[BIGLOG][LOGXFID][F129]

def get_f_129_estim_and_copy_biglog(path_to_biglog_dict):
    print(path_to_biglog_dict)
    f = ( loadmat(path_to_biglog_dict)[BIGLOG][LOGXFID][F129])
    print(f)
    os.popen("copy " + path_to_biglog_dict + " " + path_to_tempdir + "\\biglog_" + str(f) + ".mat")


def get_sensitivities_from_ress(resx, resy, driveamp, diode = 0):
	if diode == 0:
		x_ind = 1
		y_ind = 0
	if diode == 1:
		x_ind = 5
		y_ind = 4

	if isinstance(resx[0], list):
		if len(resx) == 5:
			offres_x_responses = [resx[i, x_ind] for i in [0,1,3,4]]
			offres_y_responses = [resy[i, y_ind] for i in [0,1,3,4]]
			Y_res_x = np.abs(resx[2,x_ind])/driveamp
			Y_res_y = np.abs(resy[2,y_ind])/driveamp
		if len(resx) == 3:
			offres_x_responses = [resx[i, x_ind] for i in [0,2]]
			offres_y_responses = [resy[i, y_ind] for i in [0,2]]
			Y_res_x = np.abs(resx[1,x_ind])/driveamp
			Y_res_y = np.abs(resy[1,y_ind])/driveamp
	else:
		offres_x_responses = [resx[i] for i in [0,1,3,4]]
		offres_y_responses = [resy[i] for i in [0,1,3,4]]
		Y_res_x = np.abs(resx[2])/driveamp
		Y_res_y = np.abs(resy[2])/driveamp
		
		

	Y_alk_x = np.mean(np.abs(offres_x_responses))/driveamp
	Y_alk_y = np.mean(np.abs(offres_y_responses))/driveamp
	
	#E_naive_x = (Y_res_x - Y_alk_x) / Y_alk_x
	#E_naive_y = (Y_res_y - Y_alk_y) / Y_alk_y

	#print("E_naive_x :" + str(E_naive_x))
	#print("E_naive_y :" + str(E_naive_y))

	a = Y_alk_x ** 2 + Y_alk_y ** 2 
	alpha = (Y_res_x ** 2 + Y_res_y ** 2) / a

	#E_lb_x = Y_res_x / np.sqrt(a) - 1
	#E_lb_y = Y_res_y / np.sqrt(a) - 1


	E_ver3p =  np.sqrt( - 0.5 * (1 - alpha)) 
	#print("E_ver3p: " + str(E_ver3p))

	Xe_amp = E_ver3p * np.sqrt(a)
	#print("Xe_amp " + str(Xe_amp))
	return Y_alk_x, Y_alk_y, E_ver3p 

def get_sensitivities_from_biglog_obj(biglog, diode = 0):
	resx, resy, driveamp = get_ress_from_biglog_obj(biglog)
	return get_sensitivities_from_ress(resx, resy, driveamp, diode)

def get_ress_from_biglog_obj(biglog):
	logSXMAGS = biglog["bigLog"]["logSXMAGS"]
	resx = logSXMAGS["res_forx"]
	resy = logSXMAGS["res_fory"]
	driveamp = logSXMAGS["driveamp_G"]	
	return resx, resy, driveamp

def get_sensitivities_from_biglog_path(biglog_path, diode = 0):
	return get_sensitivities_from_biglog_obj(loadmat(biglog_path), diode)

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
			res.append(what_func(path_to_biglog))	
		except Exception as e:
			print(e)

	return res


if __name__ == '__main__':
	print('hello world gil and his thesis')






