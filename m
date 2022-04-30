Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14235159CF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 04:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358815AbiD3Cm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 22:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239943AbiD3Cmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 22:42:53 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A941C7CDC6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 19:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651286372; x=1682822372;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=S+eleb+tlM26h9EFB5p1HUZbhm2dhIZJoJi5ybHVzJg=;
  b=QaRzX9tNJ2QWFwp0BMy4GzDhLYptlXDZckPLnYo/cOJqPm+mEPGM3gNc
   gxqUnlMfiCPbwow+Bc2AiJjTMEjnRfUg545ApC9mnZNxPtyQfPs/46dCD
   4zZO6VvrSzwERhnIZ7ngUtsGTKDljTi4ufsHQ6ul4pIlG6oTCNgzJ61Es
   jTYGNJJswn/HUvFKFJNhUv2+kazTi6u12jecPUR1/khPskS6OFjqcdDy7
   iwzkj+q6ZkrhirdC7xcj8UyP7VUGjRIwJV+BrYVVQYmJ6Hayspw+T9w3s
   Mdig0F8heYRVEiIr2pq5D7xIBBLmHCBk0MjIXb+VbGnQA35wPrcImdC9Z
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="291996345"
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="291996345"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 19:39:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="882162354"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 29 Apr 2022 19:39:30 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkd18-0006nf-6M;
        Sat, 30 Apr 2022 02:39:30 +0000
Date:   Sat, 30 Apr 2022 10:38:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:arm64/stacktrace/speedups 8/12]
 arch/arm64/include/asm/stacktrace.h:102:57: error: 'sdei_stack_normal_ptr'
 undeclared
Message-ID: <202204301028.wJKKgW1y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/stacktrace/speedups
head:   cdc18713d4c3bb71acf2a7fde076b8cf08975dfd
commit: 2531d5677212f4010eba8f1c5cdbad90a5df5e82 [8/12] arm64: move SDEI stack helpers to stacktrace.h
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220430/202204301028.wJKKgW1y-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=2531d5677212f4010eba8f1c5cdbad90a5df5e82
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark arm64/stacktrace/speedups
        git checkout 2531d5677212f4010eba8f1c5cdbad90a5df5e82
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/percpu.h:7,
                    from arch/arm64/include/asm/percpu.h:248,
                    from include/linux/irqflags.h:17,
                    from include/linux/rcupdate.h:26,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/context_tracking.h:5,
                    from arch/arm64/kernel/entry-common.c:8:
   arch/arm64/include/asm/stacktrace.h: In function 'on_sdei_normal_stack':
>> arch/arm64/include/asm/stacktrace.h:102:57: error: 'sdei_stack_normal_ptr' undeclared (first use in this function)
     102 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
         |                                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:318:16: note: in definition of macro '__pcpu_size_call_return'
     318 |         typeof(variable) pscr_ret__;                                    \
         |                ^~~~~~~~
   arch/arm64/include/asm/stacktrace.h:102:44: note: in expansion of macro 'raw_cpu_read'
     102 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
         |                                            ^~~~~~~~~~~~
   arch/arm64/include/asm/stacktrace.h:102:57: note: each undeclared identifier is reported only once for each function it appears in
     102 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
         |                                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:318:16: note: in definition of macro '__pcpu_size_call_return'
     318 |         typeof(variable) pscr_ret__;                                    \
         |                ^~~~~~~~
   arch/arm64/include/asm/stacktrace.h:102:44: note: in expansion of macro 'raw_cpu_read'
     102 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
         |                                            ^~~~~~~~~~~~
   arch/arm64/include/asm/stacktrace.h: In function 'on_sdei_critical_stack':
>> arch/arm64/include/asm/stacktrace.h:111:57: error: 'sdei_stack_critical_ptr' undeclared (first use in this function)
     111 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_critical_ptr);
         |                                                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:318:16: note: in definition of macro '__pcpu_size_call_return'
     318 |         typeof(variable) pscr_ret__;                                    \
         |                ^~~~~~~~
   arch/arm64/include/asm/stacktrace.h:111:44: note: in expansion of macro 'raw_cpu_read'
     111 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_critical_ptr);
         |                                            ^~~~~~~~~~~~
