Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2B24C04F5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 00:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbiBVXAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 18:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiBVXAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 18:00:34 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E5E261D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645570808; x=1677106808;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OmeWRV5IimFQ4Dk3oyvxyAAuxAGhWAT3d6jpO9rVn7s=;
  b=ib8/amGv6WRRCv01SWqw2Ftmu63shVEMUXnOF0j2QAlI/QQv057HfL/F
   gQ3malG5jiYAynkiPcw/ipH8SMyjNr8DUIHagdbTQciw9/aNR6mdtzAfR
   39K3CPOOKfC42UFFjoXyAnOJ0qVL352Py0x0QzHOUHQ2bgFs639iwQk38
   0ji8bcZ2s7cVjvlbkYGmyZc/FKPZ3Fsl7yHJegmDOv3Uouvnit2lPjKmv
   GSC/ojnY+gODCaVVc4CNu4QvZlw2y+4mL/LYblWP4bLFDAXt/w3C55EDc
   7YDSts+9UvbLYibrZNZtLnpk2yhR+7LHq0lXZNQ1oc0iLyVlx8tom6v7O
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="338269430"
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="338269430"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 15:00:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="683690224"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Feb 2022 15:00:06 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMe8c-0000hz-99; Tue, 22 Feb 2022 23:00:06 +0000
Date:   Wed, 23 Feb 2022 06:59:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2300/2324]
 drivers/hwtracing/coresight/coresight-syscfg.c:383:15: error: implicit
 declaration of function 'try_module_get'
Message-ID: <202202230657.yONGvBnm-lkp@intel.com>
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

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   7d9efc989eceed6a8fa475a186880ec4a1ad54a3
commit: b6ac2dbb891219be5e264504adb69b35c95647a8 [2300/2324] headers/deps: driver/core: Optimize <linux/device/driver.h> dependencies, remove <linux/module.h> inclusion
config: arm64-buildonly-randconfig-r006-20220221 (https://download.01.org/0day-ci/archive/20220223/202202230657.yONGvBnm-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=b6ac2dbb891219be5e264504adb69b35c95647a8
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout b6ac2dbb891219be5e264504adb69b35c95647a8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/hwtracing/coresight/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/arm64/include/asm/current.h:5,
                    from include/linux/preempt.h:10,
                    from include/linux/spinlock_api.h:55,
                    from drivers/hwtracing/coresight/coresight-syscfg.c:7:
   drivers/hwtracing/coresight/coresight-syscfg.c: In function 'cscfg_owner_get':
>> drivers/hwtracing/coresight/coresight-syscfg.c:383:15: error: implicit declaration of function 'try_module_get' [-Werror=implicit-function-declaration]
     383 |             (!try_module_get(owner_info->owner_handle)))
         |               ^~~~~~~~~~~~~~
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   drivers/hwtracing/coresight/coresight-syscfg.c:382:9: note: in expansion of macro 'if'
     382 |         if ((owner_info->type == CSCFG_OWNER_MODULE) &&
         |         ^~
   drivers/hwtracing/coresight/coresight-syscfg.c: In function 'cscfg_owner_put':
>> drivers/hwtracing/coresight/coresight-syscfg.c:392:17: error: implicit declaration of function 'module_put' [-Werror=implicit-function-declaration]
     392 |                 module_put(owner_info->owner_handle);
         |                 ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/try_module_get +383 drivers/hwtracing/coresight/coresight-syscfg.c

a13d5a246aca17 Mike Leach 2021-08-18  374  
eb2ec49606c2a0 Mike Leach 2021-11-24  375  /*
eb2ec49606c2a0 Mike Leach 2021-11-24  376   * Conditionally up reference count on owner to prevent unload.
eb2ec49606c2a0 Mike Leach 2021-11-24  377   *
eb2ec49606c2a0 Mike Leach 2021-11-24  378   * module loaded configs need to be locked in to prevent premature unload.
eb2ec49606c2a0 Mike Leach 2021-11-24  379   */
eb2ec49606c2a0 Mike Leach 2021-11-24  380  static int cscfg_owner_get(struct cscfg_load_owner_info *owner_info)
eb2ec49606c2a0 Mike Leach 2021-11-24  381  {
eb2ec49606c2a0 Mike Leach 2021-11-24  382  	if ((owner_info->type == CSCFG_OWNER_MODULE) &&
eb2ec49606c2a0 Mike Leach 2021-11-24 @383  	    (!try_module_get(owner_info->owner_handle)))
eb2ec49606c2a0 Mike Leach 2021-11-24  384  		return -EINVAL;
eb2ec49606c2a0 Mike Leach 2021-11-24  385  	return 0;
eb2ec49606c2a0 Mike Leach 2021-11-24  386  }
eb2ec49606c2a0 Mike Leach 2021-11-24  387  
eb2ec49606c2a0 Mike Leach 2021-11-24  388  /* conditionally lower ref count on an owner */
eb2ec49606c2a0 Mike Leach 2021-11-24  389  static void cscfg_owner_put(struct cscfg_load_owner_info *owner_info)
eb2ec49606c2a0 Mike Leach 2021-11-24  390  {
eb2ec49606c2a0 Mike Leach 2021-11-24  391  	if (owner_info->type == CSCFG_OWNER_MODULE)
eb2ec49606c2a0 Mike Leach 2021-11-24 @392  		module_put(owner_info->owner_handle);
eb2ec49606c2a0 Mike Leach 2021-11-24  393  }
eb2ec49606c2a0 Mike Leach 2021-11-24  394  

:::::: The code at line 383 was first introduced by commit
:::::: eb2ec49606c2a02d6382d56a0e19f34e515fde3f coresight: syscfg: Update load API for config loadable modules

:::::: TO: Mike Leach <mike.leach@linaro.org>
:::::: CC: Mathieu Poirier <mathieu.poirier@linaro.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
