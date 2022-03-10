Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4C44D3DD9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 01:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238894AbiCJAGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 19:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiCJAGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 19:06:46 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0E2AB458
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 16:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646870745; x=1678406745;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4aMMzI55SGl8c1zgk14wTxCGpG3WRn24JImT2MZfihA=;
  b=UHR0+Nrn9g1VWTik/RQL8/cLHrQgTs0nkVODhHqxBdFJEG2wSY0IIvg7
   EKXt7K5hvkNr42Gti4jDJxD+8QXcMjLBk2/x8Q7AOqk6PYK43MG+8e3AU
   QPNnda/aHB0Thpr4DOXWJtmfHHmjWKr3wKjSoM+UGKkLkgusrhP77E+Gk
   FZW0ka42JQUUtU5mNQYjewaOXkxZuqxhxdPw63a3kRI2l7QXf0TxzsVxh
   5wFrQrxaFsjlTEV0z8kjnubNl9mn8kq/5xe9wAL4T2/5QXwWF9rFlxzlM
   JsrQoNP+lZg7J0GuCkfvc2+3PzMv4lsxynpCSCuWaVwvsteBpAevFe9yG
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="237288042"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="237288042"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 16:05:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="578587257"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 09 Mar 2022 16:05:30 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nS6J7-00040O-Si; Thu, 10 Mar 2022 00:05:29 +0000
Date:   Thu, 10 Mar 2022 08:04:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [jolsa-perf:bpf/kprobe_multi_4 3/11]
 include/linux/trace_events.h:784:42: warning: declaration of 'union
 bpf_attr' will not be visible outside of this function
