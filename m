Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B815589D80
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 16:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239670AbiHDObg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 10:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239550AbiHDOb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 10:31:29 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F78A32DBC
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 07:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659623487; x=1691159487;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gFKbARwhryqBiRlQXGxuMXT1EYYHYdVhOsiHCLeWKj8=;
  b=fjwNaBK7gtBecSy6Cd1yamvtXrkOSMoy7q8FYtaFMip7E0Ls2uk0E1gR
   fYrauj4cgATd5E85llYQoYjw/vB1sjTk0Idduwj/orEvabAXDx3gVwSBL
   2TP36DnxyvocbRdWzGc6jb95iS4hnKwD0A9XshmhFthCKyhyXetI8bFC1
   JaUoelpMgVlTtZgsTAuTmu6fE/VHIhHB4oeX0EjzKTA6fotfGOT/Gef0q
   t9XS6B38kYTkN1+Yxd9tNTBdqhHk4+cQGkP/94V9RU0qOBfVDADDlKkAt
   XVMKYgVJMmzRj4llFavIzbp/+St4RbPnUpVa5/IMzlkHm4U2PbRR4gQ9I
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="272991600"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="272991600"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 07:31:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="930827953"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 04 Aug 2022 07:31:22 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJbsf-000IXB-2v;
        Thu, 04 Aug 2022 14:31:21 +0000
