Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0364A61CF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241352AbiBARC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:02:59 -0500
Received: from mga04.intel.com ([192.55.52.120]:35498 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230115AbiBARC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:02:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643734978; x=1675270978;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3XO2RCLpUwqg2gMhv4lmheHfD3ysoJ5vEX8G/1igDeg=;
  b=OiYNZFrOd8cX0Sf9yZt25h12cxqfeGC05f/7lioWGOuHUevrco2A2kQo
   A5kN/kA1z4UFWuNGfkbBHJUIJnz+VtJE44Y4oW++XOC77bpapDS0Gfjqh
   BraeIDkaayAinL4f++ss4gT+AKFX4yjup842Sn7JXk7cdmn15vdmSCVlS
   gN5ck0vwOutQushUnBUxVptAHkt00HXuVXyeei0hkIxrOjxMT97Uo/4qi
   SHcoSRMBHraB7dxWDForgnYqple8w7OT0pDMyTwPK3GfjJAz72Xsx6RX1
   FJB59NhXqWCYxnHAwJlSZr2vZHHZMtOzqbW8/QVVP680VUxUknckvgLmc
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="246569033"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="246569033"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 09:00:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="537881840"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 01 Feb 2022 09:00:55 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEwWV-000TVn-1z; Tue, 01 Feb 2022 17:00:55 +0000
Date:   Wed, 2 Feb 2022 01:00:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [dvyukov:dvyukov-sigtrap-arm64 1/1]
 arch/arm64/kernel/signal.c:566:32: error: use of undeclared identifier 'sf'
Message-ID: <202202020023.4C6dVeTR-lkp@intel.com>
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
config: arm64-randconfig-r001-20220130 (https://download.01.org/0day-ci/archive/20220202/202202020023.4C6dVeTR-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 6b1e844b69f15bb7dffaf9365cd2b355d2eb7579)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/dvyukov/linux/commit/dfd6903d9c6538e3ad792c1df6ffbcce2072b12b
        git remote add dvyukov https://github.com/dvyukov/linux
        git fetch --no-tags dvyukov dvyukov-sigtrap-arm64
        git checkout dfd6903d9c6538e3ad792c1df6ffbcce2072b12b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> arch/arm64/kernel/signal.c:566:32: error: use of undeclared identifier 'sf'
           if (!__copy_from_user(&info, &sf->info, sizeof(info)) &&
                                         ^
   arch/arm64/kernel/signal.c:930:6: warning: no previous prototype for function 'do_notify_resume' [-Wmissing-prototypes]
   void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags)
        ^
   arch/arm64/kernel/signal.c:930:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags)
   ^
   static 
   1 warning and 1 error generated.
--
>> arch/arm64/kernel/hw_breakpoint.c:754:6: warning: no previous prototype for function 'hw_bp_single_step' [-Wmissing-prototypes]
   void hw_bp_single_step(struct pt_regs *regs)
        ^
   arch/arm64/kernel/hw_breakpoint.c:754:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void hw_bp_single_step(struct pt_regs *regs)
   ^
   static 
   1 warning generated.


vim +/sf +566 arch/arm64/kernel/signal.c

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
