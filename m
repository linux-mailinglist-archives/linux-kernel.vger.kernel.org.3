Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18964BDF74
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356081AbiBULUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:20:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355824AbiBULT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:19:28 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47782BBF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 03:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645441455; x=1676977455;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=m0RoA4wRLQQDzi48j0rjW/nwYArZ4gVG2Dv/aEkZHuU=;
  b=QafB0xpOU7ff9Ej9VfQKXNmtp86zsgc6ewXJaJ2uak5EuWrO/QRU9jQA
   +fclD8DJ93Jb951tWMZYXgGNmKYeqpql1mmWf9kbkTGxiZt4EnKTF4eTJ
   rZ/XrzV4Kk8S10jeRi35/7bc6rgwcjP0ZO126AEoD4cOG3sJos5MwzLNA
   dnMfcEco6aqPzQrYS0oBkPhjEirfWPLvzVlnKXXpZFZARCgFahj8qjBs+
   B+4ZdghgvnkcBwS3EvaowNTMygS89SjiB4IMd/e5HXZSIZKYEkEOLTcmA
   2BNt7UhWyVZCMdWjbkixvfpn0IK4TO2qzuXE5HS7+uqdbf+rY6WZItb14
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="251242188"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="251242188"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 03:04:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="627340043"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Feb 2022 03:04:13 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nM6UG-0001XG-R0; Mon, 21 Feb 2022 11:04:12 +0000
Date:   Mon, 21 Feb 2022 19:03:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1505/2574]
 drivers/hwspinlock/hwspinlock_core.c:369:26: sparse: sparse: incompatible
 types in comparison expression (different address spaces):
