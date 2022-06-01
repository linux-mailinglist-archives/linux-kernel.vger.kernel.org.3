Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C93953AABC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356025AbiFAQLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355125AbiFAQLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:11:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECBCA5030
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 09:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654099870; x=1685635870;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KkCouprHMMUAj1Kbi2Kc8qPSdya0Uz0+vPZSKAFMcXE=;
  b=mJsUinmjeKNemDPwCt2OIS4z8EVMsclcbc1ZD7pbpDX77o5QmTHFcRxG
   zTk5bMdKS2ZXaf1hLhhLGpAysc6UVHJ2o0S4dJrdW7anqSpWg/CAIoLUR
   Q49+gpXMPYS37JIotmr0qoY4+Q9PIbB72CSoK/RmY6WRJ5I+U7PZ40cDo
   LX62n2ONhduIYgAEHRG2BQbkxdqMQSWOnMcDmrk/I1YcfJA1fxW4qi5mA
   DFeB8Une7gxHsmqfGCkIsgrPNo1pFuy+4ksgQRgKOUyjf9fCvCvTz4Hv8
   daLQ2XWCE7Tbo9/EJyZLvEEQlSPu0NXmSLmx4fKqSFr6FwJqzhR050/K2
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="275363192"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="275363192"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 09:11:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="707123518"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 01 Jun 2022 09:11:08 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwQw7-00049e-Ou;
        Wed, 01 Jun 2022 16:11:07 +0000
Date:   Thu, 2 Jun 2022 00:10:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:arm64/ftrace/minimal-regs 5/6]
 arch/x86/include/asm/ftrace.h:45:57: warning: 'struct ftrace_regs' declared
 inside parameter list will not be visible outside of this definition or
 declaration
Message-ID: <202206020054.xO14dbgM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/ftrace/minimal-regs
head:   b0741d059a9f19a1aa1191833140f53e41f1775a
commit: c694698df7f633bcbdf8bc0edb94f4a70ed0d092 [5/6] ftrace: pass fregs to arch_ftrace_set_direct_caller()
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20220602/202206020054.xO14dbgM-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=c694698df7f633bcbdf8bc0edb94f4a70ed0d092
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark arm64/ftrace/minimal-regs
        git checkout c694698df7f633bcbdf8bc0edb94f4a70ed0d092
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/hwmon/ kernel/trace/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/ftrace.h:23,
                    from kernel/trace/ftrace.c:29:
>> arch/x86/include/asm/ftrace.h:45:57: warning: 'struct ftrace_regs' declared inside parameter list will not be visible outside of this definition or declaration
      45 | static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsigned long addr)
         |                                                         ^~~~~~~~~~~
   arch/x86/include/asm/ftrace.h: In function 'arch_ftrace_set_direct_caller':
   arch/x86/include/asm/ftrace.h:47:32: error: implicit declaration of function 'ftrace_get_regs' [-Werror=implicit-function-declaration]
      47 |         struct pt_regs *regs = ftrace_get_regs(fregs);
         |                                ^~~~~~~~~~~~~~~
>> arch/x86/include/asm/ftrace.h:47:32: warning: initialization of 'struct pt_regs *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   In file included from kernel/trace/ftrace.c:29:
   include/linux/ftrace.h: At top level:
   include/linux/ftrace.h:121:40: error: conflicting types for 'ftrace_get_regs'; have 'struct pt_regs *(struct ftrace_regs *)'
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
   kernel/trace/ftrace.c:2451:39: error: passing argument 1 of 'arch_ftrace_set_direct_caller' from incompatible pointer type [-Werror=incompatible-pointer-types]
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
--
   In file included from include/linux/ftrace.h:23,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from kernel/trace/ring_buffer.c:8:
>> arch/x86/include/asm/ftrace.h:45:57: warning: 'struct ftrace_regs' declared inside parameter list will not be visible outside of this definition or declaration
      45 | static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsigned long addr)
         |                                                         ^~~~~~~~~~~
   arch/x86/include/asm/ftrace.h: In function 'arch_ftrace_set_direct_caller':
   arch/x86/include/asm/ftrace.h:47:32: error: implicit declaration of function 'ftrace_get_regs' [-Werror=implicit-function-declaration]
      47 |         struct pt_regs *regs = ftrace_get_regs(fregs);
         |                                ^~~~~~~~~~~~~~~
>> arch/x86/include/asm/ftrace.h:47:32: warning: initialization of 'struct pt_regs *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   In file included from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from kernel/trace/ring_buffer.c:8:
   include/linux/ftrace.h: At top level:
   include/linux/ftrace.h:121:40: error: conflicting types for 'ftrace_get_regs'; have 'struct pt_regs *(struct ftrace_regs *)'
     121 | static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
         |                                        ^~~~~~~~~~~~~~~
   In file included from include/linux/ftrace.h:23,
                    from include/linux/perf_event.h:51,
                    from include/linux/trace_events.h:10,
                    from kernel/trace/ring_buffer.c:8:
   arch/x86/include/asm/ftrace.h:47:32: note: previous implicit declaration of 'ftrace_get_regs' with type 'int()'
      47 |         struct pt_regs *regs = ftrace_get_regs(fregs);
         |                                ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/ftrace.h:23,
                    from kernel/trace/trace.c:31:
