Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC6F4BD2AD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 00:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245291AbiBTXiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 18:38:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242396AbiBTXiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 18:38:21 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D6F6179
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 15:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645400279; x=1676936279;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0J1qnhL2r06oFihAUWB0V490m2FyYiNzPm2bPGFwsQw=;
  b=Q04BDtHBsvUcEK0fyVmTD2DvzSNiBnQp164dqgxnnO7p2vSgdCz+b6Lm
   ERAIYrLRxTEN62vQC40HJyyJ6Zj+LKVSpdipm0X15kHO4nkQj/G7yrCip
   hheRoG8z33IE1DN3rFz1KK6CMWCAOKIAQ6dzhC9L3eLfhWuYr4MyLnLgM
   JZKLApf2RmH8pFxMPXe5FP9WzopDPlcmvI7Ql1zt2cIJbnOHFy8At7IMD
   L6UIkAu7blENF0PNZfQC0F1dM9S+z4TahG/tN6oOfDFtSg7N2iC6FJmeA
   6EpzXCnPM4MG2rdNqKGyfo8kAXK89zKEkVofhA8Ps1/26nsYL6mcyj39x
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="248990259"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="248990259"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 15:37:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="638364122"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 20 Feb 2022 15:37:57 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLvm9-00011M-4G; Sun, 20 Feb 2022 23:37:57 +0000
Date:   Mon, 21 Feb 2022 07:37:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1782/2574] kernel/sched/core.c:9009:6:
 warning: no previous prototype for function 'idle_task_exit'
