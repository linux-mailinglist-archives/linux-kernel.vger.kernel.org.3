Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EF153AB97
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 19:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356258AbiFARMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 13:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244187AbiFARM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 13:12:26 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F001F3ED16
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 10:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654103544; x=1685639544;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nGglPDlCqjjO8RUUp2MmxPA0zaTaZJ9LdvslMUANf/Y=;
  b=ON/ok0/9rKiesNj/DBtgu7OioHMSqHB9z/0SgkRgMBLR4+k+y/1tZr+3
   NE9an3STNnGJEhenTPmZCrht+7olYpSEYTfD+rR7ZfIAh8a1C8sFC1ibm
   RlgMEpFFvZ5m4du4/uFFCknAjFtB2OR+R2UG3rvXnZeYi11g5y5w0rg03
   sVLcnMR8GmkK7NeNVaN3x0w3R1oLucvaFAa5AAgCkBoTrvqM1imILpLFP
   5N/fzkbMndKctQ2PKFyIgDBir6B86rOmt/RD+aQCNIp4aU4AC48CXhN6E
   NNbD1252knLsJQzatQ1QvACtDuMiLVAFNkn6A+uDR13kufIoITBGE8tt0
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="274463256"
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="274463256"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 10:12:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="530157984"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 Jun 2022 10:12:11 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwRtD-0004Du-0z;
        Wed, 01 Jun 2022 17:12:11 +0000
Date:   Thu, 2 Jun 2022 01:11:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:arm64/ftrace/minimal-regs 5/6]
 arch/x86/include/asm/ftrace.h:47:32: error: implicit declaration of function
 'ftrace_get_regs'
Message-ID: <202206020125.fCHkOl8F-lkp@intel.com>
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
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20220602/202206020125.fCHkOl8F-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=c694698df7f633bcbdf8bc0edb94f4a70ed0d092
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark arm64/ftrace/minimal-regs
        git checkout c694698df7f633bcbdf8bc0edb94f4a70ed0d092
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/ftrace.h:23,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/trace_events.h:21,
                    from include/trace/define_trace.h:102,
                    from include/trace/events/ext4.h:2941,
                    from fs/ext4/super.c:61:
   arch/x86/include/asm/ftrace.h:45:57: warning: 'struct ftrace_regs' declared inside parameter list will not be visible outside of this definition or declaration
      45 | static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsigned long addr)
         |                                                         ^~~~~~~~~~~
   arch/x86/include/asm/ftrace.h: In function 'arch_ftrace_set_direct_caller':
>> arch/x86/include/asm/ftrace.h:47:32: error: implicit declaration of function 'ftrace_get_regs' [-Werror=implicit-function-declaration]
      47 |         struct pt_regs *regs = ftrace_get_regs(fregs);
         |                                ^~~~~~~~~~~~~~~
   arch/x86/include/asm/ftrace.h:47:32: warning: initialization of 'struct pt_regs *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   In file included from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/trace_events.h:21,
                    from include/trace/define_trace.h:102,
                    from include/trace/events/ext4.h:2941,
                    from fs/ext4/super.c:61:
   include/linux/ftrace.h: At top level:
>> include/linux/ftrace.h:121:40: error: conflicting types for 'ftrace_get_regs'; have 'struct pt_regs *(struct ftrace_regs *)'
     121 | static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
         |                                        ^~~~~~~~~~~~~~~
   In file included from include/linux/ftrace.h:23,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/trace_events.h:21,
                    from include/trace/define_trace.h:102,
                    from include/trace/events/ext4.h:2941,
                    from fs/ext4/super.c:61:
   arch/x86/include/asm/ftrace.h:47:32: note: previous implicit declaration of 'ftrace_get_regs' with type 'int()'
      47 |         struct pt_regs *regs = ftrace_get_regs(fregs);
         |                                ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/ftrace.h:23,
                    from include/linux/perf_event.h:51,
                    from include/linux/nd.h:11,
                    from drivers/acpi/nfit/core.c:17:
   arch/x86/include/asm/ftrace.h:45:57: warning: 'struct ftrace_regs' declared inside parameter list will not be visible outside of this definition or declaration
      45 | static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsigned long addr)
         |                                                         ^~~~~~~~~~~
   arch/x86/include/asm/ftrace.h: In function 'arch_ftrace_set_direct_caller':
