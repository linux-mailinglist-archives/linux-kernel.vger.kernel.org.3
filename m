Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C0C490C3D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240901AbiAQQMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:12:49 -0500
Received: from mga14.intel.com ([192.55.52.115]:57300 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240900AbiAQQMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:12:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642435968; x=1673971968;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EFYuPuJvdHi/G8K17mY0fNgWIkokW505n/J2iNCmH/g=;
  b=KRlEj6Zzh2JAQtnBXvtVmnnV/Axl18GPgm0dmmrX6f16yRA88GX00248
   tp8PxZuAePSsBhFjKm7d2hcskCzSpCYhA242Of8WCem2pWxx35v/qTBk8
   a/tR0lLSUPiwLU9NMP3/x+WNX3b+Ultgqago6MZ6xevdCPczfBaISenH+
   u3qqQl5JyRAXi73Os4MVnX/TMoBCkfL6jmvpUH8qS62gL6AIzzOjESppG
   1lbyXtt8pb173PXAsqNnR6rx5vEkqFmZ0AlaWy+4crnnI0tMp1ccUWEPP
   RxvMNH/cQA8X4Rl/TsCvirRxelmziGOZ6Ba715K6VUiMawTXaPV409st5
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="244849899"
X-IronPort-AV: E=Sophos;i="5.88,295,1635231600"; 
   d="scan'208";a="244849899"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 08:11:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,295,1635231600"; 
   d="scan'208";a="517461043"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 17 Jan 2022 08:11:38 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9Uba-000Bh2-2M; Mon, 17 Jan 2022 16:11:38 +0000
Date:   Tue, 18 Jan 2022 00:10:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 111/2384]
 include/linux/thread_info.h:68:20: error: redefinition of 'set_restart_fn'
Message-ID: <202201180017.awOuzVzR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   4c707c1c0de83967079b4e385012fa5b00e2cd11
commit: 7d7e24a8155b9ee4b8c93b14489476ce906788d3 [111/2384] headers/deps: kernel: Split <linux/restart_block.h> into <linux/restart_block_types.h> and <linux/restart_block_api.h>
config: i386-randconfig-a014-20220109 (https://download.01.org/0day-ci/archive/20220118/202201180017.awOuzVzR-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5f782d25a742302d25ef3c8b84b54f7483c2deb9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=7d7e24a8155b9ee4b8c93b14489476ce906788d3
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 7d7e24a8155b9ee4b8c93b14489476ce906788d3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the mingo-tip/sched/headers HEAD 4c707c1c0de83967079b4e385012fa5b00e2cd11 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/asm-offsets.c:9:
   In file included from arch/x86/kernel/../../../kernel/sched/per_task_area_struct.h:7:
   In file included from include/linux/sched.h:17:
   In file included from include/linux/rbtree.h:24:
   In file included from include/linux/rcupdate.h:27:
   In file included from include/linux/preempt.h:78:
   In file included from arch/x86/include/asm/preempt.h:7:
>> include/linux/thread_info.h:68:20: error: redefinition of 'set_restart_fn'
   static inline long set_restart_fn(struct restart_block *restart,
                      ^
   include/linux/restart_block_api.h:23:20: note: previous definition is here
   static inline long set_restart_fn(struct restart_block *restart,
                      ^
   In file included from arch/x86/kernel/asm-offsets.c:34:
   arch/x86/kernel/../../../kernel/sched/per_task_area_struct_defs.h:13:13: warning: no previous prototype for function 'per_task_common' [-Wmissing-prototypes]
   void __used per_task_common(void)
               ^
   arch/x86/kernel/../../../kernel/sched/per_task_area_struct_defs.h:13:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __used per_task_common(void)
   ^
   static 
   1 warning and 1 error generated.
   make[2]: *** [scripts/Makefile.build:121: arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1197: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/set_restart_fn +68 include/linux/thread_info.h

5abbe51a526253 Oleg Nesterov 2021-02-01  67  
5abbe51a526253 Oleg Nesterov 2021-02-01 @68  static inline long set_restart_fn(struct restart_block *restart,
5abbe51a526253 Oleg Nesterov 2021-02-01  69  					long (*fn)(struct restart_block *))
5abbe51a526253 Oleg Nesterov 2021-02-01  70  {
5abbe51a526253 Oleg Nesterov 2021-02-01  71  	restart->fn = fn;
5abbe51a526253 Oleg Nesterov 2021-02-01  72  	arch_set_restart_data(restart);
5abbe51a526253 Oleg Nesterov 2021-02-01  73  	return -ERESTART_RESTARTBLOCK;
5abbe51a526253 Oleg Nesterov 2021-02-01  74  }
5abbe51a526253 Oleg Nesterov 2021-02-01  75  

:::::: The code at line 68 was first introduced by commit
:::::: 5abbe51a526253b9f003e9a0a195638dc882d660 kernel, fs: Introduce and use set_restart_fn() and arch_set_restart_data()

:::::: TO: Oleg Nesterov <oleg@redhat.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