Message-ID: <202203100814.ubrhuffY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/kprobe_multi_4
head:   02731d567ee31d7c7f012e9c5930f114ed1e2478
commit: c330e21ba4633cb075ce0c4c5f936b16ed722666 [3/11] bpf: Add multi kprobe link
config: s390-buildonly-randconfig-r001-20220309 (https://download.01.org/0day-ci/archive/20220310/202203100814.ubrhuffY-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 276ca87382b8f16a65bddac700202924228982f6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=c330e21ba4633cb075ce0c4c5f936b16ed722666
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/kprobe_multi_4
        git checkout c330e21ba4633cb075ce0c4c5f936b16ed722666
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/trace/ftrace.c:18:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from kernel/trace/ftrace.c:18:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from kernel/trace/ftrace.c:18:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   In file included from kernel/trace/ftrace.c:45:
   In file included from kernel/trace/trace_output.h:6:
   In file included from kernel/trace/trace.h:17:
>> include/linux/trace_events.h:784:42: warning: declaration of 'union bpf_attr' will not be visible outside of this function [-Wvisibility]
   bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
                                            ^
   kernel/trace/ftrace.c:297:5: warning: no previous prototype for function '__register_ftrace_function' [-Wmissing-prototypes]
   int __register_ftrace_function(struct ftrace_ops *ops)
       ^
   kernel/trace/ftrace.c:297:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __register_ftrace_function(struct ftrace_ops *ops)
   ^
   static 
   kernel/trace/ftrace.c:340:5: warning: no previous prototype for function '__unregister_ftrace_function' [-Wmissing-prototypes]
   int __unregister_ftrace_function(struct ftrace_ops *ops)
       ^
   kernel/trace/ftrace.c:340:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __unregister_ftrace_function(struct ftrace_ops *ops)
   ^
   static 
   kernel/trace/ftrace.c:3905:15: warning: no previous prototype for function 'arch_ftrace_match_adjust' [-Wmissing-prototypes]
   char * __weak arch_ftrace_match_adjust(char *str, const char *search)
                 ^
   kernel/trace/ftrace.c:3905:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   char * __weak arch_ftrace_match_adjust(char *str, const char *search)
   ^
   static 
   kernel/trace/ftrace.c:3108:1: warning: unused function 'ops_references_rec' [-Wunused-function]
   ops_references_rec(struct ftrace_ops *ops, struct dyn_ftrace *rec)
   ^
   17 warnings generated.
--
   In file included from kernel/trace/ring_buffer.c:8:
>> include/linux/trace_events.h:784:42: warning: declaration of 'union bpf_attr' will not be visible outside of this function [-Wvisibility]
   bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
                                            ^
   In file included from kernel/trace/ring_buffer.c:7:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:9:
   In file included from include/linux/sched.h:14:
   In file included from include/linux/pid.h:6:
   In file included from include/linux/wait.h:9:
   In file included from include/linux/spinlock.h:93:
   arch/s390/include/asm/spinlock.h:81:3: error: expected absolute expression
                   ALTERNATIVE("", ".long 0xb2fa0070", 49) /* NIAI 7 */
                   ^
   arch/s390/include/asm/alternative.h:111:2: note: expanded from macro 'ALTERNATIVE'
           ALTINSTR_REPLACEMENT(altinstr, 1)                               \
           ^
   arch/s390/include/asm/alternative.h:106:2: note: expanded from macro 'ALTINSTR_REPLACEMENT'
           INSTR_LEN_SANITY_CHECK(altinstr_len(num))
           ^
   arch/s390/include/asm/alternative.h:62:3: note: expanded from macro 'INSTR_LEN_SANITY_CHECK'
           ".if " len " > 254\n"                                           \
            ^
   <inline asm>:5:5: note: instantiated into assembly here
   .if 6651b-6641b > 254
       ^
   In file included from kernel/trace/ring_buffer.c:7:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:9:
   In file included from include/linux/sched.h:14:
   In file included from include/linux/pid.h:6:
   In file included from include/linux/wait.h:9:
   In file included from include/linux/spinlock.h:93:
   arch/s390/include/asm/spinlock.h:81:3: error: cpu alternatives does not support instructions blocks > 254 bytes
                   ALTERNATIVE("", ".long 0xb2fa0070", 49) /* NIAI 7 */
                   ^
   arch/s390/include/asm/alternative.h:111:2: note: expanded from macro 'ALTERNATIVE'
           ALTINSTR_REPLACEMENT(altinstr, 1)                               \
           ^
   arch/s390/include/asm/alternative.h:106:2: note: expanded from macro 'ALTINSTR_REPLACEMENT'
           INSTR_LEN_SANITY_CHECK(altinstr_len(num))
           ^
   arch/s390/include/asm/alternative.h:63:3: note: expanded from macro 'INSTR_LEN_SANITY_CHECK'
           "\t.error \"cpu alternatives does not support instructions "    \
            ^
   <inline asm>:6:2: note: instantiated into assembly here
           .error "cpu alternatives does not support instructions blocks > 254 bytes"
           ^
   In file included from kernel/trace/ring_buffer.c:7:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:9:
   In file included from include/linux/sched.h:14:
   In file included from include/linux/pid.h:6:
   In file included from include/linux/wait.h:9:
   In file included from include/linux/spinlock.h:93:
   arch/s390/include/asm/spinlock.h:81:3: error: expected absolute expression
                   ALTERNATIVE("", ".long 0xb2fa0070", 49) /* NIAI 7 */
                   ^
   arch/s390/include/asm/alternative.h:111:2: note: expanded from macro 'ALTERNATIVE'
           ALTINSTR_REPLACEMENT(altinstr, 1)                               \
           ^
   arch/s390/include/asm/alternative.h:106:2: note: expanded from macro 'ALTINSTR_REPLACEMENT'
           INSTR_LEN_SANITY_CHECK(altinstr_len(num))
           ^
   arch/s390/include/asm/alternative.h:66:3: note: expanded from macro 'INSTR_LEN_SANITY_CHECK'
           ".if (" len ") %% 2\n"                                          \
            ^
   <inline asm>:8:5: note: instantiated into assembly here
   .if (6651b-6641b) % 2
       ^
   In file included from kernel/trace/ring_buffer.c:7:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:9:
   In file included from include/linux/sched.h:14:
   In file included from include/linux/pid.h:6:
   In file included from include/linux/wait.h:9:
   In file included from include/linux/spinlock.h:93:
   arch/s390/include/asm/spinlock.h:81:3: error: cpu alternatives instructions length is odd
                   ALTERNATIVE("", ".long 0xb2fa0070", 49) /* NIAI 7 */
                   ^
   arch/s390/include/asm/alternative.h:111:2: note: expanded from macro 'ALTERNATIVE'
           ALTINSTR_REPLACEMENT(altinstr, 1)                               \
           ^
   arch/s390/include/asm/alternative.h:106:2: note: expanded from macro 'ALTINSTR_REPLACEMENT'
           INSTR_LEN_SANITY_CHECK(altinstr_len(num))
           ^
   arch/s390/include/asm/alternative.h:67:3: note: expanded from macro 'INSTR_LEN_SANITY_CHECK'
           "\t.error \"cpu alternatives instructions length is odd\"\n"    \
            ^
   <inline asm>:9:2: note: instantiated into assembly here
           .error "cpu alternatives instructions length is odd"
           ^
   In file included from kernel/trace/ring_buffer.c:7:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:9:
   In file included from include/linux/sched.h:14:
   In file included from include/linux/pid.h:6:
--
   In file included from kernel/trace/trace.c:53:
   In file included from kernel/trace/trace.h:9:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from kernel/trace/trace.c:53:
   In file included from kernel/trace/trace.h:9:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from kernel/trace/trace.c:53:
   In file included from kernel/trace/trace.h:9:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   In file included from kernel/trace/trace.c:53:
   In file included from kernel/trace/trace.h:17:
>> include/linux/trace_events.h:784:42: warning: declaration of 'union bpf_attr' will not be visible outside of this function [-Wvisibility]
   bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
                                            ^
   In file included from kernel/trace/trace.c:15:
   In file included from include/linux/ring_buffer.h:5:
   In file included from include/linux/mm.h:10:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:93:
   arch/s390/include/asm/spinlock.h:81:3: error: expected absolute expression
                   ALTERNATIVE("", ".long 0xb2fa0070", 49) /* NIAI 7 */
                   ^
   arch/s390/include/asm/alternative.h:111:2: note: expanded from macro 'ALTERNATIVE'
           ALTINSTR_REPLACEMENT(altinstr, 1)                               \
           ^
   arch/s390/include/asm/alternative.h:106:2: note: expanded from macro 'ALTINSTR_REPLACEMENT'
           INSTR_LEN_SANITY_CHECK(altinstr_len(num))
           ^
   arch/s390/include/asm/alternative.h:62:3: note: expanded from macro 'INSTR_LEN_SANITY_CHECK'
           ".if " len " > 254\n"                                           \
            ^
   <inline asm>:5:5: note: instantiated into assembly here
   .if 6651b-6641b > 254
       ^
   In file included from kernel/trace/trace.c:15:
   In file included from include/linux/ring_buffer.h:5:
   In file included from include/linux/mm.h:10:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:93:
   arch/s390/include/asm/spinlock.h:81:3: error: cpu alternatives does not support instructions blocks > 254 bytes
                   ALTERNATIVE("", ".long 0xb2fa0070", 49) /* NIAI 7 */
                   ^
   arch/s390/include/asm/alternative.h:111:2: note: expanded from macro 'ALTERNATIVE'
           ALTINSTR_REPLACEMENT(altinstr, 1)                               \
           ^
   arch/s390/include/asm/alternative.h:106:2: note: expanded from macro 'ALTINSTR_REPLACEMENT'
           INSTR_LEN_SANITY_CHECK(altinstr_len(num))
           ^
   arch/s390/include/asm/alternative.h:63:3: note: expanded from macro 'INSTR_LEN_SANITY_CHECK'
           "\t.error \"cpu alternatives does not support instructions "    \
            ^
   <inline asm>:6:2: note: instantiated into assembly here
           .error "cpu alternatives does not support instructions blocks > 254 bytes"
           ^
   In file included from kernel/trace/trace.c:15:
   In file included from include/linux/ring_buffer.h:5:
   In file included from include/linux/mm.h:10:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:93:
   arch/s390/include/asm/spinlock.h:81:3: error: expected absolute expression
                   ALTERNATIVE("", ".long 0xb2fa0070", 49) /* NIAI 7 */
                   ^
   arch/s390/include/asm/alternative.h:111:2: note: expanded from macro 'ALTERNATIVE'
           ALTINSTR_REPLACEMENT(altinstr, 1)                               \
           ^
   arch/s390/include/asm/alternative.h:106:2: note: expanded from macro 'ALTINSTR_REPLACEMENT'
           INSTR_LEN_SANITY_CHECK(altinstr_len(num))
           ^
   arch/s390/include/asm/alternative.h:66:3: note: expanded from macro 'INSTR_LEN_SANITY_CHECK'
           ".if (" len ") %% 2\n"                                          \
            ^
   <inline asm>:8:5: note: instantiated into assembly here
   .if (6651b-6641b) % 2
       ^
   In file included from kernel/trace/trace.c:15:
   In file included from include/linux/ring_buffer.h:5:
   In file included from include/linux/mm.h:10:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:93:
   arch/s390/include/asm/spinlock.h:81:3: error: cpu alternatives instructions length is odd
                   ALTERNATIVE("", ".long 0xb2fa0070", 49) /* NIAI 7 */
                   ^
   arch/s390/include/asm/alternative.h:111:2: note: expanded from macro 'ALTERNATIVE'
           ALTINSTR_REPLACEMENT(altinstr, 1)                               \
           ^
   arch/s390/include/asm/alternative.h:106:2: note: expanded from macro 'ALTINSTR_REPLACEMENT'
           INSTR_LEN_SANITY_CHECK(altinstr_len(num))
           ^
   arch/s390/include/asm/alternative.h:67:3: note: expanded from macro 'INSTR_LEN_SANITY_CHECK'
           "\t.error \"cpu alternatives instructions length is odd\"\n"    \
            ^
   <inline asm>:9:2: note: instantiated into assembly here
           .error "cpu alternatives instructions length is odd"
           ^
   In file included from kernel/trace/trace.c:15:
   In file included from include/linux/ring_buffer.h:5:
   In file included from include/linux/mm.h:10:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:93:
   arch/s390/include/asm/spinlock.h:81:3: error: expected absolute expression
                   ALTERNATIVE("", ".long 0xb2fa0070", 49) /* NIAI 7 */
                   ^
   arch/s390/include/asm/alternative.h:113:2: note: expanded from macro 'ALTERNATIVE'
           OLDINSTR(oldinstr, 1)                                           \
           ^
   arch/s390/include/asm/alternative.h:83:2: note: expanded from macro 'OLDINSTR'
           OLDINSTR_PADDING(oldinstr, num)                                 \
..


vim +784 include/linux/trace_events.h

   755	
   756	static inline int
   757	perf_event_query_prog_array(struct perf_event *event, void __user *info)
   758	{
   759		return -EOPNOTSUPP;
   760	}
   761	static inline int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *p)
   762	{
   763		return -EOPNOTSUPP;
   764	}
   765	static inline int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog *p)
   766	{
   767		return -EOPNOTSUPP;
   768	}
   769	static inline struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name)
   770	{
   771		return NULL;
   772	}
   773	static inline void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
   774	{
   775	}
   776	static inline int bpf_get_perf_event_info(const struct perf_event *event,
   777						  u32 *prog_id, u32 *fd_type,
   778						  const char **buf, u64 *probe_offset,
   779						  u64 *probe_addr)
   780	{
   781		return -EOPNOTSUPP;
   782	}
   783	static inline int
 > 784	bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
   785	{
   786		return -EOPNOTSUPP;
   787	}
   788	#endif
   789	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