>> arch/x86/include/asm/ftrace.h:47:32: error: implicit declaration of function 'ftrace_get_regs' [-Werror=implicit-function-declaration]
      47 |         struct pt_regs *regs = ftrace_get_regs(fregs);
         |                                ^~~~~~~~~~~~~~~
   arch/x86/include/asm/ftrace.h:47:32: warning: initialization of 'struct pt_regs *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   In file included from include/linux/perf_event.h:51,
                    from include/linux/nd.h:11,
                    from drivers/acpi/nfit/core.c:17:
   include/linux/ftrace.h: At top level:
>> include/linux/ftrace.h:121:40: error: conflicting types for 'ftrace_get_regs'; have 'struct pt_regs *(struct ftrace_regs *)'
     121 | static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
         |                                        ^~~~~~~~~~~~~~~
   In file included from include/linux/ftrace.h:23,
                    from include/linux/perf_event.h:51,
                    from include/linux/nd.h:11,
                    from drivers/acpi/nfit/core.c:17:
   arch/x86/include/asm/ftrace.h:47:32: note: previous implicit declaration of 'ftrace_get_regs' with type 'int()'
      47 |         struct pt_regs *regs = ftrace_get_regs(fregs);
         |                                ^~~~~~~~~~~~~~~
   drivers/acpi/nfit/core.c:1717:13: warning: no previous prototype for 'nfit_intel_shutdown_status' [-Wmissing-prototypes]
    1717 | __weak void nfit_intel_shutdown_status(struct nfit_mem *nfit_mem)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/ftrace.h:23,
                    from include/linux/perf_event.h:51,
                    from include/linux/nd.h:11,
                    from drivers/nvdimm/nd-core.h:11,
                    from drivers/nvdimm/dimm_devs.c:14:
   arch/x86/include/asm/ftrace.h:45:57: warning: 'struct ftrace_regs' declared inside parameter list will not be visible outside of this definition or declaration
      45 | static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsigned long addr)
         |                                                         ^~~~~~~~~~~
   arch/x86/include/asm/ftrace.h: In function 'arch_ftrace_set_direct_caller':
>> arch/x86/include/asm/ftrace.h:47:32: error: implicit declaration of function 'ftrace_get_regs' [-Werror=implicit-function-declaration]
      47 |         struct pt_regs *regs = ftrace_get_regs(fregs);
         |                                ^~~~~~~~~~~~~~~
   arch/x86/include/asm/ftrace.h:47:32: warning: initialization of 'struct pt_regs *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   In file included from include/linux/perf_event.h:51,
                    from include/linux/nd.h:11,
                    from drivers/nvdimm/nd-core.h:11,
                    from drivers/nvdimm/dimm_devs.c:14:
   include/linux/ftrace.h: At top level:
>> include/linux/ftrace.h:121:40: error: conflicting types for 'ftrace_get_regs'; have 'struct pt_regs *(struct ftrace_regs *)'
     121 | static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
         |                                        ^~~~~~~~~~~~~~~
   In file included from include/linux/ftrace.h:23,
                    from include/linux/perf_event.h:51,
                    from include/linux/nd.h:11,
                    from drivers/nvdimm/nd-core.h:11,
                    from drivers/nvdimm/dimm_devs.c:14:
   arch/x86/include/asm/ftrace.h:47:32: note: previous implicit declaration of 'ftrace_get_regs' with type 'int()'
      47 |         struct pt_regs *regs = ftrace_get_regs(fregs);
         |                                ^~~~~~~~~~~~~~~
   drivers/nvdimm/dimm_devs.c:352:16: warning: no previous prototype for 'security_show' [-Wmissing-prototypes]
     352 | __weak ssize_t security_show(struct device *dev,
         |                ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/ftrace.h:23,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from include/linux/entry-common.h:7,
                    from arch/x86/entry/common.c:13:
   arch/x86/include/asm/ftrace.h:45:57: warning: 'struct ftrace_regs' declared inside parameter list will not be visible outside of this definition or declaration
      45 | static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsigned long addr)
         |                                                         ^~~~~~~~~~~
   arch/x86/include/asm/ftrace.h: In function 'arch_ftrace_set_direct_caller':
