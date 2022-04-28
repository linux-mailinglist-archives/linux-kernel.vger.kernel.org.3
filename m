Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0A85135C5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347789AbiD1N4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235821AbiD1Nz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:55:57 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6A6B42DA
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651153962; x=1682689962;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fHe2c0I+/bm/Zyv3YNuPcJLhU2ZLFZXztJWRk1LD5rU=;
  b=n0gAV5lU8/Zy+9pvcvj4Iaacy13Mgq3TXhI30hpQS3jDPkSxuaRoeJ+p
   B16YYamlnIX3+i+bpoA+6Wo1nbNTSzdWsHCq3/oC4De07jT+ywSxBW5YH
   t36bulSxJLsRRXYyJLBZxc2ngNVKZQ7G8fWEcUOKjZimfFqH+nj8wbYYs
   XEba8xrC2GgGEZWErehnPuJMANHbqo+6PUyLI2T1sAIvph8t1fH6hr1tb
   P/xfhEMTDjB+S7zmV78CbJZbAgxbZTCE8wfKUxMKvxY8Oc4WxSQhK6hRl
   X+Fty2WW3cjx3TKpTizhmJZzDFBTT7Mo538B7i1XqZAh/xzBvJtMAirVW
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="266110024"
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="266110024"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 06:52:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="533890957"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Apr 2022 06:52:40 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nk4ZT-0005Q5-Pv;
        Thu, 28 Apr 2022 13:52:39 +0000
Date:   Thu, 28 Apr 2022 21:52:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/fixes 1/5] include/linux/kallsyms.h:166:19: error:
 static declaration of 'kallsyms_on_each_symbol' follows non-static
 declaration
Message-ID: <202204282157.sMS0vx7Y-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/fixes
head:   35597ce11b848ee8a696d54223d1f7b64cb49cb2
commit: 280f76918c82441cbe72620287fa24cbb7f74353 [1/5] kallsyms: Fully export kallsyms_on_each_symbol function
config: nios2-randconfig-r023-20220428 (https://download.01.org/0day-ci/archive/20220428/202204282157.sMS0vx7Y-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=280f76918c82441cbe72620287fa24cbb7f74353
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/fixes
        git checkout 280f76918c82441cbe72620287fa24cbb7f74353
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/ftrace.h:13,
                    from include/linux/perf_event.h:51,
                    from drivers/tty/sysrq.c:35:
>> include/linux/kallsyms.h:166:19: error: static declaration of 'kallsyms_on_each_symbol' follows non-static declaration
     166 | static inline int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *, unsigned long),
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/ftrace.h:13,
                    from include/linux/perf_event.h:51,
                    from drivers/tty/sysrq.c:35:
   include/linux/kallsyms.h:68:5: note: previous declaration of 'kallsyms_on_each_symbol' with type 'int(int (*)(void *, const char *, struct module *, long unsigned int), void *)'
      68 | int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/sysrq.c:412:34: warning: 'sysrq_thaw_op' defined but not used [-Wunused-const-variable=]
     412 | static const struct sysrq_key_op sysrq_thaw_op = {
         |                                  ^~~~~~~~~~~~~
--
   In file included from include/linux/ftrace.h:13,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from drivers/char/random.c:52:
>> include/linux/kallsyms.h:166:19: error: static declaration of 'kallsyms_on_each_symbol' follows non-static declaration
     166 | static inline int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *, unsigned long),
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/ftrace.h:13,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from drivers/char/random.c:52:
   include/linux/kallsyms.h:68:5: note: previous declaration of 'kallsyms_on_each_symbol' with type 'int(int (*)(void *, const char *, struct module *, long unsigned int), void *)'
      68 | int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
         |     ^~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/ftrace.h:13,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from init/main.c:21:
>> include/linux/kallsyms.h:166:19: error: static declaration of 'kallsyms_on_each_symbol' follows non-static declaration
     166 | static inline int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *, unsigned long),
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/ftrace.h:13,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from init/main.c:21:
   include/linux/kallsyms.h:68:5: note: previous declaration of 'kallsyms_on_each_symbol' with type 'int(int (*)(void *, const char *, struct module *, long unsigned int), void *)'
      68 | int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   init/main.c:769:20: warning: no previous prototype for 'arch_post_acpi_subsys_init' [-Wmissing-prototypes]
     769 | void __init __weak arch_post_acpi_subsys_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   init/main.c:781:20: warning: no previous prototype for 'mem_encrypt_init' [-Wmissing-prototypes]
     781 | void __init __weak mem_encrypt_init(void) { }
         |                    ^~~~~~~~~~~~~~~~
   init/main.c:783:20: warning: no previous prototype for 'poking_init' [-Wmissing-prototypes]
     783 | void __init __weak poking_init(void) { }
         |                    ^~~~~~~~~~~
