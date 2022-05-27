Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4A0536935
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 01:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355179AbiE0Xlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 19:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355155AbiE0XlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 19:41:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9E1B1E9
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 16:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653694881; x=1685230881;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DyHYUP0eMBKDXeZ8DPCN5gb/ahXDmU6YjnjDnB5h0kI=;
  b=ggvc/kWh07q3D6xHMTCTVBmWcBcnIvhDOcL7/trAQ2t4eEZg7McHrQH5
   m+jRWjtChsyppTG/V2ySG8MkutSnppoNivCooi4zZzDoQeNq3Ie+RFgJo
   TDr+0au9uGrUDJrJEPaD6JNHaxDyTDjNkbyb2XmhJlj/sGHCehTKMd4Fb
   cQ8Ps8qSXzXRkFO4TvT8zALnBG34Kk9pkZMabaST9dtJ6ZUs0PGB9ECyq
   9U+EcAxjLEXeeJq2Mwr1iU3D1NCcskv2AIY6osQDkm6U5qiaYBC7m3cAo
   OtS5XihpjvT/hCUAm7a2Lr2PxycAjnwIHuzXGMdQXF4pYRRbwghs/S6om
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="274698929"
X-IronPort-AV: E=Sophos;i="5.91,257,1647327600"; 
   d="scan'208";a="274698929"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 16:41:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,257,1647327600"; 
   d="scan'208";a="561009804"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 27 May 2022 16:41:19 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuja3-0005E7-4n;
        Fri, 27 May 2022 23:41:19 +0000