>> arch/x86/include/asm/ftrace.h:47:32: error: implicit declaration of function 'ftrace_get_regs' [-Werror=implicit-function-declaration]
      47 |         struct pt_regs *regs = ftrace_get_regs(fregs);
         |                                ^~~~~~~~~~~~~~~
   arch/x86/include/asm/ftrace.h:47:32: warning: initialization of 'struct pt_regs *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   In file included from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from include/linux/entry-common.h:7,
                    from arch/x86/entry/common.c:13:
   include/linux/ftrace.h: At top level:
>> include/linux/ftrace.h:121:40: error: conflicting types for 'ftrace_get_regs'; have 'struct pt_regs *(struct ftrace_regs *)'
     121 | static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
         |                                        ^~~~~~~~~~~~~~~
   In file included from include/linux/ftrace.h:23,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from include/linux/entry-common.h:7,
                    from arch/x86/entry/common.c:13:
   arch/x86/include/asm/ftrace.h:47:32: note: previous implicit declaration of 'ftrace_get_regs' with type 'int()'
      47 |         struct pt_regs *regs = ftrace_get_regs(fregs);
         |                                ^~~~~~~~~~~~~~~
   arch/x86/entry/common.c:238:24: warning: no previous prototype for 'do_SYSENTER_32' [-Wmissing-prototypes]
     238 | __visible noinstr long do_SYSENTER_32(struct pt_regs *regs)
         |                        ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from arch/x86/mm/init_64.c:57:
   arch/x86/include/asm/ftrace.h:45:57: warning: 'struct ftrace_regs' declared inside parameter list will not be visible outside of this definition or declaration
      45 | static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsigned long addr)
         |                                                         ^~~~~~~~~~~
   arch/x86/include/asm/ftrace.h: In function 'arch_ftrace_set_direct_caller':
>> arch/x86/include/asm/ftrace.h:47:32: error: implicit declaration of function 'ftrace_get_regs' [-Werror=implicit-function-declaration]
      47 |         struct pt_regs *regs = ftrace_get_regs(fregs);
         |                                ^~~~~~~~~~~~~~~
   arch/x86/include/asm/ftrace.h:47:32: warning: initialization of 'struct pt_regs *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   cc1: some warnings being treated as errors
--
   In file included from include/linux/ftrace.h:23,
                    from kernel/kallsyms.c:26:
   arch/x86/include/asm/ftrace.h:45:57: warning: 'struct ftrace_regs' declared inside parameter list will not be visible outside of this definition or declaration
      45 | static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsigned long addr)
         |                                                         ^~~~~~~~~~~
   arch/x86/include/asm/ftrace.h: In function 'arch_ftrace_set_direct_caller':
>> arch/x86/include/asm/ftrace.h:47:32: error: implicit declaration of function 'ftrace_get_regs' [-Werror=implicit-function-declaration]
      47 |         struct pt_regs *regs = ftrace_get_regs(fregs);
         |                                ^~~~~~~~~~~~~~~
   arch/x86/include/asm/ftrace.h:47:32: warning: initialization of 'struct pt_regs *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   In file included from kernel/kallsyms.c:26:
   include/linux/ftrace.h: At top level:
>> include/linux/ftrace.h:121:40: error: conflicting types for 'ftrace_get_regs'; have 'struct pt_regs *(struct ftrace_regs *)'
     121 | static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
         |                                        ^~~~~~~~~~~~~~~
   In file included from include/linux/ftrace.h:23,
                    from kernel/kallsyms.c:26:
   arch/x86/include/asm/ftrace.h:47:32: note: previous implicit declaration of 'ftrace_get_regs' with type 'int()'
      47 |         struct pt_regs *regs = ftrace_get_regs(fregs);
         |                                ^~~~~~~~~~~~~~~
   kernel/kallsyms.c:590:12: warning: no previous prototype for 'arch_get_kallsym' [-Wmissing-prototypes]
     590 | int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
         |            ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/ftrace.h:23,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from kernel/audit.c:44:
   arch/x86/include/asm/ftrace.h:45:57: warning: 'struct ftrace_regs' declared inside parameter list will not be visible outside of this definition or declaration
      45 | static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsigned long addr)
         |                                                         ^~~~~~~~~~~
   arch/x86/include/asm/ftrace.h: In function 'arch_ftrace_set_direct_caller':
