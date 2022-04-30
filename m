Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B2B515AA6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 07:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241295AbiD3FqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 01:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbiD3Fp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 01:45:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE66951339
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 22:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651297357; x=1682833357;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sesM0fAwJVPUfsHy9ICoPZ9At+Or+1+09s2UVnWWS80=;
  b=MDjpD41c4Q+0Uq+Fd48ABMHiU5r+CQG1ht2e47eMtgxzFwDi/zszHNh/
   eVpK/5qM5bqVGP+CTYozAoXwO0oWBRECwXpEn5qJy/dbtx6rZsSX8CG2N
   ishcPKAmRnpcUIV8IkDkqsOhsTJgmqDnSOB9QHgTUoMfR6rbvlEAwPXDY
   mxw0BoBQeDQhK2g1yFlhkd6z3wCAM7c72S9yHjcNNO6WvnMqcpdl5U7TJ
   wlLxsmPXoKDgDuLDZFV/mIivTWFG0HeuKGyHzZ23daG4lt4NWPeRPFbsY
   ol1WQxnZnHKw+MDkZLrCGDQDFi3V1HGqPNxi4iieUxzoiLMTR2iT4M+J0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="267001690"
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="267001690"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 22:42:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="732447099"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 29 Apr 2022 22:42:36 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkfsJ-0006uh-Cl;
        Sat, 30 Apr 2022 05:42:35 +0000
Date:   Sat, 30 Apr 2022 13:42:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:arm64/stacktrace/speedups 12/12]
 arch/arm64/kernel/stacktrace.c:66:13: error: 'tsk' undeclared
Message-ID: <202204301323.qB6x1Lyu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/stacktrace/speedups
head:   cdc18713d4c3bb71acf2a7fde076b8cf08975dfd
commit: cdc18713d4c3bb71acf2a7fde076b8cf08975dfd [12/12] WIP: rework stacktrace structure
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220430/202204301323.qB6x1Lyu-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=cdc18713d4c3bb71acf2a7fde076b8cf08975dfd
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark arm64/stacktrace/speedups
        git checkout cdc18713d4c3bb71acf2a7fde076b8cf08975dfd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/percpu.h:7,
                    from arch/arm64/include/asm/percpu.h:248,
                    from arch/arm64/include/asm/smp.h:28,
                    from include/linux/smp.h:113,
                    from include/linux/percpu.h:7,
                    from include/linux/context_tracking_state.h:5,
                    from include/linux/hardirq.h:5,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from arch/arm64/kernel/stacktrace.c:9:
   arch/arm64/include/asm/stacktrace.h: In function 'stackinfo_get_sdei_normal':
   arch/arm64/include/asm/stacktrace.h:122:57: error: 'sdei_stack_normal_ptr' undeclared (first use in this function)
     122 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
         |                                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:318:16: note: in definition of macro '__pcpu_size_call_return'
     318 |         typeof(variable) pscr_ret__;                                    \
         |                ^~~~~~~~
   arch/arm64/include/asm/stacktrace.h:122:44: note: in expansion of macro 'raw_cpu_read'
     122 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
         |                                            ^~~~~~~~~~~~
   arch/arm64/include/asm/stacktrace.h:122:57: note: each undeclared identifier is reported only once for each function it appears in
     122 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
         |                                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:318:16: note: in definition of macro '__pcpu_size_call_return'
     318 |         typeof(variable) pscr_ret__;                                    \
         |                ^~~~~~~~
   arch/arm64/include/asm/stacktrace.h:122:44: note: in expansion of macro 'raw_cpu_read'
     122 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
         |                                            ^~~~~~~~~~~~
   arch/arm64/include/asm/stacktrace.h: In function 'stackinfo_get_sdei_critical':
   arch/arm64/include/asm/stacktrace.h:134:57: error: 'sdei_stack_critical_ptr' undeclared (first use in this function); did you mean 'sdei_shadow_call_stack_critical_ptr'?
     134 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_critical_ptr);
         |                                                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:318:16: note: in definition of macro '__pcpu_size_call_return'
     318 |         typeof(variable) pscr_ret__;                                    \
         |                ^~~~~~~~
   arch/arm64/include/asm/stacktrace.h:134:44: note: in expansion of macro 'raw_cpu_read'
     134 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_critical_ptr);
         |                                            ^~~~~~~~~~~~
   arch/arm64/kernel/stacktrace.c: In function 'unwind_frame_record':
