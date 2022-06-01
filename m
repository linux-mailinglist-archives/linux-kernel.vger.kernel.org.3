Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAADD53AA1B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352299AbiFAPaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345782AbiFAPaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:30:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231D04739F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 08:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654097410; x=1685633410;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XgRMkxUN03gqLhb/yJGS9PoM44or4z1VFge9H4Qb6n0=;
  b=bBlnO6pV0QhRAsUyQhf7I0e1ZCddB40IbTajZmB78Q0/aQqVWGFOtSOs
   szIKtxggzpgnZTgRUAKMXzKWDmkb4PoQVgCALjru1GubAs1i/JPJ49yg8
   yF5/JcEzuhTtQL3MD87Xe5SAiXbx3NmIQnJIdOevS9VYAeoSZa7lOKTHH
   FsVqjok6L5MIs2xeBPsYmfPS610CQ2CwPAd7gMLNeeOnQ9ugm9LbB5rh9
   pVZ8QRkTawBgBZZ/8oDl7yQqy+sChgaw0mwFnvT64WH1knOoH+EF/Ydp+
   Q+24ClcdtkgZ3qsdHsaV+ev0k/wWGUvHwgCCQgmYvdsXyivwaKc44gMdE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="362001194"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="362001194"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 08:30:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="756225823"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 Jun 2022 08:30:06 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwQIQ-000478-79;
        Wed, 01 Jun 2022 15:30:06 +0000
Date:   Wed, 1 Jun 2022 23:29:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:arm64/ftrace/minimal-regs 5/6] include/linux/ftrace.h:422:57:
 warning: 'struct ftrace_regs' declared inside parameter list will not be
 visible outside of this definition or declaration
Message-ID: <202206012357.BH7ZUhqM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/ftrace/minimal-regs
head:   b0741d059a9f19a1aa1191833140f53e41f1775a
commit: c694698df7f633bcbdf8bc0edb94f4a70ed0d092 [5/6] ftrace: pass fregs to arch_ftrace_set_direct_caller()
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220601/202206012357.BH7ZUhqM-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=c694698df7f633bcbdf8bc0edb94f4a70ed0d092
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark arm64/ftrace/minimal-regs
        git checkout c694698df7f633bcbdf8bc0edb94f4a70ed0d092
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from fs/binfmt_misc.c:27:
>> include/linux/ftrace.h:422:57: warning: 'struct ftrace_regs' declared inside parameter list will not be visible outside of this definition or declaration
     422 | static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs,
         |                                                         ^~~~~~~~~~~
--
   In file included from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from fs/pipe.c:24:
>> include/linux/ftrace.h:422:57: warning: 'struct ftrace_regs' declared inside parameter list will not be visible outside of this definition or declaration
     422 | static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs,
         |                                                         ^~~~~~~~~~~
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
   In file included from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from fs/d_path.c:2:
>> include/linux/ftrace.h:422:57: warning: 'struct ftrace_regs' declared inside parameter list will not be visible outside of this definition or declaration
     422 | static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs,
         |                                                         ^~~~~~~~~~~
   fs/d_path.c:318:7: warning: no previous prototype for 'simple_dname' [-Wmissing-prototypes]
     318 | char *simple_dname(struct dentry *dentry, char *buffer, int buflen)
         |       ^~~~~~~~~~~~
--
   In file included from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from fs/io_uring.c:45:
>> include/linux/ftrace.h:422:57: warning: 'struct ftrace_regs' declared inside parameter list will not be visible outside of this definition or declaration
     422 | static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs,
         |                                                         ^~~~~~~~~~~
   fs/io_uring.c: In function '__io_submit_flush_completions':
   fs/io_uring.c:3152:40: warning: variable 'prev' set but not used [-Wunused-but-set-variable]
    3152 |         struct io_wq_work_node *node, *prev;
         |                                        ^~~~


vim +422 include/linux/ftrace.h

   407	
   408	#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
   409	/*
   410	 * This must be implemented by the architecture.
   411	 * It is the way the ftrace direct_ops helper, when called
   412	 * via ftrace (because there's other callbacks besides the
   413	 * direct call), can inform the architecture's trampoline that this
   414	 * routine has a direct caller, and what the caller is.
   415	 *
   416	 * For example, in x86, it returns the direct caller
   417	 * callback function via the regs->orig_ax parameter.
   418	 * Then in the ftrace trampoline, if this is set, it makes
   419	 * the return from the trampoline jump to the direct caller
   420	 * instead of going back to the function it just traced.
   421	 */
 > 422	static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs,
   423							 unsigned long addr) { }
   424	#endif /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
   425	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