Date:   Thu, 4 Aug 2022 22:31:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tracing_multi 12/18] do_mounts.c:(.text+0x37e):
 multiple definition of `bpf_tracing_multi_attach';
 init/main.o:main.c:(.text+0x70): first defined here
Message-ID: <202208042254.Lnk0UNlF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tracing_multi
head:   3f77a2c51293ea19f1ce6a9b06b9fa394beecd13
commit: e005380dc118dbc67a921f1797c50541f4c3f1e5 [12/18] bpf: Add support to create tracing multi link
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220804/202208042254.Lnk0UNlF-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=e005380dc118dbc67a921f1797c50541f4c3f1e5
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tracing_multi
        git checkout e005380dc118dbc67a921f1797c50541f4c3f1e5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from arch/x86/um/ldt.c:9:
>> include/linux/trace_events.h:797:5: warning: no previous prototype for 'bpf_tracing_multi_attach' [-Wmissing-prototypes]
     797 | int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from arch/x86/um/tls_32.c:8:
>> include/linux/trace_events.h:797:5: warning: no previous prototype for 'bpf_tracing_multi_attach' [-Wmissing-prototypes]
     797 | int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/um/tls_32.c:23:5: warning: no previous prototype for 'do_set_thread_area' [-Wmissing-prototypes]
      23 | int do_set_thread_area(struct user_desc *info)
         |     ^~~~~~~~~~~~~~~~~~
   arch/x86/um/tls_32.c:39:5: warning: no previous prototype for 'do_get_thread_area' [-Wmissing-prototypes]
      39 | int do_get_thread_area(struct user_desc *info)
         |     ^~~~~~~~~~~~~~~~~~
   arch/x86/um/tls_32.c:187:5: warning: no previous prototype for 'arch_switch_tls' [-Wmissing-prototypes]
     187 | int arch_switch_tls(struct task_struct *to)
         |     ^~~~~~~~~~~~~~~
--
   In file included from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from kernel/fork.c:55:
>> include/linux/trace_events.h:797:5: warning: no previous prototype for 'bpf_tracing_multi_attach' [-Wmissing-prototypes]
     797 | int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:163:13: warning: no previous prototype for 'arch_release_task_struct' [-Wmissing-prototypes]
     163 | void __weak arch_release_task_struct(struct task_struct *tsk)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:852:20: warning: no previous prototype for 'arch_task_cache_init' [-Wmissing-prototypes]
     852 | void __init __weak arch_task_cache_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:947:12: warning: no previous prototype for 'arch_dup_task_struct' [-Wmissing-prototypes]
     947 | int __weak arch_dup_task_struct(struct task_struct *dst,
         |            ^~~~~~~~~~~~~~~~~~~~
--
   In file included from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from kernel/exit.c:42:
>> include/linux/trace_events.h:797:5: warning: no previous prototype for 'bpf_tracing_multi_attach' [-Wmissing-prototypes]
     797 | int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/exit.c:1814:13: warning: no previous prototype for 'abort' [-Wmissing-prototypes]
    1814 | __weak void abort(void)
         |             ^~~~~
--
   In file included from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from include/linux/syscalls_api.h:1,
                    from kernel/sched/sched.h:60,
                    from kernel/sched/fair.c:54:
>> include/linux/trace_events.h:797:5: warning: no previous prototype for 'bpf_tracing_multi_attach' [-Wmissing-prototypes]
     797 | int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:675:5: warning: no previous prototype for 'sched_update_scaling' [-Wmissing-prototypes]
     675 | int sched_update_scaling(void)
         |     ^~~~~~~~~~~~~~~~~~~~
--
   In file included from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from fs/pipe.c:24:
>> include/linux/trace_events.h:797:5: warning: no previous prototype for 'bpf_tracing_multi_attach' [-Wmissing-prototypes]
     797 | int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   fs/pipe.c:757:15: warning: no previous prototype for 'account_pipe_buffers' [-Wmissing-prototypes]
     757 | unsigned long account_pipe_buffers(struct user_struct *user,
         |               ^~~~~~~~~~~~~~~~~~~~
   fs/pipe.c:763:6: warning: no previous prototype for 'too_many_pipe_buffers_soft' [-Wmissing-prototypes]
     763 | bool too_many_pipe_buffers_soft(unsigned long user_bufs)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/pipe.c:770:6: warning: no previous prototype for 'too_many_pipe_buffers_hard' [-Wmissing-prototypes]
     770 | bool too_many_pipe_buffers_hard(unsigned long user_bufs)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/pipe.c:777:6: warning: no previous prototype for 'pipe_is_unprivileged_user' [-Wmissing-prototypes]
     777 | bool pipe_is_unprivileged_user(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   fs/pipe.c:1253:5: warning: no previous prototype for 'pipe_resize_ring' [-Wmissing-prototypes]
    1253 | int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
         |     ^~~~~~~~~~~~~~~~
--
   In file included from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from fs/d_path.c:2:
>> include/linux/trace_events.h:797:5: warning: no previous prototype for 'bpf_tracing_multi_attach' [-Wmissing-prototypes]
     797 | int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   fs/d_path.c:318:7: warning: no previous prototype for 'simple_dname' [-Wmissing-prototypes]
     318 | char *simple_dname(struct dentry *dentry, char *buffer, int buflen)
         |       ^~~~~~~~~~~~
--
   In file included from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from fs/io_uring.c:45:
>> include/linux/trace_events.h:797:5: warning: no previous prototype for 'bpf_tracing_multi_attach' [-Wmissing-prototypes]
     797 | int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   fs/io_uring.c: In function '__io_submit_flush_completions':
   fs/io_uring.c:3150:40: warning: variable 'prev' set but not used [-Wunused-but-set-variable]
    3150 |         struct io_wq_work_node *node, *prev;
         |                                        ^~~~
--
   In file included from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from kernel/time/hrtimer.c:30:
>> include/linux/trace_events.h:797:5: warning: no previous prototype for 'bpf_tracing_multi_attach' [-Wmissing-prototypes]
     797 | int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:120:35: warning: initialized field overwritten [-Woverride-init]
     120 |         [CLOCK_REALTIME]        = HRTIMER_BASE_REALTIME,
         |                                   ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:120:35: note: (near initialization for 'hrtimer_clock_to_base_table[0]')
   kernel/time/hrtimer.c:121:35: warning: initialized field overwritten [-Woverride-init]
     121 |         [CLOCK_MONOTONIC]       = HRTIMER_BASE_MONOTONIC,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:121:35: note: (near initialization for 'hrtimer_clock_to_base_table[1]')
   kernel/time/hrtimer.c:122:35: warning: initialized field overwritten [-Woverride-init]
     122 |         [CLOCK_BOOTTIME]        = HRTIMER_BASE_BOOTTIME,
         |                                   ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:122:35: note: (near initialization for 'hrtimer_clock_to_base_table[7]')
   kernel/time/hrtimer.c:123:35: warning: initialized field overwritten [-Woverride-init]
     123 |         [CLOCK_TAI]             = HRTIMER_BASE_TAI,
         |                                   ^~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:123:35: note: (near initialization for 'hrtimer_clock_to_base_table[11]')
   kernel/time/hrtimer.c: In function '__run_hrtimer':
   kernel/time/hrtimer.c:1648:14: warning: variable 'expires_in_hardirq' set but not used [-Wunused-but-set-variable]
    1648 |         bool expires_in_hardirq;
         |              ^~~~~~~~~~~~~~~~~~
--
   In file included from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from net/socket.c:79:
>> include/linux/trace_events.h:797:5: warning: no previous prototype for 'bpf_tracing_multi_attach' [-Wmissing-prototypes]
     797 | int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   net/socket.c: In function '__sys_getsockopt':
   net/socket.c:2278:13: warning: variable 'max_optlen' set but not used [-Wunused-but-set-variable]
    2278 |         int max_optlen;
         |             ^~~~~~~~~~
--
   ld: init/do_mounts.o: in function `bpf_tracing_multi_attach':
