Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D09C5027FB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 12:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352108AbiDOKJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 06:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244518AbiDOKJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:09:18 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB1290FF9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 03:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650017209; x=1681553209;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zCuEbjT65LIV2/5LKAE2eDsqjao6KbnOcVoo9XTjADE=;
  b=T3+77+vnFF55OFa8Xa0E94SRHRDY65aTenabHt5y3r2QMR4zh612/D+G
   n5ZqdxLBYeYmokrCx76om/aP5QiC5tKc0ZWl+QcjwmXu+E3xKT82GIwN6
   yYtZyutlGkUBxRz61skc8/I10eJBpl9jRHEyqCwBkg+b5TunKugLsK/4I
   e4vUzCTUuXVTpWH+j6AQ2Lb94wfPWRhTsolFuVkKAgDQrPbs5cCdU7P+m
   f2jd33ROMHrTftANErhXekvwVjbahb4xH31ClZJ/8qKI3mNpJjsRDLIsF
   0DLDdmzE3XP283HFvsC9t3rC8JLaYnFAk+eIFMUuWQ1G7rsEtcE35s7x0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="261976270"
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="261976270"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 03:06:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="661957748"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 Apr 2022 03:06:47 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfIqQ-0001pJ-VS;
        Fri, 15 Apr 2022 10:06:26 +0000
Date:   Fri, 15 Apr 2022 18:05:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [chanwoo:devfreq-testing 5/5] drivers/devfreq/devfreq.c:937:2:
 error: use of undeclared identifier 'ret'
