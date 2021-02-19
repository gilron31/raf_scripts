import extract_which_frequecies as e
import numpy as np


def get_biglogs_from_run(p1):
	list_of_biglogs = []
	for p in p1:
		ptemp1 = os.listdir(os.join(p1, p, 'WPS_before_and_after'))[0]
		ptemp2 = os.join(p1, p, 'WPS_before_and_after', ptemp1, 'bigLog.mat')
		list_of_biglogs.append(ptemp2)
	return list_of_biglogs
