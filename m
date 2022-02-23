Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B0C4C1C53
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244464AbiBWTh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240506AbiBWThR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:37:17 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0234344F1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645645008; x=1677181008;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mk3aN3pcpAB7oiE45QTenKkiA2nwTqBeLt06UaOynF4=;
  b=RfSy2R1h6wkwdBgDQJaF9p/RXNO+/sLVI7YqLam+X/KamdKTiun9gd5m
   6RoZT2JgQFq0Ru4zUah9b6aKCBIEGlE0lEcGUlRTuo313jd8ct4mQRNEi
   cRLyGWH7Lkx1+wO30xZzLF8JDZ5tWmJy0r+DgquGQRCJ9Ohj/SJ7hrolC
   a/sZaW2AInx5+Rgi0e4kQ5PaNorjDTiC/agdQaZcq0S9W5uH7z2/PdcEf
   KhzhzfHU0fq41C2Id10zttULtsIV074J571rZNmOay3XJ7DrTmbeNILPt
   Jq9WRATO03gdmHBMdUSl/3tavgIWjbaUUQYeideEtcpwUGU17hmDZeT6o
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="235573913"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="235573913"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 11:36:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="776797599"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 23 Feb 2022 11:36:45 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMxRM-0001kK-S2; Wed, 23 Feb 2022 19:36:44 +0000
Date:   Thu, 24 Feb 2022 03:35:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 571/2340]
 arch/s390/include/asm/preempt.h:110:42: error: implicit declaration of
 function 'task_thread_info'
