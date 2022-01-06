Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76564486D7F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 00:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245347AbiAFXDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 18:03:43 -0500
Received: from mga04.intel.com ([192.55.52.120]:14524 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245283AbiAFXDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 18:03:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641510216; x=1673046216;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ah2QyRooiK1gL7AYen1FZ3/+RGTMz2Tq/LATd+ALnUk=;
  b=UeIT8T4Vbqa2IEJ1JZp6ftV9AoBCvednkJm7S5E/85V/pi2iMrc00Q7n
   zVAbiWlGqv602hVQYfYpAbTUfRoDCUDn8IbPWmlFYY5FwQ7ZzQXVSQe3m
   khQw1SeT5nCiBXUiw6wQmcmUqfE/ZfWH+Z7luVlBUfgTcpt3UWuXNm4YZ
   /Ccm3yB/Cmkvouc3DK+n5Y6EA0BoM0CF2tXH2QS3FdsR6jBxJGDmoJoZf
   tQrpzQ19MpWfC6fARWxleV4jnZxunD1hoH/GBtUPqkrUrtHzdZ+3bPIbU
   PEKwj3sJjgS4XpYmHennMRkOKNChA7yNDGzjLlPFU5lX6J8hnxq9U+hM8
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="241573416"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="241573416"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 15:03:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="513571266"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 06 Jan 2022 15:03:33 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5bnA-000I4a-TD; Thu, 06 Jan 2022 23:03:32 +0000
Date:   Fri, 7 Jan 2022 07:03:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:kvm/entry-rework 1/5] include/linux/kvm_host.h:434:37: error:
 'CALLER_ADDR0' undeclared
Message-ID: <202201070743.bpqNr207-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git kvm/entry-rework
head:   8d884276f428cde5dbdcf197ba94ed5b2461c4c1
commit: 0515c622963b34a5fc0aeee6dbd18f47b7e40563 [1/5] kvm: add exit_to_guest_mode() and enter_from_guest_mode()
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220107/202201070743.bpqNr207-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=0515c622963b34a5fc0aeee6dbd18f47b7e40563
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark kvm/entry-rework
        git checkout 0515c622963b34a5fc0aeee6dbd18f47b7e40563
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/mips/kernel/asm-offsets.c:24:
   include/linux/kvm_host.h: In function 'exit_to_guest_mode':
>> include/linux/kvm_host.h:434:37: error: 'CALLER_ADDR0' undeclared (first use in this function)
     434 |         lockdep_hardirqs_on_prepare(CALLER_ADDR0);
         |                                     ^~~~~~~~~~~~
   include/linux/kvm_host.h:434:37: note: each undeclared identifier is reported only once for each function it appears in
   include/linux/kvm_host.h: In function 'enter_from_guest_mode':
   include/linux/kvm_host.h:502:30: error: 'CALLER_ADDR0' undeclared (first use in this function)
     502 |         lockdep_hardirqs_off(CALLER_ADDR0);
         |                              ^~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c: At top level:
   arch/mips/kernel/asm-offsets.c:26:6: warning: no previous prototype for 'output_ptreg_defines' [-Wmissing-prototypes]
      26 | void output_ptreg_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:78:6: warning: no previous prototype for 'output_task_defines' [-Wmissing-prototypes]
      78 | void output_task_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:92:6: warning: no previous prototype for 'output_thread_info_defines' [-Wmissing-prototypes]
      92 | void output_thread_info_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:108:6: warning: no previous prototype for 'output_thread_defines' [-Wmissing-prototypes]
     108 | void output_thread_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:136:6: warning: no previous prototype for 'output_thread_fpu_defines' [-Wmissing-prototypes]
     136 | void output_thread_fpu_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:179:6: warning: no previous prototype for 'output_mm_defines' [-Wmissing-prototypes]
     179 | void output_mm_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:218:6: warning: no previous prototype for 'output_sc_defines' [-Wmissing-prototypes]
     218 | void output_sc_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:253:6: warning: no previous prototype for 'output_signal_defined' [-Wmissing-prototypes]
     253 | void output_signal_defined(void)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:320:6: warning: no previous prototype for 'output_pbe_defines' [-Wmissing-prototypes]
     320 | void output_pbe_defines(void)
         |      ^~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:332:6: warning: no previous prototype for 'output_pm_defines' [-Wmissing-prototypes]
     332 | void output_pm_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:346:6: warning: no previous prototype for 'output_kvm_defines' [-Wmissing-prototypes]
     346 | void output_kvm_defines(void)
         |      ^~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:390:6: warning: no previous prototype for 'output_cps_defines' [-Wmissing-prototypes]
     390 | void output_cps_defines(void)
         |      ^~~~~~~~~~~~~~~~~~
   make[2]: *** [scripts/Makefile.build:121: arch/mips/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1197: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/CALLER_ADDR0 +434 include/linux/kvm_host.h

   413	
   414	/**
   415	 * exit_to_guest_mode - Fixup state when exiting to guest mode
   416	 *
   417	 * This is analagous to exit_to_user_mode(), and ensures we perform the
   418	 * following in order:
   419	 *
   420	 * 1) Trace interrupts on state
   421	 * 2) Invoke context tracking if enabled to adjust RCU state
   422	 * 3) Tell lockdep that interrupts are enabled
   423	 *
   424	 * Invoked from architecture specific code as the last step before entering a
   425	 * guest. Must be invoked with interrupts disabled and the caller must be
   426	 * non-instrumentable.
   427	 *
   428	 * This must be called after guest_timing_enter_irqoff().
   429	 */
   430	static __always_inline void exit_to_guest_mode(void)
   431	{
   432		instrumentation_begin();
   433		trace_hardirqs_on_prepare();
 > 434		lockdep_hardirqs_on_prepare(CALLER_ADDR0);
   435		instrumentation_end();
   436	
   437		guest_context_enter_irqoff();
   438		lockdep_hardirqs_on(CALLER_ADDR0);
   439	}
   440	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
