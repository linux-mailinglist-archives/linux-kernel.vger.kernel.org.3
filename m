Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C8B4DC002
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 08:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiCQHM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 03:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiCQHMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:12:51 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB1C16A698
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 00:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647501095; x=1679037095;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0nRXy9gODoW5iD619RVbr29Ns5KlgGZx/6Y1CsdPbdo=;
  b=D1c32EDG4wpS3ok522wzAhF5wKnmsi76z8LpziksCnCoBk+NdTNfFKzp
   wJ7iUHNLkGLYCqRMdDSFNklKdSbMgsFLHTOxFSF66TcdhtPfjzcTk82Ee
   xLEwz6JIyIikhjSd1RmJZ8q+duqAKA4ow4QKv9IpBPG34MLcBVu/8fvXr
   A9orr95vgYI75JNa/qOC2lLWdjkxIPobQvmzSoj72OL7bPvDtlZeGt6j4
   zXVyJV8oTUUWfVlBvzKzYGqpwMCmTdz47HjFIC/sp6NgbUDavEJPwzbLq
   wdpLFbeG1S8uV9AMa8pfaPtWcnTD2kATlt2AHUmbvmgV+CsUqMFc4C+6K
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="281589514"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="281589514"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 00:11:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="516657638"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 17 Mar 2022 00:11:33 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUkIG-000DQN-MJ; Thu, 17 Mar 2022 07:11:33 +0000
Date:   Thu, 17 Mar 2022 15:10:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 558/2335] arch/s390/include/asm/preempt.h:110:42:
 error: implicit declaration of function 'task_thread_info'
Message-ID: <202203171524.ipsveLi5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: fc65f6666073b489472bc5f3625d1f90d3dde51f [558/2335] headers/deps: Move task->thread_info to per_task()
config: s390-randconfig-r032-20220317 (https://download.01.org/0day-ci/archive/20220317/202203171524.ipsveLi5-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6ec1e3d798f8eab43fb3a91028c6ab04e115fcb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=fc65f6666073b489472bc5f3625d1f90d3dde51f
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout fc65f6666073b489472bc5f3625d1f90d3dde51f
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
   include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
   # define unlikely(x)    __builtin_expect(!!(x), 0)
                                               ^
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
   2 warnings and 3 errors generated.
   make[2]: *** [scripts/Makefile.build:121: arch/s390/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1191: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/task_thread_info +110 arch/s390/include/asm/preempt.h

c360192bf4a8dc7 Martin Schwidefsky 2016-10-25  107  
c360192bf4a8dc7 Martin Schwidefsky 2016-10-25  108  static inline bool __preempt_count_dec_and_test(void)
c360192bf4a8dc7 Martin Schwidefsky 2016-10-25  109  {
c360192bf4a8dc7 Martin Schwidefsky 2016-10-25 @110  	return !--S390_lowcore.preempt_count && tif_need_resched();
c360192bf4a8dc7 Martin Schwidefsky 2016-10-25  111  }
c360192bf4a8dc7 Martin Schwidefsky 2016-10-25  112  

:::::: The code at line 110 was first introduced by commit
:::::: c360192bf4a8dc72f102dd6a4e1bf8bd0b404cfa s390/preempt: move preempt_count to the lowcore

:::::: TO: Martin Schwidefsky <schwidefsky@de.ibm.com>
:::::: CC: Martin Schwidefsky <schwidefsky@de.ibm.com>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