>> arch/arm64/kernel/stacktrace.c:66:13: error: 'tsk' undeclared (first use in this function)
      66 |         if (tsk->ret_stack &&
         |             ^~~


vim +/tsk +66 arch/arm64/kernel/stacktrace.c

b07f3499661c61 Mark Brown               2021-03-19  50  
592700f094be22 Mark Rutland             2019-07-02  51  /*
592700f094be22 Mark Rutland             2019-07-02  52   * Unwind from one frame record (A) to the next frame record (B).
592700f094be22 Mark Rutland             2019-07-02  53   *
592700f094be22 Mark Rutland             2019-07-02  54   * We terminate early if the location of B indicates a malformed chain of frame
592700f094be22 Mark Rutland             2019-07-02  55   * records (e.g. a cycle), determined based on the location and fp value of A
592700f094be22 Mark Rutland             2019-07-02  56   * and the location (but not the fp value) of B.
592700f094be22 Mark Rutland             2019-07-02  57   */
60ffc30d565281 Catalin Marinas          2012-03-05  58  
60ffc30d565281 Catalin Marinas          2012-03-05  59  
cdc18713d4c3bb Mark Rutland             2022-04-25  60  static notrace int unwind_frame_record(struct unwind_state *state,
cdc18713d4c3bb Mark Rutland             2022-04-25  61  				       stack_trace_consume_fn consume_entry, void *cookie)
cdc18713d4c3bb Mark Rutland             2022-04-25  62  {
90131eb350137d Madhavan T. Venkataraman 2022-01-17  63  	state->pc = ptrauth_strip_insn_pac(state->pc);
c6d3cd32fd0064 Mark Rutland             2021-10-29  64  
20380bb390a443 AKASHI Takahiro          2015-12-15  65  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
b5e7307d9d5a34 Mark Rutland             2016-09-23 @66  	if (tsk->ret_stack &&
90131eb350137d Madhavan T. Venkataraman 2022-01-17  67  		(state->pc == (unsigned long)return_to_handler)) {
c6d3cd32fd0064 Mark Rutland             2021-10-29  68  		unsigned long orig_pc;
20380bb390a443 AKASHI Takahiro          2015-12-15  69  		/*
20380bb390a443 AKASHI Takahiro          2015-12-15  70  		 * This is a case where function graph tracer has
20380bb390a443 AKASHI Takahiro          2015-12-15  71  		 * modified a return address (LR) in a stack frame
20380bb390a443 AKASHI Takahiro          2015-12-15  72  		 * to hook a function return.
20380bb390a443 AKASHI Takahiro          2015-12-15  73  		 * So replace it to an original value.
20380bb390a443 AKASHI Takahiro          2015-12-15  74  		 */
90131eb350137d Madhavan T. Venkataraman 2022-01-17  75  		orig_pc = ftrace_graph_ret_addr(tsk, NULL, state->pc,
90131eb350137d Madhavan T. Venkataraman 2022-01-17  76  						(void *)state->fp);
90131eb350137d Madhavan T. Venkataraman 2022-01-17  77  		if (WARN_ON_ONCE(state->pc == orig_pc))
a448276ce515c9 Steven Rostedt (VMware   2018-12-07  78) 			return -EINVAL;
90131eb350137d Madhavan T. Venkataraman 2022-01-17  79  		state->pc = orig_pc;
20380bb390a443 AKASHI Takahiro          2015-12-15  80  	}
20380bb390a443 AKASHI Takahiro          2015-12-15  81  #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
cd9bc2c9258816 Masami Hiramatsu         2021-10-21  82  #ifdef CONFIG_KRETPROBES
90131eb350137d Madhavan T. Venkataraman 2022-01-17  83  	if (is_kretprobe_trampoline(state->pc))
90131eb350137d Madhavan T. Venkataraman 2022-01-17  84  		state->pc = kretprobe_find_ret_addr(tsk, (void *)state->fp, &state->kr_cur);
cd9bc2c9258816 Masami Hiramatsu         2021-10-21  85  #endif
20380bb390a443 AKASHI Takahiro          2015-12-15  86  
cdc18713d4c3bb Mark Rutland             2022-04-25  87  	if (!consume_entry(cookie, state->pc))
cdc18713d4c3bb Mark Rutland             2022-04-25  88  		return -ENOENT;
cdc18713d4c3bb Mark Rutland             2022-04-25  89  
60ffc30d565281 Catalin Marinas          2012-03-05  90  	return 0;
60ffc30d565281 Catalin Marinas          2012-03-05  91  }
cdc18713d4c3bb Mark Rutland             2022-04-25  92  NOKPROBE_SYMBOL(unwind_frame_record);
60ffc30d565281 Catalin Marinas          2012-03-05  93  

:::::: The code at line 66 was first introduced by commit
:::::: b5e7307d9d5a340d2c9fabbe1cee137d4c682c71 arm64: fix dump_backtrace/unwind_frame with NULL tsk

:::::: TO: Mark Rutland <mark.rutland@arm.com>
:::::: CC: Will Deacon <will.deacon@arm.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
