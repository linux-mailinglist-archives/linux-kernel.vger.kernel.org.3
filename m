Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5589B4882C2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 10:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbiAHJVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 04:21:52 -0500
Received: from mga02.intel.com ([134.134.136.20]:61959 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231347AbiAHJVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 04:21:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641633711; x=1673169711;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eGmDA91vw1cAP61EA0OaUm/Oee1N6LqneZ+nBrptQVM=;
  b=DVB2Gg0yvLnKAgwj8mHTCNa7PwBCZ5f4W6We2q+zHDk2N5wJc0OuQEg5
   aGOGSsUlhQXMvTYkSP+M7MFJhFCY45W9MK58yiwrebnavoqw30jcJMZwD
   FzAdcx8S4N20qLacL8/hqkaj1gwL715U6T61R+zf9PMe+zfODimN4Bqoy
   oSGWZjVvI4ieOq7r0oSJHZ5mXk9onzYWaZM6FOjxXc2qDpcNpBNs8mTxv
   yVxECjZ+mFKaMK1GOyoPoXyPItQmBP2emyMyNp0rnXb3xfl0xLJddlKq9
   Bwn/7W7AMw9iSrjFl7oI2ZnTzhaDPIeMquJeRaUXk6MoO5Qxp/Qaq2D/D
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="230342663"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="230342663"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 01:21:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="473608112"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Jan 2022 01:21:50 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n67v3-0000Sx-Bl; Sat, 08 Jan 2022 09:21:49 +0000
Date:   Sat, 8 Jan 2022 17:21:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.01.04a 52/55] kernel/stop_machine.c:207:13:
 warning: variable 't' set but not used
Message-ID: <202201081735.gNXE7dpe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.01.04a
head:   64595d0dff992756e8c6d53c0e9f1e3e50c451f7
commit: 5cd99ef59351bcdd73ce5412934fda67d0ca2a1c [52/55] EXP timers: NMI stacktraces for last-resort jiffies update
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220108/202201081735.gNXE7dpe-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=5cd99ef59351bcdd73ce5412934fda67d0ca2a1c
        git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
        git fetch --no-tags paulmck-rcu dev.2022.01.04a
        git checkout 5cd99ef59351bcdd73ce5412934fda67d0ca2a1c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/stop_machine.c: In function 'dump_multi_cpu_stop_state':
   kernel/stop_machine.c:209:9: error: implicit declaration of function 'tick_setup_sched_timer_dump' [-Werror=implicit-function-declaration]
     209 |         tick_setup_sched_timer_dump();
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/stop_machine.c:207:13: warning: variable 't' set but not used [-Wunused-but-set-variable]
     207 |         u64 t;
         |             ^
   kernel/stop_machine.c: In function 'multi_cpu_stop':
   kernel/stop_machine.c:288:21: error: implicit declaration of function 'cpu_hp_check_delay' [-Werror=implicit-function-declaration]
     288 |                     cpu_hp_check_delay("MULTI_STOP_RUN in", multi_cpu_stop))
         |                     ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/t +207 kernel/stop_machine.c

   201	
   202	static void dump_multi_cpu_stop_state(struct multi_stop_data *msdata, bool *firsttime)
   203	{
   204		struct cpu_stopper *stopper;
   205		unsigned long flags;
   206		int cpu;
 > 207		u64 t;
   208	
 > 209		tick_setup_sched_timer_dump();
   210		pr_info("%s threads %d/%d state %d\n", __func__, atomic_read(&msdata->thread_ack), msdata->num_threads, msdata->state);
   211		for_each_online_cpu(cpu) {
   212			if (cpu_is_offline(cpu))
   213				continue;
   214			stopper = &per_cpu(cpu_stopper, cpu);
   215			raw_spin_lock_irqsave(&stopper->lock, flags);
   216			t = ktime_get();
   217	//		tlast = stopper->lasttime;
   218			pr_info("%s: %s%s ->state=%#x%s\n", __func__, stopper->thread->comm, stopper->thread == current ? " (me)" : "", stopper->thread->__state, task_curr(stopper->thread) ? "" : " Not running!");
   219			raw_spin_unlock_irqrestore(&stopper->lock, flags);
   220			if (firsttime && *firsttime && !task_curr(stopper->thread)) {
   221				trigger_single_cpu_backtrace(cpu);
   222				*firsttime = false;
   223			}
   224	//		if (time_after64(t, tlast + NSEC_PER_SEC) &&
   225	//		    smp_load_acquire(&multi_stop_cpu_ipi_handled)) {
   226	//			pr_info("%s: sending IPI from CPU %d to CPU %d\n", __func__, raw_smp_processor_id(), cpu);
   227	//			WRITE_ONCE(multi_stop_cpu_ipi_handled, false);
   228	//			smp_mb();
   229	//			smp_call_function_single(cpu, multi_stop_cpu_ipi, NULL, 0);
   230	//		}
   231		}
   232	}
   233	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
