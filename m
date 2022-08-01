Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7075866AE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiHAJDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiHAJD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:03:28 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4453B96E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 02:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659344603; x=1690880603;
  h=subject:references:to:cc:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=peUsnCn+VpGM0wv+WsonlTaAtdoxQsEllP47+xeRC4Q=;
  b=NCiKzPruQvySi5JhSElWZNewY9A191FQnLzUImSXH9BF2frjEMFm/jDG
   mwNwwrd9u69bpqz7IFkFiGPLGu6IHm9gvR8/32aKsCDSaiKpnExDKbrrr
   gD75AJsvjd3HTg0yL7LABMGc18NYodG4cyOHlCGEM3SXOkNwKrEpohVrC
   OQPWBi5KVbjkdPNBdlLSvU5qhcGWspB6k3uly9svY6C5LrjyuOGqcZO23
   4DKZfbzd86f6kZnBL+4wlWy461WVYH5BMHO/BRS4FUCB7aIv9x8flzpfh
   fefl5yKGEICFs6ciVjGmE/kaaczKa+L8rQBQhl2n7AtSaWZmXw0QrpFga
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="287856506"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="287856506"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 02:03:22 -0700
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="661065657"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.172.209]) ([10.249.172.209])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 02:03:20 -0700
Subject: [mark:arm64/stacktrace/rework-cleanup 3/8]
 arch/arm64/include/asm/stacktrace.h:70:57: error: 'sdei_stack_normal_ptr'
 undeclared
