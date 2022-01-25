Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BB349ADD2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 09:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378151AbiAYIJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:09:50 -0500
Received: from mga09.intel.com ([134.134.136.24]:4093 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377688AbiAYIHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:07:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643098057; x=1674634057;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f/MmS7BcnzhNlHP7hghAd7De16m3GvOpG6gtGsW7xqI=;
  b=Oq4efrf6gl4Ru+pZTvVabefOXhZDMP3n8Ep+KiUxFjR0zi0hvrkgiJhC
   B+due6PZ+qiRW9buLG9gRHEM+RJbHDcTMVfNwI23Dhwp8/c/Zd3rZz7Qq
   s6zzjB5HLygnyB9CGYdXjcfT4L/6QI8EyM2YFi6J3eQ0HkKVw9l4T+Yog
   m8r+Ca1S6I7pyPzhZm4hULBN+D+tr35Xh+BexfNwowyP9R0Ij8GJo9XW5
   e2+uglvC/AGD2PhZgI0AdH/U7BIswQsH2Ng105tZjMIW5SW4kR99eK/gI
   moiGXX4tfkdceE10TDeXEm6dDg/wcjuMdtdKDiOMKfljKqqjIsBzz9Ne9
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="246029891"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="246029891"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 00:07:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="562959458"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 Jan 2022 00:07:31 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCGrS-000JYs-LB; Tue, 25 Jan 2022 08:07:30 +0000
Date:   Tue, 25 Jan 2022 16:07:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [kees:for-next/array-bounds 9/10]
 arch/m68k/include/asm/cmpxchg.h:64:17: warning: array subscript 'volatile
 struct __xchg_dummy[0]' is partly outside array bounds of 'atomic_t[1]'
Message-ID: <202201251648.VyzfPvSk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/array-bounds
head:   3ccac0d2ba34a8e6f722975136f06c30fb586ca0
commit: 4ba545781e20f49cf1175e11d9f606e621040acf [9/10] Makefile: Enable -Warray-bounds
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220125/202201251648.VyzfPvSk-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=4ba545781e20f49cf1175e11d9f606e621040acf
        git remote add kees https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
        git fetch --no-tags kees for-next/array-bounds
        git checkout 4ba545781e20f49cf1175e11d9f606e621040acf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash block/ drivers/accessibility/speakup/ drivers/infiniband/sw/siw/ kernel/rcu/ mm/ net/ipv4/ net/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/m68k/include/asm/atomic.h:7,
                    from include/linux/atomic.h:7,
                    from include/linux/cpumask.h:13,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:10,
                    from mm/swap_state.c:10:
   mm/swap_state.c: In function 'swap_cluster_readahead':
>> arch/m68k/include/asm/cmpxchg.h:64:17: warning: array subscript 'volatile struct __xchg_dummy[0]' is partly outside array bounds of 'atomic_t[1]' [-Warray-bounds]
      64 |                 __asm__ __volatile__
         |                 ^~~~~~~
   mm/swap_state.c:71:17: note: while referencing 'swapin_readahead_hits'
      71 | static atomic_t swapin_readahead_hits = ATOMIC_INIT(4);
         |                 ^~~~~~~~~~~~~~~~~~~~~
--
   In file included from arch/m68k/include/asm/atomic.h:7,
                    from include/linux/atomic.h:7,
                    from include/linux/mm_types_task.h:13,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from kernel/rcu/rcutorture.c:18:
   kernel/rcu/rcutorture.c: In function 'rcu_torture_stats_print':
>> arch/m68k/include/asm/cmpxchg.h:64:17: warning: array subscript 'volatile struct __xchg_dummy[0]' is partly outside array bounds of 'atomic_t[1]' [-Warray-bounds]
      64 |                 __asm__ __volatile__
         |                 ^~~~~~~
   In file included from kernel/rcu/rcutorture.c:51:
   kernel/rcu/rcu.h:254:25: note: while referencing '___rfd_beenhere'
     254 |         static atomic_t ___rfd_beenhere = ATOMIC_INIT(0); \
         |                         ^~~~~~~~~~~~~~~
   kernel/rcu/rcutorture.c:1915:17: note: in expansion of macro 'rcu_ftrace_dump'
    1915 |                 rcu_ftrace_dump(DUMP_ALL);
         |                 ^~~~~~~~~~~~~~~
   In file included from arch/m68k/include/asm/atomic.h:7,
                    from include/linux/atomic.h:7,
                    from include/linux/mm_types_task.h:13,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from kernel/rcu/rcutorture.c:18:
   kernel/rcu/rcutorture.c: In function 'rcu_torture_writer':
>> arch/m68k/include/asm/cmpxchg.h:64:17: warning: array subscript 'volatile struct __xchg_dummy[0]' is partly outside array bounds of 'atomic_t[1]' [-Warray-bounds]
      64 |                 __asm__ __volatile__
         |                 ^~~~~~~
   In file included from kernel/rcu/rcutorture.c:51:
   kernel/rcu/rcu.h:254:25: note: while referencing '___rfd_beenhere'
     254 |         static atomic_t ___rfd_beenhere = ATOMIC_INIT(0); \
         |                         ^~~~~~~~~~~~~~~
   kernel/rcu/rcutorture.c:1287:41: note: in expansion of macro 'rcu_ftrace_dump'
    1287 |                                         rcu_ftrace_dump(DUMP_ALL);
         |                                         ^~~~~~~~~~~~~~~
   In file included from arch/m68k/include/asm/atomic.h:7,
                    from include/linux/atomic.h:7,
                    from include/linux/mm_types_task.h:13,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from kernel/rcu/rcutorture.c:18:
   kernel/rcu/rcutorture.c: In function 'rcu_torture_fwd_prog':
>> arch/m68k/include/asm/cmpxchg.h:64:17: warning: array subscript 'volatile struct __xchg_dummy[0]' is partly outside array bounds of 'atomic_long_t[1]' {aka 'atomic_t[1]'} [-Warray-bounds]
      64 |                 __asm__ __volatile__
         |                 ^~~~~~~
   kernel/rcu/rcutorture.c:2170:22: note: while referencing 'rcu_fwd_max_cbs'
    2170 | static atomic_long_t rcu_fwd_max_cbs;
         |                      ^~~~~~~~~~~~~~~
   In file included from arch/m68k/include/asm/atomic.h:7,
                    from include/linux/atomic.h:7,
                    from include/linux/mm_types_task.h:13,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from kernel/rcu/rcutorture.c:18:
   kernel/rcu/rcutorture.c: In function 'rcu_torture_one_read':
>> arch/m68k/include/asm/cmpxchg.h:64:17: warning: array subscript 'volatile struct __xchg_dummy[0]' is partly outside array bounds of 'atomic_t[1]' [-Warray-bounds]
      64 |                 __asm__ __volatile__
         |                 ^~~~~~~
   In file included from kernel/rcu/rcutorture.c:51:
   kernel/rcu/rcu.h:254:25: note: while referencing '___rfd_beenhere'
     254 |         static atomic_t ___rfd_beenhere = ATOMIC_INIT(0); \
         |                         ^~~~~~~~~~~~~~~
   kernel/rcu/rcutorture.c:1650:17: note: in expansion of macro 'rcu_ftrace_dump'
    1650 |                 rcu_ftrace_dump(DUMP_ALL);
         |                 ^~~~~~~~~~~~~~~
   In file included from arch/m68k/include/asm/atomic.h:7,
                    from include/linux/atomic.h:7,
                    from include/linux/mm_types_task.h:13,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from kernel/rcu/rcutorture.c:18:
>> arch/m68k/include/asm/cmpxchg.h:64:17: warning: array subscript 'volatile struct __xchg_dummy[0]' is partly outside array bounds of 'int[1]' [-Warray-bounds]
      64 |                 __asm__ __volatile__
         |                 ^~~~~~~
   kernel/rcu/rcutorture.c:241:12: note: while referencing 'err_segs_recorded'
     241 | static int err_segs_recorded;
         |            ^~~~~~~~~~~~~~~~~
--
   In file included from arch/m68k/include/asm/atomic.h:7,
                    from include/linux/atomic.h:7,
                    from include/linux/cpumask.h:13,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:10,
                    from kernel/rcu/rcuscale.c:15:
   kernel/rcu/rcuscale.c: In function 'rcu_scale_writer':
>> arch/m68k/include/asm/cmpxchg.h:64:17: warning: array subscript 'volatile struct __xchg_dummy[0]' is partly outside array bounds of 'atomic_t[1]' [-Warray-bounds]
      64 |                 __asm__ __volatile__
         |                 ^~~~~~~
   In file included from kernel/rcu/rcuscale.c:43:
   kernel/rcu/rcu.h:254:25: note: while referencing '___rfd_beenhere'
     254 |         static atomic_t ___rfd_beenhere = ATOMIC_INIT(0); \
         |                         ^~~~~~~~~~~~~~~
   kernel/rcu/rcuscale.c:464:33: note: in expansion of macro 'rcu_ftrace_dump'
     464 |                                 rcu_ftrace_dump(DUMP_ALL);
         |                                 ^~~~~~~~~~~~~~~
--
   In file included from arch/m68k/include/asm/atomic.h:7,
                    from include/linux/atomic.h:7,
                    from include/linux/mm_types_task.h:13,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from block/blk-mq.c:9:
   block/blk-mq.c: In function 'blk_complete_reqs.constprop':
>> arch/m68k/include/asm/cmpxchg.h:64:17: warning: array subscript 'volatile struct __xchg_dummy[0]' is partly outside array bounds of 'struct llist_head[1]' [-Warray-bounds]
      64 |                 __asm__ __volatile__
         |                 ^~~~~~~
   In file included from include/asm-generic/percpu.h:7,
                    from ./arch/m68k/include/generated/asm/percpu.h:1,
                    from include/linux/irqflags.h:17,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/mm_types_task.h:13,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from block/blk-mq.c:9:
   block/blk-mq.c:46:42: note: while referencing 'blk_cpu_done'
      46 | static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
         |                                          ^~~~~~~~~~~~
   include/linux/percpu-defs.h:95:51: note: in definition of macro 'DEFINE_PER_CPU_SECTION'
      95 |         __PCPU_ATTRS(sec) __weak __typeof__(type) name
         |                                                   ^~~~
   block/blk-mq.c:46:8: note: in expansion of macro 'DEFINE_PER_CPU'
      46 | static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
         |        ^~~~~~~~~~~~~~
--
   In file included from arch/m68k/include/asm/atomic.h:7,
                    from include/linux/atomic.h:7,
                    from include/linux/rcupdate.h:25,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/miscdevice.h:7,
                    from drivers/accessibility/speakup/devsynth.c:3:
   drivers/accessibility/speakup/devsynth.c: In function 'speakup_file_open':
>> arch/m68k/include/asm/cmpxchg.h:64:17: warning: array subscript 'volatile struct __xchg_dummy[0]' is partly outside array bounds of 'int[1]' [-Warray-bounds]
      64 |                 __asm__ __volatile__
         |                 ^~~~~~~
   drivers/accessibility/speakup/devsynth.c:11:12: note: while referencing 'dev_opened'
      11 | static int dev_opened;
         |            ^~~~~~~~~~
--
   In file included from arch/m68k/include/asm/atomic.h:7,
                    from include/linux/atomic.h:7,
                    from include/linux/cpumask.h:13,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from drivers/accessibility/speakup/selection.c:2:
   drivers/accessibility/speakup/selection.c: In function 'speakup_cancel_selection':
>> arch/m68k/include/asm/cmpxchg.h:64:17: warning: array subscript 'volatile struct __xchg_dummy[0]' is partly outside array bounds of 'struct speakup_selection_work[1]' [-Warray-bounds]
      64 |                 __asm__ __volatile__
         |                 ^~~~~~~
   drivers/accessibility/speakup/selection.c:57:38: note: while referencing 'speakup_sel_work'
      57 | static struct speakup_selection_work speakup_sel_work = {
         |                                      ^~~~~~~~~~~~~~~~
   In file included from arch/m68k/include/asm/atomic.h:7,
                    from include/linux/atomic.h:7,
                    from include/linux/cpumask.h:13,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from drivers/accessibility/speakup/selection.c:2:
   drivers/accessibility/speakup/selection.c: In function 'speakup_cancel_paste':
>> arch/m68k/include/asm/cmpxchg.h:64:17: warning: array subscript 'volatile struct __xchg_dummy[0]' is partly outside array bounds of 'struct speakup_selection_work[1]' [-Warray-bounds]
      64 |                 __asm__ __volatile__
         |                 ^~~~~~~
   drivers/accessibility/speakup/selection.c:116:38: note: while referencing 'speakup_paste_work'
     116 | static struct speakup_selection_work speakup_paste_work = {
         |                                      ^~~~~~~~~~~~~~~~~~
--
   In file included from arch/m68k/include/asm/atomic.h:7,
                    from include/linux/atomic.h:7,
                    from include/linux/jump_label.h:261,
                    from include/linux/once.h:6,
                    from include/linux/random.h:13,
                    from include/linux/net.h:18,
                    from drivers/infiniband/sw/siw/siw_qp_tx.c:8:
   drivers/infiniband/sw/siw/siw_qp_tx.c: In function 'siw_run_sq':
>> arch/m68k/include/asm/cmpxchg.h:64:17: warning: array subscript 'volatile struct __xchg_dummy[0]' is partly outside array bounds of 'struct tx_task_t[1]' [-Warray-bounds]
      64 |                 __asm__ __volatile__
         |                 ^~~~~~~
   In file included from include/asm-generic/percpu.h:7,
                    from ./arch/m68k/include/generated/asm/percpu.h:1,
                    from include/linux/irqflags.h:17,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/jump_label.h:261,
                    from include/linux/once.h:6,
                    from include/linux/random.h:13,
                    from include/linux/net.h:18,
                    from drivers/infiniband/sw/siw/siw_qp_tx.c:8:
   drivers/infiniband/sw/siw/siw_qp_tx.c:1200:41: note: while referencing 'siw_tx_task_g'
    1200 | static DEFINE_PER_CPU(struct tx_task_t, siw_tx_task_g);
         |                                         ^~~~~~~~~~~~~
   include/linux/percpu-defs.h:95:51: note: in definition of macro 'DEFINE_PER_CPU_SECTION'
      95 |         __PCPU_ATTRS(sec) __weak __typeof__(type) name
         |                                                   ^~~~
   drivers/infiniband/sw/siw/siw_qp_tx.c:1200:8: note: in expansion of macro 'DEFINE_PER_CPU'
    1200 | static DEFINE_PER_CPU(struct tx_task_t, siw_tx_task_g);
         |        ^~~~~~~~~~~~~~
   In file included from arch/m68k/include/asm/atomic.h:7,
                    from include/linux/atomic.h:7,
                    from include/linux/jump_label.h:261,
                    from include/linux/once.h:6,
                    from include/linux/random.h:13,
                    from include/linux/net.h:18,
                    from drivers/infiniband/sw/siw/siw_qp_tx.c:8:
>> arch/m68k/include/asm/cmpxchg.h:64:17: warning: array subscript 'volatile struct __xchg_dummy[0]' is partly outside array bounds of 'struct tx_task_t[1]' [-Warray-bounds]
      64 |                 __asm__ __volatile__
         |                 ^~~~~~~
   In file included from include/asm-generic/percpu.h:7,
                    from ./arch/m68k/include/generated/asm/percpu.h:1,
                    from include/linux/irqflags.h:17,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/jump_label.h:261,
                    from include/linux/once.h:6,
                    from include/linux/random.h:13,
                    from include/linux/net.h:18,
                    from drivers/infiniband/sw/siw/siw_qp_tx.c:8:
   drivers/infiniband/sw/siw/siw_qp_tx.c:1200:41: note: while referencing 'siw_tx_task_g'
    1200 | static DEFINE_PER_CPU(struct tx_task_t, siw_tx_task_g);
         |                                         ^~~~~~~~~~~~~
   include/linux/percpu-defs.h:95:51: note: in definition of macro 'DEFINE_PER_CPU_SECTION'
      95 |         __PCPU_ATTRS(sec) __weak __typeof__(type) name
         |                                                   ^~~~
   drivers/infiniband/sw/siw/siw_qp_tx.c:1200:8: note: in expansion of macro 'DEFINE_PER_CPU'
    1200 | static DEFINE_PER_CPU(struct tx_task_t, siw_tx_task_g);
         |        ^~~~~~~~~~~~~~
--
   In file included from arch/m68k/include/asm/atomic.h:7,
                    from include/linux/atomic.h:7,
                    from include/linux/crypto.h:15,
                    from include/crypto/hash.h:11,
                    from net/ipv4/tcp.c:246:
   net/ipv4/tcp.c: In function 'tcp_leave_memory_pressure':
>> arch/m68k/include/asm/cmpxchg.h:64:17: warning: array subscript 'volatile struct __xchg_dummy[0]' is partly outside array bounds of 'long unsigned int[1]' [-Warray-bounds]
      64 |                 __asm__ __volatile__
         |                 ^~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/preempt.h:10,
                    from arch/m68k/include/asm/irqflags.h:6,
                    from include/linux/irqflags.h:16,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/crypto.h:15,
                    from include/crypto/hash.h:11,
                    from net/ipv4/tcp.c:246:
   net/ipv4/tcp.c:325:19: note: while referencing 'tcp_memory_pressure'
     325 | EXPORT_SYMBOL_GPL(tcp_memory_pressure);
         |                   ^~~~~~~~~~~~~~~~~~~
   include/linux/export.h:98:28: note: in definition of macro '___EXPORT_SYMBOL'
      98 |         extern typeof(sym) sym;                                                 \
         |                            ^~~
   include/linux/export.h:160:41: note: in expansion of macro '__EXPORT_SYMBOL'
     160 | #define _EXPORT_SYMBOL(sym, sec)        __EXPORT_SYMBOL(sym, sec, "")
         |                                         ^~~~~~~~~~~~~~~
   include/linux/export.h:164:41: note: in expansion of macro '_EXPORT_SYMBOL'
     164 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "_gpl")
         |                                         ^~~~~~~~~~~~~~
   net/ipv4/tcp.c:325:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
     325 | EXPORT_SYMBOL_GPL(tcp_memory_pressure);
         | ^~~~~~~~~~~~~~~~~
..


vim +64 arch/m68k/include/asm/cmpxchg.h

803f69144f0d48 David Howells 2012-03-28  11  
803f69144f0d48 David Howells 2012-03-28  12  #ifndef CONFIG_RMW_INSNS
803f69144f0d48 David Howells 2012-03-28  13  static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int size)
803f69144f0d48 David Howells 2012-03-28  14  {
803f69144f0d48 David Howells 2012-03-28  15  	unsigned long flags, tmp;
803f69144f0d48 David Howells 2012-03-28  16  
803f69144f0d48 David Howells 2012-03-28  17  	local_irq_save(flags);
803f69144f0d48 David Howells 2012-03-28  18  
803f69144f0d48 David Howells 2012-03-28  19  	switch (size) {
803f69144f0d48 David Howells 2012-03-28  20  	case 1:
803f69144f0d48 David Howells 2012-03-28  21  		tmp = *(u8 *)ptr;
803f69144f0d48 David Howells 2012-03-28  22  		*(u8 *)ptr = x;
803f69144f0d48 David Howells 2012-03-28  23  		x = tmp;
803f69144f0d48 David Howells 2012-03-28  24  		break;
803f69144f0d48 David Howells 2012-03-28  25  	case 2:
803f69144f0d48 David Howells 2012-03-28  26  		tmp = *(u16 *)ptr;
803f69144f0d48 David Howells 2012-03-28  27  		*(u16 *)ptr = x;
803f69144f0d48 David Howells 2012-03-28  28  		x = tmp;
803f69144f0d48 David Howells 2012-03-28  29  		break;
803f69144f0d48 David Howells 2012-03-28  30  	case 4:
803f69144f0d48 David Howells 2012-03-28  31  		tmp = *(u32 *)ptr;
803f69144f0d48 David Howells 2012-03-28  32  		*(u32 *)ptr = x;
803f69144f0d48 David Howells 2012-03-28  33  		x = tmp;
803f69144f0d48 David Howells 2012-03-28  34  		break;
803f69144f0d48 David Howells 2012-03-28  35  	default:
803f69144f0d48 David Howells 2012-03-28  36  		tmp = __invalid_xchg_size(x, ptr, size);
803f69144f0d48 David Howells 2012-03-28  37  		break;
803f69144f0d48 David Howells 2012-03-28  38  	}
803f69144f0d48 David Howells 2012-03-28  39  
803f69144f0d48 David Howells 2012-03-28  40  	local_irq_restore(flags);
803f69144f0d48 David Howells 2012-03-28  41  	return x;
803f69144f0d48 David Howells 2012-03-28  42  }
803f69144f0d48 David Howells 2012-03-28  43  #else
803f69144f0d48 David Howells 2012-03-28  44  static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int size)
803f69144f0d48 David Howells 2012-03-28  45  {
803f69144f0d48 David Howells 2012-03-28  46  	switch (size) {
803f69144f0d48 David Howells 2012-03-28  47  	case 1:
803f69144f0d48 David Howells 2012-03-28  48  		__asm__ __volatile__
803f69144f0d48 David Howells 2012-03-28  49  			("moveb %2,%0\n\t"
803f69144f0d48 David Howells 2012-03-28  50  			 "1:\n\t"
803f69144f0d48 David Howells 2012-03-28  51  			 "casb %0,%1,%2\n\t"
803f69144f0d48 David Howells 2012-03-28  52  			 "jne 1b"
803f69144f0d48 David Howells 2012-03-28  53  			 : "=&d" (x) : "d" (x), "m" (*__xg(ptr)) : "memory");
803f69144f0d48 David Howells 2012-03-28  54  		break;
803f69144f0d48 David Howells 2012-03-28  55  	case 2:
803f69144f0d48 David Howells 2012-03-28  56  		__asm__ __volatile__
803f69144f0d48 David Howells 2012-03-28  57  			("movew %2,%0\n\t"
803f69144f0d48 David Howells 2012-03-28  58  			 "1:\n\t"
803f69144f0d48 David Howells 2012-03-28  59  			 "casw %0,%1,%2\n\t"
803f69144f0d48 David Howells 2012-03-28  60  			 "jne 1b"
803f69144f0d48 David Howells 2012-03-28  61  			 : "=&d" (x) : "d" (x), "m" (*__xg(ptr)) : "memory");
803f69144f0d48 David Howells 2012-03-28  62  		break;
803f69144f0d48 David Howells 2012-03-28  63  	case 4:
803f69144f0d48 David Howells 2012-03-28 @64  		__asm__ __volatile__
803f69144f0d48 David Howells 2012-03-28  65  			("movel %2,%0\n\t"
803f69144f0d48 David Howells 2012-03-28  66  			 "1:\n\t"
803f69144f0d48 David Howells 2012-03-28  67  			 "casl %0,%1,%2\n\t"
803f69144f0d48 David Howells 2012-03-28  68  			 "jne 1b"
803f69144f0d48 David Howells 2012-03-28  69  			 : "=&d" (x) : "d" (x), "m" (*__xg(ptr)) : "memory");
803f69144f0d48 David Howells 2012-03-28  70  		break;
803f69144f0d48 David Howells 2012-03-28  71  	default:
803f69144f0d48 David Howells 2012-03-28  72  		x = __invalid_xchg_size(x, ptr, size);
803f69144f0d48 David Howells 2012-03-28  73  		break;
803f69144f0d48 David Howells 2012-03-28  74  	}
803f69144f0d48 David Howells 2012-03-28  75  	return x;
803f69144f0d48 David Howells 2012-03-28  76  }
803f69144f0d48 David Howells 2012-03-28  77  #endif
803f69144f0d48 David Howells 2012-03-28  78  

:::::: The code at line 64 was first introduced by commit
:::::: 803f69144f0d48863c68f9d111b56849c7cef5bb Disintegrate asm/system.h for M68K

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: David Howells <dhowells@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