>> arch/x86/include/asm/ftrace.h:45:57: warning: 'struct ftrace_regs' declared inside parameter list will not be visible outside of this definition or declaration
      45 | static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsigned long addr)
         |                                                         ^~~~~~~~~~~
   arch/x86/include/asm/ftrace.h: In function 'arch_ftrace_set_direct_caller':
   arch/x86/include/asm/ftrace.h:47:32: error: implicit declaration of function 'ftrace_get_regs' [-Werror=implicit-function-declaration]
      47 |         struct pt_regs *regs = ftrace_get_regs(fregs);
         |                                ^~~~~~~~~~~~~~~
>> arch/x86/include/asm/ftrace.h:47:32: warning: initialization of 'struct pt_regs *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   In file included from kernel/trace/trace.c:31:
   include/linux/ftrace.h: At top level:
   include/linux/ftrace.h:121:40: error: conflicting types for 'ftrace_get_regs'; have 'struct pt_regs *(struct ftrace_regs *)'
     121 | static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
         |                                        ^~~~~~~~~~~~~~~
   In file included from include/linux/ftrace.h:23,
                    from kernel/trace/trace.c:31:
   arch/x86/include/asm/ftrace.h:47:32: note: previous implicit declaration of 'ftrace_get_regs' with type 'int()'
      47 |         struct pt_regs *regs = ftrace_get_regs(fregs);
         |                                ^~~~~~~~~~~~~~~
   kernel/trace/trace.c: In function 'trace_check_vprintf':
   kernel/trace/trace.c:3846:17: warning: function 'trace_check_vprintf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    3846 |                 trace_seq_vprintf(&iter->seq, iter->fmt, ap);
         |                 ^~~~~~~~~~~~~~~~~
   kernel/trace/trace.c:3913:17: warning: function 'trace_check_vprintf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    3913 |                 trace_seq_vprintf(&iter->seq, p, ap);
         |                 ^~~~~~~~~~~~~~~~~
   At top level:
   kernel/trace/trace.c:1689:37: warning: 'tracing_max_lat_fops' defined but not used [-Wunused-const-variable=]
    1689 | static const struct file_operations tracing_max_lat_fops;
         |                                     ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/ftrace.h:23,
                    from kernel/trace/trace_output.c:10:
>> arch/x86/include/asm/ftrace.h:45:57: warning: 'struct ftrace_regs' declared inside parameter list will not be visible outside of this definition or declaration
      45 | static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsigned long addr)
         |                                                         ^~~~~~~~~~~
   arch/x86/include/asm/ftrace.h: In function 'arch_ftrace_set_direct_caller':
   arch/x86/include/asm/ftrace.h:47:32: error: implicit declaration of function 'ftrace_get_regs' [-Werror=implicit-function-declaration]
      47 |         struct pt_regs *regs = ftrace_get_regs(fregs);
         |                                ^~~~~~~~~~~~~~~
>> arch/x86/include/asm/ftrace.h:47:32: warning: initialization of 'struct pt_regs *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   In file included from kernel/trace/trace_output.c:10:
   include/linux/ftrace.h: At top level:
   include/linux/ftrace.h:121:40: error: conflicting types for 'ftrace_get_regs'; have 'struct pt_regs *(struct ftrace_regs *)'
     121 | static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
         |                                        ^~~~~~~~~~~~~~~
   In file included from include/linux/ftrace.h:23,
                    from kernel/trace/trace_output.c:10:
   arch/x86/include/asm/ftrace.h:47:32: note: previous implicit declaration of 'ftrace_get_regs' with type 'int()'
      47 |         struct pt_regs *regs = ftrace_get_regs(fregs);
         |                                ^~~~~~~~~~~~~~~
   kernel/trace/trace_output.c: In function 'trace_output_raw':
   kernel/trace/trace_output.c:332:9: warning: function 'trace_output_raw' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     332 |         trace_seq_vprintf(s, trace_event_format(iter, fmt), ap);
         |         ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/ftrace.h:23,
                    from kernel/trace/fgraph.c:12:
>> arch/x86/include/asm/ftrace.h:45:57: warning: 'struct ftrace_regs' declared inside parameter list will not be visible outside of this definition or declaration
      45 | static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsigned long addr)
         |                                                         ^~~~~~~~~~~
   arch/x86/include/asm/ftrace.h: In function 'arch_ftrace_set_direct_caller':
   arch/x86/include/asm/ftrace.h:47:32: error: implicit declaration of function 'ftrace_get_regs' [-Werror=implicit-function-declaration]
      47 |         struct pt_regs *regs = ftrace_get_regs(fregs);
         |                                ^~~~~~~~~~~~~~~
>> arch/x86/include/asm/ftrace.h:47:32: warning: initialization of 'struct pt_regs *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   In file included from kernel/trace/fgraph.c:12:
   include/linux/ftrace.h: At top level:
   include/linux/ftrace.h:121:40: error: conflicting types for 'ftrace_get_regs'; have 'struct pt_regs *(struct ftrace_regs *)'
     121 | static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
         |                                        ^~~~~~~~~~~~~~~
   In file included from include/linux/ftrace.h:23,
                    from kernel/trace/fgraph.c:12:
   arch/x86/include/asm/ftrace.h:47:32: note: previous implicit declaration of 'ftrace_get_regs' with type 'int()'
      47 |         struct pt_regs *regs = ftrace_get_regs(fregs);
         |                                ^~~~~~~~~~~~~~~
   kernel/trace/fgraph.c:241:15: warning: no previous prototype for 'ftrace_return_to_handler' [-Wmissing-prototypes]
     241 | unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
         |               ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/fgraph.c:356:6: warning: no previous prototype for 'ftrace_graph_sleep_time_control' [-Wmissing-prototypes]
     356 | void ftrace_graph_sleep_time_control(bool enable)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +45 arch/x86/include/asm/ftrace.h

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
