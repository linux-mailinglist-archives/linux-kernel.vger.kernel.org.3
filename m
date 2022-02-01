Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2725E4A5E14
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 15:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239141AbiBAORr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 09:17:47 -0500
Received: from mga12.intel.com ([192.55.52.136]:63417 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239002AbiBAORq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 09:17:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643725066; x=1675261066;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+GLfgRA4ZVTebpf7cqDVMOf0gvYeW+Um8SmJ4jWt1Zk=;
  b=OeNXUIFa6h9YmtoT7kJD2X6yrGpPnqcnfHCUBUOVGmsRs7cJRXYPKrEH
   alcx/QMErLBQTVkwvqyULeJdQfF+vUBO1F7oXh0rqdAOVcxUol+EQXTmf
   2meXCB6ODII6eypYYxndfQRdoVdDMWb94RJEQNg3/4tQz92PyPZDyKK8H
   1ew9LeADvh0UGPMd2G2CWQgNr23FWgMzr5o3+rBvIwc6sCHGf7OrTWjCh
   XdikmH9Ax32Vswh7MUCUC48kpOTXBFYDdM46Yi9hLrtmA8hp72ThR2mmq
   JQjga/oA0GCKO6no6JofES3D01ocCDypv5Ugd5RaqKb0+MLFsFvxMbZPm
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="227670182"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="227670182"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 06:17:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="479702820"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 Feb 2022 06:17:45 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEtya-000TLs-Eb; Tue, 01 Feb 2022 14:17:44 +0000
Date:   Tue, 1 Feb 2022 22:17:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [dvyukov:dvyukov-sigtrap-arm64 1/1]
 arch/arm64/kernel/signal.c:566:39: error: 'sf' undeclared; did you mean
 's8'?
Message-ID: <202202012216.ccEQmUmT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/dvyukov/linux dvyukov-sigtrap-arm64
head:   dfd6903d9c6538e3ad792c1df6ffbcce2072b12b
commit: dfd6903d9c6538e3ad792c1df6ffbcce2072b12b [1/1] arm64: try to fix arm64 watchpoints
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220201/202202012216.ccEQmUmT-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/dvyukov/linux/commit/dfd6903d9c6538e3ad792c1df6ffbcce2072b12b
        git remote add dvyukov https://github.com/dvyukov/linux
        git fetch --no-tags dvyukov dvyukov-sigtrap-arm64
        git checkout dfd6903d9c6538e3ad792c1df6ffbcce2072b12b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   arch/arm64/kernel/signal.c: In function '__arm64_sys_rt_sigreturn':
>> arch/arm64/kernel/signal.c:566:39: error: 'sf' undeclared (first use in this function); did you mean 's8'?
     566 |         if (!__copy_from_user(&info, &sf->info, sizeof(info)) &&
         |                                       ^~
         |                                       s8
   arch/arm64/kernel/signal.c:566:39: note: each undeclared identifier is reported only once for each function it appears in
   arch/arm64/kernel/signal.c: At top level:
   arch/arm64/kernel/signal.c:930:6: warning: no previous prototype for 'do_notify_resume' [-Wmissing-prototypes]
     930 | void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags)
         |      ^~~~~~~~~~~~~~~~
--
>> arch/arm64/kernel/hw_breakpoint.c:754:6: warning: no previous prototype for 'hw_bp_single_step' [-Wmissing-prototypes]
     754 | void hw_bp_single_step(struct pt_regs *regs)
         |      ^~~~~~~~~~~~~~~~~


vim +566 arch/arm64/kernel/signal.c

   536	
   537	SYSCALL_DEFINE0(rt_sigreturn)
   538	{
   539		struct pt_regs *regs = current_pt_regs();
   540		struct rt_sigframe __user *frame;
   541		struct siginfo info;
   542	
   543		/* Always make any pending restarted system calls return -EINTR */
   544		current->restart_block.fn = do_no_restart_syscall;
   545	
   546		/*
   547		 * Since we stacked the signal on a 128-bit boundary, then 'sp' should
   548		 * be word aligned here.
   549		 */
   550		if (regs->sp & 15)
   551			goto badframe;
   552	
   553		frame = (struct rt_sigframe __user *)regs->sp;
   554	
   555		if (!access_ok(frame, sizeof (*frame)))
   556			goto badframe;
   557	
   558		if (restore_sigframe(regs, frame))
   559			goto badframe;
   560	
   561		if (restore_altstack(&frame->uc.uc_stack))
   562			goto badframe;
   563	
   564		// TODO: memorize the original return PC in setup_rt_frame
   565		// and ensure we are returning to the same PC.
 > 566		if (!__copy_from_user(&info, &sf->info, sizeof(info)) &&
   567			info.si_signo == SIGTRAP && info.si_code == TRAP_PERF &&
   568			info.si_perf_type == PERF_TYPE_BREAKPOINT)
   569			hw_bp_single_step(regs);
   570	
   571		return regs->regs[0];
   572	
   573	badframe:
   574		arm64_notify_segfault(regs->sp);
   575		return 0;
   576	}
   577	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