References: <202207301421.sXiXP6tR-lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        linux-kernel@vger.kernel.org
From:   kernel test robot <rong.a.chen@intel.com>
X-Forwarded-Message-Id: <202207301421.sXiXP6tR-lkp@intel.com>
Message-ID: <79409409-613f-ebf4-800a-01e8e4ab4d8f@intel.com>
Date:   Mon, 1 Aug 2022 17:03:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <202207301421.sXiXP6tR-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git 
arm64/stacktrace/rework-cleanup
head:   37ad2f60a7f96676259bde924cf329d652c75e2c
commit: 365ef1c2e3f77492fef937e652f3f85a1818c7f3 [3/8] arm64: 
stacktrace: move SDEI stack helpers to stacktrace code
config: arm64-allyesconfig 
(https://download.01.org/0day-ci/archive/20220730/202207301421.sXiXP6tR-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
         wget 
https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
-O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # 
https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=365ef1c2e3f77492fef937e652f3f85a1818c7f3
         git remote add mark 
https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
         git fetch --no-tags mark arm64/stacktrace/rework-cleanup
         git checkout 365ef1c2e3f77492fef937e652f3f85a1818c7f3
         # save the config file
         mkdir build_dir && cp config build_dir/.config
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross 
W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

    In file included from include/asm-generic/percpu.h:7,
                     from arch/arm64/include/asm/percpu.h:249,
                     from include/linux/irqflags.h:17,
                     from include/linux/rcupdate.h:26,
                     from include/linux/rculist.h:11,
                     from include/linux/pid.h:5,
                     from include/linux/sched.h:14,
                     from include/linux/context_tracking.h:5,
                     from arch/arm64/kernel/entry-common.c:8:
    arch/arm64/include/asm/stacktrace.h: In function 'on_sdei_normal_stack':
>> arch/arm64/include/asm/stacktrace.h:70:57: error: 'sdei_stack_normal_ptr' undeclared (first use in this function)
       70 |         unsigned long low = (unsigned 
long)raw_cpu_read(sdei_stack_normal_ptr);
          | 
^~~~~~~~~~~~~~~~~~~~~
    include/linux/percpu-defs.h:318:16: note: in definition of macro 
'__pcpu_size_call_return'
      318 |         typeof(variable) pscr_ret__; 
             \
          |                ^~~~~~~~
    arch/arm64/include/asm/stacktrace.h:70:44: note: in expansion of 
macro 'raw_cpu_read'
       70 |         unsigned long low = (unsigned 
long)raw_cpu_read(sdei_stack_normal_ptr);
          |                                            ^~~~~~~~~~~~
    arch/arm64/include/asm/stacktrace.h:70:57: note: each undeclared 
identifier is reported only once for each function it appears in
       70 |         unsigned long low = (unsigned 
long)raw_cpu_read(sdei_stack_normal_ptr);
          | 
^~~~~~~~~~~~~~~~~~~~~
    include/linux/percpu-defs.h:318:16: note: in definition of macro 
'__pcpu_size_call_return'
      318 |         typeof(variable) pscr_ret__; 
             \
          |                ^~~~~~~~
    arch/arm64/include/asm/stacktrace.h:70:44: note: in expansion of 
macro 'raw_cpu_read'
       70 |         unsigned long low = (unsigned 
long)raw_cpu_read(sdei_stack_normal_ptr);
          |                                            ^~~~~~~~~~~~
    arch/arm64/include/asm/stacktrace.h: In function 
'on_sdei_critical_stack':
>> arch/arm64/include/asm/stacktrace.h:79:57: error: 'sdei_stack_critical_ptr' undeclared (first use in this function)
       79 |         unsigned long low = (unsigned 
long)raw_cpu_read(sdei_stack_critical_ptr);
          | 
^~~~~~~~~~~~~~~~~~~~~~~
    include/linux/percpu-defs.h:318:16: note: in definition of macro 
'__pcpu_size_call_return'
      318 |         typeof(variable) pscr_ret__; 
             \
          |                ^~~~~~~~
    arch/arm64/include/asm/stacktrace.h:79:44: note: in expansion of 
macro 'raw_cpu_read'
       79 |         unsigned long low = (unsigned 
long)raw_cpu_read(sdei_stack_critical_ptr);
          |                                            ^~~~~~~~~~~~
--
    In file included from include/asm-generic/percpu.h:7,
                     from arch/arm64/include/asm/percpu.h:249,
                     from include/linux/irqflags.h:17,
                     from include/linux/rcupdate.h:26,
                     from include/linux/rculist.h:11,
                     from include/linux/pid.h:5,
                     from include/linux/sched.h:14,
                     from include/linux/audit.h:12,
                     from arch/arm64/kernel/ptrace.c:11:
    arch/arm64/include/asm/stacktrace.h: In function 'on_sdei_normal_stack':
>> arch/arm64/include/asm/stacktrace.h:70:57: error: 'sdei_stack_normal_ptr' undeclared (first use in this function)
       70 |         unsigned long low = (unsigned 
long)raw_cpu_read(sdei_stack_normal_ptr);
          | 
^~~~~~~~~~~~~~~~~~~~~
    include/linux/percpu-defs.h:318:16: note: in definition of macro 
'__pcpu_size_call_return'
      318 |         typeof(variable) pscr_ret__; 
             \
          |                ^~~~~~~~
    arch/arm64/include/asm/stacktrace.h:70:44: note: in expansion of 
macro 'raw_cpu_read'
       70 |         unsigned long low = (unsigned 
long)raw_cpu_read(sdei_stack_normal_ptr);
          |                                            ^~~~~~~~~~~~
    arch/arm64/include/asm/stacktrace.h:70:57: note: each undeclared 
identifier is reported only once for each function it appears in
       70 |         unsigned long low = (unsigned 
long)raw_cpu_read(sdei_stack_normal_ptr);
          | 
^~~~~~~~~~~~~~~~~~~~~
    include/linux/percpu-defs.h:318:16: note: in definition of macro 
'__pcpu_size_call_return'
      318 |         typeof(variable) pscr_ret__; 
             \
          |                ^~~~~~~~
    arch/arm64/include/asm/stacktrace.h:70:44: note: in expansion of 
macro 'raw_cpu_read'
       70 |         unsigned long low = (unsigned 
long)raw_cpu_read(sdei_stack_normal_ptr);
          |                                            ^~~~~~~~~~~~
    arch/arm64/include/asm/stacktrace.h: In function 
'on_sdei_critical_stack':
>> arch/arm64/include/asm/stacktrace.h:79:57: error: 'sdei_stack_critical_ptr' undeclared (first use in this function)
       79 |         unsigned long low = (unsigned 
long)raw_cpu_read(sdei_stack_critical_ptr);
          | 
^~~~~~~~~~~~~~~~~~~~~~~
    include/linux/percpu-defs.h:318:16: note: in definition of macro 
'__pcpu_size_call_return'
      318 |         typeof(variable) pscr_ret__; 
             \
          |                ^~~~~~~~
    arch/arm64/include/asm/stacktrace.h:79:44: note: in expansion of 
macro 'raw_cpu_read'
       79 |         unsigned long low = (unsigned 
long)raw_cpu_read(sdei_stack_critical_ptr);
          |                                            ^~~~~~~~~~~~
    arch/arm64/kernel/ptrace.c: At top level:
    arch/arm64/kernel/ptrace.c:2112:5: warning: no previous prototype 
for 'syscall_trace_enter' [-Wmissing-prototypes]
     2112 | int syscall_trace_enter(struct pt_regs *regs)
          |     ^~~~~~~~~~~~~~~~~~~
    arch/arm64/kernel/ptrace.c:2135:6: warning: no previous prototype 
for 'syscall_trace_exit' [-Wmissing-prototypes]
     2135 | void syscall_trace_exit(struct pt_regs *regs)
          |      ^~~~~~~~~~~~~~~~~~
--
    In file included from include/asm-generic/percpu.h:7,
                     from arch/arm64/include/asm/percpu.h:249,
                     from include/linux/irqflags.h:17,
                     from include/linux/rcupdate.h:26,
                     from include/linux/rculist.h:11,
                     from include/linux/pid.h:5,
                     from include/linux/sched.h:14,
                     from include/linux/context_tracking.h:5,
                     from arch/arm64/kernel/traps.c:10:
    arch/arm64/include/asm/stacktrace.h: In function 'on_sdei_normal_stack':
>> arch/arm64/include/asm/stacktrace.h:70:57: error: 'sdei_stack_normal_ptr' undeclared (first use in this function)
       70 |         unsigned long low = (unsigned 
long)raw_cpu_read(sdei_stack_normal_ptr);
          | 
^~~~~~~~~~~~~~~~~~~~~
    include/linux/percpu-defs.h:318:16: note: in definition of macro 
'__pcpu_size_call_return'
      318 |         typeof(variable) pscr_ret__; 
             \
          |                ^~~~~~~~
    arch/arm64/include/asm/stacktrace.h:70:44: note: in expansion of 
macro 'raw_cpu_read'
       70 |         unsigned long low = (unsigned 
long)raw_cpu_read(sdei_stack_normal_ptr);
          |                                            ^~~~~~~~~~~~
    arch/arm64/include/asm/stacktrace.h:70:57: note: each undeclared 
identifier is reported only once for each function it appears in
       70 |         unsigned long low = (unsigned 
long)raw_cpu_read(sdei_stack_normal_ptr);
          | 
^~~~~~~~~~~~~~~~~~~~~
    include/linux/percpu-defs.h:318:16: note: in definition of macro 
'__pcpu_size_call_return'
      318 |         typeof(variable) pscr_ret__; 
             \
          |                ^~~~~~~~
    arch/arm64/include/asm/stacktrace.h:70:44: note: in expansion of 
macro 'raw_cpu_read'
       70 |         unsigned long low = (unsigned 
long)raw_cpu_read(sdei_stack_normal_ptr);
          |                                            ^~~~~~~~~~~~
    arch/arm64/include/asm/stacktrace.h: In function 
'on_sdei_critical_stack':
>> arch/arm64/include/asm/stacktrace.h:79:57: error: 'sdei_stack_critical_ptr' undeclared (first use in this function)
       79 |         unsigned long low = (unsigned 
long)raw_cpu_read(sdei_stack_critical_ptr);
          | 
^~~~~~~~~~~~~~~~~~~~~~~
    include/linux/percpu-defs.h:318:16: note: in definition of macro 
'__pcpu_size_call_return'
      318 |         typeof(variable) pscr_ret__; 
             \
          |                ^~~~~~~~
    arch/arm64/include/asm/stacktrace.h:79:44: note: in expansion of 
macro 'raw_cpu_read'
       79 |         unsigned long low = (unsigned 
long)raw_cpu_read(sdei_stack_critical_ptr);
          |                                            ^~~~~~~~~~~~
    arch/arm64/kernel/traps.c: At top level:
    arch/arm64/kernel/traps.c:802:43: warning: initialized field 
overwritten [-Woverride-init]
      802 |         [ESR_ELx_EC_UNKNOWN]            = 
"Unknown/Uncategorized",
          | 
^~~~~~~~~~~~~~~~~~~~~~~
    arch/arm64/kernel/traps.c:802:43: note: (near initialization for 
'esr_class_str[0]')
    arch/arm64/kernel/traps.c:803:43: warning: initialized field 
overwritten [-Woverride-init]
      803 |         [ESR_ELx_EC_WFx]                = "WFI/WFE",
          |                                           ^~~~~~~~~
    arch/arm64/kernel/traps.c:803:43: note: (near initialization for 
'esr_class_str[1]')
    arch/arm64/kernel/traps.c:804:43: warning: initialized field 
overwritten [-Woverride-init]
      804 |         [ESR_ELx_EC_CP15_32]            = "CP15 MCR/MRC",
          |                                           ^~~~~~~~~~~~~~
    arch/arm64/kernel/traps.c:804:43: note: (near initialization for 
'esr_class_str[3]')
    arch/arm64/kernel/traps.c:805:43: warning: initialized field 
overwritten [-Woverride-init]
      805 |         [ESR_ELx_EC_CP15_64]            = "CP15 MCRR/MRRC",
          |                                           ^~~~~~~~~~~~~~~~
    arch/arm64/kernel/traps.c:805:43: note: (near initialization for 
'esr_class_str[4]')
    arch/arm64/kernel/traps.c:806:43: warning: initialized field 
overwritten [-Woverride-init]
      806 |         [ESR_ELx_EC_CP14_MR]            = "CP14 MCR/MRC",
          |                                           ^~~~~~~~~~~~~~
    arch/arm64/kernel/traps.c:806:43: note: (near initialization for 
'esr_class_str[5]')
    arch/arm64/kernel/traps.c:807:43: warning: initialized field 
overwritten [-Woverride-init]
      807 |         [ESR_ELx_EC_CP14_LS]            = "CP14 LDC/STC",
          |                                           ^~~~~~~~~~~~~~
    arch/arm64/kernel/traps.c:807:43: note: (near initialization for 
'esr_class_str[6]')
    arch/arm64/kernel/traps.c:808:43: warning: initialized field 
overwritten [-Woverride-init]
      808 |         [ESR_ELx_EC_FP_ASIMD]           = "ASIMD",
          |                                           ^~~~~~~
    arch/arm64/kernel/traps.c:808:43: note: (near initialization for 
'esr_class_str[7]')
    arch/arm64/kernel/traps.c:809:43: warning: initialized field 
overwritten [-Woverride-init]
      809 |         [ESR_ELx_EC_CP10_ID]            = "CP10 MRC/VMRS",
          |                                           ^~~~~~~~~~~~~~~
    arch/arm64/kernel/traps.c:809:43: note: (near initialization for 
'esr_class_str[8]')
    arch/arm64/kernel/traps.c:810:43: warning: initialized field 
overwritten [-Woverride-init]
      810 |         [ESR_ELx_EC_PAC]                = "PAC",
          |                                           ^~~~~
    arch/arm64/kernel/traps.c:810:43: note: (near initialization for 
'esr_class_str[9]')
    arch/arm64/kernel/traps.c:811:43: warning: initialized field 
overwritten [-Woverride-init]
      811 |         [ESR_ELx_EC_CP14_64]            = "CP14 MCRR/MRRC",
          |                                           ^~~~~~~~~~~~~~~~
    arch/arm64/kernel/traps.c:811:43: note: (near initialization for 
'esr_class_str[12]')
    arch/arm64/kernel/traps.c:812:43: warning: initialized field 
overwritten [-Woverride-init]
      812 |         [ESR_ELx_EC_BTI]                = "BTI",
          |                                           ^~~~~
    arch/arm64/kernel/traps.c:812:43: note: (near initialization for 
'esr_class_str[13]')
    arch/arm64/kernel/traps.c:813:43: warning: initialized field 
overwritten [-Woverride-init]
      813 |         [ESR_ELx_EC_ILL]                = "PSTATE.IL",
          |                                           ^~~~~~~~~~~
    arch/arm64/kernel/traps.c:813:43: note: (near initialization for 
'esr_class_str[14]')
    arch/arm64/kernel/traps.c:814:43: warning: initialized field 
overwritten [-Woverride-init]
      814 |         [ESR_ELx_EC_SVC32]              = "SVC (AArch32)",
          |                                           ^~~~~~~~~~~~~~~
    arch/arm64/kernel/traps.c:814:43: note: (near initialization for 
'esr_class_str[17]')
    arch/arm64/kernel/traps.c:815:43: warning: initialized field 
overwritten [-Woverride-init]
      815 |         [ESR_ELx_EC_HVC32]              = "HVC (AArch32)",
          |                                           ^~~~~~~~~~~~~~~
    arch/arm64/kernel/traps.c:815:43: note: (near initialization for 
'esr_class_str[18]')
    arch/arm64/kernel/traps.c:816:43: warning: initialized field 
overwritten [-Woverride-init]
      816 |         [ESR_ELx_EC_SMC32]              = "SMC (AArch32)",
          |                                           ^~~~~~~~~~~~~~~
    arch/arm64/kernel/traps.c:816:43: note: (near initialization for 
'esr_class_str[19]')
    arch/arm64/kernel/traps.c:817:43: warning: initialized field 
overwritten [-Woverride-init]
      817 |         [ESR_ELx_EC_SVC64]              = "SVC (AArch64)",
          |                                           ^~~~~~~~~~~~~~~
    arch/arm64/kernel/traps.c:817:43: note: (near initialization for 
'esr_class_str[21]')
    arch/arm64/kernel/traps.c:818:43: warning: initialized field 
overwritten [-Woverride-init]
      818 |         [ESR_ELx_EC_HVC64]              = "HVC (AArch64)",
          |                                           ^~~~~~~~~~~~~~~
    arch/arm64/kernel/traps.c:818:43: note: (near initialization for 
'esr_class_str[22]')
    arch/arm64/kernel/traps.c:819:43: warning: initialized field 
overwritten [-Woverride-init]
      819 |         [ESR_ELx_EC_SMC64]              = "SMC (AArch64)",
          |                                           ^~~~~~~~~~~~~~~
    arch/arm64/kernel/traps.c:819:43: note: (near initialization for 
'esr_class_str[23]')
    arch/arm64/kernel/traps.c:820:43: warning: initialized field 
overwritten [-Woverride-init]
      820 |         [ESR_ELx_EC_SYS64]              = "MSR/MRS (AArch64)",
          |                                           ^~~~~~~~~~~~~~~~~~~
    arch/arm64/kernel/traps.c:820:43: note: (near initialization for 
'esr_class_str[24]')
    arch/arm64/kernel/traps.c:821:43: warning: initialized field 
overwritten [-Woverride-init]
      821 |         [ESR_ELx_EC_SVE]                = "SVE",
          |                                           ^~~~~
    arch/arm64/kernel/traps.c:821:43: note: (near initialization for 
'esr_class_str[25]')
    arch/arm64/kernel/traps.c:822:43: warning: initialized field 
overwritten [-Woverride-init]
      822 |         [ESR_ELx_EC_ERET]               = "ERET/ERETAA/ERETAB",
          |                                           ^~~~~~~~~~~~~~~~~~~~
    arch/arm64/kernel/traps.c:822:43: note: (near initialization for 
'esr_class_str[26]')
    arch/arm64/kernel/traps.c:823:43: warning: initialized field 
overwritten [-Woverride-init]
      823 |         [ESR_ELx_EC_FPAC]               = "FPAC",
          |                                           ^~~~~~
    arch/arm64/kernel/traps.c:823:43: note: (near initialization for 
'esr_class_str[28]')
    arch/arm64/kernel/traps.c:824:43: warning: initialized field 
overwritten [-Woverride-init]
      824 |         [ESR_ELx_EC_SME]                = "SME",
          |                                           ^~~~~


vim +/sdei_stack_normal_ptr +70 arch/arm64/include/asm/stacktrace.h

365ef1c2e3f7749 Mark Rutland 2022-04-14  66  365ef1c2e3f7749 Mark 
Rutland 2022-04-14  67  static inline bool on_sdei_normal_stack(unsigned 
long sp, unsigned long size,
365ef1c2e3f7749 Mark Rutland 2022-04-14  68  					struct stack_info *info)
365ef1c2e3f7749 Mark Rutland 2022-04-14  69  {
365ef1c2e3f7749 Mark Rutland 2022-04-14 @70  	unsigned long low = 
(unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
365ef1c2e3f7749 Mark Rutland 2022-04-14  71  	unsigned long high = low + 
SDEI_STACK_SIZE;
365ef1c2e3f7749 Mark Rutland 2022-04-14  72  365ef1c2e3f7749 Mark 
Rutland 2022-04-14  73  	return on_stack(sp, size, low, high, 
STACK_TYPE_SDEI_NORMAL, info);
365ef1c2e3f7749 Mark Rutland 2022-04-14  74  }
365ef1c2e3f7749 Mark Rutland 2022-04-14  75  365ef1c2e3f7749 Mark 
Rutland 2022-04-14  76  static inline bool 
on_sdei_critical_stack(unsigned long sp, unsigned long size,
365ef1c2e3f7749 Mark Rutland 2022-04-14  77  					  struct stack_info *info)
365ef1c2e3f7749 Mark Rutland 2022-04-14  78  {
365ef1c2e3f7749 Mark Rutland 2022-04-14 @79  	unsigned long low = 
(unsigned long)raw_cpu_read(sdei_stack_critical_ptr);
365ef1c2e3f7749 Mark Rutland 2022-04-14  80  	unsigned long high = low + 
SDEI_STACK_SIZE;
365ef1c2e3f7749 Mark Rutland 2022-04-14  81  365ef1c2e3f7749 Mark 
Rutland 2022-04-14  82  	return on_stack(sp, size, low, high, 
STACK_TYPE_SDEI_CRITICAL, info);
365ef1c2e3f7749 Mark Rutland 2022-04-14  83  }
365ef1c2e3f7749 Mark Rutland 2022-04-14  84  #else
365ef1c2e3f7749 Mark Rutland 2022-04-14  85  static inline bool 
on_sdei_normal_stack(unsigned long sp, unsigned long size,
365ef1c2e3f7749 Mark Rutland 2022-04-14  86  					struct stack_info *info)
365ef1c2e3f7749 Mark Rutland 2022-04-14  87  {
365ef1c2e3f7749 Mark Rutland 2022-04-14  88  	return false;
365ef1c2e3f7749 Mark Rutland 2022-04-14  89  }
365ef1c2e3f7749 Mark Rutland 2022-04-14  90
-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org
