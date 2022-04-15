Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C05502774
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351738AbiDOJiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245380AbiDOJh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:37:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8DCA996C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 02:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650015328; x=1681551328;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NrmkqrCIg4rozZYmVQEVUfwUlNn1hrIPfvlkHvP1too=;
  b=jUlTh9LyK5EI/SgsSmn8RBXQ23ueAXK8t0Q9xh9yE9nzk3sjnIrCqhxd
   L9EFxfLLY+Hurct6cQfF5MpdBvFuSrjF7Vsi9PreJqrSz9/IjQL60SVDg
   X5Y+WlwoTHxVhqSkndbmqfow7ySTpB6im1HJp4hQzYEnTrVvZyCfMBbIB
   cgKvQ3NgH8A4nVb5QjKi2RJRFmjYd2eYSny0W5u/YATnxkZQuXahv24z3
   9/GGGZ10DqxPYufp566g2Oz9pI4eTsead5PQS/DhzsDhkReu2R585dYRv
   UdqLE4gvzqV7n8hmfbWfgFdkv2ozEuaYxYSA7+oMbldyNe75gLtUy5Isr
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="261972788"
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="261972788"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 02:35:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="661930569"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 Apr 2022 02:35:26 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfIMP-0001nx-Un;
        Fri, 15 Apr 2022 09:35:25 +0000
Date:   Fri, 15 Apr 2022 17:35:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [chanwoo:devfreq-testing 5/5] drivers/devfreq/devfreq.c:937:9:
 error: 'ret' undeclared; did you mean 'net'?