Message-ID: <202202211957.Gxf9NwU6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   39e8a0edc8fae20758051dadf7846849edc18b88
commit: 75d1193425bb839256332fc5d2d7051f603a1830 [1505/2574] headers/deps: radix-tree: Optimize <linux/radix-tree.h> dependencies, remove <linux/rcupdate.h>
config: x86_64-randconfig-s022-20220221 (https://download.01.org/0day-ci/archive/20220221/202202211957.Gxf9NwU6-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=75d1193425bb839256332fc5d2d7051f603a1830
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 75d1193425bb839256332fc5d2d7051f603a1830
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/entry/vsyscall/ drivers/hwspinlock/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/hwspinlock/hwspinlock_core.c:368:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void **slot @@     got void [noderef] __rcu ** @@
   drivers/hwspinlock/hwspinlock_core.c:368:9: sparse:     expected void **slot
   drivers/hwspinlock/hwspinlock_core.c:368:9: sparse:     got void [noderef] __rcu **
   drivers/hwspinlock/hwspinlock_core.c:368:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void **slot @@     got void [noderef] __rcu ** @@
   drivers/hwspinlock/hwspinlock_core.c:368:9: sparse:     expected void **slot
   drivers/hwspinlock/hwspinlock_core.c:368:9: sparse:     got void [noderef] __rcu **
>> drivers/hwspinlock/hwspinlock_core.c:369:26: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/hwspinlock/hwspinlock_core.c:369:26: sparse:    void [noderef] __rcu *
>> drivers/hwspinlock/hwspinlock_core.c:369:26: sparse:    void *
   drivers/hwspinlock/hwspinlock_core.c:98:5: sparse: sparse: context imbalance in '__hwspin_trylock' - different lock contexts for basic block
   drivers/hwspinlock/hwspinlock_core.c:296:39: sparse: sparse: context imbalance in '__hwspin_unlock' - unexpected unlock

vim +369 drivers/hwspinlock/hwspinlock_core.c

fb7737e949e31d Suman Anna      2015-03-04  331  
fb7737e949e31d Suman Anna      2015-03-04  332  /**
fb7737e949e31d Suman Anna      2015-03-04  333   * of_hwspin_lock_get_id() - get lock id for an OF phandle-based specific lock
fb7737e949e31d Suman Anna      2015-03-04  334   * @np: device node from which to request the specific hwlock
fb7737e949e31d Suman Anna      2015-03-04  335   * @index: index of the hwlock in the list of values
fb7737e949e31d Suman Anna      2015-03-04  336   *
fb7737e949e31d Suman Anna      2015-03-04  337   * This function provides a means for DT users of the hwspinlock module to
fb7737e949e31d Suman Anna      2015-03-04  338   * get the global lock id of a specific hwspinlock using the phandle of the
fb7737e949e31d Suman Anna      2015-03-04  339   * hwspinlock device, so that it can be requested using the normal
fb7737e949e31d Suman Anna      2015-03-04  340   * hwspin_lock_request_specific() API.
fb7737e949e31d Suman Anna      2015-03-04  341   *
fb7737e949e31d Suman Anna      2015-03-04  342   * Returns the global lock id number on success, -EPROBE_DEFER if the hwspinlock
fb7737e949e31d Suman Anna      2015-03-04  343   * device is not yet registered, -EINVAL on invalid args specifier value or an
fb7737e949e31d Suman Anna      2015-03-04  344   * appropriate error as returned from the OF parsing of the DT client node.
fb7737e949e31d Suman Anna      2015-03-04  345   */
fb7737e949e31d Suman Anna      2015-03-04  346  int of_hwspin_lock_get_id(struct device_node *np, int index)
fb7737e949e31d Suman Anna      2015-03-04  347  {
fb7737e949e31d Suman Anna      2015-03-04  348  	struct of_phandle_args args;
fb7737e949e31d Suman Anna      2015-03-04  349  	struct hwspinlock *hwlock;
fb7737e949e31d Suman Anna      2015-03-04  350  	struct radix_tree_iter iter;
fb7737e949e31d Suman Anna      2015-03-04  351  	void **slot;
fb7737e949e31d Suman Anna      2015-03-04  352  	int id;
fb7737e949e31d Suman Anna      2015-03-04  353  	int ret;
fb7737e949e31d Suman Anna      2015-03-04  354  
fb7737e949e31d Suman Anna      2015-03-04  355  	ret = of_parse_phandle_with_args(np, "hwlocks", "#hwlock-cells", index,
fb7737e949e31d Suman Anna      2015-03-04  356  					 &args);
fb7737e949e31d Suman Anna      2015-03-04  357  	if (ret)
fb7737e949e31d Suman Anna      2015-03-04  358  		return ret;
fb7737e949e31d Suman Anna      2015-03-04  359  
fbd7330c9fd8ef Fabien Dessenne 2019-03-08  360  	if (!of_device_is_available(args.np)) {
fbd7330c9fd8ef Fabien Dessenne 2019-03-08  361  		ret = -ENOENT;
fbd7330c9fd8ef Fabien Dessenne 2019-03-08  362  		goto out;
fbd7330c9fd8ef Fabien Dessenne 2019-03-08  363  	}
fbd7330c9fd8ef Fabien Dessenne 2019-03-08  364  
fb7737e949e31d Suman Anna      2015-03-04  365  	/* Find the hwspinlock device: we need its base_id */
fb7737e949e31d Suman Anna      2015-03-04  366  	ret = -EPROBE_DEFER;
fb7737e949e31d Suman Anna      2015-03-04  367  	rcu_read_lock();
fb7737e949e31d Suman Anna      2015-03-04 @368  	radix_tree_for_each_slot(slot, &hwspinlock_tree, &iter, 0) {
fb7737e949e31d Suman Anna      2015-03-04 @369  		hwlock = radix_tree_deref_slot(slot);
fb7737e949e31d Suman Anna      2015-03-04  370  		if (unlikely(!hwlock))
fb7737e949e31d Suman Anna      2015-03-04  371  			continue;
b76ba4af4ddd6a Matthew Wilcox  2016-05-20  372  		if (radix_tree_deref_retry(hwlock)) {
c6400ba7e13a41 Matthew Wilcox  2016-02-02  373  			slot = radix_tree_iter_retry(&iter);
c6400ba7e13a41 Matthew Wilcox  2016-02-02  374  			continue;
c6400ba7e13a41 Matthew Wilcox  2016-02-02  375  		}
fb7737e949e31d Suman Anna      2015-03-04  376  
fb7737e949e31d Suman Anna      2015-03-04  377  		if (hwlock->bank->dev->of_node == args.np) {
fb7737e949e31d Suman Anna      2015-03-04  378  			ret = 0;
fb7737e949e31d Suman Anna      2015-03-04  379  			break;
fb7737e949e31d Suman Anna      2015-03-04  380  		}
fb7737e949e31d Suman Anna      2015-03-04  381  	}
fb7737e949e31d Suman Anna      2015-03-04  382  	rcu_read_unlock();
fb7737e949e31d Suman Anna      2015-03-04  383  	if (ret < 0)
fb7737e949e31d Suman Anna      2015-03-04  384  		goto out;
fb7737e949e31d Suman Anna      2015-03-04  385  
fb7737e949e31d Suman Anna      2015-03-04  386  	id = of_hwspin_lock_simple_xlate(&args);
fb7737e949e31d Suman Anna      2015-03-04  387  	if (id < 0 || id >= hwlock->bank->num_locks) {
fb7737e949e31d Suman Anna      2015-03-04  388  		ret = -EINVAL;
fb7737e949e31d Suman Anna      2015-03-04  389  		goto out;
fb7737e949e31d Suman Anna      2015-03-04  390  	}
fb7737e949e31d Suman Anna      2015-03-04  391  	id += hwlock->bank->base_id;
fb7737e949e31d Suman Anna      2015-03-04  392  
fb7737e949e31d Suman Anna      2015-03-04  393  out:
fb7737e949e31d Suman Anna      2015-03-04  394  	of_node_put(args.np);
fb7737e949e31d Suman Anna      2015-03-04  395  	return ret ? ret : id;
fb7737e949e31d Suman Anna      2015-03-04  396  }
fb7737e949e31d Suman Anna      2015-03-04  397  EXPORT_SYMBOL_GPL(of_hwspin_lock_get_id);
fb7737e949e31d Suman Anna      2015-03-04  398  

:::::: The code at line 369 was first introduced by commit
:::::: fb7737e949e31d8a71acee6bbb670f32dbd2a2c0 hwspinlock/core: add device tree support

:::::: TO: Suman Anna <s-anna@ti.com>
:::::: CC: Ohad Ben-Cohen <ohad@wizery.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
