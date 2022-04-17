Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6645150463A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 06:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbiDQEOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 00:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiDQEOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 00:14:02 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900E024940
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 21:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650168687; x=1681704687;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=R6snIBSE0Ns1xWc1TQprKBkaUYfOcyOiQu7IMY2eMr0=;
  b=MAmU1Q5aPO7hODd+bFXNhgepBAVtq88u6tnzV6yM2Re8Vi2lOf/fodY5
   xFZewI0OkvdhlHoXshLxIizBMpfHVOpYooKFJsevFMO+eiK+fC32wZ8Ay
   geK7wgWkZf8Zt88P1SwxlTUKzzaSKVAv0uT4XKadzpJs6Ouuz+Eh5cAv/
   3M+dh0V/+wpH757D5PyV+s1ORuIqMs/1feOPhha2ya33mmUWP+gec1y9G
   w54s9P+yY04/seoOoGrMgqcPElx6D2WqdHnnQmtmjE9z73Wjw6ZpU7pze
   PZrleakJ77XrMIKAjVnCymoHC/Q19VDhWjw0D3kxpuFvnmTWgurpCsv00
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="263533781"
X-IronPort-AV: E=Sophos;i="5.90,266,1643702400"; 
   d="scan'208";a="263533781"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2022 21:11:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,266,1643702400"; 
   d="scan'208";a="624944467"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 16 Apr 2022 21:11:25 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfwFx-0003gV-8j;
        Sun, 17 Apr 2022 04:11:25 +0000
Date:   Sun, 17 Apr 2022 12:11:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:arm64/stacktrace/speedups 9/9]
 arch/arm64/include/asm/stacktrace.h:102:57: error: 'sdei_stack_normal_ptr'
 undeclared
Message-ID: <202204171236.O3pFdS1J-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/stacktrace/speedups
head:   481959ff932d344c5dc29591d2be4108adf0403b
commit: 481959ff932d344c5dc29591d2be4108adf0403b [9/9] WIP: arm64: move SDEI stack bits into stacktrace.h
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220417/202204171236.O3pFdS1J-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=481959ff932d344c5dc29591d2be4108adf0403b
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark arm64/stacktrace/speedups
        git checkout 481959ff932d344c5dc29591d2be4108adf0403b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/percpu.h:7,
                    from arch/arm64/include/asm/percpu.h:248,
                    from arch/arm64/include/asm/smp.h:28,
                    from include/linux/smp.h:113,
                    from include/linux/lockdep.h:14,
                    from include/linux/mutex.h:17,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from include/acpi/apei.h:9,
                    from include/acpi/ghes.h:5,
                    from include/linux/arm_sdei.h:8,
                    from arch/arm64/kernel/sdei.c:6:
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
   kernel/stackleak.c: In function 'stackleak_erase':
   kernel/stackleak.c:117:26: warning: assignment to 'long unsigned int' from 'void *' makes integer from pointer without a cast [-Wint-conversion]
     117 |                 boundary = current_top_of_stack();
         |                          ^
   kernel/stackleak.c:125:31: warning: assignment to 'long unsigned int' from 'void *' makes integer from pointer without a cast [-Wint-conversion]
     125 |         current->lowest_stack = current_top_of_stack() - THREAD_SIZE/64;
         |                               ^
   kernel/stackleak.c: At top level:
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