Message-ID: <202204151740.xkrgdq9a-lkp@intel.com>
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
config: alpha-randconfig-r003-20220414 (https://download.01.org/0day-ci/archive/20220415/202204151740.xkrgdq9a-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?id=c758fc873c71a3466266f84a9bd8ccbebb0e7d68
        git remote add chanwoo https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
        git fetch --no-tags chanwoo devfreq-testing
        git checkout c758fc873c71a3466266f84a9bd8ccbebb0e7d68
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/devfreq/ fs/btrfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from drivers/devfreq/devfreq.c:31:
   drivers/devfreq/governor.h:64:38: warning: initialized field overwritten [-Woverride-init]
      64 |         [DEVFREQ_GOV_USERSPACE_ID] = {
         |                                      ^
   drivers/devfreq/governor.h:64:38: note: (near initialization for 'governor_info[3]')
   drivers/devfreq/devfreq.c: In function 'devfreq_add_device':
>> drivers/devfreq/devfreq.c:937:9: error: 'ret' undeclared (first use in this function); did you mean 'net'?
     937 |         ret = devfreq_set_governor_data(devfreq, governor_name, data)
         |         ^~~
         |         net
   drivers/devfreq/devfreq.c:937:9: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/devfreq/devfreq.c:937:70: error: expected ';' before 'if'
     937 |         ret = devfreq_set_governor_data(devfreq, governor_name, data)
         |                                                                      ^
         |                                                                      ;
     938 |         if (ret < 0) {
         |         ~~                                                            
   drivers/devfreq/devfreq.c: In function 'devfreq_set_governor_data':
>> drivers/devfreq/devfreq.c:1441:16: error: invalid storage class for function 'name_show'
    1441 | static ssize_t name_show(struct device *dev,
         |                ^~~~~~~~~
>> drivers/devfreq/devfreq.c:1441:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    1441 | static ssize_t name_show(struct device *dev,
         | ^~~~~~
   In file included from include/linux/kobject.h:20,
                    from include/linux/energy_model.h:7,
                    from include/linux/device.h:16,
                    from include/linux/devfreq.h:13,
                    from include/linux/devfreq_cooling.h:13,
                    from drivers/devfreq/devfreq.c:14:
>> drivers/devfreq/devfreq.c:1447:23: error: initializer element is not constant
    1447 | static DEVICE_ATTR_RO(name);
         |                       ^~~~
   include/linux/sysfs.h:117:19: note: in definition of macro '__ATTR_RO'
     117 |         .show   = _name##_show,                                         \
         |                   ^~~~~
   drivers/devfreq/devfreq.c:1447:8: note: in expansion of macro 'DEVICE_ATTR_RO'
    1447 | static DEVICE_ATTR_RO(name);
         |        ^~~~~~~~~~~~~~
   drivers/devfreq/devfreq.c:1447:23: note: (near initialization for 'dev_attr_name.show')
    1447 | static DEVICE_ATTR_RO(name);
         |                       ^~~~
   include/linux/sysfs.h:117:19: note: in definition of macro '__ATTR_RO'
     117 |         .show   = _name##_show,                                         \
         |                   ^~~~~
   drivers/devfreq/devfreq.c:1447:8: note: in expansion of macro 'DEVICE_ATTR_RO'
    1447 | static DEVICE_ATTR_RO(name);
         |        ^~~~~~~~~~~~~~
>> drivers/devfreq/devfreq.c:1449:16: error: invalid storage class for function 'governor_show'
    1449 | static ssize_t governor_show(struct device *dev,
         |                ^~~~~~~~~~~~~
>> drivers/devfreq/devfreq.c:1460:16: error: invalid storage class for function 'governor_store'
    1460 | static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
         |                ^~~~~~~~~~~~~~
   In file included from include/linux/kobject.h:20,
                    from include/linux/energy_model.h:7,
                    from include/linux/device.h:16,
                    from include/linux/devfreq.h:13,
                    from include/linux/devfreq_cooling.h:13,
                    from drivers/devfreq/devfreq.c:14:
   drivers/devfreq/devfreq.c:1538:23: error: initializer element is not constant
    1538 | static DEVICE_ATTR_RW(governor);
         |                       ^~~~~~~~
   include/linux/sysfs.h:104:19: note: in definition of macro '__ATTR'
     104 |         .show   = _show,                                                \
         |                   ^~~~~
   include/linux/device.h:132:52: note: in expansion of macro '__ATTR_RW'
     132 |         struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
         |                                                    ^~~~~~~~~
   drivers/devfreq/devfreq.c:1538:8: note: in expansion of macro 'DEVICE_ATTR_RW'
    1538 | static DEVICE_ATTR_RW(governor);
         |        ^~~~~~~~~~~~~~
   drivers/devfreq/devfreq.c:1538:23: note: (near initialization for 'dev_attr_governor.show')
    1538 | static DEVICE_ATTR_RW(governor);
         |                       ^~~~~~~~
   include/linux/sysfs.h:104:19: note: in definition of macro '__ATTR'
     104 |         .show   = _show,                                                \
         |                   ^~~~~
   include/linux/device.h:132:52: note: in expansion of macro '__ATTR_RW'
     132 |         struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
         |                                                    ^~~~~~~~~
   drivers/devfreq/devfreq.c:1538:8: note: in expansion of macro 'DEVICE_ATTR_RW'
    1538 | static DEVICE_ATTR_RW(governor);
         |        ^~~~~~~~~~~~~~
   drivers/devfreq/devfreq.c:1538:23: error: initializer element is not constant
    1538 | static DEVICE_ATTR_RW(governor);
         |                       ^~~~~~~~
   include/linux/sysfs.h:105:19: note: in definition of macro '__ATTR'
     105 |         .store  = _store,                                               \
         |                   ^~~~~~
   include/linux/device.h:132:52: note: in expansion of macro '__ATTR_RW'
     132 |         struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
         |                                                    ^~~~~~~~~
   drivers/devfreq/devfreq.c:1538:8: note: in expansion of macro 'DEVICE_ATTR_RW'
    1538 | static DEVICE_ATTR_RW(governor);
         |        ^~~~~~~~~~~~~~
   drivers/devfreq/devfreq.c:1538:23: note: (near initialization for 'dev_attr_governor.store')
    1538 | static DEVICE_ATTR_RW(governor);
         |                       ^~~~~~~~
   include/linux/sysfs.h:105:19: note: in definition of macro '__ATTR'
     105 |         .store  = _store,                                               \
         |                   ^~~~~~
   include/linux/device.h:132:52: note: in expansion of macro '__ATTR_RW'
     132 |         struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
         |                                                    ^~~~~~~~~
   drivers/devfreq/devfreq.c:1538:8: note: in expansion of macro 'DEVICE_ATTR_RW'
    1538 | static DEVICE_ATTR_RW(governor);
         |        ^~~~~~~~~~~~~~
>> drivers/devfreq/devfreq.c:1540:16: error: invalid storage class for function 'available_governors_show'
    1540 | static ssize_t available_governors_show(struct device *d,
         |                ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/kobject.h:20,
                    from include/linux/energy_model.h:7,
                    from include/linux/device.h:16,
                    from include/linux/devfreq.h:13,
                    from include/linux/devfreq_cooling.h:13,
                    from drivers/devfreq/devfreq.c:14:
   drivers/devfreq/devfreq.c:1584:23: error: initializer element is not constant
    1584 | static DEVICE_ATTR_RO(available_governors);
         |                       ^~~~~~~~~~~~~~~~~~~
   include/linux/sysfs.h:117:19: note: in definition of macro '__ATTR_RO'
     117 |         .show   = _name##_show,                                         \
         |                   ^~~~~
   drivers/devfreq/devfreq.c:1584:8: note: in expansion of macro 'DEVICE_ATTR_RO'
    1584 | static DEVICE_ATTR_RO(available_governors);
         |        ^~~~~~~~~~~~~~
   drivers/devfreq/devfreq.c:1584:23: note: (near initialization for 'dev_attr_available_governors.show')
    1584 | static DEVICE_ATTR_RO(available_governors);
         |                       ^~~~~~~~~~~~~~~~~~~
   include/linux/sysfs.h:117:19: note: in definition of macro '__ATTR_RO'
     117 |         .show   = _name##_show,                                         \
         |                   ^~~~~
   drivers/devfreq/devfreq.c:1584:8: note: in expansion of macro 'DEVICE_ATTR_RO'
    1584 | static DEVICE_ATTR_RO(available_governors);
         |        ^~~~~~~~~~~~~~
>> drivers/devfreq/devfreq.c:1586:16: error: invalid storage class for function 'cur_freq_show'
    1586 | static ssize_t cur_freq_show(struct device *dev, struct device_attribute *attr,
         |                ^~~~~~~~~~~~~
   In file included from include/linux/kobject.h:20,
                    from include/linux/energy_model.h:7,
                    from include/linux/device.h:16,
                    from include/linux/devfreq.h:13,
                    from include/linux/devfreq_cooling.h:13,
                    from drivers/devfreq/devfreq.c:14:
   drivers/devfreq/devfreq.c:1601:23: error: initializer element is not constant
    1601 | static DEVICE_ATTR_RO(cur_freq);
         |                       ^~~~~~~~
   include/linux/sysfs.h:117:19: note: in definition of macro '__ATTR_RO'
     117 |         .show   = _name##_show,                                         \
         |                   ^~~~~
   drivers/devfreq/devfreq.c:1601:8: note: in expansion of macro 'DEVICE_ATTR_RO'
    1601 | static DEVICE_ATTR_RO(cur_freq);
         |        ^~~~~~~~~~~~~~
   drivers/devfreq/devfreq.c:1601:23: note: (near initialization for 'dev_attr_cur_freq.show')
    1601 | static DEVICE_ATTR_RO(cur_freq);
         |                       ^~~~~~~~
   include/linux/sysfs.h:117:19: note: in definition of macro '__ATTR_RO'
     117 |         .show   = _name##_show,                                         \
         |                   ^~~~~
   drivers/devfreq/devfreq.c:1601:8: note: in expansion of macro 'DEVICE_ATTR_RO'
    1601 | static DEVICE_ATTR_RO(cur_freq);
         |        ^~~~~~~~~~~~~~
>> drivers/devfreq/devfreq.c:1603:16: error: invalid storage class for function 'target_freq_show'
    1603 | static ssize_t target_freq_show(struct device *dev,
         |                ^~~~~~~~~~~~~~~~
   In file included from include/linux/kobject.h:20,
                    from include/linux/energy_model.h:7,
                    from include/linux/device.h:16,
                    from include/linux/devfreq.h:13,
                    from include/linux/devfreq_cooling.h:13,
                    from drivers/devfreq/devfreq.c:14:
   drivers/devfreq/devfreq.c:1610:23: error: initializer element is not constant
    1610 | static DEVICE_ATTR_RO(target_freq);
         |                       ^~~~~~~~~~~
   include/linux/sysfs.h:117:19: note: in definition of macro '__ATTR_RO'
     117 |         .show   = _name##_show,                                         \
         |                   ^~~~~
   drivers/devfreq/devfreq.c:1610:8: note: in expansion of macro 'DEVICE_ATTR_RO'
    1610 | static DEVICE_ATTR_RO(target_freq);
         |        ^~~~~~~~~~~~~~
   drivers/devfreq/devfreq.c:1610:23: note: (near initialization for 'dev_attr_target_freq.show')
    1610 | static DEVICE_ATTR_RO(target_freq);
         |                       ^~~~~~~~~~~
   include/linux/sysfs.h:117:19: note: in definition of macro '__ATTR_RO'
     117 |         .show   = _name##_show,                                         \
         |                   ^~~~~
   drivers/devfreq/devfreq.c:1610:8: note: in expansion of macro 'DEVICE_ATTR_RO'
    1610 | static DEVICE_ATTR_RO(target_freq);
         |        ^~~~~~~~~~~~~~
>> drivers/devfreq/devfreq.c:1612:16: error: invalid storage class for function 'min_freq_store'
    1612 | static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
         |                ^~~~~~~~~~~~~~
>> drivers/devfreq/devfreq.c:1639:16: error: invalid storage class for function 'min_freq_show'
    1639 | static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
         |                ^~~~~~~~~~~~~
   In file included from include/linux/kobject.h:20,
                    from include/linux/energy_model.h:7,
                    from include/linux/device.h:16,
                    from include/linux/devfreq.h:13,
                    from include/linux/devfreq_cooling.h:13,
                    from drivers/devfreq/devfreq.c:14:
   drivers/devfreq/devfreq.c:1651:23: error: initializer element is not constant
    1651 | static DEVICE_ATTR_RW(min_freq);
         |                       ^~~~~~~~
   include/linux/sysfs.h:104:19: note: in definition of macro '__ATTR'
     104 |         .show   = _show,                                                \
         |                   ^~~~~
   include/linux/device.h:132:52: note: in expansion of macro '__ATTR_RW'
     132 |         struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
         |                                                    ^~~~~~~~~
   drivers/devfreq/devfreq.c:1651:8: note: in expansion of macro 'DEVICE_ATTR_RW'
    1651 | static DEVICE_ATTR_RW(min_freq);
         |        ^~~~~~~~~~~~~~
   drivers/devfreq/devfreq.c:1651:23: note: (near initialization for 'dev_attr_min_freq.show')
    1651 | static DEVICE_ATTR_RW(min_freq);
         |                       ^~~~~~~~
   include/linux/sysfs.h:104:19: note: in definition of macro '__ATTR'
     104 |         .show   = _show,                                                \
         |                   ^~~~~
   include/linux/device.h:132:52: note: in expansion of macro '__ATTR_RW'
     132 |         struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
         |                                                    ^~~~~~~~~
   drivers/devfreq/devfreq.c:1651:8: note: in expansion of macro 'DEVICE_ATTR_RW'
    1651 | static DEVICE_ATTR_RW(min_freq);
         |        ^~~~~~~~~~~~~~
   drivers/devfreq/devfreq.c:1651:23: error: initializer element is not constant
    1651 | static DEVICE_ATTR_RW(min_freq);
         |                       ^~~~~~~~
   include/linux/sysfs.h:105:19: note: in definition of macro '__ATTR'
     105 |         .store  = _store,                                               \
         |                   ^~~~~~
   include/linux/device.h:132:52: note: in expansion of macro '__ATTR_RW'
     132 |         struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
         |                                                    ^~~~~~~~~
   drivers/devfreq/devfreq.c:1651:8: note: in expansion of macro 'DEVICE_ATTR_RW'
    1651 | static DEVICE_ATTR_RW(min_freq);
         |        ^~~~~~~~~~~~~~
   drivers/devfreq/devfreq.c:1651:23: note: (near initialization for 'dev_attr_min_freq.store')
    1651 | static DEVICE_ATTR_RW(min_freq);
         |                       ^~~~~~~~
   include/linux/sysfs.h:105:19: note: in definition of macro '__ATTR'
     105 |         .store  = _store,                                               \
         |                   ^~~~~~
   include/linux/device.h:132:52: note: in expansion of macro '__ATTR_RW'
     132 |         struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
         |                                                    ^~~~~~~~~
   drivers/devfreq/devfreq.c:1651:8: note: in expansion of macro 'DEVICE_ATTR_RW'
    1651 | static DEVICE_ATTR_RW(min_freq);
         |        ^~~~~~~~~~~~~~
>> drivers/devfreq/devfreq.c:1653:16: error: invalid storage class for function 'max_freq_store'
    1653 | static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
         |                ^~~~~~~~~~~~~~
>> drivers/devfreq/devfreq.c:1693:16: error: invalid storage class for function 'max_freq_show'
    1693 | static ssize_t max_freq_show(struct device *dev, struct device_attribute *attr,
         |                ^~~~~~~~~~~~~
   In file included from include/linux/kobject.h:20,
                    from include/linux/energy_model.h:7,
                    from include/linux/device.h:16,
                    from include/linux/devfreq.h:13,
                    from include/linux/devfreq_cooling.h:13,
                    from drivers/devfreq/devfreq.c:14:
   drivers/devfreq/devfreq.c:1705:23: error: initializer element is not constant
    1705 | static DEVICE_ATTR_RW(max_freq);
         |                       ^~~~~~~~
   include/linux/sysfs.h:104:19: note: in definition of macro '__ATTR'
     104 |         .show   = _show,                                                \
         |                   ^~~~~
   include/linux/device.h:132:52: note: in expansion of macro '__ATTR_RW'
     132 |         struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
         |                                                    ^~~~~~~~~
   drivers/devfreq/devfreq.c:1705:8: note: in expansion of macro 'DEVICE_ATTR_RW'
    1705 | static DEVICE_ATTR_RW(max_freq);
         |        ^~~~~~~~~~~~~~
   drivers/devfreq/devfreq.c:1705:23: note: (near initialization for 'dev_attr_max_freq.show')
    1705 | static DEVICE_ATTR_RW(max_freq);
         |                       ^~~~~~~~
   include/linux/sysfs.h:104:19: note: in definition of macro '__ATTR'
     104 |         .show   = _show,                                                \
         |                   ^~~~~
   include/linux/device.h:132:52: note: in expansion of macro '__ATTR_RW'
     132 |         struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
         |                                                    ^~~~~~~~~
   drivers/devfreq/devfreq.c:1705:8: note: in expansion of macro 'DEVICE_ATTR_RW'
    1705 | static DEVICE_ATTR_RW(max_freq);
         |        ^~~~~~~~~~~~~~
   drivers/devfreq/devfreq.c:1705:23: error: initializer element is not constant
    1705 | static DEVICE_ATTR_RW(max_freq);
         |                       ^~~~~~~~
   include/linux/sysfs.h:105:19: note: in definition of macro '__ATTR'
     105 |         .store  = _store,                                               \
         |                   ^~~~~~
   include/linux/device.h:132:52: note: in expansion of macro '__ATTR_RW'
     132 |         struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
         |                                                    ^~~~~~~~~
   drivers/devfreq/devfreq.c:1705:8: note: in expansion of macro 'DEVICE_ATTR_RW'
    1705 | static DEVICE_ATTR_RW(max_freq);
         |        ^~~~~~~~~~~~~~
   drivers/devfreq/devfreq.c:1705:23: note: (near initialization for 'dev_attr_max_freq.store')
    1705 | static DEVICE_ATTR_RW(max_freq);
         |                       ^~~~~~~~
   include/linux/sysfs.h:105:19: note: in definition of macro '__ATTR'
     105 |         .store  = _store,                                               \
         |                   ^~~~~~
   include/linux/device.h:132:52: note: in expansion of macro '__ATTR_RW'
     132 |         struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
         |                                                    ^~~~~~~~~
   drivers/devfreq/devfreq.c:1705:8: note: in expansion of macro 'DEVICE_ATTR_RW'
    1705 | static DEVICE_ATTR_RW(max_freq);
         |        ^~~~~~~~~~~~~~
>> drivers/devfreq/devfreq.c:1707:16: error: invalid storage class for function 'available_frequencies_show'
    1707 | static ssize_t available_frequencies_show(struct device *d,
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/kobject.h:20,
                    from include/linux/energy_model.h:7,
                    from include/linux/device.h:16,
                    from include/linux/devfreq.h:13,
                    from include/linux/devfreq_cooling.h:13,
                    from drivers/devfreq/devfreq.c:14:
   drivers/devfreq/devfreq.c:1733:23: error: initializer element is not constant
    1733 | static DEVICE_ATTR_RO(available_frequencies);
         |                       ^~~~~~~~~~~~~~~~~~~~~
   include/linux/sysfs.h:117:19: note: in definition of macro '__ATTR_RO'
     117 |         .show   = _name##_show,                                         \
         |                   ^~~~~
   drivers/devfreq/devfreq.c:1733:8: note: in expansion of macro 'DEVICE_ATTR_RO'
    1733 | static DEVICE_ATTR_RO(available_frequencies);
         |        ^~~~~~~~~~~~~~
   drivers/devfreq/devfreq.c:1733:23: note: (near initialization for 'dev_attr_available_frequencies.show')
    1733 | static DEVICE_ATTR_RO(available_frequencies);
         |                       ^~~~~~~~~~~~~~~~~~~~~
   include/linux/sysfs.h:117:19: note: in definition of macro '__ATTR_RO'
     117 |         .show   = _name##_show,                                         \
         |                   ^~~~~
   drivers/devfreq/devfreq.c:1733:8: note: in expansion of macro 'DEVICE_ATTR_RO'
    1733 | static DEVICE_ATTR_RO(available_frequencies);
         |        ^~~~~~~~~~~~~~
>> drivers/devfreq/devfreq.c:1735:16: error: invalid storage class for function 'trans_stat_show'
    1735 | static ssize_t trans_stat_show(struct device *dev,
         |                ^~~~~~~~~~~~~~~
>> drivers/devfreq/devfreq.c:1788:16: error: invalid storage class for function 'trans_stat_store'
    1788 | static ssize_t trans_stat_store(struct device *dev,
         |                ^~~~~~~~~~~~~~~~
   In file included from include/linux/kobject.h:20,
                    from include/linux/energy_model.h:7,
                    from include/linux/device.h:16,
                    from include/linux/devfreq.h:13,
                    from include/linux/devfreq_cooling.h:13,
                    from drivers/devfreq/devfreq.c:14:
   drivers/devfreq/devfreq.c:1817:23: error: initializer element is not constant
    1817 | static DEVICE_ATTR_RW(trans_stat);
         |                       ^~~~~~~~~~
   include/linux/sysfs.h:104:19: note: in definition of macro '__ATTR'
     104 |         .show   = _show,                                                \
         |                   ^~~~~
   include/linux/device.h:132:52: note: in expansion of macro '__ATTR_RW'
     132 |         struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
         |                                                    ^~~~~~~~~
   drivers/devfreq/devfreq.c:1817:8: note: in expansion of macro 'DEVICE_ATTR_RW'
    1817 | static DEVICE_ATTR_RW(trans_stat);
         |        ^~~~~~~~~~~~~~
   drivers/devfreq/devfreq.c:1817:23: note: (near initialization for 'dev_attr_trans_stat.show')
    1817 | static DEVICE_ATTR_RW(trans_stat);
         |                       ^~~~~~~~~~
   include/linux/sysfs.h:104:19: note: in definition of macro '__ATTR'
     104 |         .show   = _show,                                                \
         |                   ^~~~~
   include/linux/device.h:132:52: note: in expansion of macro '__ATTR_RW'
     132 |         struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
         |                                                    ^~~~~~~~~
   drivers/devfreq/devfreq.c:1817:8: note: in expansion of macro 'DEVICE_ATTR_RW'
    1817 | static DEVICE_ATTR_RW(trans_stat);
         |        ^~~~~~~~~~~~~~
   drivers/devfreq/devfreq.c:1817:23: error: initializer element is not constant
    1817 | static DEVICE_ATTR_RW(trans_stat);
         |                       ^~~~~~~~~~
   include/linux/sysfs.h:105:19: note: in definition of macro '__ATTR'
     105 |         .store  = _store,                                               \
         |                   ^~~~~~
   include/linux/device.h:132:52: note: in expansion of macro '__ATTR_RW'
     132 |         struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
         |                                                    ^~~~~~~~~
   drivers/devfreq/devfreq.c:1817:8: note: in expansion of macro 'DEVICE_ATTR_RW'
    1817 | static DEVICE_ATTR_RW(trans_stat);
         |        ^~~~~~~~~~~~~~
   drivers/devfreq/devfreq.c:1817:23: note: (near initialization for 'dev_attr_trans_stat.store')
    1817 | static DEVICE_ATTR_RW(trans_stat);
         |                       ^~~~~~~~~~
   include/linux/sysfs.h:105:19: note: in definition of macro '__ATTR'
     105 |         .store  = _store,                                               \
         |                   ^~~~~~
   include/linux/device.h:132:52: note: in expansion of macro '__ATTR_RW'
     132 |         struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
         |                                                    ^~~~~~~~~
   drivers/devfreq/devfreq.c:1817:8: note: in expansion of macro 'DEVICE_ATTR_RW'
    1817 | static DEVICE_ATTR_RW(trans_stat);
         |        ^~~~~~~~~~~~~~
>> drivers/devfreq/devfreq.c:1833:16: error: invalid storage class for function 'polling_interval_show'
    1833 | static ssize_t polling_interval_show(struct device *dev,
         |                ^~~~~~~~~~~~~~~~~~~~~
>> drivers/devfreq/devfreq.c:1844:16: error: invalid storage class for function 'polling_interval_store'
    1844 | static ssize_t polling_interval_store(struct device *dev,
         |                ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/kobject.h:20,
                    from include/linux/energy_model.h:7,
                    from include/linux/device.h:16,
                    from include/linux/devfreq.h:13,
                    from include/linux/devfreq_cooling.h:13,
                    from drivers/devfreq/devfreq.c:14:
   drivers/devfreq/devfreq.c:1864:23: error: initializer element is not constant
    1864 | static DEVICE_ATTR_RW(polling_interval);
         |                       ^~~~~~~~~~~~~~~~
   include/linux/sysfs.h:104:19: note: in definition of macro '__ATTR'
     104 |         .show   = _show,                                                \
         |                   ^~~~~
   include/linux/device.h:132:52: note: in expansion of macro '__ATTR_RW'
     132 |         struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
         |                                                    ^~~~~~~~~
   drivers/devfreq/devfreq.c:1864:8: note: in expansion of macro 'DEVICE_ATTR_RW'
    1864 | static DEVICE_ATTR_RW(polling_interval);
         |        ^~~~~~~~~~~~~~
   drivers/devfreq/devfreq.c:1864:23: note: (near initialization for 'dev_attr_polling_interval.show')
    1864 | static DEVICE_ATTR_RW(polling_interval);
         |                       ^~~~~~~~~~~~~~~~
   include/linux/sysfs.h:104:19: note: in definition of macro '__ATTR'
     104 |         .show   = _show,                                                \
         |                   ^~~~~
   include/linux/device.h:132:52: note: in expansion of macro '__ATTR_RW'
     132 |         struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
         |                                                    ^~~~~~~~~
   drivers/devfreq/devfreq.c:1864:8: note: in expansion of macro 'DEVICE_ATTR_RW'
    1864 | static DEVICE_ATTR_RW(polling_interval);
         |        ^~~~~~~~~~~~~~
   drivers/devfreq/devfreq.c:1864:23: error: initializer element is not constant
    1864 | static DEVICE_ATTR_RW(polling_interval);
         |                       ^~~~~~~~~~~~~~~~
   include/linux/sysfs.h:105:19: note: in definition of macro '__ATTR'
     105 |         .store  = _store,                                               \
         |                   ^~~~~~
   include/linux/device.h:132:52: note: in expansion of macro '__ATTR_RW'
     132 |         struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
         |                                                    ^~~~~~~~~
   drivers/devfreq/devfreq.c:1864:8: note: in expansion of macro 'DEVICE_ATTR_RW'
    1864 | static DEVICE_ATTR_RW(polling_interval);
         |        ^~~~~~~~~~~~~~
   drivers/devfreq/devfreq.c:1864:23: note: (near initialization for 'dev_attr_polling_interval.store')
    1864 | static DEVICE_ATTR_RW(polling_interval);
         |                       ^~~~~~~~~~~~~~~~
   include/linux/sysfs.h:105:19: note: in definition of macro '__ATTR'
     105 |         .store  = _store,                                               \
         |                   ^~~~~~
   include/linux/device.h:132:52: note: in expansion of macro '__ATTR_RW'
     132 |         struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
         |                                                    ^~~~~~~~~
   drivers/devfreq/devfreq.c:1864:8: note: in expansion of macro 'DEVICE_ATTR_RW'
    1864 | static DEVICE_ATTR_RW(polling_interval);
         |        ^~~~~~~~~~~~~~
>> drivers/devfreq/devfreq.c:1866:16: error: invalid storage class for function 'timer_show'
    1866 | static ssize_t timer_show(struct device *dev,
         |                ^~~~~~~~~~
   drivers/devfreq/devfreq.c:1877:16: error: invalid storage class for function 'timer_store'
    1877 | static ssize_t timer_store(struct device *dev, struct device_attribute *attr,
         |                ^~~~~~~~~~~
   In file included from include/linux/kobject.h:20,
                    from include/linux/energy_model.h:7,
                    from include/linux/device.h:16,
                    from include/linux/devfreq.h:13,
                    from include/linux/devfreq_cooling.h:13,
                    from drivers/devfreq/devfreq.c:14:
   drivers/devfreq/devfreq.c:1927:23: error: initializer element is not constant
    1927 | static DEVICE_ATTR_RW(timer);
         |                       ^~~~~
   include/linux/sysfs.h:104:19: note: in definition of macro '__ATTR'
     104 |         .show   = _show,                                                \
         |                   ^~~~~
   include/linux/device.h:132:52: note: in expansion of macro '__ATTR_RW'
     132 |         struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
         |                                                    ^~~~~~~~~
   drivers/devfreq/devfreq.c:1927:8: note: in expansion of macro 'DEVICE_ATTR_RW'
    1927 | static DEVICE_ATTR_RW(timer);
         |        ^~~~~~~~~~~~~~
   drivers/devfreq/devfreq.c:1927:23: note: (near initialization for 'dev_attr_timer.show')
    1927 | static DEVICE_ATTR_RW(timer);
         |                       ^~~~~
   include/linux/sysfs.h:104:19: note: in definition of macro '__ATTR'
     104 |         .show   = _show,                                                \
         |                   ^~~~~
   include/linux/device.h:132:52: note: in expansion of macro '__ATTR_RW'
     132 |         struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
         |                                                    ^~~~~~~~~
   drivers/devfreq/devfreq.c:1927:8: note: in expansion of macro 'DEVICE_ATTR_RW'
    1927 | static DEVICE_ATTR_RW(timer);
         |        ^~~~~~~~~~~~~~
   drivers/devfreq/devfreq.c:1927:23: error: initializer element is not constant
    1927 | static DEVICE_ATTR_RW(timer);
         |                       ^~~~~
   include/linux/sysfs.h:105:19: note: in definition of macro '__ATTR'
     105 |         .store  = _store,                                               \
         |                   ^~~~~~
   include/linux/device.h:132:52: note: in expansion of macro '__ATTR_RW'
     132 |         struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
         |                                                    ^~~~~~~~~
   drivers/devfreq/devfreq.c:1927:8: note: in expansion of macro 'DEVICE_ATTR_RW'
    1927 | static DEVICE_ATTR_RW(timer);
         |        ^~~~~~~~~~~~~~
   drivers/devfreq/devfreq.c:1927:23: note: (near initialization for 'dev_attr_timer.store')
    1927 | static DEVICE_ATTR_RW(timer);
         |                       ^~~~~
   include/linux/sysfs.h:105:19: note: in definition of macro '__ATTR'
     105 |         .store  = _store,                                               \
         |                   ^~~~~~
   include/linux/device.h:132:52: note: in expansion of macro '__ATTR_RW'
     132 |         struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
         |                                                    ^~~~~~~~~
   drivers/devfreq/devfreq.c:1927:8: note: in expansion of macro 'DEVICE_ATTR_RW'
    1927 | static DEVICE_ATTR_RW(timer);
         |        ^~~~~~~~~~~~~~
   drivers/devfreq/devfreq.c:1940:13: error: invalid storage class for function 'create_sysfs_files'
    1940 | static void create_sysfs_files(struct devfreq *devfreq,
         |             ^~~~~~~~~~~~~~~~~~
   drivers/devfreq/devfreq.c:1950:13: error: invalid storage class for function 'remove_sysfs_files'
    1950 | static void remove_sysfs_files(struct devfreq *devfreq,
         |             ^~~~~~~~~~~~~~~~~~
   drivers/devfreq/devfreq.c:1970:12: error: invalid storage class for function 'devfreq_summary_show'
    1970 | static int devfreq_summary_show(struct seq_file *s, void *data)
         |            ^~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/debugfs.h:16,
                    from drivers/devfreq/devfreq.c:13:
   drivers/devfreq/devfreq.c:2040:23: error: invalid storage class for function 'devfreq_summary_open'
    2040 | DEFINE_SHOW_ATTRIBUTE(devfreq_summary);
         |                       ^~~~~~~~~~~~~~~
   include/linux/seq_file.h:197:12: note: in definition of macro 'DEFINE_SHOW_ATTRIBUTE'
     197 | static int __name ## _open(struct inode *inode, struct file *file)      \
         |            ^~~~~~
   drivers/devfreq/devfreq.c:2040:23: error: initializer element is not constant
    2040 | DEFINE_SHOW_ATTRIBUTE(devfreq_summary);
         |                       ^~~~~~~~~~~~~~~
   include/linux/seq_file.h:204:27: note: in definition of macro 'DEFINE_SHOW_ATTRIBUTE'
     204 |         .open           = __name ## _open,                              \
         |                           ^~~~~~
   drivers/devfreq/devfreq.c:2040:23: note: (near initialization for 'devfreq_summary_fops.open')
    2040 | DEFINE_SHOW_ATTRIBUTE(devfreq_summary);
         |                       ^~~~~~~~~~~~~~~
   include/linux/seq_file.h:204:27: note: in definition of macro 'DEFINE_SHOW_ATTRIBUTE'
     204 |         .open           = __name ## _open,                              \
         |                           ^~~~~~
   drivers/devfreq/devfreq.c:2042:19: error: invalid storage class for function 'devfreq_init'
    2042 | static int __init devfreq_init(void)
         |                   ^~~~~~~~~~~~
   In file included from include/linux/printk.h:6,
                    from include/linux/kernel.h:29,
                    from drivers/devfreq/devfreq.c:10:
   drivers/devfreq/devfreq.c:2065:17: error: initializer element is not constant
    2065 | subsys_initcall(devfreq_init);
         |                 ^~~~~~~~~~~~
   include/linux/init.h:250:55: note: in definition of macro '____define_initcall'
     250 |                 __attribute__((__section__(__sec))) = fn;
         |                                                       ^~
..


vim +937 drivers/devfreq/devfreq.c

   768	
 > 769	static void create_sysfs_files(struct devfreq *devfreq,
   770					const struct devfreq_governor *gov);
 > 771	static void remove_sysfs_files(struct devfreq *devfreq,
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