--
   In file included from include/asm-generic/percpu.h:7,
                    from arch/arm64/include/asm/percpu.h:248,
                    from include/linux/irqflags.h:17,
                    from include/linux/rcupdate.h:26,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/audit.h:12,
                    from arch/arm64/kernel/ptrace.c:11:
   arch/arm64/include/asm/stacktrace.h: In function 'on_sdei_normal_stack':
>> arch/arm64/include/asm/stacktrace.h:102:57: error: 'sdei_stack_normal_ptr' undeclared (first use in this function)
     102 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
         |                                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:318:16: note: in definition of macro '__pcpu_size_call_return'
     318 |         typeof(variable) pscr_ret__;                                    \
         |                ^~~~~~~~
   arch/arm64/include/asm/stacktrace.h:102:44: note: in expansion of macro 'raw_cpu_read'
     102 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
         |                                            ^~~~~~~~~~~~
   arch/arm64/include/asm/stacktrace.h:102:57: note: each undeclared identifier is reported only once for each function it appears in
     102 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
         |                                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:318:16: note: in definition of macro '__pcpu_size_call_return'
     318 |         typeof(variable) pscr_ret__;                                    \
         |                ^~~~~~~~
   arch/arm64/include/asm/stacktrace.h:102:44: note: in expansion of macro 'raw_cpu_read'
     102 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
         |                                            ^~~~~~~~~~~~
   arch/arm64/include/asm/stacktrace.h: In function 'on_sdei_critical_stack':
>> arch/arm64/include/asm/stacktrace.h:111:57: error: 'sdei_stack_critical_ptr' undeclared (first use in this function)
     111 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_critical_ptr);
         |                                                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:318:16: note: in definition of macro '__pcpu_size_call_return'
     318 |         typeof(variable) pscr_ret__;                                    \
         |                ^~~~~~~~
   arch/arm64/include/asm/stacktrace.h:111:44: note: in expansion of macro 'raw_cpu_read'
     111 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_critical_ptr);
         |                                            ^~~~~~~~~~~~
   arch/arm64/kernel/ptrace.c: At top level:
   arch/arm64/kernel/ptrace.c:1838:5: warning: no previous prototype for 'syscall_trace_enter' [-Wmissing-prototypes]
    1838 | int syscall_trace_enter(struct pt_regs *regs)
         |     ^~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/ptrace.c:1861:6: warning: no previous prototype for 'syscall_trace_exit' [-Wmissing-prototypes]
    1861 | void syscall_trace_exit(struct pt_regs *regs)
         |      ^~~~~~~~~~~~~~~~~~
--
   In file included from include/asm-generic/percpu.h:7,
                    from arch/arm64/include/asm/percpu.h:248,
                    from include/linux/irqflags.h:17,
                    from include/linux/rcupdate.h:26,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/context_tracking.h:5,
                    from arch/arm64/kernel/traps.c:10:
   arch/arm64/include/asm/stacktrace.h: In function 'on_sdei_normal_stack':
>> arch/arm64/include/asm/stacktrace.h:102:57: error: 'sdei_stack_normal_ptr' undeclared (first use in this function)
     102 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
         |                                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:318:16: note: in definition of macro '__pcpu_size_call_return'
     318 |         typeof(variable) pscr_ret__;                                    \
         |                ^~~~~~~~
   arch/arm64/include/asm/stacktrace.h:102:44: note: in expansion of macro 'raw_cpu_read'
     102 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
         |                                            ^~~~~~~~~~~~
   arch/arm64/include/asm/stacktrace.h:102:57: note: each undeclared identifier is reported only once for each function it appears in
     102 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
         |                                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:318:16: note: in definition of macro '__pcpu_size_call_return'
     318 |         typeof(variable) pscr_ret__;                                    \
         |                ^~~~~~~~
   arch/arm64/include/asm/stacktrace.h:102:44: note: in expansion of macro 'raw_cpu_read'
     102 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
         |                                            ^~~~~~~~~~~~
   arch/arm64/include/asm/stacktrace.h: In function 'on_sdei_critical_stack':