--
   In file included from include/linux/ftrace.h:13,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from arch/nios2/kernel/sys_nios2.c:15:
>> include/linux/kallsyms.h:166:19: error: static declaration of 'kallsyms_on_each_symbol' follows non-static declaration
     166 | static inline int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *, unsigned long),
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/ftrace.h:13,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from arch/nios2/kernel/sys_nios2.c:15:
   include/linux/kallsyms.h:68:5: note: previous declaration of 'kallsyms_on_each_symbol' with type 'int(int (*)(void *, const char *, struct module *, long unsigned int), void *)'
      68 | int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   arch/nios2/kernel/sys_nios2.c:21:16: warning: no previous prototype for 'sys_cacheflush' [-Wmissing-prototypes]
      21 | asmlinkage int sys_cacheflush(unsigned long addr, unsigned long len,
         |                ^~~~~~~~~~~~~~
   arch/nios2/kernel/sys_nios2.c:57:16: warning: no previous prototype for 'sys_getpagesize' [-Wmissing-prototypes]
      57 | asmlinkage int sys_getpagesize(void)
         |                ^~~~~~~~~~~~~~~
--
   In file included from include/linux/ftrace.h:13,
                    from include/linux/kprobes.h:28,
                    from include/linux/kgdb.h:19,
                    from arch/nios2/kernel/kgdb.c:12:
>> include/linux/kallsyms.h:166:19: error: static declaration of 'kallsyms_on_each_symbol' follows non-static declaration
     166 | static inline int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *, unsigned long),
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/ftrace.h:13,
                    from include/linux/kprobes.h:28,
                    from include/linux/kgdb.h:19,
                    from arch/nios2/kernel/kgdb.c:12:
   include/linux/kallsyms.h:68:5: note: previous declaration of 'kallsyms_on_each_symbol' with type 'int(int (*)(void *, const char *, struct module *, long unsigned int), void *)'
      68 | int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   arch/nios2/kernel/kgdb.c:130:17: warning: no previous prototype for 'kgdb_breakpoint_c' [-Wmissing-prototypes]
     130 | asmlinkage void kgdb_breakpoint_c(struct pt_regs *regs)
         |                 ^~~~~~~~~~~~~~~~~
--
   In file included from include/linux/ftrace.h:13,
                    from include/linux/perf_event.h:51,
                    from arch/nios2/mm/fault.c:27:
>> include/linux/kallsyms.h:166:19: error: static declaration of 'kallsyms_on_each_symbol' follows non-static declaration
     166 | static inline int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *, unsigned long),
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/ftrace.h:13,
                    from include/linux/perf_event.h:51,
                    from arch/nios2/mm/fault.c:27:
   include/linux/kallsyms.h:68:5: note: previous declaration of 'kallsyms_on_each_symbol' with type 'int(int (*)(void *, const char *, struct module *, long unsigned int), void *)'
      68 | int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   arch/nios2/mm/fault.c:43:17: warning: no previous prototype for 'do_page_fault' [-Wmissing-prototypes]
      43 | asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long cause,
         |                 ^~~~~~~~~~~~~
--
   In file included from include/linux/ftrace.h:13,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from kernel/fork.c:55:
>> include/linux/kallsyms.h:166:19: error: static declaration of 'kallsyms_on_each_symbol' follows non-static declaration
     166 | static inline int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *, unsigned long),
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/ftrace.h:13,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from kernel/fork.c:55:
   include/linux/kallsyms.h:68:5: note: previous declaration of 'kallsyms_on_each_symbol' with type 'int(int (*)(void *, const char *, struct module *, long unsigned int), void *)'
      68 | int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:163:13: warning: no previous prototype for 'arch_release_task_struct' [-Wmissing-prototypes]
     163 | void __weak arch_release_task_struct(struct task_struct *tsk)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:853:20: warning: no previous prototype for 'arch_task_cache_init' [-Wmissing-prototypes]
     853 | void __init __weak arch_task_cache_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:948:12: warning: no previous prototype for 'arch_dup_task_struct' [-Wmissing-prototypes]
     948 | int __weak arch_dup_task_struct(struct task_struct *dst,
         |            ^~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/ftrace.h:13,
                    from include/linux/kprobes.h:28,
                    from include/linux/kgdb.h:19,
                    from kernel/panic.c:15:
>> include/linux/kallsyms.h:166:19: error: static declaration of 'kallsyms_on_each_symbol' follows non-static declaration
     166 | static inline int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *, unsigned long),
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/ftrace.h:13,
                    from include/linux/kprobes.h:28,
                    from include/linux/kgdb.h:19,
                    from kernel/panic.c:15:
   include/linux/kallsyms.h:68:5: note: previous declaration of 'kallsyms_on_each_symbol' with type 'int(int (*)(void *, const char *, struct module *, long unsigned int), void *)'
      68 | int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/panic.c: In function '__warn':
   kernel/panic.c:591:17: warning: function '__warn' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     591 |                 vprintk(args->fmt, args->args);
         |                 ^~~~~~~
--
   In file included from include/linux/ftrace.h:13,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from kernel/exit.c:42:
>> include/linux/kallsyms.h:166:19: error: static declaration of 'kallsyms_on_each_symbol' follows non-static declaration
     166 | static inline int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *, unsigned long),
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/ftrace.h:13,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from kernel/exit.c:42:
   include/linux/kallsyms.h:68:5: note: previous declaration of 'kallsyms_on_each_symbol' with type 'int(int (*)(void *, const char *, struct module *, long unsigned int), void *)'
      68 | int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/exit.c:1814:13: warning: no previous prototype for 'abort' [-Wmissing-prototypes]
    1814 | __weak void abort(void)
         |             ^~~~~
--
   In file included from include/linux/ftrace.h:13,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from include/linux/syscalls_api.h:1,
                    from kernel/sched/core.c:13:
>> include/linux/kallsyms.h:166:19: error: static declaration of 'kallsyms_on_each_symbol' follows non-static declaration
     166 | static inline int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *, unsigned long),
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/ftrace.h:13,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from include/linux/syscalls_api.h:1,
                    from kernel/sched/core.c:13:
   include/linux/kallsyms.h:68:5: note: previous declaration of 'kallsyms_on_each_symbol' with type 'int(int (*)(void *, const char *, struct module *, long unsigned int), void *)'
      68 | int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:5235:20: warning: no previous prototype for 'task_sched_runtime' [-Wmissing-prototypes]
    5235 | unsigned long long task_sched_runtime(struct task_struct *p)
         |                    ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:9420:13: warning: no previous prototype for 'sched_init_smp' [-Wmissing-prototypes]
    9420 | void __init sched_init_smp(void)
         |             ^~~~~~~~~~~~~~
   kernel/sched/core.c:9448:13: warning: no previous prototype for 'sched_init' [-Wmissing-prototypes]
    9448 | void __init sched_init(void)
         |             ^~~~~~~~~~
--
   In file included from include/linux/ftrace.h:13,
                    from include/linux/livepatch.h:13,
                    from kernel/sched/build_policy.c:23:
>> include/linux/kallsyms.h:166:19: error: static declaration of 'kallsyms_on_each_symbol' follows non-static declaration
     166 | static inline int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *, unsigned long),
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/ftrace.h:13,
                    from include/linux/livepatch.h:13,
                    from kernel/sched/build_policy.c:23:
   include/linux/kallsyms.h:68:5: note: previous declaration of 'kallsyms_on_each_symbol' with type 'int(int (*)(void *, const char *, struct module *, long unsigned int), void *)'
      68 | int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/sched/build_policy.c:43:
   kernel/sched/rt.c:666:6: warning: no previous prototype for 'sched_rt_bandwidth_account' [-Wmissing-prototypes]
     666 | bool sched_rt_bandwidth_account(struct rt_rq *rt_rq)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
..


vim +/kallsyms_on_each_symbol +166 include/linux/kallsyms.h

   165	
 > 166	static inline int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *, unsigned long),
   167						  void *data)
   168	{
   169		return -EOPNOTSUPP;
   170	}
   171	#endif /*CONFIG_KALLSYMS*/
   172	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
