Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE9C488393
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 13:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiAHMZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 07:25:57 -0500
Received: from mga11.intel.com ([192.55.52.93]:43746 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231879AbiAHMZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 07:25:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641644755; x=1673180755;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Qx2sqzFnTTldtcweI57wcHni6YKX+49IvQ0DGz4++6Q=;
  b=W29OGvH5wla8W2+1B6AYXbwMGJ0rnt+iZ3IWxk9BHJE4XM8B8opK/KKW
   cwh2rHsv54+kcGuwbiIXfGMGyjjlH4j5eJTLYxmGP/IEz88t9kYcCYG8V
   /QSWuvN0gXGlKRP8v8UkFIE0LT5FJy16XiGZOwsjFK8uWSq8sx2Crx1Bf
   fxYfcalNxW8d8cT2YtVQbOf8A8R4PsAhKVVKwgTj+iCfikPLa5cvUw80Y
   FbonEknUqHW2LPflcsFQIbC/fvwDrDjjZVWx73VH2TGToi8ugd4lvW6ws
   d9KJk9Uanh/JFfudyBfumvZdvUt99jtp7Svq1nT4C4vpmPx+uybvSOuaO
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="240561245"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="240561245"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 04:25:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="471588754"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 08 Jan 2022 04:25:53 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6AnB-0000cA-3F; Sat, 08 Jan 2022 12:25:53 +0000
Date:   Sat, 8 Jan 2022 20:25:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.01.04a 52/55] kernel/stop_machine.c:207:6:
 warning: variable 't' set but not used
Message-ID: <202201082041.wv0NluSe-lkp@intel.com>
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
config: s390-randconfig-r026-20220107 (https://download.01.org/0day-ci/archive/20220108/202201082041.wv0NluSe-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 32167bfe64a4c5dd4eb3f7a58e24f4cba76f5ac2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=5cd99ef59351bcdd73ce5412934fda67d0ca2a1c
        git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
        git fetch --no-tags paulmck-rcu dev.2022.01.04a
        git checkout 5cd99ef59351bcdd73ce5412934fda67d0ca2a1c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/stop_machine.c:207:6: warning: variable 't' set but not used [-Wunused-but-set-variable]
           u64 t;
               ^
   1 warning generated.


vim +/t +207 kernel/stop_machine.c

   201	
   202	static void dump_multi_cpu_stop_state(struct multi_stop_data *msdata, bool *firsttime)
   203	{
   204		struct cpu_stopper *stopper;
   205		unsigned long flags;
   206		int cpu;
 > 207		u64 t;
   208	
   209		tick_setup_sched_timer_dump();
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