>> arch/arm64/include/asm/stacktrace.h:111:57: error: 'sdei_stack_critical_ptr' undeclared (first use in this function)
     111 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_critical_ptr);
         |                                                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:318:16: note: in definition of macro '__pcpu_size_call_return'
     318 |         typeof(variable) pscr_ret__;                                    \
         |                ^~~~~~~~
   arch/arm64/include/asm/stacktrace.h:111:44: note: in expansion of macro 'raw_cpu_read'
     111 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_critical_ptr);
         |                                            ^~~~~~~~~~~~
   arch/arm64/kernel/traps.c: At top level:
   arch/arm64/kernel/traps.c:802:43: warning: initialized field overwritten [-Woverride-init]
     802 |         [ESR_ELx_EC_UNKNOWN]            = "Unknown/Uncategorized",
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:802:43: note: (near initialization for 'esr_class_str[0]')
   arch/arm64/kernel/traps.c:803:43: warning: initialized field overwritten [-Woverride-init]
     803 |         [ESR_ELx_EC_WFx]                = "WFI/WFE",
         |                                           ^~~~~~~~~
   arch/arm64/kernel/traps.c:803:43: note: (near initialization for 'esr_class_str[1]')
   arch/arm64/kernel/traps.c:804:43: warning: initialized field overwritten [-Woverride-init]
     804 |         [ESR_ELx_EC_CP15_32]            = "CP15 MCR/MRC",
         |                                           ^~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:804:43: note: (near initialization for 'esr_class_str[3]')
   arch/arm64/kernel/traps.c:805:43: warning: initialized field overwritten [-Woverride-init]
     805 |         [ESR_ELx_EC_CP15_64]            = "CP15 MCRR/MRRC",
         |                                           ^~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:805:43: note: (near initialization for 'esr_class_str[4]')
   arch/arm64/kernel/traps.c:806:43: warning: initialized field overwritten [-Woverride-init]
     806 |         [ESR_ELx_EC_CP14_MR]            = "CP14 MCR/MRC",
         |                                           ^~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:806:43: note: (near initialization for 'esr_class_str[5]')
   arch/arm64/kernel/traps.c:807:43: warning: initialized field overwritten [-Woverride-init]
     807 |         [ESR_ELx_EC_CP14_LS]            = "CP14 LDC/STC",
         |                                           ^~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:807:43: note: (near initialization for 'esr_class_str[6]')
   arch/arm64/kernel/traps.c:808:43: warning: initialized field overwritten [-Woverride-init]
     808 |         [ESR_ELx_EC_FP_ASIMD]           = "ASIMD",
         |                                           ^~~~~~~
   arch/arm64/kernel/traps.c:808:43: note: (near initialization for 'esr_class_str[7]')
   arch/arm64/kernel/traps.c:809:43: warning: initialized field overwritten [-Woverride-init]
     809 |         [ESR_ELx_EC_CP10_ID]            = "CP10 MRC/VMRS",
         |                                           ^~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:809:43: note: (near initialization for 'esr_class_str[8]')
   arch/arm64/kernel/traps.c:810:43: warning: initialized field overwritten [-Woverride-init]
     810 |         [ESR_ELx_EC_PAC]                = "PAC",
         |                                           ^~~~~
   arch/arm64/kernel/traps.c:810:43: note: (near initialization for 'esr_class_str[9]')
   arch/arm64/kernel/traps.c:811:43: warning: initialized field overwritten [-Woverride-init]
     811 |         [ESR_ELx_EC_CP14_64]            = "CP14 MCRR/MRRC",
         |                                           ^~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:811:43: note: (near initialization for 'esr_class_str[12]')
   arch/arm64/kernel/traps.c:812:43: warning: initialized field overwritten [-Woverride-init]
     812 |         [ESR_ELx_EC_BTI]                = "BTI",
         |                                           ^~~~~
   arch/arm64/kernel/traps.c:812:43: note: (near initialization for 'esr_class_str[13]')
   arch/arm64/kernel/traps.c:813:43: warning: initialized field overwritten [-Woverride-init]
     813 |         [ESR_ELx_EC_ILL]                = "PSTATE.IL",
         |                                           ^~~~~~~~~~~
   arch/arm64/kernel/traps.c:813:43: note: (near initialization for 'esr_class_str[14]')
   arch/arm64/kernel/traps.c:814:43: warning: initialized field overwritten [-Woverride-init]
     814 |         [ESR_ELx_EC_SVC32]              = "SVC (AArch32)",
         |                                           ^~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:814:43: note: (near initialization for 'esr_class_str[17]')
   arch/arm64/kernel/traps.c:815:43: warning: initialized field overwritten [-Woverride-init]
     815 |         [ESR_ELx_EC_HVC32]              = "HVC (AArch32)",
         |                                           ^~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:815:43: note: (near initialization for 'esr_class_str[18]')
   arch/arm64/kernel/traps.c:816:43: warning: initialized field overwritten [-Woverride-init]
     816 |         [ESR_ELx_EC_SMC32]              = "SMC (AArch32)",
         |                                           ^~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:816:43: note: (near initialization for 'esr_class_str[19]')
   arch/arm64/kernel/traps.c:817:43: warning: initialized field overwritten [-Woverride-init]
     817 |         [ESR_ELx_EC_SVC64]              = "SVC (AArch64)",
         |                                           ^~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:817:43: note: (near initialization for 'esr_class_str[21]')
   arch/arm64/kernel/traps.c:818:43: warning: initialized field overwritten [-Woverride-init]
     818 |         [ESR_ELx_EC_HVC64]              = "HVC (AArch64)",
         |                                           ^~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:818:43: note: (near initialization for 'esr_class_str[22]')
   arch/arm64/kernel/traps.c:819:43: warning: initialized field overwritten [-Woverride-init]
     819 |         [ESR_ELx_EC_SMC64]              = "SMC (AArch64)",
         |                                           ^~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:819:43: note: (near initialization for 'esr_class_str[23]')
   arch/arm64/kernel/traps.c:820:43: warning: initialized field overwritten [-Woverride-init]
     820 |         [ESR_ELx_EC_SYS64]              = "MSR/MRS (AArch64)",
         |                                           ^~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:820:43: note: (near initialization for 'esr_class_str[24]')
   arch/arm64/kernel/traps.c:821:43: warning: initialized field overwritten [-Woverride-init]
     821 |         [ESR_ELx_EC_SVE]                = "SVE",
         |                                           ^~~~~
   arch/arm64/kernel/traps.c:821:43: note: (near initialization for 'esr_class_str[25]')
   arch/arm64/kernel/traps.c:822:43: warning: initialized field overwritten [-Woverride-init]
     822 |         [ESR_ELx_EC_ERET]               = "ERET/ERETAA/ERETAB",
         |                                           ^~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:822:43: note: (near initialization for 'esr_class_str[26]')
   arch/arm64/kernel/traps.c:823:43: warning: initialized field overwritten [-Woverride-init]
     823 |         [ESR_ELx_EC_FPAC]               = "FPAC",
         |                                           ^~~~~~
   arch/arm64/kernel/traps.c:823:43: note: (near initialization for 'esr_class_str[28]')
   arch/arm64/kernel/traps.c:824:43: warning: initialized field overwritten [-Woverride-init]
     824 |         [ESR_ELx_EC_IMP_DEF]            = "EL3 IMP DEF",
         |                                           ^~~~~~~~~~~~~
