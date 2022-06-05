Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966EA53DCDE
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 18:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351184AbiFEQKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 12:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbiFEQKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 12:10:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2561BEB9
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 09:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654445450; x=1685981450;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Vv3THXUiMqKA3QW7kmHGz6TVaZ6mHvUQEH7PyKoPAIs=;
  b=WbHB+ONBgMiantzs+2it30z9KLx1k3GOn765hth0/XxeFnezo4Qq2Rr5
   2kYvBA5m1eNO9e7jRLjd5i6ztL1HG4usAz38Rhl+YEWgvUSHke1tonvv0
   UAOI0xal/7Jl20UP+MNbI/U6i5wmj5UFCa/iWkzdakUkF0Kq4Dchh5XVy
   AKZSrlMwtsIn9J/+l4rcnjijIkJny5rP5CKHWgL81QYqMufuymXN+vjZe
   8gFuzETGvvkJPWsBI2oDvXUF38tgWfIwde6rJwsIgFV9LuOqJ1qkdjBUn
   nn8duEV7HvD831ESDJLGDwEzjuwDUlOE3aZQUVxpLrNHUL9xwBcWKVnUU
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="276353520"
X-IronPort-AV: E=Sophos;i="5.91,279,1647327600"; 
   d="scan'208";a="276353520"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 09:10:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,279,1647327600"; 
   d="scan'208";a="613971474"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 05 Jun 2022 09:10:48 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxsq0-000C2f-2Z;
        Sun, 05 Jun 2022 16:10:48 +0000
Date:   Mon, 6 Jun 2022 00:10:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:sched/idle 27/33] include/linux/thread_info.h:182:16:
 error: implicit declaration of function 'arch_test_bit'; did you mean
 'test_bit'?
Message-ID: <202206060037.oU7dxd19-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/idle
head:   5aca393851ce7ebb9a3405bb4ffd4f38d96949e4
commit: bb0533e97a1f03b96874efacec607cffb5fa7a3a [27/33] cpuidle,sched: Remove annotations from TIF_{POLLING_NRFLAG,NEED_RESCHED}
config: ia64-buildonly-randconfig-r002-20220605 (https://download.01.org/0day-ci/archive/20220606/202206060037.oU7dxd19-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=bb0533e97a1f03b96874efacec607cffb5fa7a3a
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue sched/idle
        git checkout bb0533e97a1f03b96874efacec607cffb5fa7a3a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=ia64 prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/preempt.h:5,
                    from ./arch/ia64/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rculist.h:11,
                    from include/linux/sched/signal.h:5,
                    from arch/ia64/kernel/asm-offsets.c:10:
   include/linux/thread_info.h: In function 'tif_need_resched':
>> include/linux/thread_info.h:182:16: error: implicit declaration of function 'arch_test_bit'; did you mean 'test_bit'? [-Werror=implicit-function-declaration]
     182 |         return arch_test_bit(TIF_NEED_RESCHED,
         |                ^~~~~~~~~~~~~
         |                test_bit
   arch/ia64/kernel/asm-offsets.c: At top level:
   arch/ia64/kernel/asm-offsets.c:23:6: warning: no previous prototype for 'foo' [-Wmissing-prototypes]
      23 | void foo(void)
         |      ^~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:121: arch/ia64/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1196: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +182 include/linux/thread_info.h

   179	
   180	static __always_inline bool tif_need_resched(void)
   181	{
 > 182		return arch_test_bit(TIF_NEED_RESCHED,
   183				     (unsigned long *)(&current_thread_info()->flags));
   184	}
   185	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