>> arch/x86/include/asm/ftrace.h:47:32: error: implicit declaration of function 'ftrace_get_regs' [-Werror=implicit-function-declaration]
      47 |         struct pt_regs *regs = ftrace_get_regs(fregs);
         |                                ^~~~~~~~~~~~~~~
   arch/x86/include/asm/ftrace.h:47:32: warning: initialization of 'struct pt_regs *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   In file included from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from kernel/audit.c:44:
   include/linux/ftrace.h: At top level:
>> include/linux/ftrace.h:121:40: error: conflicting types for 'ftrace_get_regs'; have 'struct pt_regs *(struct ftrace_regs *)'
     121 | static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
         |                                        ^~~~~~~~~~~~~~~
   In file included from include/linux/ftrace.h:23,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from kernel/audit.c:44:
   arch/x86/include/asm/ftrace.h:47:32: note: previous implicit declaration of 'ftrace_get_regs' with type 'int()'
      47 |         struct pt_regs *regs = ftrace_get_regs(fregs);
         |                                ^~~~~~~~~~~~~~~
   kernel/audit.c: In function 'audit_log_vformat':
   kernel/audit.c:1965:9: warning: function 'audit_log_vformat' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1965 |         len = vsnprintf(skb_tail_pointer(skb), avail, fmt, args);
         |         ^~~
   kernel/audit.c:1974:17: warning: function 'audit_log_vformat' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1974 |                 len = vsnprintf(skb_tail_pointer(skb), avail, fmt, args2);
         |                 ^~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/ftrace.h:23,
                    from include/linux/kprobes.h:28,
                    from include/linux/kgdb.h:19,
                    from kernel/panic.c:15:
   arch/x86/include/asm/ftrace.h:45:57: warning: 'struct ftrace_regs' declared inside parameter list will not be visible outside of this definition or declaration
      45 | static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsigned long addr)
         |                                                         ^~~~~~~~~~~
   arch/x86/include/asm/ftrace.h: In function 'arch_ftrace_set_direct_caller':
>> arch/x86/include/asm/ftrace.h:47:32: error: implicit declaration of function 'ftrace_get_regs' [-Werror=implicit-function-declaration]
      47 |         struct pt_regs *regs = ftrace_get_regs(fregs);
         |                                ^~~~~~~~~~~~~~~
   arch/x86/include/asm/ftrace.h:47:32: warning: initialization of 'struct pt_regs *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   In file included from include/linux/kprobes.h:28,
                    from include/linux/kgdb.h:19,
                    from kernel/panic.c:15:
   include/linux/ftrace.h: At top level:
>> include/linux/ftrace.h:121:40: error: conflicting types for 'ftrace_get_regs'; have 'struct pt_regs *(struct ftrace_regs *)'
     121 | static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
         |                                        ^~~~~~~~~~~~~~~
   In file included from include/linux/ftrace.h:23,
                    from include/linux/kprobes.h:28,
                    from include/linux/kgdb.h:19,
                    from kernel/panic.c:15:
   arch/x86/include/asm/ftrace.h:47:32: note: previous implicit declaration of 'ftrace_get_regs' with type 'int()'
      47 |         struct pt_regs *regs = ftrace_get_regs(fregs);
         |                                ^~~~~~~~~~~~~~~
   kernel/panic.c: In function '__warn':
   kernel/panic.c:617:17: warning: function '__warn' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     617 |                 vprintk(args->fmt, args->args);
         |                 ^~~~~~~
   kernel/panic.c: At top level:
   kernel/panic.c:706:24: warning: no previous prototype for '__stack_chk_fail' [-Wmissing-prototypes]
     706 | __visible noinstr void __stack_chk_fail(void)
         |                        ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/ftrace.h:23,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from kernel/exit.c:42:
   arch/x86/include/asm/ftrace.h:45:57: warning: 'struct ftrace_regs' declared inside parameter list will not be visible outside of this definition or declaration
      45 | static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsigned long addr)
         |                                                         ^~~~~~~~~~~
   arch/x86/include/asm/ftrace.h: In function 'arch_ftrace_set_direct_caller':
>> arch/x86/include/asm/ftrace.h:47:32: error: implicit declaration of function 'ftrace_get_regs' [-Werror=implicit-function-declaration]
      47 |         struct pt_regs *regs = ftrace_get_regs(fregs);
         |                                ^~~~~~~~~~~~~~~
   arch/x86/include/asm/ftrace.h:47:32: warning: initialization of 'struct pt_regs *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   In file included from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from kernel/exit.c:42:
   include/linux/ftrace.h: At top level:
>> include/linux/ftrace.h:121:40: error: conflicting types for 'ftrace_get_regs'; have 'struct pt_regs *(struct ftrace_regs *)'
     121 | static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
         |                                        ^~~~~~~~~~~~~~~
   In file included from include/linux/ftrace.h:23,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from kernel/exit.c:42:
   arch/x86/include/asm/ftrace.h:47:32: note: previous implicit declaration of 'ftrace_get_regs' with type 'int()'
      47 |         struct pt_regs *regs = ftrace_get_regs(fregs);
         |                                ^~~~~~~~~~~~~~~
   kernel/exit.c:1814:13: warning: no previous prototype for 'abort' [-Wmissing-prototypes]
    1814 | __weak void abort(void)
         |             ^~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/ftrace.h:23,
                    from kernel/trace/ftrace.c:29:
   arch/x86/include/asm/ftrace.h:45:57: warning: 'struct ftrace_regs' declared inside parameter list will not be visible outside of this definition or declaration
      45 | static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsigned long addr)
         |                                                         ^~~~~~~~~~~
   arch/x86/include/asm/ftrace.h: In function 'arch_ftrace_set_direct_caller':
>> arch/x86/include/asm/ftrace.h:47:32: error: implicit declaration of function 'ftrace_get_regs' [-Werror=implicit-function-declaration]
      47 |         struct pt_regs *regs = ftrace_get_regs(fregs);
         |                                ^~~~~~~~~~~~~~~
   arch/x86/include/asm/ftrace.h:47:32: warning: initialization of 'struct pt_regs *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   In file included from kernel/trace/ftrace.c:29:
   include/linux/ftrace.h: At top level:
>> include/linux/ftrace.h:121:40: error: conflicting types for 'ftrace_get_regs'; have 'struct pt_regs *(struct ftrace_regs *)'
     121 | static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
         |                                        ^~~~~~~~~~~~~~~
   In file included from include/linux/ftrace.h:23,
                    from kernel/trace/ftrace.c:29:
   arch/x86/include/asm/ftrace.h:47:32: note: previous implicit declaration of 'ftrace_get_regs' with type 'int()'
      47 |         struct pt_regs *regs = ftrace_get_regs(fregs);
         |                                ^~~~~~~~~~~~~~~
   kernel/trace/ftrace.c:299:5: warning: no previous prototype for '__register_ftrace_function' [-Wmissing-prototypes]
     299 | int __register_ftrace_function(struct ftrace_ops *ops)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c:342:5: warning: no previous prototype for '__unregister_ftrace_function' [-Wmissing-prototypes]
     342 | int __unregister_ftrace_function(struct ftrace_ops *ops)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c: In function 'call_direct_funcs':
>> kernel/trace/ftrace.c:2451:39: error: passing argument 1 of 'arch_ftrace_set_direct_caller' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2451 |         arch_ftrace_set_direct_caller(fregs, addr);
         |                                       ^~~~~
         |                                       |
         |                                       struct ftrace_regs *
   In file included from include/linux/ftrace.h:23,
                    from kernel/trace/ftrace.c:29:
   arch/x86/include/asm/ftrace.h:45:70: note: expected 'struct ftrace_regs *' but argument is of type 'struct ftrace_regs *'
      45 | static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsigned long addr)
         |                                                  ~~~~~~~~~~~~~~~~~~~~^~~~~
   kernel/trace/ftrace.c: At top level:
   kernel/trace/ftrace.c:3983:15: warning: no previous prototype for 'arch_ftrace_match_adjust' [-Wmissing-prototypes]
    3983 | char * __weak arch_ftrace_match_adjust(char *str, const char *search)
         |               ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
..


vim +/ftrace_get_regs +47 arch/x86/include/asm/ftrace.h

    37	
    38	/*
    39	 * When a ftrace registered caller is tracing a function that is
    40	 * also set by a register_ftrace_direct() call, it needs to be
    41	 * differentiated in the ftrace_caller trampoline. To do this, we
    42	 * place the direct caller in the ORIG_AX part of pt_regs. This
    43	 * tells the ftrace_caller that there's a direct caller.
    44	 */
  > 45	static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsigned long addr)
    46	{
  > 47		struct pt_regs *regs = ftrace_get_regs(fregs);
    48	
    49		/* Emulate a call */
    50		regs->orig_ax = addr;
    51	}
    52	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
