Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264B5509846
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385248AbiDUGt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385173AbiDUGrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:47:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AC41572D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523436; x=1682059436;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Iz05hkzh046AFXyvV17QUF1THEeOgPBiNmH1Mg45MDM=;
  b=UnKTkZXVK/eMi1td7PWUDfZUJlScQ2eDy4wYIhZjp7f4/LETV7B9CfOt
   sP7sRblCZC/GUXZfET1dSb3vVdLXzOGb5vsU+7bMGlWxyyGgTy5I38cFo
   1w1oBPU7b75cAIh1d4t8AOXBFm+QYcrTgQc9BPpFRk32ag54T/miASQEp
   GtercIPJrhAySFjgvdWbdJvKNnz7RRdSqe7ScCaRav/9Vsceq4oY6UR98
   CzVUJ2V7qOlIVoOlwi6fyaTipb+Z8FU26r6HaMV7TpMFXgVw93j37UD1c
   uJObyi7egsIu7sl7hZyZ7M+gIqTIPLpQhPwxtZmhLIWqgUqlUdoNgSxe7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="350704801"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="350704801"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:43:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="805384268"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 20 Apr 2022 23:43:51 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQXe-00080d-Ue;
        Thu, 21 Apr 2022 06:43:50 +0000
Date:   Thu, 21 Apr 2022 14:43:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1820/2579] kernel/signal.c:190:6: error:
 implicit declaration of function 'cgroup_task_frozen' is invalid in C99
Message-ID: <202204210613.DeyJT7kn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: ec8ca2d8ef76b4edd4dc7e12899b5ff5e64657a5 [1820/2579] headers/deps: cgroups: Remove the <linux/cgroup_api.h> header from the default <linux/cgroup.h> header
config: mips-randconfig-r026-20220419 (https://download.01.org/0day-ci/archive/20220421/202204210613.DeyJT7kn-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c1c49a356162b22554088d269f7689bdb044a9f1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=ec8ca2d8ef76b4edd4dc7e12899b5ff5e64657a5
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout ec8ca2d8ef76b4edd4dc7e12899b5ff5e64657a5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/signal.c:190:6: error: implicit declaration of function 'cgroup_task_frozen' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
               cgroup_task_frozen(t)) {
               ^
>> kernel/signal.c:2325:3: error: implicit declaration of function 'cgroup_enter_frozen' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   cgroup_enter_frozen();
                   ^
>> kernel/signal.c:2328:3: error: implicit declaration of function 'cgroup_leave_frozen' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   cgroup_leave_frozen(true);
                   ^
   kernel/signal.c:2328:3: note: did you mean 'cgroup_enter_frozen'?
   kernel/signal.c:2325:3: note: 'cgroup_enter_frozen' declared here
                   cgroup_enter_frozen();
                   ^
   kernel/signal.c:2516:3: error: implicit declaration of function 'cgroup_enter_frozen' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   cgroup_enter_frozen();
                   ^
   kernel/signal.c:2595:2: error: implicit declaration of function 'cgroup_enter_frozen' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           cgroup_enter_frozen();
           ^
   kernel/signal.c:2763:16: error: implicit declaration of function 'cgroup_task_frozen' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   if (unlikely(cgroup_task_frozen(current))) {
                                ^
   kernel/signal.c:2765:4: error: implicit declaration of function 'cgroup_leave_frozen' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                           cgroup_leave_frozen(false);
                           ^
   kernel/signal.c:2865:4: error: implicit declaration of function 'cgroup_leave_frozen' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                           cgroup_leave_frozen(true);
                           ^
   8 errors generated.


vim +/cgroup_task_frozen +190 kernel/signal.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  184  
09ae854edb2d27 Christian Brauner 2018-08-21  185  static bool recalc_sigpending_tsk(struct task_struct *t)
^1da177e4c3f41 Linus Torvalds    2005-04-16  186  {
76f969e8948d82 Roman Gushchin    2019-04-19  187  	if ((t->jobctl & (JOBCTL_PENDING_MASK | JOBCTL_TRAP_FREEZE)) ||
6616e4593f1b57 Ingo Molnar       2022-01-28  188  	    PENDING(&per_task(t, pending), &per_task(t, blocked)) ||
ec2f4babb822f7 Ingo Molnar       2022-01-28  189  	    PENDING(&t->signal->shared_pending, &per_task(t, blocked)) ||
76f969e8948d82 Roman Gushchin    2019-04-19 @190  	    cgroup_task_frozen(t)) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  191  		set_tsk_thread_flag(t, TIF_SIGPENDING);
09ae854edb2d27 Christian Brauner 2018-08-21  192  		return true;
7bb44adef39ad3 Roland McGrath    2007-05-23  193  	}
09ae854edb2d27 Christian Brauner 2018-08-21  194  
b74d0deb968e1f Roland McGrath    2007-06-06  195  	/*
b74d0deb968e1f Roland McGrath    2007-06-06  196  	 * We must never clear the flag in another thread, or in current
b74d0deb968e1f Roland McGrath    2007-06-06  197  	 * when it's possible the current syscall is returning -ERESTART*.
b74d0deb968e1f Roland McGrath    2007-06-06  198  	 * So we don't clear it here, and only callers who know they should do.
b74d0deb968e1f Roland McGrath    2007-06-06  199  	 */
09ae854edb2d27 Christian Brauner 2018-08-21  200  	return false;
7bb44adef39ad3 Roland McGrath    2007-05-23  201  }
7bb44adef39ad3 Roland McGrath    2007-05-23  202  

:::::: The code at line 190 was first introduced by commit
:::::: 76f969e8948d82e78e1bc4beb6b9465908e74873 cgroup: cgroup v2 freezer

:::::: TO: Roman Gushchin <guro@fb.com>
:::::: CC: Tejun Heo <tj@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
