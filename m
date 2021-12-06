Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B71E469550
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242675AbhLFL5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:57:04 -0500
Received: from mga04.intel.com ([192.55.52.120]:30900 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242806AbhLFL4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:56:40 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="236036493"
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="236036493"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 03:53:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="479090150"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 06 Dec 2021 03:53:07 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muCYK-000LEj-Qo; Mon, 06 Dec 2021 11:53:04 +0000
Date:   Mon, 6 Dec 2021 19:52:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     kbuild-all@lists.01.org, gregkh <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, quic_psodagud@quicinc.com
Subject: Re: [PATCHv5 3/4] tracing: Add register read/write tracing support
Message-ID: <202112061907.RvKTwMEo-lkp@intel.com>
References: <e088f4b4021f2e56093c7f73e77f556059e114b7.1638275062.git.quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e088f4b4021f2e56093c7f73e77f556059e114b7.1638275062.git.quic_saipraka@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sai,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on rostedt-trace/for-next arnd-asm-generic/master v5.16-rc4 next-20211206]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Sai-Prakash-Ranjan/tracing-rwmmio-arm64-Add-support-to-trace-register-reads-writes/20211206-163212
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20211206/202112061907.RvKTwMEo-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/1b255eef866824f8925cc46d6b127d641f1c8982
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Sai-Prakash-Ranjan/tracing-rwmmio-arm64-Add-support-to-trace-register-reads-writes/20211206-163212
        git checkout 1b255eef866824f8925cc46d6b127d641f1c8982
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

                    from include/asm-generic/hardirq.h:17,
                    from arch/sh/include/asm/hardirq.h:9,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   include/asm-generic/iomap.h:31:21: note: previous declaration of 'ioread16be' with type 'unsigned int(const void *)'
      31 | extern unsigned int ioread16be(const void __iomem *);
         |                     ^~~~~~~~~~
   In file included from kernel/trace/trace_readwrite.c:10:
   include/asm-generic/io.h:785:20: error: conflicting types for 'ioread32be'; have 'u32(const volatile void *)' {aka 'unsigned int(const volatile void *)'}
     785 | #define ioread32be ioread32be
         |                    ^~~~~~~~~~
   include/asm-generic/io.h:786:19: note: in expansion of macro 'ioread32be'
     786 | static inline u32 ioread32be(const volatile void __iomem *addr)
         |                   ^~~~~~~~~~
   In file included from arch/sh/include/asm/io.h:22,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:17,
                    from arch/sh/include/asm/hardirq.h:9,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   include/asm-generic/iomap.h:33:21: note: previous declaration of 'ioread32be' with type 'unsigned int(const void *)'
      33 | extern unsigned int ioread32be(const void __iomem *);
         |                     ^~~~~~~~~~
   In file included from kernel/trace/trace_readwrite.c:10:
   include/asm-generic/io.h:803:21: error: conflicting types for 'iowrite16be'; have 'void(u16,  volatile void *)' {aka 'void(short unsigned int,  volatile void *)'}
     803 | #define iowrite16be iowrite16be
         |                     ^~~~~~~~~~~
   include/asm-generic/io.h:804:20: note: in expansion of macro 'iowrite16be'
     804 | static inline void iowrite16be(u16 value, void volatile __iomem *addr)
         |                    ^~~~~~~~~~~
   In file included from arch/sh/include/asm/io.h:22,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:17,
                    from arch/sh/include/asm/hardirq.h:9,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   include/asm-generic/iomap.h:52:13: note: previous declaration of 'iowrite16be' with type 'void(u16,  void *)' {aka 'void(short unsigned int,  void *)'}
      52 | extern void iowrite16be(u16, void __iomem *);
         |             ^~~~~~~~~~~
   In file included from kernel/trace/trace_readwrite.c:10:
   include/asm-generic/io.h:811:21: error: conflicting types for 'iowrite32be'; have 'void(u32,  volatile void *)' {aka 'void(unsigned int,  volatile void *)'}
     811 | #define iowrite32be iowrite32be
         |                     ^~~~~~~~~~~
   include/asm-generic/io.h:812:20: note: in expansion of macro 'iowrite32be'
     812 | static inline void iowrite32be(u32 value, volatile void __iomem *addr)
         |                    ^~~~~~~~~~~
   In file included from arch/sh/include/asm/io.h:22,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:17,
                    from arch/sh/include/asm/hardirq.h:9,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   include/asm-generic/iomap.h:54:13: note: previous declaration of 'iowrite32be' with type 'void(u32,  void *)' {aka 'void(unsigned int,  void *)'}
      54 | extern void iowrite32be(u32, void __iomem *);
         |             ^~~~~~~~~~~
   In file included from kernel/trace/trace_readwrite.c:10:
   include/asm-generic/io.h:829:21: error: conflicting types for 'ioread8_rep'; have 'void(const volatile void *, void *, unsigned int)'
     829 | #define ioread8_rep ioread8_rep
         |                     ^~~~~~~~~~~
   include/asm-generic/io.h:830:20: note: in expansion of macro 'ioread8_rep'
     830 | static inline void ioread8_rep(const volatile void __iomem *addr, void *buffer,
         |                    ^~~~~~~~~~~
   In file included from arch/sh/include/asm/io.h:22,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:17,
                    from arch/sh/include/asm/hardirq.h:9,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   include/asm-generic/iomap.h:82:13: note: previous declaration of 'ioread8_rep' with type 'void(const void *, void *, long unsigned int)'
      82 | extern void ioread8_rep(const void __iomem *port, void *buf, unsigned long count);
         |             ^~~~~~~~~~~
   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:17,
                    from arch/sh/include/asm/hardirq.h:9,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   include/asm-generic/io.h: In function 'ioread8_rep':
>> include/asm-generic/io.h:833:16: warning: passing argument 1 of '__raw_readsb' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     833 |         readsb(addr, buffer, count);
         |                ^~~~
   arch/sh/include/asm/io.h:59:46: note: in definition of macro 'readsb'
      59 | #define readsb(p,d,l)           __raw_readsb(p,d,l)
         |                                              ^
   arch/sh/include/asm/io.h:103:60: note: expected 'volatile void *' but argument is of type 'const volatile void *'
     103 | static inline void pfx##reads##bwlq(volatile void __iomem *mem,         \
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~^~~
   arch/sh/include/asm/io.h:114:1: note: in expansion of macro '__BUILD_MEMORY_STRING'
     114 | __BUILD_MEMORY_STRING(__raw_, b, u8)
         | ^~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/trace/trace_readwrite.c:10:
   include/asm-generic/io.h: At top level:
   include/asm-generic/io.h:838:22: error: conflicting types for 'ioread16_rep'; have 'void(const volatile void *, void *, unsigned int)'
     838 | #define ioread16_rep ioread16_rep
         |                      ^~~~~~~~~~~~
   include/asm-generic/io.h:839:20: note: in expansion of macro 'ioread16_rep'
     839 | static inline void ioread16_rep(const volatile void __iomem *addr,
         |                    ^~~~~~~~~~~~
   In file included from arch/sh/include/asm/io.h:22,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:17,
                    from arch/sh/include/asm/hardirq.h:9,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   include/asm-generic/iomap.h:83:13: note: previous declaration of 'ioread16_rep' with type 'void(const void *, void *, long unsigned int)'
      83 | extern void ioread16_rep(const void __iomem *port, void *buf, unsigned long count);
         |             ^~~~~~~~~~~~
   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:17,
                    from arch/sh/include/asm/hardirq.h:9,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   include/asm-generic/io.h: In function 'ioread16_rep':
>> include/asm-generic/io.h:842:16: warning: passing argument 1 of '__raw_readsw' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     842 |         readsw(addr, buffer, count);
         |                ^~~~
   arch/sh/include/asm/io.h:60:46: note: in definition of macro 'readsw'
      60 | #define readsw(p,d,l)           __raw_readsw(p,d,l)
         |                                              ^
   arch/sh/include/asm/io.h:103:60: note: expected 'volatile void *' but argument is of type 'const volatile void *'
     103 | static inline void pfx##reads##bwlq(volatile void __iomem *mem,         \
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~^~~
   arch/sh/include/asm/io.h:115:1: note: in expansion of macro '__BUILD_MEMORY_STRING'
     115 | __BUILD_MEMORY_STRING(__raw_, w, u16)
         | ^~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/trace/trace_readwrite.c:10:
   include/asm-generic/io.h: At top level:
   include/asm-generic/io.h:847:22: error: conflicting types for 'ioread32_rep'; have 'void(const volatile void *, void *, unsigned int)'
     847 | #define ioread32_rep ioread32_rep
         |                      ^~~~~~~~~~~~
   include/asm-generic/io.h:848:20: note: in expansion of macro 'ioread32_rep'
     848 | static inline void ioread32_rep(const volatile void __iomem *addr,
         |                    ^~~~~~~~~~~~
   In file included from arch/sh/include/asm/io.h:22,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:17,
                    from arch/sh/include/asm/hardirq.h:9,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   include/asm-generic/iomap.h:84:13: note: previous declaration of 'ioread32_rep' with type 'void(const void *, void *, long unsigned int)'
      84 | extern void ioread32_rep(const void __iomem *port, void *buf, unsigned long count);
         |             ^~~~~~~~~~~~
   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:17,
                    from arch/sh/include/asm/hardirq.h:9,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   include/asm-generic/io.h: In function 'ioread32_rep':
>> include/asm-generic/io.h:851:16: warning: passing argument 1 of '__raw_readsl' discards 'volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]
     851 |         readsl(addr, buffer, count);
         |                ^~~~
   arch/sh/include/asm/io.h:61:46: note: in definition of macro 'readsl'
      61 | #define readsl(p,d,l)           __raw_readsl(p,d,l)
         |                                              ^
   arch/sh/include/asm/io.h:118:39: note: expected 'const void *' but argument is of type 'const volatile void *'
     118 | void __raw_readsl(const void __iomem *addr, void *data, int longlen);
         |                   ~~~~~~~~~~~~~~~~~~~~^~~~
   In file included from kernel/trace/trace_readwrite.c:10:
   include/asm-generic/io.h: At top level:
   include/asm-generic/io.h:867:22: error: conflicting types for 'iowrite8_rep'; have 'void(volatile void *, const void *, unsigned int)'
     867 | #define iowrite8_rep iowrite8_rep
         |                      ^~~~~~~~~~~~
   include/asm-generic/io.h:868:20: note: in expansion of macro 'iowrite8_rep'
     868 | static inline void iowrite8_rep(volatile void __iomem *addr,
         |                    ^~~~~~~~~~~~
   In file included from arch/sh/include/asm/io.h:22,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:17,
                    from arch/sh/include/asm/hardirq.h:9,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   include/asm-generic/iomap.h:86:13: note: previous declaration of 'iowrite8_rep' with type 'void(void *, const void *, long unsigned int)'
      86 | extern void iowrite8_rep(void __iomem *port, const void *buf, unsigned long count);
         |             ^~~~~~~~~~~~
   In file included from kernel/trace/trace_readwrite.c:10:
   include/asm-generic/io.h:877:23: error: conflicting types for 'iowrite16_rep'; have 'void(volatile void *, const void *, unsigned int)'
     877 | #define iowrite16_rep iowrite16_rep
         |                       ^~~~~~~~~~~~~
   include/asm-generic/io.h:878:20: note: in expansion of macro 'iowrite16_rep'
     878 | static inline void iowrite16_rep(volatile void __iomem *addr,
         |                    ^~~~~~~~~~~~~
   In file included from arch/sh/include/asm/io.h:22,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:17,
                    from arch/sh/include/asm/hardirq.h:9,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   include/asm-generic/iomap.h:87:13: note: previous declaration of 'iowrite16_rep' with type 'void(void *, const void *, long unsigned int)'
      87 | extern void iowrite16_rep(void __iomem *port, const void *buf, unsigned long count);
         |             ^~~~~~~~~~~~~
   In file included from kernel/trace/trace_readwrite.c:10:
   include/asm-generic/io.h:887:23: error: conflicting types for 'iowrite32_rep'; have 'void(volatile void *, const void *, unsigned int)'
     887 | #define iowrite32_rep iowrite32_rep
         |                       ^~~~~~~~~~~~~
   include/asm-generic/io.h:888:20: note: in expansion of macro 'iowrite32_rep'
     888 | static inline void iowrite32_rep(volatile void __iomem *addr,
         |                    ^~~~~~~~~~~~~
   In file included from arch/sh/include/asm/io.h:22,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:17,
                    from arch/sh/include/asm/hardirq.h:9,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   include/asm-generic/iomap.h:88:13: note: previous declaration of 'iowrite32_rep' with type 'void(void *, const void *, long unsigned int)'
      88 | extern void iowrite32_rep(void __iomem *port, const void *buf, unsigned long count);
         |             ^~~~~~~~~~~~~
   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:17,
                    from arch/sh/include/asm/hardirq.h:9,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   include/asm-generic/io.h: In function 'iowrite32_rep':
>> include/asm-generic/io.h:892:17: warning: passing argument 1 of '__raw_writesl' discards 'volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]
     892 |         writesl(addr, buffer, count);
         |                 ^~~~
   arch/sh/include/asm/io.h:65:47: note: in definition of macro 'writesl'
      65 | #define writesl(p,d,l)          __raw_writesl(p,d,l)
         |                                               ^
   arch/sh/include/asm/io.h:117:34: note: expected 'void *' but argument is of type 'volatile void *'
     117 | void __raw_writesl(void __iomem *addr, const void *data, int longlen);
         |                    ~~~~~~~~~~~~~~^~~~
   In file included from kernel/trace/trace_readwrite.c:10:
   include/asm-generic/io.h: At top level:
   include/asm-generic/io.h:1077:19: error: conflicting types for 'memset_io'; have 'void(volatile void *, int,  size_t)' {aka 'void(volatile void *, int,  unsigned int)'}
    1077 | #define memset_io memset_io
         |                   ^~~~~~~~~
   include/asm-generic/io.h:1086:20: note: in expansion of macro 'memset_io'
    1086 | static inline void memset_io(volatile void __iomem *addr, int value,
         |                    ^~~~~~~~~
   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:17,
                    from arch/sh/include/asm/hardirq.h:9,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   arch/sh/include/asm/io.h:230:6: note: previous declaration of 'memset_io' with type 'void(volatile void *, int,  long unsigned int)'
     230 | void memset_io(volatile void __iomem *, int, unsigned long);
         |      ^~~~~~~~~
   In file included from kernel/trace/trace_readwrite.c:10:
   include/asm-generic/io.h:1094:23: error: conflicting types for 'memcpy_fromio'; have 'void(void *, const volatile void *, size_t)' {aka 'void(void *, const volatile void *, unsigned int)'}
    1094 | #define memcpy_fromio memcpy_fromio
         |                       ^~~~~~~~~~~~~
   include/asm-generic/io.h:1103:20: note: in expansion of macro 'memcpy_fromio'
    1103 | static inline void memcpy_fromio(void *buffer,
         |                    ^~~~~~~~~~~~~
   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:17,
                    from arch/sh/include/asm/hardirq.h:9,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   arch/sh/include/asm/io.h:228:6: note: previous declaration of 'memcpy_fromio' with type 'void(void *, const volatile void *, long unsigned int)'
     228 | void memcpy_fromio(void *, const volatile void __iomem *, unsigned long);
         |      ^~~~~~~~~~~~~
   In file included from kernel/trace/trace_readwrite.c:10:
   include/asm-generic/io.h:1112:21: error: conflicting types for 'memcpy_toio'; have 'void(volatile void *, const void *, size_t)' {aka 'void(volatile void *, const void *, unsigned int)'}
    1112 | #define memcpy_toio memcpy_toio
         |                     ^~~~~~~~~~~
   include/asm-generic/io.h:1121:20: note: in expansion of macro 'memcpy_toio'
    1121 | static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
         |                    ^~~~~~~~~~~
   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:17,
                    from arch/sh/include/asm/hardirq.h:9,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   arch/sh/include/asm/io.h:229:6: note: previous declaration of 'memcpy_toio' with type 'void(volatile void *, const void *, long unsigned int)'
     229 | void memcpy_toio(volatile void __iomem *, const void *, unsigned long);
         |      ^~~~~~~~~~~
   kernel/trace/trace_readwrite.c:16:6: warning: no previous prototype for 'log_write_mmio' [-Wmissing-prototypes]
      16 | void log_write_mmio(u64 val, u8 width, volatile void __iomem *addr)
         |      ^~~~~~~~~~~~~~
   kernel/trace/trace_readwrite.c:23:6: warning: no previous prototype for 'log_read_mmio' [-Wmissing-prototypes]
      23 | void log_read_mmio(u8 width, const volatile void __iomem *addr)
         |      ^~~~~~~~~~~~~


vim +833 include/asm-generic/io.h

9e44fb1816dba8 Horia Geantă   2016-05-19  827  
9ab3a7a0d2b417 Thierry Reding 2014-07-04  828  #ifndef ioread8_rep
9ab3a7a0d2b417 Thierry Reding 2014-07-04  829  #define ioread8_rep ioread8_rep
9ab3a7a0d2b417 Thierry Reding 2014-07-04  830  static inline void ioread8_rep(const volatile void __iomem *addr, void *buffer,
9ab3a7a0d2b417 Thierry Reding 2014-07-04  831  			       unsigned int count)
9ab3a7a0d2b417 Thierry Reding 2014-07-04  832  {
9ab3a7a0d2b417 Thierry Reding 2014-07-04 @833  	readsb(addr, buffer, count);
9ab3a7a0d2b417 Thierry Reding 2014-07-04  834  }
9ab3a7a0d2b417 Thierry Reding 2014-07-04  835  #endif
9ab3a7a0d2b417 Thierry Reding 2014-07-04  836  
9ab3a7a0d2b417 Thierry Reding 2014-07-04  837  #ifndef ioread16_rep
9ab3a7a0d2b417 Thierry Reding 2014-07-04  838  #define ioread16_rep ioread16_rep
9ab3a7a0d2b417 Thierry Reding 2014-07-04  839  static inline void ioread16_rep(const volatile void __iomem *addr,
9ab3a7a0d2b417 Thierry Reding 2014-07-04  840  				void *buffer, unsigned int count)
9ab3a7a0d2b417 Thierry Reding 2014-07-04  841  {
9ab3a7a0d2b417 Thierry Reding 2014-07-04 @842  	readsw(addr, buffer, count);
9ab3a7a0d2b417 Thierry Reding 2014-07-04  843  }
9ab3a7a0d2b417 Thierry Reding 2014-07-04  844  #endif
9ab3a7a0d2b417 Thierry Reding 2014-07-04  845  
9ab3a7a0d2b417 Thierry Reding 2014-07-04  846  #ifndef ioread32_rep
9ab3a7a0d2b417 Thierry Reding 2014-07-04  847  #define ioread32_rep ioread32_rep
9ab3a7a0d2b417 Thierry Reding 2014-07-04  848  static inline void ioread32_rep(const volatile void __iomem *addr,
9ab3a7a0d2b417 Thierry Reding 2014-07-04  849  				void *buffer, unsigned int count)
9ab3a7a0d2b417 Thierry Reding 2014-07-04  850  {
9ab3a7a0d2b417 Thierry Reding 2014-07-04 @851  	readsl(addr, buffer, count);
9ab3a7a0d2b417 Thierry Reding 2014-07-04  852  }
9ab3a7a0d2b417 Thierry Reding 2014-07-04  853  #endif
9ab3a7a0d2b417 Thierry Reding 2014-07-04  854  
9e44fb1816dba8 Horia Geantă   2016-05-19  855  #ifdef CONFIG_64BIT
9e44fb1816dba8 Horia Geantă   2016-05-19  856  #ifndef ioread64_rep
9e44fb1816dba8 Horia Geantă   2016-05-19  857  #define ioread64_rep ioread64_rep
9e44fb1816dba8 Horia Geantă   2016-05-19  858  static inline void ioread64_rep(const volatile void __iomem *addr,
9e44fb1816dba8 Horia Geantă   2016-05-19  859  				void *buffer, unsigned int count)
9e44fb1816dba8 Horia Geantă   2016-05-19  860  {
9e44fb1816dba8 Horia Geantă   2016-05-19  861  	readsq(addr, buffer, count);
9e44fb1816dba8 Horia Geantă   2016-05-19  862  }
9e44fb1816dba8 Horia Geantă   2016-05-19  863  #endif
9e44fb1816dba8 Horia Geantă   2016-05-19  864  #endif /* CONFIG_64BIT */
9e44fb1816dba8 Horia Geantă   2016-05-19  865  
9ab3a7a0d2b417 Thierry Reding 2014-07-04  866  #ifndef iowrite8_rep
9ab3a7a0d2b417 Thierry Reding 2014-07-04  867  #define iowrite8_rep iowrite8_rep
9ab3a7a0d2b417 Thierry Reding 2014-07-04  868  static inline void iowrite8_rep(volatile void __iomem *addr,
9ab3a7a0d2b417 Thierry Reding 2014-07-04  869  				const void *buffer,
9ab3a7a0d2b417 Thierry Reding 2014-07-04  870  				unsigned int count)
9ab3a7a0d2b417 Thierry Reding 2014-07-04  871  {
9ab3a7a0d2b417 Thierry Reding 2014-07-04  872  	writesb(addr, buffer, count);
9ab3a7a0d2b417 Thierry Reding 2014-07-04  873  }
9ab3a7a0d2b417 Thierry Reding 2014-07-04  874  #endif
9ab3a7a0d2b417 Thierry Reding 2014-07-04  875  
9ab3a7a0d2b417 Thierry Reding 2014-07-04  876  #ifndef iowrite16_rep
9ab3a7a0d2b417 Thierry Reding 2014-07-04  877  #define iowrite16_rep iowrite16_rep
9ab3a7a0d2b417 Thierry Reding 2014-07-04  878  static inline void iowrite16_rep(volatile void __iomem *addr,
9ab3a7a0d2b417 Thierry Reding 2014-07-04  879  				 const void *buffer,
9ab3a7a0d2b417 Thierry Reding 2014-07-04  880  				 unsigned int count)
9ab3a7a0d2b417 Thierry Reding 2014-07-04  881  {
9ab3a7a0d2b417 Thierry Reding 2014-07-04  882  	writesw(addr, buffer, count);
9ab3a7a0d2b417 Thierry Reding 2014-07-04  883  }
9ab3a7a0d2b417 Thierry Reding 2014-07-04  884  #endif
9ab3a7a0d2b417 Thierry Reding 2014-07-04  885  
9ab3a7a0d2b417 Thierry Reding 2014-07-04  886  #ifndef iowrite32_rep
9ab3a7a0d2b417 Thierry Reding 2014-07-04  887  #define iowrite32_rep iowrite32_rep
9ab3a7a0d2b417 Thierry Reding 2014-07-04  888  static inline void iowrite32_rep(volatile void __iomem *addr,
9ab3a7a0d2b417 Thierry Reding 2014-07-04  889  				 const void *buffer,
9ab3a7a0d2b417 Thierry Reding 2014-07-04  890  				 unsigned int count)
9ab3a7a0d2b417 Thierry Reding 2014-07-04  891  {
9ab3a7a0d2b417 Thierry Reding 2014-07-04 @892  	writesl(addr, buffer, count);
9ab3a7a0d2b417 Thierry Reding 2014-07-04  893  }
9ab3a7a0d2b417 Thierry Reding 2014-07-04  894  #endif
9e44fb1816dba8 Horia Geantă   2016-05-19  895  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