--
   In file included from include/asm-generic/percpu.h:7,
                    from arch/arm64/include/asm/percpu.h:248,
                    from include/linux/irqflags.h:17,
                    from include/linux/spinlock.h:58,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from kernel/fork.c:16:
   arch/arm64/include/asm/stacktrace.h: In function 'on_sdei_normal_stack':
>> arch/arm64/include/asm/stacktrace.h:102:57: error: 'sdei_stack_normal_ptr' undeclared (first use in this function)
     102 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
         |                                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:318:16: note: in definition of macro '__pcpu_size_call_return'
     318 |         typeof(variable) pscr_ret__;                                    \
         |                ^~~~~~~~
   arch/arm64/include/asm/stacktrace.h:102:44: note: in expansion of macro 'raw_cpu_read'
     102 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
         |                                            ^~~~~~~~~~~~
   arch/arm64/include/asm/stacktrace.h:102:57: note: each undeclared identifier is reported only once for each function it appears in
     102 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
         |                                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:318:16: note: in definition of macro '__pcpu_size_call_return'
     318 |         typeof(variable) pscr_ret__;                                    \
         |                ^~~~~~~~
   arch/arm64/include/asm/stacktrace.h:102:44: note: in expansion of macro 'raw_cpu_read'
     102 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
         |                                            ^~~~~~~~~~~~
   arch/arm64/include/asm/stacktrace.h: In function 'on_sdei_critical_stack':