Message-ID: <202204151747.mGomaEyl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git devfreq-testing
head:   c758fc873c71a3466266f84a9bd8ccbebb0e7d68
commit: c758fc873c71a3466266f84a9bd8ccbebb0e7d68 [5/5] PM / devfreq: Add devfreq_set_governor_data
config: s390-randconfig-r025-20220414 (https://download.01.org/0day-ci/archive/20220415/202204151747.mGomaEyl-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6b7e6ea489f6dd45a9b0da9ac20871560917b9b0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?id=c758fc873c71a3466266f84a9bd8ccbebb0e7d68
        git remote add chanwoo https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
        git fetch --no-tags chanwoo devfreq-testing
        git checkout c758fc873c71a3466266f84a9bd8ccbebb0e7d68
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/devfreq/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/devfreq/devfreq.c:31:
   drivers/devfreq/governor.h:64:31: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [DEVFREQ_GOV_USERSPACE_ID] = {
                                        ^
   drivers/devfreq/governor.h:60:31: note: previous initialization is here
           [DEVFREQ_GOV_USERSPACE_ID] = {
                                        ^
>> drivers/devfreq/devfreq.c:937:2: error: use of undeclared identifier 'ret'
           ret = devfreq_set_governor_data(devfreq, governor_name, data)
           ^
>> drivers/devfreq/devfreq.c:1443:1: error: function definition is not allowed here
   {
   ^
>> drivers/devfreq/devfreq.c:1447:8: error: use of undeclared identifier 'name_show'
   static DEVICE_ATTR_RO(name);
          ^
   include/linux/device.h:136:45: note: expanded from macro 'DEVICE_ATTR_RO'
           struct device_attribute dev_attr_##_name = __ATTR_RO(_name)
                                                      ^
   include/linux/sysfs.h:117:10: note: expanded from macro '__ATTR_RO'
           .show   = _name##_show,                                         \
                     ^
   <scratch space>:27:1: note: expanded from here
   name_show
   ^
   drivers/devfreq/devfreq.c:1451:1: error: function definition is not allowed here
   {
   ^
   drivers/devfreq/devfreq.c:1462:1: error: function definition is not allowed here
   {
   ^
>> drivers/devfreq/devfreq.c:1538:8: error: use of undeclared identifier 'governor_show'
   static DEVICE_ATTR_RW(governor);
          ^
   include/linux/device.h:132:45: note: expanded from macro 'DEVICE_ATTR_RW'
           struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
                                                      ^
   include/linux/sysfs.h:138:46: note: expanded from macro '__ATTR_RW'
   #define __ATTR_RW(_name) __ATTR(_name, 0644, _name##_show, _name##_store)
                                                ^
   <scratch space>:42:1: note: expanded from here
   governor_show
   ^
>> drivers/devfreq/devfreq.c:1538:8: error: use of undeclared identifier 'governor_store'; did you mean 'governor_name'?
   include/linux/device.h:132:45: note: expanded from macro 'DEVICE_ATTR_RW'
           struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
                                                      ^
   include/linux/sysfs.h:138:60: note: expanded from macro '__ATTR_RW'
   #define __ATTR_RW(_name) __ATTR(_name, 0644, _name##_show, _name##_store)
                                                              ^
   <scratch space>:43:1: note: expanded from here
   governor_store
   ^
   drivers/devfreq/devfreq.c:1414:16: note: 'governor_name' declared here
                           const char *governor_name, void *data)
                                       ^
   drivers/devfreq/devfreq.c:1543:1: error: function definition is not allowed here
   {
   ^
>> drivers/devfreq/devfreq.c:1584:8: error: use of undeclared identifier 'available_governors_show'
   static DEVICE_ATTR_RO(available_governors);
          ^
   include/linux/device.h:136:45: note: expanded from macro 'DEVICE_ATTR_RO'
           struct device_attribute dev_attr_##_name = __ATTR_RO(_name)
                                                      ^
   include/linux/sysfs.h:117:10: note: expanded from macro '__ATTR_RO'
           .show   = _name##_show,                                         \
                     ^
   <scratch space>:55:1: note: expanded from here
   available_governors_show
   ^
   drivers/devfreq/devfreq.c:1588:1: error: function definition is not allowed here
   {
   ^
>> drivers/devfreq/devfreq.c:1601:8: error: use of undeclared identifier 'cur_freq_show'; did you mean 'chrdev_show'?
   static DEVICE_ATTR_RO(cur_freq);
          ^
   include/linux/device.h:136:45: note: expanded from macro 'DEVICE_ATTR_RO'
           struct device_attribute dev_attr_##_name = __ATTR_RO(_name)
                                                      ^
   include/linux/sysfs.h:117:10: note: expanded from macro '__ATTR_RO'
           .show   = _name##_show,                                         \
                     ^
   <scratch space>:59:1: note: expanded from here
   cur_freq_show
   ^
   include/linux/fs.h:2687:13: note: 'chrdev_show' declared here
   extern void chrdev_show(struct seq_file *,off_t);
               ^
>> drivers/devfreq/devfreq.c:1601:8: error: incompatible function pointer types initializing 'ssize_t (*)(struct device *, struct device_attribute *, char *)' (aka 'long (*)(struct device *, struct device_attribute *, char *)') with an expression of type 'void (struct seq_file *, off_t)' (aka 'void (struct seq_file *, long)') [-Werror,-Wincompatible-function-pointer-types]
   static DEVICE_ATTR_RO(cur_freq);
          ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/device.h:136:45: note: expanded from macro 'DEVICE_ATTR_RO'
           struct device_attribute dev_attr_##_name = __ATTR_RO(_name)
                                                      ^~~~~~~~~~~~~~~~
   include/linux/sysfs.h:117:10: note: expanded from macro '__ATTR_RO'
           .show   = _name##_show,                                         \
                     ^~~~~~~~~~~~
   <scratch space>:59:1: note: expanded from here
   cur_freq_show
   ^~~~~~~~~~~~~
   drivers/devfreq/devfreq.c:1605:1: error: function definition is not allowed here
   {
   ^
>> drivers/devfreq/devfreq.c:1610:8: error: use of undeclared identifier 'target_freq_show'; did you mean 'socket_seq_show'?
   static DEVICE_ATTR_RO(target_freq);
          ^
   include/linux/device.h:136:45: note: expanded from macro 'DEVICE_ATTR_RO'
           struct device_attribute dev_attr_##_name = __ATTR_RO(_name)
                                                      ^
   include/linux/sysfs.h:117:10: note: expanded from macro '__ATTR_RO'
           .show   = _name##_show,                                         \
                     ^
   <scratch space>:63:1: note: expanded from here
   target_freq_show
   ^
   include/linux/socket.h:23:13: note: 'socket_seq_show' declared here
   extern void socket_seq_show(struct seq_file *seq);
               ^
   drivers/devfreq/devfreq.c:1610:8: error: incompatible function pointer types initializing 'ssize_t (*)(struct device *, struct device_attribute *, char *)' (aka 'long (*)(struct device *, struct device_attribute *, char *)') with an expression of type 'void (struct seq_file *)' [-Werror,-Wincompatible-function-pointer-types]
   static DEVICE_ATTR_RO(target_freq);
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/device.h:136:45: note: expanded from macro 'DEVICE_ATTR_RO'
           struct device_attribute dev_attr_##_name = __ATTR_RO(_name)
                                                      ^~~~~~~~~~~~~~~~
   include/linux/sysfs.h:117:10: note: expanded from macro '__ATTR_RO'
           .show   = _name##_show,                                         \
                     ^~~~~~~~~~~~
   <scratch space>:63:1: note: expanded from here
   target_freq_show
   ^~~~~~~~~~~~~~~~
   drivers/devfreq/devfreq.c:1614:1: error: function definition is not allowed here
   {
   ^
   drivers/devfreq/devfreq.c:1641:1: error: function definition is not allowed here
   {
   ^
>> drivers/devfreq/devfreq.c:1651:8: error: use of undeclared identifier 'min_freq_show'
   static DEVICE_ATTR_RW(min_freq);
          ^
   include/linux/device.h:132:45: note: expanded from macro 'DEVICE_ATTR_RW'
           struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
                                                      ^
   include/linux/sysfs.h:138:46: note: expanded from macro '__ATTR_RW'
   #define __ATTR_RW(_name) __ATTR(_name, 0644, _name##_show, _name##_store)
                                                ^
   <scratch space>:67:1: note: expanded from here
   min_freq_show
   ^
>> drivers/devfreq/devfreq.c:1651:8: error: use of undeclared identifier 'min_freq_store'
   include/linux/device.h:132:45: note: expanded from macro 'DEVICE_ATTR_RW'
           struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
                                                      ^
   include/linux/sysfs.h:138:60: note: expanded from macro '__ATTR_RW'
   #define __ATTR_RW(_name) __ATTR(_name, 0644, _name##_show, _name##_store)
                                                              ^
   <scratch space>:68:1: note: expanded from here
   min_freq_store
   ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   1 warning and 20 errors generated.
--
   In file included from drivers/devfreq/governor_userspace.c:15:
   drivers/devfreq/governor.h:64:31: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [DEVFREQ_GOV_USERSPACE_ID] = {
                                        ^
   drivers/devfreq/governor.h:60:31: note: previous initialization is here
           [DEVFREQ_GOV_USERSPACE_ID] = {
                                        ^
>> drivers/devfreq/governor_userspace.c:43:7: error: incompatible pointer types assigning to 'struct userspace_data *' from 'void **' [-Werror,-Wincompatible-pointer-types]
           data = devfreq->data;
                ^ ~~~~~~~~~~~~~
   drivers/devfreq/governor_userspace.c:63:7: error: incompatible pointer types assigning to 'struct userspace_data *' from 'void **' [-Werror,-Wincompatible-pointer-types]
           data = devfreq->data;
                ^ ~~~~~~~~~~~~~
>> drivers/devfreq/governor_userspace.c:94:16: error: incompatible pointer types assigning to 'void **' from 'struct userspace_data *' [-Werror,-Wincompatible-pointer-types]
           devfreq->data = data;
                         ^ ~~~~
   1 warning and 3 errors generated.


vim +/ret +937 drivers/devfreq/devfreq.c

   768	
   769	static void create_sysfs_files(struct devfreq *devfreq,
   770					const struct devfreq_governor *gov);
   771	static void remove_sysfs_files(struct devfreq *devfreq,
   772					const struct devfreq_governor *gov);
   773	
   774	/**
   775	 * devfreq_add_device() - Add devfreq feature to the device
   776	 * @dev:	the device to add devfreq feature.
   777	 * @profile:	device-specific profile to run devfreq.
   778	 * @governor_name:	name of the policy to choose frequency.
   779	 * @data:	private data for the governor. The devfreq framework does not
   780	 *		touch this value.
   781	 */
   782	struct devfreq *devfreq_add_device(struct device *dev,
   783					   struct devfreq_dev_profile *profile,
   784					   const char *governor_name,
   785					   void *data)
   786	{
   787		struct devfreq *devfreq;
   788		struct devfreq_governor *governor;
   789		unsigned long min_freq, max_freq;
   790		int err = 0;
   791	
   792		if (!dev || !profile || !governor_name) {
   793			dev_err(dev, "%s: Invalid parameters.\n", __func__);
   794			return ERR_PTR(-EINVAL);
   795		}
   796	
   797		mutex_lock(&devfreq_list_lock);
   798		devfreq = find_device_devfreq(dev);
   799		mutex_unlock(&devfreq_list_lock);
   800		if (!IS_ERR(devfreq)) {
   801			dev_err(dev, "%s: devfreq device already exists!\n",
   802				__func__);
   803			err = -EINVAL;
   804			goto err_out;
   805		}
   806	
   807		devfreq = kzalloc(sizeof(struct devfreq), GFP_KERNEL);
   808		if (!devfreq) {
   809			err = -ENOMEM;
   810			goto err_out;
   811		}
   812	
   813		devfreq->data = kzalloc(sizeof(void *) * DEVFREQ_GOV_NUM, GFP_KERNEL);
   814		if (!devfreq->data) {
   815			err = -ENOMEM;
   816			goto err_dev;
   817		}
   818	
   819		mutex_init(&devfreq->lock);
   820		mutex_lock(&devfreq->lock);
   821		devfreq->dev.parent = dev;
   822		devfreq->dev.class = devfreq_class;
   823		devfreq->dev.release = devfreq_dev_release;
   824		INIT_LIST_HEAD(&devfreq->node);
   825		devfreq->profile = profile;
   826		devfreq->previous_freq = profile->initial_freq;
   827		devfreq->last_status.current_frequency = profile->initial_freq;
   828		devfreq->nb.notifier_call = devfreq_notifier_call;
   829	
   830		if (devfreq->profile->timer < 0
   831			|| devfreq->profile->timer >= DEVFREQ_TIMER_NUM) {
   832			mutex_unlock(&devfreq->lock);
   833			err = -EINVAL;
   834			goto err_dev;
   835		}
   836	
   837		if (!devfreq->profile->max_state || !devfreq->profile->freq_table) {
   838			mutex_unlock(&devfreq->lock);
   839			err = set_freq_table(devfreq);
   840			if (err < 0)
   841				goto err_dev;
   842			mutex_lock(&devfreq->lock);
   843		}
   844	
   845		devfreq->scaling_min_freq = find_available_min_freq(devfreq);
   846		if (!devfreq->scaling_min_freq) {
   847			mutex_unlock(&devfreq->lock);
   848			err = -EINVAL;
   849			goto err_dev;
   850		}
   851	
   852		devfreq->scaling_max_freq = find_available_max_freq(devfreq);
   853		if (!devfreq->scaling_max_freq) {
   854			mutex_unlock(&devfreq->lock);
   855			err = -EINVAL;
   856			goto err_dev;
   857		}
   858	
   859		devfreq_get_freq_range(devfreq, &min_freq, &max_freq);
   860	
   861		devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
   862		devfreq->opp_table = dev_pm_opp_get_opp_table(dev);
   863		if (IS_ERR(devfreq->opp_table))
   864			devfreq->opp_table = NULL;
   865	
   866		atomic_set(&devfreq->suspend_count, 0);
   867	
   868		dev_set_name(&devfreq->dev, "%s", dev_name(dev));
   869		err = device_register(&devfreq->dev);
   870		if (err) {
   871			mutex_unlock(&devfreq->lock);
   872			put_device(&devfreq->dev);
   873			goto err_out;
   874		}
   875	
   876		devfreq->stats.trans_table = devm_kzalloc(&devfreq->dev,
   877				array3_size(sizeof(unsigned int),
   878					    devfreq->profile->max_state,
   879					    devfreq->profile->max_state),
   880				GFP_KERNEL);
   881		if (!devfreq->stats.trans_table) {
   882			mutex_unlock(&devfreq->lock);
   883			err = -ENOMEM;
   884			goto err_devfreq;
   885		}
   886	
   887		devfreq->stats.time_in_state = devm_kcalloc(&devfreq->dev,
   888				devfreq->profile->max_state,
   889				sizeof(*devfreq->stats.time_in_state),
   890				GFP_KERNEL);
   891		if (!devfreq->stats.time_in_state) {
   892			mutex_unlock(&devfreq->lock);
   893			err = -ENOMEM;
   894			goto err_devfreq;
   895		}
   896	
   897		devfreq->stats.total_trans = 0;
   898		devfreq->stats.last_update = get_jiffies_64();
   899	
   900		srcu_init_notifier_head(&devfreq->transition_notifier_list);
   901	
   902		mutex_unlock(&devfreq->lock);
   903	
   904		err = dev_pm_qos_add_request(dev, &devfreq->user_min_freq_req,
   905					     DEV_PM_QOS_MIN_FREQUENCY, 0);
   906		if (err < 0)
   907			goto err_devfreq;
   908		err = dev_pm_qos_add_request(dev, &devfreq->user_max_freq_req,
   909					     DEV_PM_QOS_MAX_FREQUENCY,
   910					     PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
   911		if (err < 0)
   912			goto err_devfreq;
   913	
   914		devfreq->nb_min.notifier_call = qos_min_notifier_call;
   915		err = dev_pm_qos_add_notifier(dev, &devfreq->nb_min,
   916					      DEV_PM_QOS_MIN_FREQUENCY);
   917		if (err)
   918			goto err_devfreq;
   919	
   920		devfreq->nb_max.notifier_call = qos_max_notifier_call;
   921		err = dev_pm_qos_add_notifier(dev, &devfreq->nb_max,
   922					      DEV_PM_QOS_MAX_FREQUENCY);
   923		if (err)
   924			goto err_devfreq;
   925	
   926		mutex_lock(&devfreq_list_lock);
   927	
   928		governor = try_then_request_governor(governor_name);
   929		if (IS_ERR(governor)) {
   930			dev_err(dev, "%s: Unable to find governor for the device\n",
   931				__func__);
   932			err = PTR_ERR(governor);
   933			goto err_init;
   934		}
   935		devfreq->governor = governor;
   936	
 > 937		ret = devfreq_set_governor_data(devfreq, governor_name, data)
   938		if (ret < 0) {
   939			dev_err(dev, "%s: Unable to set data for governor(%s)\n",
   940				__func__, governor_name);
   941			return ret;
   942		}
   943	
   944		err = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_START,
   945							NULL);
   946		if (err) {
   947			dev_err(dev, "%s: Unable to start governor for the device\n",
   948				__func__);
   949			goto err_init;
   950		}
   951		create_sysfs_files(devfreq, devfreq->governor);
   952	
   953		list_add(&devfreq->node, &devfreq_list);
   954	
   955		mutex_unlock(&devfreq_list_lock);
   956	
   957		if (devfreq->profile->is_cooling_device) {
   958			devfreq->cdev = devfreq_cooling_em_register(devfreq, NULL);
   959			if (IS_ERR(devfreq->cdev))
   960				devfreq->cdev = NULL;
   961		}
   962	
   963		return devfreq;
   964	
   965	err_init:
   966		mutex_unlock(&devfreq_list_lock);
   967	err_devfreq:
   968		devfreq_remove_device(devfreq);
   969		devfreq = NULL;
   970	err_dev:
   971		if (*devfreq->data != NULL)
   972			kfree(devfreq->data);
   973		kfree(devfreq);
   974	err_out:
   975		return ERR_PTR(err);
   976	}
   977	EXPORT_SYMBOL(devfreq_add_device);
   978	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