Date:   Sat, 28 May 2022 07:40:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: arch/arm64/kernel/signal.c:663:43: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202205280710.c7k1K4sD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bf272460d744112bacd4c4d562592decbf0edf64
commit: a1f4ccd25cc256255813f584f10e5527369d4a02 arm64/sme: Provide Kconfig for SME
date:   5 weeks ago
config: arm64-randconfig-s032-20220527 (https://download.01.org/0day-ci/archive/20220528/202205280710.c7k1K4sD-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-14-g5a0004b5-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a1f4ccd25cc256255813f584f10e5527369d4a02
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a1f4ccd25cc256255813f584f10e5527369d4a02
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/arm64/kernel/signal.c:663:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct user_ctxs [noderef] __user *user @@     got struct user_ctxs * @@
   arch/arm64/kernel/signal.c:663:43: sparse:     expected struct user_ctxs [noderef] __user *user
   arch/arm64/kernel/signal.c:663:43: sparse:     got struct user_ctxs *
   arch/arm64/kernel/signal.c:933:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void ( [noderef] [usertype] __user *[assigned] [usertype] sigtramp )( ... ) @@     got void * @@
   arch/arm64/kernel/signal.c:933:26: sparse:     expected void ( [noderef] [usertype] __user *[assigned] [usertype] sigtramp )( ... )
   arch/arm64/kernel/signal.c:933:26: sparse:     got void *
>> arch/arm64/kernel/signal.c:394:35: sparse: sparse: dereference of noderef expression
>> arch/arm64/kernel/signal.c:394:35: sparse: sparse: dereference of noderef expression
   arch/arm64/kernel/signal.c:428:53: sparse: sparse: dereference of noderef expression
   arch/arm64/kernel/signal.c:428:53: sparse: sparse: dereference of noderef expression

vim +663 arch/arm64/kernel/signal.c

47ccb02868cead Dave Martin      2017-06-15  620  
2c020ed8d148f7 Catalin Marinas  2012-03-05  621  static int restore_sigframe(struct pt_regs *regs,
2c020ed8d148f7 Catalin Marinas  2012-03-05  622  			    struct rt_sigframe __user *sf)
2c020ed8d148f7 Catalin Marinas  2012-03-05  623  {
2c020ed8d148f7 Catalin Marinas  2012-03-05  624  	sigset_t set;
2c020ed8d148f7 Catalin Marinas  2012-03-05  625  	int i, err;
47ccb02868cead Dave Martin      2017-06-15  626  	struct user_ctxs user;
2c020ed8d148f7 Catalin Marinas  2012-03-05  627  
2c020ed8d148f7 Catalin Marinas  2012-03-05  628  	err = __copy_from_user(&set, &sf->uc.uc_sigmask, sizeof(set));
2c020ed8d148f7 Catalin Marinas  2012-03-05  629  	if (err == 0)
2c020ed8d148f7 Catalin Marinas  2012-03-05  630  		set_current_blocked(&set);
2c020ed8d148f7 Catalin Marinas  2012-03-05  631  
2c020ed8d148f7 Catalin Marinas  2012-03-05  632  	for (i = 0; i < 31; i++)
2c020ed8d148f7 Catalin Marinas  2012-03-05  633  		__get_user_error(regs->regs[i], &sf->uc.uc_mcontext.regs[i],
2c020ed8d148f7 Catalin Marinas  2012-03-05  634  				 err);
2c020ed8d148f7 Catalin Marinas  2012-03-05  635  	__get_user_error(regs->sp, &sf->uc.uc_mcontext.sp, err);
2c020ed8d148f7 Catalin Marinas  2012-03-05  636  	__get_user_error(regs->pc, &sf->uc.uc_mcontext.pc, err);
2c020ed8d148f7 Catalin Marinas  2012-03-05  637  	__get_user_error(regs->pstate, &sf->uc.uc_mcontext.pstate, err);
2c020ed8d148f7 Catalin Marinas  2012-03-05  638  
2c020ed8d148f7 Catalin Marinas  2012-03-05  639  	/*
2c020ed8d148f7 Catalin Marinas  2012-03-05  640  	 * Avoid sys_rt_sigreturn() restarting.
2c020ed8d148f7 Catalin Marinas  2012-03-05  641  	 */
17c28958600928 Dave Martin      2017-08-01  642  	forget_syscall(regs);
2c020ed8d148f7 Catalin Marinas  2012-03-05  643  
dbd4d7ca563fd0 Mark Rutland     2016-03-01  644  	err |= !valid_user_regs(&regs->user_regs, current);
47ccb02868cead Dave Martin      2017-06-15  645  	if (err == 0)
47ccb02868cead Dave Martin      2017-06-15  646  		err = parse_user_sigframe(&user, sf);
2c020ed8d148f7 Catalin Marinas  2012-03-05  647  
6d502b6ba1b267 Suzuki K Poulose 2020-01-13  648  	if (err == 0 && system_supports_fpsimd()) {
8cd969d28fd284 Dave Martin      2017-10-31  649  		if (!user.fpsimd)
8cd969d28fd284 Dave Martin      2017-10-31  650  			return -EINVAL;
8cd969d28fd284 Dave Martin      2017-10-31  651  
8cd969d28fd284 Dave Martin      2017-10-31  652  		if (user.sve) {
8cd969d28fd284 Dave Martin      2017-10-31  653  			if (!system_supports_sve())
8cd969d28fd284 Dave Martin      2017-10-31  654  				return -EINVAL;
8cd969d28fd284 Dave Martin      2017-10-31  655  
8cd969d28fd284 Dave Martin      2017-10-31  656  			err = restore_sve_fpsimd_context(&user);
8cd969d28fd284 Dave Martin      2017-10-31  657  		} else {
47ccb02868cead Dave Martin      2017-06-15  658  			err = restore_fpsimd_context(user.fpsimd);
8cd969d28fd284 Dave Martin      2017-10-31  659  		}
8cd969d28fd284 Dave Martin      2017-10-31  660  	}
2c020ed8d148f7 Catalin Marinas  2012-03-05  661  
39782210eb7e87 Mark Brown       2022-04-19  662  	if (err == 0 && system_supports_sme() && user.za)
39782210eb7e87 Mark Brown       2022-04-19 @663  		err = restore_za_context(&user);
39782210eb7e87 Mark Brown       2022-04-19  664  
2c020ed8d148f7 Catalin Marinas  2012-03-05  665  	return err;
2c020ed8d148f7 Catalin Marinas  2012-03-05  666  }
2c020ed8d148f7 Catalin Marinas  2012-03-05  667  

:::::: The code at line 663 was first introduced by commit
:::::: 39782210eb7e87634d96cacb6ece370bc59d74ba arm64/sme: Implement ZA signal handling

:::::: TO: Mark Brown <broonie@kernel.org>
:::::: CC: Catalin Marinas <catalin.marinas@arm.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