Message-ID: <202202240337.1ug9UnXJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   97c5eeb4de3ad324ed2a4656b46465299cfd010a
commit: 32c0f4ef20d93c78fce830a2fe6cc83db8bb29d0 [571/2340] headers/deps: Move task->thread_info to per_task()
config: s390-randconfig-r044-20220223 (https://download.01.org/0day-ci/archive/20220224/202202240337.1ug9UnXJ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=32c0f4ef20d93c78fce830a2fe6cc83db8bb29d0
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 32c0f4ef20d93c78fce830a2fe6cc83db8bb29d0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:7:
   In file included from include/linux/hardirq.h:5:
   In file included from include/linux/context_tracking_state.h:5:
   In file included from include/linux/percpu.h:6:
   In file included from include/linux/smp.h:110:
   In file included from include/linux/preempt.h:78:
>> arch/s390/include/asm/preempt.h:110:42: error: implicit declaration of function 'task_thread_info' [-Werror,-Wimplicit-function-declaration]
           return !--S390_lowcore.preempt_count && tif_need_resched();
                                                   ^
   include/linux/sched/thread_info_api_lowlevel.h:103:28: note: expanded from macro 'tif_need_resched'
   #define tif_need_resched() test_thread_flag(TIF_NEED_RESCHED)
                              ^
   include/linux/sched/thread_info_api_lowlevel.h:64:22: note: expanded from macro 'test_thread_flag'
           test_ti_thread_flag(current_thread_info(), flag)
                               ^
   include/linux/thread_info.h:26:32: note: expanded from macro 'current_thread_info'
   # define current_thread_info() task_thread_info(current)
                                  ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:7:
   In file included from include/linux/hardirq.h:5:
   In file included from include/linux/context_tracking_state.h:5:
   In file included from include/linux/percpu.h:6:
   In file included from include/linux/smp.h:110:
   In file included from include/linux/preempt.h:78:
>> arch/s390/include/asm/preempt.h:110:42: warning: incompatible integer to pointer conversion passing 'int' to parameter of type 'struct thread_info *' [-Wint-conversion]
           return !--S390_lowcore.preempt_count && tif_need_resched();
                                                   ^~~~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api_lowlevel.h:103:28: note: expanded from macro 'tif_need_resched'
   #define tif_need_resched() test_thread_flag(TIF_NEED_RESCHED)
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api_lowlevel.h:64:22: note: expanded from macro 'test_thread_flag'
           test_ti_thread_flag(current_thread_info(), flag)
                               ^~~~~~~~~~~~~~~~~~~~~
   include/linux/thread_info.h:26:32: note: expanded from macro 'current_thread_info'
   # define current_thread_info() task_thread_info(current)
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api_lowlevel.h:39:59: note: passing argument to parameter 'ti' here
   static inline int test_ti_thread_flag(struct thread_info *ti, int flag)
                                                             ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:7:
   In file included from include/linux/hardirq.h:5:
   In file included from include/linux/context_tracking_state.h:5:
   In file included from include/linux/percpu.h:6:
   In file included from include/linux/smp.h:110:
   In file included from include/linux/preempt.h:78:
   arch/s390/include/asm/preempt.h:116:4: error: implicit declaration of function 'task_thread_info' [-Werror,-Wimplicit-function-declaration]
                           tif_need_resched());
                           ^
   include/linux/sched/thread_info_api_lowlevel.h:103:28: note: expanded from macro 'tif_need_resched'
   #define tif_need_resched() test_thread_flag(TIF_NEED_RESCHED)
                              ^
   include/linux/sched/thread_info_api_lowlevel.h:64:22: note: expanded from macro 'test_thread_flag'
           test_ti_thread_flag(current_thread_info(), flag)
                               ^
   include/linux/thread_info.h:26:32: note: expanded from macro 'current_thread_info'
   # define current_thread_info() task_thread_info(current)
                                  ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:7:
   In file included from include/linux/hardirq.h:5:
   In file included from include/linux/context_tracking_state.h:5:
   In file included from include/linux/percpu.h:6:
   In file included from include/linux/smp.h:110:
   In file included from include/linux/preempt.h:78:
   arch/s390/include/asm/preempt.h:116:4: warning: incompatible integer to pointer conversion passing 'int' to parameter of type 'struct thread_info *' [-Wint-conversion]
                           tif_need_resched());
                           ^~~~~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api_lowlevel.h:103:28: note: expanded from macro 'tif_need_resched'
   #define tif_need_resched() test_thread_flag(TIF_NEED_RESCHED)
                              ^
   include/linux/sched/thread_info_api_lowlevel.h:64:22: note: expanded from macro 'test_thread_flag'
           test_ti_thread_flag(current_thread_info(), flag)
                               ^
   include/linux/thread_info.h:26:32: note: expanded from macro 'current_thread_info'
   # define current_thread_info() task_thread_info(current)
                                  ^
   include/linux/compiler.h:48:41: note: expanded from macro 'unlikely'
   #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
                            ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:33:34: note: expanded from macro '__branch_check__'
                           ______r = __builtin_expect(!!(x), expect);      \
                                                         ^
   include/linux/sched/thread_info_api_lowlevel.h:39:59: note: passing argument to parameter 'ti' here
   static inline int test_ti_thread_flag(struct thread_info *ti, int flag)
                                                             ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:7:
   In file included from include/linux/hardirq.h:5:
   In file included from include/linux/context_tracking_state.h:5:
   In file included from include/linux/percpu.h:6:
   In file included from include/linux/smp.h:110:
   In file included from include/linux/preempt.h:78:
   arch/s390/include/asm/preempt.h:116:4: warning: incompatible integer to pointer conversion passing 'int' to parameter of type 'struct thread_info *' [-Wint-conversion]
                           tif_need_resched());
                           ^~~~~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api_lowlevel.h:103:28: note: expanded from macro 'tif_need_resched'
   #define tif_need_resched() test_thread_flag(TIF_NEED_RESCHED)
                              ^
   include/linux/sched/thread_info_api_lowlevel.h:64:22: note: expanded from macro 'test_thread_flag'
           test_ti_thread_flag(current_thread_info(), flag)
                               ^
   include/linux/thread_info.h:26:32: note: expanded from macro 'current_thread_info'
   # define current_thread_info() task_thread_info(current)
                                  ^
   include/linux/compiler.h:48:68: note: expanded from macro 'unlikely'
   #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   include/linux/compiler.h:35:19: note: expanded from macro '__branch_check__'
                                                expect, is_constant);      \
                                                        ^~~~~~~~~~~
   include/linux/sched/thread_info_api_lowlevel.h:39:59: note: passing argument to parameter 'ti' here
   static inline int test_ti_thread_flag(struct thread_info *ti, int flag)
                                                             ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:7:
   In file included from include/linux/hardirq.h:9:
   In file included from include/linux/sched.h:12:
   include/linux/sched/per_task.h:48:11: fatal error: 'generated/asm-offsets.h' file not found
   # include <generated/asm-offsets.h>
             ^~~~~~~~~~~~~~~~~~~~~~~~~
   3 warnings and 3 errors generated.
   make[2]: *** [scripts/Makefile.build:121: arch/s390/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1191: prepare0] Error 2


vim +/task_thread_info +110 arch/s390/include/asm/preempt.h

c360192bf4a8dc Martin Schwidefsky 2016-10-25  107  
c360192bf4a8dc Martin Schwidefsky 2016-10-25  108  static inline bool __preempt_count_dec_and_test(void)
c360192bf4a8dc Martin Schwidefsky 2016-10-25  109  {
c360192bf4a8dc Martin Schwidefsky 2016-10-25 @110  	return !--S390_lowcore.preempt_count && tif_need_resched();
c360192bf4a8dc Martin Schwidefsky 2016-10-25  111  }
c360192bf4a8dc Martin Schwidefsky 2016-10-25  112  

:::::: The code at line 110 was first introduced by commit
:::::: c360192bf4a8dc72f102dd6a4e1bf8bd0b404cfa s390/preempt: move preempt_count to the lowcore

:::::: TO: Martin Schwidefsky <schwidefsky@de.ibm.com>
:::::: CC: Martin Schwidefsky <schwidefsky@de.ibm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
