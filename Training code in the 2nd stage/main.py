import argparse
import os
import tensorflow as tf
from model import Model
from modelVGG import ModelVGG
from modelVGGASSP import  ModelVGGASSP


"""
This script defines hyperparameters.
"""

def configure():
	flags = tf.app.flags

	# training
	flags.DEFINE_integer('num_steps',27000, 'maximum number of iterations')
	flags.DEFINE_integer('save_interval', 3000, 'number of iterations for saving and visualization')
	flags.DEFINE_integer('random_seed', 1234, 'random seed')
	flags.DEFINE_float('weight_decay', 0.0005, 'weight decay rate')
	flags.DEFINE_float('learning_rate', 1e-3, 'learning rate') #6-7e-5 for resnet, 1e-3 for vgg
	flags.DEFINE_float('power', 0.9, 'hyperparameter for poly learning rate')
	flags.DEFINE_float('momentum', 0.9, 'momentum')
	flags.DEFINE_boolean('is_training', False, 'whether to updates the running means and variances of BN during the training')
	#flags.DEFINE_string('pretrain_file', './model/DSRG2018//224-58.9/', 'pre-trained model filename') #./model/3k53.6/model.ckpt-3000 #'./deeplab_resnet_init.ckpt' DEEPLABVGG-INIT/larfovinit/norm-20999
	flags.DEFINE_string('pretrain_file', '.\model\DEEPLABVGG-INIT/asspinit/norm-23999', 'pre-trained model filename') #./model/3k53.6/model.ckpt-3000 #'./deeplab_resnet_init.ckpt' DEEPLABVGG-INIT/larfovinit/norm-20999
#DEEPLABVGG-INIT/asspinit/norm-23999 DEEPLABVGG-INIT/larfovinit/norm-20999

	#model\VGG-1028\实验1\STEP4-57.6/model.ckpt-24000
	#.\model\DEEPLABVGG-INIT\\asspinit\\norm-23999
	#model\VGG-1028\STEP2-deepsal+REVCAM+53.3/model.ckpt-240009++
	#/VGG106-AAAI/56.9/model.ckpt-18000
# tipDSRG569620SEL0.76allbkmask
	flags.DEFINE_string('data_list', './dataset/TIP2020//BKGMM//proxy-SEENETDRFI.txt', 'training data list filename') #tipDSRG569BKGMMrefine825train
	#trainSam0.5spnosal './dataset/RESNET830/train2603.txt
	#'./dataset/resnet826/train0.8.txt' // vgg91/train0.55
	# testing / validation
	#flags.DEFINE_integer('valid_step', 3000, 'checkpoint number for testing/validation')
	flags.DEFINE_integer('valid_step',18000, 'checkpoint number for testing/validation')
	#flags.DEFINE_integer('valid_step',18000, 'checkpoint number for testing/validation')
	flags.DEFINE_integer('valid_num_steps', 1449, '= number of testing/validation samples')
	flags.DEFINE_string('valid_data_list', './dataset/val.txt', 'testing/validation data list filename')

	# data
	flags.DEFINE_string('data_dir', 'F:\\DEEPLEARNING\\LINGUOSHENGrefinenet-master\\datasets\\voc2012_trainval\\', 'data directory')
	flags.DEFINE_integer('batch_size', 7, 'training batch size')
	flags.DEFINE_integer('input_height', 321, 'input image height') #257
	flags.DEFINE_integer('input_width', 321, 'input image width')
	flags.DEFINE_integer('num_classes', 21, 'number of classes')
	flags.DEFINE_integer('ignore_label', 255, 'label pixel value that should be ignored')
	flags.DEFINE_boolean('random_scale', True, 'whether to perform random scaling data-augmentation')
	flags.DEFINE_boolean('random_mirror', True, 'whether to perform random left-right flipping data-augmentation')
	
	# logw
	flags.DEFINE_string('modeldir', 'model', 'model directory')
	flags.DEFINE_string('logfile', 'log.txt', 'training log filename')
	flags.DEFINE_string('logdir', 'log', 'training log directory')
	
	flags.FLAGS.__dict__['__parsed'] = False
	return flags.FLAGS
#而是他
def main(_):
	parser = argparse.ArgumentParser()
	parser.add_argument('--option', dest='option', type=str, default='test')
	args = parser.parse_args()

	if args.option not in ['train', 'test', 'predict']:
		print('invalid option: ', args.option)
		print("Please input a option: train, test, or predict")
	else:
		# Set up tf session and initialize variables. 
		# config = tf.ConfigProto()
		# config.gpu_options.allow_growth = Truehaha
		# sess = tf.Session(config=config)
		sess = tf.Session()
		# Run
		#model = Model(sess, configure()) ## to train the model for resnet.
		#model = ModelVGG(sess, configure())
		model = ModelVGGASSP(sess, configure())
		getattr(model, args.option)()


if __name__ == '__main__':
	# Choose which gpu or cpu to use
	os.environ['CUDA_VISIBLE_DEVICES'] = '0'
	tf.app.run()