Message-ID: <202202210715.pKdyhau2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   39e8a0edc8fae20758051dadf7846849edc18b88
commit: b6902652b0ca92c05ba2a78dafaa1db83f232fe4 [1782/2574] headers/deps: Reorganize, clean up and optimize kernel/sched/sched.h dependencies
config: x86_64-randconfig-a003 (https://download.01.org/0day-ci/archive/20220221/202202210715.pKdyhau2-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=b6902652b0ca92c05ba2a78dafaa1db83f232fe4
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout b6902652b0ca92c05ba2a78dafaa1db83f232fe4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/sched/core.c:3645:6: warning: no previous prototype for function 'sched_set_stop_task' [-Wmissing-prototypes]
   void sched_set_stop_task(int cpu, struct task_struct *stop)
        ^
   kernel/sched/core.c:3645:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void sched_set_stop_task(int cpu, struct task_struct *stop)
   ^
   static 
   kernel/sched/core.c:5345:20: warning: no previous prototype for function 'task_sched_runtime' [-Wmissing-prototypes]
   unsigned long long task_sched_runtime(struct task_struct *p)
                      ^
   kernel/sched/core.c:5345:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   unsigned long long task_sched_runtime(struct task_struct *p)
   ^
   static 
>> kernel/sched/core.c:9009:6: warning: no previous prototype for function 'idle_task_exit' [-Wmissing-prototypes]
   void idle_task_exit(void)
        ^
   kernel/sched/core.c:9009:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void idle_task_exit(void)
   ^
   static 
>> kernel/sched/core.c:9242:5: warning: no previous prototype for function 'sched_cpu_activate' [-Wmissing-prototypes]
   int sched_cpu_activate(unsigned int cpu)
       ^
   kernel/sched/core.c:9242:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int sched_cpu_activate(unsigned int cpu)
   ^
   static 
>> kernel/sched/core.c:9286:5: warning: no previous prototype for function 'sched_cpu_deactivate' [-Wmissing-prototypes]
   int sched_cpu_deactivate(unsigned int cpu)
       ^
   kernel/sched/core.c:9286:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int sched_cpu_deactivate(unsigned int cpu)
   ^
   static 
>> kernel/sched/core.c:9359:5: warning: no previous prototype for function 'sched_cpu_starting' [-Wmissing-prototypes]
   int sched_cpu_starting(unsigned int cpu)
       ^
   kernel/sched/core.c:9359:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int sched_cpu_starting(unsigned int cpu)
   ^
   static 
>> kernel/sched/core.c:9380:5: warning: no previous prototype for function 'sched_cpu_wait_empty' [-Wmissing-prototypes]
   int sched_cpu_wait_empty(unsigned int cpu)
       ^
   kernel/sched/core.c:9380:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int sched_cpu_wait_empty(unsigned int cpu)
   ^
   static 
>> kernel/sched/core.c:9422:5: warning: no previous prototype for function 'sched_cpu_dying' [-Wmissing-prototypes]
   int sched_cpu_dying(unsigned int cpu)
       ^
   kernel/sched/core.c:9422:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int sched_cpu_dying(unsigned int cpu)
   ^
   static 
   kernel/sched/core.c:9445:13: warning: no previous prototype for function 'sched_init_smp' [-Wmissing-prototypes]
   void __init sched_init_smp(void)
               ^
   kernel/sched/core.c:9445:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init sched_init_smp(void)
   ^
   static 
   kernel/sched/core.c:9508:13: warning: no previous prototype for function 'per_task_init' [-Wmissing-prototypes]
   void __init per_task_init(void)
               ^
   kernel/sched/core.c:9508:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init per_task_init(void)
   ^
   static 
   kernel/sched/core.c:9517:13: warning: no previous prototype for function 'sched_init' [-Wmissing-prototypes]
   void __init sched_init(void)
               ^
   kernel/sched/core.c:9517:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init sched_init(void)
   ^
   static 
   kernel/sched/core.c:1852:1: warning: unused function 'uclamp_update_active' [-Wunused-function]
   uclamp_update_active(struct task_struct *p)
   ^
   12 warnings generated.


vim +/idle_task_exit +9009 kernel/sched/core.c

^1da177e4c3f41 kernel/sched.c      Linus Torvalds     2005-04-16  9003  
^1da177e4c3f41 kernel/sched.c      Linus Torvalds     2005-04-16  9004  #ifdef CONFIG_HOTPLUG_CPU
054b9108e01ef2 kernel/sched.c      Kirill Korotaev    2006-12-10  9005  /*
d1ccc66df8bfe3 kernel/sched/core.c Ingo Molnar        2017-02-01  9006   * Ensure that the idle task is using init_mm right before its CPU goes
48c5ccae88dcd9 kernel/sched.c      Peter Zijlstra     2010-11-13  9007   * offline.
054b9108e01ef2 kernel/sched.c      Kirill Korotaev    2006-12-10  9008   */
48c5ccae88dcd9 kernel/sched.c      Peter Zijlstra     2010-11-13 @9009  void idle_task_exit(void)
^1da177e4c3f41 kernel/sched.c      Linus Torvalds     2005-04-16  9010  {
48c5ccae88dcd9 kernel/sched.c      Peter Zijlstra     2010-11-13  9011  	struct mm_struct *mm = current->active_mm;
^1da177e4c3f41 kernel/sched.c      Linus Torvalds     2005-04-16  9012  
48c5ccae88dcd9 kernel/sched.c      Peter Zijlstra     2010-11-13  9013  	BUG_ON(cpu_online(smp_processor_id()));
bf2c59fce4074e kernel/sched/core.c Peter Zijlstra     2020-04-01  9014  	BUG_ON(current != this_rq()->idle);
e76bd8d9850c22 kernel/sched.c      Rusty Russell      2008-11-25  9015  
a53efe5ff88d02 kernel/sched/core.c Martin Schwidefsky 2012-10-26  9016  	if (mm != &init_mm) {
252d2a4117bc18 kernel/sched/core.c Andy Lutomirski    2017-06-09  9017  		switch_mm(mm, &init_mm, current);
a53efe5ff88d02 kernel/sched/core.c Martin Schwidefsky 2012-10-26  9018  		finish_arch_post_lock_switch();
a53efe5ff88d02 kernel/sched/core.c Martin Schwidefsky 2012-10-26  9019  	}
bf2c59fce4074e kernel/sched/core.c Peter Zijlstra     2020-04-01  9020  
bf2c59fce4074e kernel/sched/core.c Peter Zijlstra     2020-04-01  9021  	/* finish_cpu(), as ran on the BP, will clean up the active_mm state */
^1da177e4c3f41 kernel/sched.c      Linus Torvalds     2005-04-16  9022  }
^1da177e4c3f41 kernel/sched.c      Linus Torvalds     2005-04-16  9023  

:::::: The code at line 9009 was first introduced by commit
:::::: 48c5ccae88dcd989d9de507e8510313c6cbd352b sched: Simplify cpu-hot-unplug task migration

:::::: TO: Peter Zijlstra <a.p.zijlstra@chello.nl>
:::::: CC: Ingo Molnar <mingo@elte.hu>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