>> do_mounts.c:(.text+0x37e): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: init/noinitramfs.o: in function `bpf_tracing_multi_attach':
   noinitramfs.c:(.text+0x0): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: arch/um/drivers/mconsole_kern.o: in function `bpf_tracing_multi_attach':
   mconsole_kern.c:(.text+0x7ae): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: arch/x86/um/ldt.o: in function `bpf_tracing_multi_attach':
   ldt.c:(.text+0x59e): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: arch/x86/um/tls_32.o: in function `bpf_tracing_multi_attach':
   tls_32.c:(.text+0x199): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: arch/x86/um/../kernel/sys_ia32.o: in function `bpf_tracing_multi_attach':
   sys_ia32.c:(.text+0x0): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: arch/x86/um/syscalls_32.o: in function `bpf_tracing_multi_attach':
   syscalls_32.c:(.text+0x0): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/fork.o: in function `bpf_tracing_multi_attach':
   fork.c:(.text+0xa10): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/exec_domain.o: in function `bpf_tracing_multi_attach':
   exec_domain.c:(.text+0x13): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/cpu.o: in function `bpf_tracing_multi_attach':
   cpu.c:(.text+0x4c9): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/exit.o: in function `bpf_tracing_multi_attach':
   exit.c:(.text+0x5a1): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/sysctl.o: in function `bpf_tracing_multi_attach':
   sysctl.c:(.text+0xf71): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/capability.o: in function `bpf_tracing_multi_attach':
   capability.c:(.text+0x4e7): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/ptrace.o: in function `bpf_tracing_multi_attach':
   ptrace.c:(.text+0x1c5): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/signal.o: in function `bpf_tracing_multi_attach':
   signal.c:(.text+0x967): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/sys.o: in function `bpf_tracing_multi_attach':
   sys.c:(.text+0xeb8): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/umh.o: in function `bpf_tracing_multi_attach':
   umh.c:(.text+0x628): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/pid.o: in function `bpf_tracing_multi_attach':
   pid.c:(.text+0x1ef): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/nsproxy.o: in function `bpf_tracing_multi_attach':
   nsproxy.c:(.text+0x202): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/reboot.o: in function `bpf_tracing_multi_attach':
   reboot.c:(.text+0x520): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/kmod.o: in function `bpf_tracing_multi_attach':
   kmod.c:(.text+0x27f): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/groups.o: in function `bpf_tracing_multi_attach':
   groups.c:(.text+0x110): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/sched/core.o: in function `bpf_tracing_multi_attach':
   core.c:(.text+0x9d4): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/sched/fair.o: in function `bpf_tracing_multi_attach':
   fair.c:(.text+0xfbd): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/sched/build_policy.o: in function `bpf_tracing_multi_attach':
   build_policy.c:(.text+0x1915): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/sched/build_utility.o: in function `bpf_tracing_multi_attach':
   build_utility.c:(.text+0x1138): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/power/qos.o: in function `bpf_tracing_multi_attach':
   qos.c:(.text+0x157): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/power/main.o: in function `bpf_tracing_multi_attach':
   main.c:(.text+0x5c2): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/power/process.o: in function `bpf_tracing_multi_attach':
   process.c:(.text+0x276): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/power/suspend.o: in function `bpf_tracing_multi_attach':
   suspend.c:(.text+0x100): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/printk/printk.o: in function `bpf_tracing_multi_attach':
   printk.c:(.text+0x1d8b): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/module/main.o: in function `bpf_tracing_multi_attach':
   main.c:(.text+0x7a0): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/freezer.o: in function `bpf_tracing_multi_attach':
   freezer.c:(.text+0x149): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/time/time.o: in function `bpf_tracing_multi_attach':
   time.c:(.text+0x51c): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/time/timer.o: in function `bpf_tracing_multi_attach':
   timer.c:(.text+0x9c0): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/time/hrtimer.o: in function `bpf_tracing_multi_attach':
   hrtimer.c:(.text+0xbb2): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/time/posix-timers.o: in function `bpf_tracing_multi_attach':
   posix-timers.c:(.text+0xc60): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/time/posix-clock.o: in function `bpf_tracing_multi_attach':
   posix-clock.c:(.text+0x3c7): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/time/itimer.o: in function `bpf_tracing_multi_attach':
   itimer.c:(.text+0x522): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/time/tick-common.o: in function `bpf_tracing_multi_attach':
   tick-common.c:(.text+0xa6): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/futex/syscalls.o: in function `bpf_tracing_multi_attach':
   syscalls.c:(.text+0x60): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/uid16.o: in function `bpf_tracing_multi_attach':
   uid16.c:(.text+0x41): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/acct.o: in function `bpf_tracing_multi_attach':
   acct.c:(.text+0x7b6): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: kernel/seccomp.o: in function `bpf_tracing_multi_attach':
   seccomp.c:(.text+0x1159): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: mm/oom_kill.o: in function `bpf_tracing_multi_attach':
   oom_kill.c:(.text+0x1ee): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: mm/fadvise.o: in function `bpf_tracing_multi_attach':
   fadvise.c:(.text+0x1fa): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: mm/page-writeback.o: in function `bpf_tracing_multi_attach':
   page-writeback.c:(.text+0x15cf): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: mm/readahead.o: in function `bpf_tracing_multi_attach':
   readahead.c:(.text+0x454): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: mm/shmem.o: in function `bpf_tracing_multi_attach':
   shmem.c:(.text+0x23c7): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: mm/debug.o: in function `bpf_tracing_multi_attach':
   debug.c:(.text+0x1aa): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
   ld: mm/mmap_lock.o: in function `bpf_tracing_multi_attach':
   mmap_lock.c:(.text+0x0): multiple definition of `bpf_tracing_multi_attach'; init/main.o:main.c:(.text+0x70): first defined here
..

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