>> arch/arm64/include/asm/stacktrace.h:111:57: error: 'sdei_stack_critical_ptr' undeclared (first use in this function)
     111 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_critical_ptr);
         |                                                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:318:16: note: in definition of macro '__pcpu_size_call_return'
     318 |         typeof(variable) pscr_ret__;                                    \
         |                ^~~~~~~~
   arch/arm64/include/asm/stacktrace.h:111:44: note: in expansion of macro 'raw_cpu_read'
     111 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_critical_ptr);
         |                                            ^~~~~~~~~~~~
   kernel/fork.c: At top level:
   kernel/fork.c:853:20: warning: no previous prototype for 'arch_task_cache_init' [-Wmissing-prototypes]
     853 | void __init __weak arch_task_cache_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~
--
   In file included from include/asm-generic/percpu.h:7,
                    from arch/arm64/include/asm/percpu.h:248,
                    from include/linux/irqflags.h:17,
                    from include/linux/rcupdate.h:26,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/stackleak.h:5,
                    from kernel/stackleak.c:13:
   arch/arm64/include/asm/stacktrace.h: In function 'on_sdei_normal_stack':
>> arch/arm64/include/asm/stacktrace.h:102:57: error: 'sdei_stack_normal_ptr' undeclared (first use in this function)
     102 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
         |                                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:318:16: note: in definition of macro '__pcpu_size_call_return'
     318 |         typeof(variable) pscr_ret__;                                    \
         |                ^~~~~~~~
   arch/arm64/include/asm/stacktrace.h:102:44: note: in expansion of macro 'raw_cpu_read'
     102 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
         |                                            ^~~~~~~~~~~~
   arch/arm64/include/asm/stacktrace.h:102:57: note: each undeclared identifier is reported only once for each function it appears in
     102 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
         |                                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:318:16: note: in definition of macro '__pcpu_size_call_return'
     318 |         typeof(variable) pscr_ret__;                                    \
         |                ^~~~~~~~
   arch/arm64/include/asm/stacktrace.h:102:44: note: in expansion of macro 'raw_cpu_read'
     102 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
         |                                            ^~~~~~~~~~~~
   arch/arm64/include/asm/stacktrace.h: In function 'on_sdei_critical_stack':
>> arch/arm64/include/asm/stacktrace.h:111:57: error: 'sdei_stack_critical_ptr' undeclared (first use in this function)
     111 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_critical_ptr);
         |                                                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:318:16: note: in definition of macro '__pcpu_size_call_return'
     318 |         typeof(variable) pscr_ret__;                                    \
         |                ^~~~~~~~
   arch/arm64/include/asm/stacktrace.h:111:44: note: in expansion of macro 'raw_cpu_read'
     111 |         unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_critical_ptr);
         |                                            ^~~~~~~~~~~~
   kernel/stackleak.c: At top level:
   kernel/stackleak.c:73:25: warning: no previous prototype for 'stackleak_erase' [-Wmissing-prototypes]
      73 | asmlinkage void noinstr stackleak_erase(void)
         |                         ^~~~~~~~~~~~~~~
   kernel/stackleak.c:128:49: warning: no previous prototype for 'stackleak_track_stack' [-Wmissing-prototypes]
     128 | void __used __no_caller_saved_registers noinstr stackleak_track_stack(void)
         |                                                 ^~~~~~~~~~~~~~~~~~~~~


vim +/sdei_stack_normal_ptr +102 arch/arm64/include/asm/stacktrace.h

    98	
    99	static inline bool on_sdei_normal_stack(unsigned long sp, unsigned long size,
   100						struct stack_info *info)
   101	{
 > 102		unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
   103		unsigned long high = low + SDEI_STACK_SIZE;
   104	
   105		return on_stack(sp, size, low, high, STACK_TYPE_SDEI_NORMAL, info);
   106	}
   107	
   108	static inline bool on_sdei_critical_stack(unsigned long sp, unsigned long size,
   109						  struct stack_info *info)
   110	{
 > 111		unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_critical_ptr);
   112		unsigned long high = low + SDEI_STACK_SIZE;
   113	
   114		return on_stack(sp, size, low, high, STACK_TYPE_SDEI_CRITICAL, info);
   115	}
   116	#else
   117	static inline bool on_sdei_normal_stack(unsigned long sp, unsigned long size,
   118						struct stack_info *info)
   119	{
   120		return false;
   121	}
   122	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
