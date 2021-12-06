Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C45546A18F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbhLFQmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:42:47 -0500
Received: from mga06.intel.com ([134.134.136.31]:27159 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234427AbhLFQmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:42:45 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="298151443"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="298151443"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 08:39:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="461902736"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 06 Dec 2021 08:39:13 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muH1E-000LUC-C7; Mon, 06 Dec 2021 16:39:12 +0000
Date:   Tue, 7 Dec 2021 00:39:01 +0800
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
Message-ID: <202112070036.AVohI56z-lkp@intel.com>
References: <e088f4b4021f2e56093c7f73e77f556059e114b7.1638275062.git.quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e088f4b4021f2e56093c7f73e77f556059e114b7.1638275062.git.quic_saipraka@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sai,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on rostedt-trace/for-next arnd-asm-generic/master v5.16-rc4 next-20211206]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Sai-Prakash-Ranjan/tracing-rwmmio-arm64-Add-support-to-trace-register-reads-writes/20211206-163212
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20211207/202112070036.AVohI56z-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/1b255eef866824f8925cc46d6b127d641f1c8982
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Sai-Prakash-Ranjan/tracing-rwmmio-arm64-Add-support-to-trace-register-reads-writes/20211206-163212
        git checkout 1b255eef866824f8925cc46d6b127d641f1c8982
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/trace/trace_readwrite.c:10:
>> include/asm-generic/io.h:74:21: error: redefinition of '__raw_readb'
      74 | #define __raw_readb __raw_readb
         |                     ^~~~~~~~~~~
   include/asm-generic/io.h:75:18: note: in expansion of macro '__raw_readb'
      75 | static inline u8 __raw_readb(const volatile void __iomem *addr)
         |                  ^~~~~~~~~~~
   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/parisc/include/asm/hardirq.h:13,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   arch/parisc/include/asm/io.h:136:29: note: previous definition of '__raw_readb' with type 'unsigned char(const volatile void *)'
     136 | static inline unsigned char __raw_readb(const volatile void __iomem *addr)
         |                             ^~~~~~~~~~~
   In file included from kernel/trace/trace_readwrite.c:10:
>> include/asm-generic/io.h:82:21: error: redefinition of '__raw_readw'
      82 | #define __raw_readw __raw_readw
         |                     ^~~~~~~~~~~
   include/asm-generic/io.h:83:19: note: in expansion of macro '__raw_readw'
      83 | static inline u16 __raw_readw(const volatile void __iomem *addr)
         |                   ^~~~~~~~~~~
   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/parisc/include/asm/hardirq.h:13,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   arch/parisc/include/asm/io.h:140:30: note: previous definition of '__raw_readw' with type 'short unsigned int(const volatile void *)'
     140 | static inline unsigned short __raw_readw(const volatile void __iomem *addr)
         |                              ^~~~~~~~~~~
   In file included from kernel/trace/trace_readwrite.c:10:
>> include/asm-generic/io.h:90:21: error: redefinition of '__raw_readl'
      90 | #define __raw_readl __raw_readl
         |                     ^~~~~~~~~~~
   include/asm-generic/io.h:91:19: note: in expansion of macro '__raw_readl'
      91 | static inline u32 __raw_readl(const volatile void __iomem *addr)
         |                   ^~~~~~~~~~~
   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/parisc/include/asm/hardirq.h:13,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   arch/parisc/include/asm/io.h:144:28: note: previous definition of '__raw_readl' with type 'unsigned int(const volatile void *)'
     144 | static inline unsigned int __raw_readl(const volatile void __iomem *addr)
         |                            ^~~~~~~~~~~
   In file included from kernel/trace/trace_readwrite.c:10:
>> include/asm-generic/io.h:108:22: error: redefinition of '__raw_writeb'
     108 | #define __raw_writeb __raw_writeb
         |                      ^~~~~~~~~~~~
   include/asm-generic/io.h:109:20: note: in expansion of macro '__raw_writeb'
     109 | static inline void __raw_writeb(u8 value, volatile void __iomem *addr)
         |                    ^~~~~~~~~~~~
   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/parisc/include/asm/hardirq.h:13,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   arch/parisc/include/asm/io.h:153:20: note: previous definition of '__raw_writeb' with type 'void(unsigned char,  volatile void *)'
     153 | static inline void __raw_writeb(unsigned char b, volatile void __iomem *addr)
         |                    ^~~~~~~~~~~~
   In file included from kernel/trace/trace_readwrite.c:10:
>> include/asm-generic/io.h:116:22: error: redefinition of '__raw_writew'
     116 | #define __raw_writew __raw_writew
         |                      ^~~~~~~~~~~~
   include/asm-generic/io.h:117:20: note: in expansion of macro '__raw_writew'
     117 | static inline void __raw_writew(u16 value, volatile void __iomem *addr)
         |                    ^~~~~~~~~~~~
   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/parisc/include/asm/hardirq.h:13,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   arch/parisc/include/asm/io.h:157:20: note: previous definition of '__raw_writew' with type 'void(short unsigned int,  volatile void *)'
     157 | static inline void __raw_writew(unsigned short b, volatile void __iomem *addr)
         |                    ^~~~~~~~~~~~
   In file included from kernel/trace/trace_readwrite.c:10:
>> include/asm-generic/io.h:124:22: error: redefinition of '__raw_writel'
     124 | #define __raw_writel __raw_writel
         |                      ^~~~~~~~~~~~
   include/asm-generic/io.h:125:20: note: in expansion of macro '__raw_writel'
     125 | static inline void __raw_writel(u32 value, volatile void __iomem *addr)
         |                    ^~~~~~~~~~~~
   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/parisc/include/asm/hardirq.h:13,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   arch/parisc/include/asm/io.h:161:20: note: previous definition of '__raw_writel' with type 'void(unsigned int,  volatile void *)'
     161 | static inline void __raw_writel(unsigned int b, volatile void __iomem *addr)
         |                    ^~~~~~~~~~~~
   In file included from kernel/trace/trace_readwrite.c:10:
   include/asm-generic/io.h:606:14: error: conflicting types for 'insb'; have 'void(long unsigned int,  void *, unsigned int)'
     606 | #define insb insb
         |              ^~~~
   include/asm-generic/io.h:607:20: note: in expansion of macro 'insb'
     607 | static inline void insb(unsigned long addr, void *buffer, unsigned int count)
         |                    ^~~~
   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/parisc/include/asm/hardirq.h:13,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   arch/parisc/include/asm/io.h:284:13: note: previous declaration of 'insb' with type 'void(long unsigned int,  void *, long unsigned int)'
     284 | extern void insb (unsigned long port, void *dst, unsigned long count);
         |             ^~~~
   In file included from kernel/trace/trace_readwrite.c:10:
   include/asm-generic/io.h:614:14: error: conflicting types for 'insw'; have 'void(long unsigned int,  void *, unsigned int)'
     614 | #define insw insw
         |              ^~~~
   include/asm-generic/io.h:615:20: note: in expansion of macro 'insw'
     615 | static inline void insw(unsigned long addr, void *buffer, unsigned int count)
         |                    ^~~~
   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/parisc/include/asm/hardirq.h:13,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   arch/parisc/include/asm/io.h:285:13: note: previous declaration of 'insw' with type 'void(long unsigned int,  void *, long unsigned int)'
     285 | extern void insw (unsigned long port, void *dst, unsigned long count);
         |             ^~~~
   In file included from kernel/trace/trace_readwrite.c:10:
   include/asm-generic/io.h:622:14: error: conflicting types for 'insl'; have 'void(long unsigned int,  void *, unsigned int)'
     622 | #define insl insl
         |              ^~~~
   include/asm-generic/io.h:623:20: note: in expansion of macro 'insl'
     623 | static inline void insl(unsigned long addr, void *buffer, unsigned int count)
         |                    ^~~~
   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/parisc/include/asm/hardirq.h:13,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   arch/parisc/include/asm/io.h:286:13: note: previous declaration of 'insl' with type 'void(long unsigned int,  void *, long unsigned int)'
     286 | extern void insl (unsigned long port, void *dst, unsigned long count);
         |             ^~~~
   In file included from kernel/trace/trace_readwrite.c:10:
   include/asm-generic/io.h:630:15: error: conflicting types for 'outsb'; have 'void(long unsigned int,  const void *, unsigned int)'
     630 | #define outsb outsb
         |               ^~~~~
   include/asm-generic/io.h:631:20: note: in expansion of macro 'outsb'
     631 | static inline void outsb(unsigned long addr, const void *buffer,
         |                    ^~~~~
   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/parisc/include/asm/hardirq.h:13,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   arch/parisc/include/asm/io.h:287:13: note: previous declaration of 'outsb' with type 'void(long unsigned int,  const void *, long unsigned int)'
     287 | extern void outsb (unsigned long port, const void *src, unsigned long count);
         |             ^~~~~
   In file included from kernel/trace/trace_readwrite.c:10:
   include/asm-generic/io.h:639:15: error: conflicting types for 'outsw'; have 'void(long unsigned int,  const void *, unsigned int)'
     639 | #define outsw outsw
         |               ^~~~~
   include/asm-generic/io.h:640:20: note: in expansion of macro 'outsw'
     640 | static inline void outsw(unsigned long addr, const void *buffer,
         |                    ^~~~~
   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/parisc/include/asm/hardirq.h:13,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
--
                    from kernel/trace/trace_readwrite.c:8:
   include/asm-generic/iomap.h:82:13: note: previous declaration of 'ioread8_rep' with type 'void(const void *, void *, long unsigned int)'
      82 | extern void ioread8_rep(const void __iomem *port, void *buf, unsigned long count);
         |             ^~~~~~~~~~~
   In file included from kernel/trace/trace_readwrite.c:10:
   include/asm-generic/io.h:838:22: error: conflicting types for 'ioread16_rep'; have 'void(const volatile void *, void *, unsigned int)'
     838 | #define ioread16_rep ioread16_rep
         |                      ^~~~~~~~~~~~
   include/asm-generic/io.h:839:20: note: in expansion of macro 'ioread16_rep'
     839 | static inline void ioread16_rep(const volatile void __iomem *addr,
         |                    ^~~~~~~~~~~~
   In file included from arch/parisc/include/asm/io.h:311,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/parisc/include/asm/hardirq.h:13,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   include/asm-generic/iomap.h:83:13: note: previous declaration of 'ioread16_rep' with type 'void(const void *, void *, long unsigned int)'
      83 | extern void ioread16_rep(const void __iomem *port, void *buf, unsigned long count);
         |             ^~~~~~~~~~~~
   In file included from kernel/trace/trace_readwrite.c:10:
   include/asm-generic/io.h:847:22: error: conflicting types for 'ioread32_rep'; have 'void(const volatile void *, void *, unsigned int)'
     847 | #define ioread32_rep ioread32_rep
         |                      ^~~~~~~~~~~~
   include/asm-generic/io.h:848:20: note: in expansion of macro 'ioread32_rep'
     848 | static inline void ioread32_rep(const volatile void __iomem *addr,
         |                    ^~~~~~~~~~~~
   In file included from arch/parisc/include/asm/io.h:311,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/parisc/include/asm/hardirq.h:13,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   include/asm-generic/iomap.h:84:13: note: previous declaration of 'ioread32_rep' with type 'void(const void *, void *, long unsigned int)'
      84 | extern void ioread32_rep(const void __iomem *port, void *buf, unsigned long count);
         |             ^~~~~~~~~~~~
   In file included from kernel/trace/trace_readwrite.c:10:
   include/asm-generic/io.h:867:22: error: conflicting types for 'iowrite8_rep'; have 'void(volatile void *, const void *, unsigned int)'
     867 | #define iowrite8_rep iowrite8_rep
         |                      ^~~~~~~~~~~~
   include/asm-generic/io.h:868:20: note: in expansion of macro 'iowrite8_rep'
     868 | static inline void iowrite8_rep(volatile void __iomem *addr,
         |                    ^~~~~~~~~~~~
   In file included from arch/parisc/include/asm/io.h:311,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/parisc/include/asm/hardirq.h:13,
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
   In file included from arch/parisc/include/asm/io.h:311,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/parisc/include/asm/hardirq.h:13,
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
   In file included from arch/parisc/include/asm/io.h:311,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/parisc/include/asm/hardirq.h:13,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   include/asm-generic/iomap.h:88:13: note: previous declaration of 'iowrite32_rep' with type 'void(void *, const void *, long unsigned int)'
      88 | extern void iowrite32_rep(void __iomem *port, const void *buf, unsigned long count);
         |             ^~~~~~~~~~~~~
   In file included from kernel/trace/trace_readwrite.c:10:
>> include/asm-generic/io.h:1020:20: error: static declaration of 'ioport_map' follows non-static declaration
    1020 | #define ioport_map ioport_map
         |                    ^~~~~~~~~~
   include/asm-generic/io.h:1021:29: note: in expansion of macro 'ioport_map'
    1021 | static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
         |                             ^~~~~~~~~~
   In file included from arch/parisc/include/asm/io.h:311,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/parisc/include/asm/hardirq.h:13,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   include/asm-generic/iomap.h:92:22: note: previous declaration of 'ioport_map' with type 'void *(long unsigned int,  unsigned int)'
      92 | extern void __iomem *ioport_map(unsigned long port, unsigned int nr);
         |                      ^~~~~~~~~~
   In file included from kernel/trace/trace_readwrite.c:10:
>> include/asm-generic/io.h:1030:22: error: static declaration of 'ioport_unmap' follows non-static declaration
    1030 | #define ioport_unmap ioport_unmap
         |                      ^~~~~~~~~~~~
   include/asm-generic/io.h:1031:20: note: in expansion of macro 'ioport_unmap'
    1031 | static inline void ioport_unmap(void __iomem *p)
         |                    ^~~~~~~~~~~~
   In file included from arch/parisc/include/asm/io.h:311,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/parisc/include/asm/hardirq.h:13,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   include/asm-generic/iomap.h:93:13: note: previous declaration of 'ioport_unmap' with type 'void(void *)'
      93 | extern void ioport_unmap(void __iomem *);
         |             ^~~~~~~~~~~~
   In file included from kernel/trace/trace_readwrite.c:10:
   include/asm-generic/io.h:1077:19: error: conflicting types for 'memset_io'; have 'void(volatile void *, int,  size_t)' {aka 'void(volatile void *, int,  unsigned int)'}
    1077 | #define memset_io memset_io
         |                   ^~~~~~~~~
   include/asm-generic/io.h:1086:20: note: in expansion of macro 'memset_io'
    1086 | static inline void memset_io(volatile void __iomem *addr, int value,
         |                    ^~~~~~~~~
   In file included from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/parisc/include/asm/hardirq.h:13,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   arch/parisc/include/asm/io.h:222:6: note: previous declaration of 'memset_io' with type 'void(volatile void *, unsigned char,  int)'
     222 | void memset_io(volatile void __iomem *addr, unsigned char val, int count);
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
                    from arch/parisc/include/asm/hardirq.h:13,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   arch/parisc/include/asm/io.h:223:6: note: previous declaration of 'memcpy_fromio' with type 'void(void *, const volatile void *, int)'
     223 | void memcpy_fromio(void *dst, const volatile void __iomem *src, int count);
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
                    from arch/parisc/include/asm/hardirq.h:13,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/trace_readwrite.c:8:
   arch/parisc/include/asm/io.h:224:6: note: previous declaration of 'memcpy_toio' with type 'void(volatile void *, const void *, int)'
     224 | void memcpy_toio(volatile void __iomem *dst, const void *src, int count);
         |      ^~~~~~~~~~~
   kernel/trace/trace_readwrite.c:16:6: warning: no previous prototype for 'log_write_mmio' [-Wmissing-prototypes]
      16 | void log_write_mmio(u64 val, u8 width, volatile void __iomem *addr)
         |      ^~~~~~~~~~~~~~
   kernel/trace/trace_readwrite.c:23:6: warning: no previous prototype for 'log_read_mmio' [-Wmissing-prototypes]
      23 | void log_read_mmio(u8 width, const volatile void __iomem *addr)
         |      ^~~~~~~~~~~~~


vim +/__raw_readb +74 include/asm-generic/io.h

64e2c6738b4d49 Sinan Kaya     2018-04-05   63  
64e2c6738b4d49 Sinan Kaya     2018-04-05   64  
3f7e212df82ca0 Arnd Bergmann  2009-05-13   65  /*
9216efafc52ff9 Thierry Reding 2014-10-01   66   * __raw_{read,write}{b,w,l,q}() access memory in native endianness.
9216efafc52ff9 Thierry Reding 2014-10-01   67   *
9216efafc52ff9 Thierry Reding 2014-10-01   68   * On some architectures memory mapped IO needs to be accessed differently.
9216efafc52ff9 Thierry Reding 2014-10-01   69   * On the simple architectures, we just read/write the memory location
9216efafc52ff9 Thierry Reding 2014-10-01   70   * directly.
3f7e212df82ca0 Arnd Bergmann  2009-05-13   71   */
9216efafc52ff9 Thierry Reding 2014-10-01   72  
35dbc0e020c658 Mike Frysinger 2010-10-18   73  #ifndef __raw_readb
9216efafc52ff9 Thierry Reding 2014-10-01  @74  #define __raw_readb __raw_readb
3f7e212df82ca0 Arnd Bergmann  2009-05-13   75  static inline u8 __raw_readb(const volatile void __iomem *addr)
3f7e212df82ca0 Arnd Bergmann  2009-05-13   76  {
3f7e212df82ca0 Arnd Bergmann  2009-05-13   77  	return *(const volatile u8 __force *)addr;
3f7e212df82ca0 Arnd Bergmann  2009-05-13   78  }
35dbc0e020c658 Mike Frysinger 2010-10-18   79  #endif
3f7e212df82ca0 Arnd Bergmann  2009-05-13   80  
35dbc0e020c658 Mike Frysinger 2010-10-18   81  #ifndef __raw_readw
9216efafc52ff9 Thierry Reding 2014-10-01  @82  #define __raw_readw __raw_readw
3f7e212df82ca0 Arnd Bergmann  2009-05-13   83  static inline u16 __raw_readw(const volatile void __iomem *addr)
3f7e212df82ca0 Arnd Bergmann  2009-05-13   84  {
3f7e212df82ca0 Arnd Bergmann  2009-05-13   85  	return *(const volatile u16 __force *)addr;
3f7e212df82ca0 Arnd Bergmann  2009-05-13   86  }
35dbc0e020c658 Mike Frysinger 2010-10-18   87  #endif
3f7e212df82ca0 Arnd Bergmann  2009-05-13   88  
35dbc0e020c658 Mike Frysinger 2010-10-18   89  #ifndef __raw_readl
9216efafc52ff9 Thierry Reding 2014-10-01  @90  #define __raw_readl __raw_readl
3f7e212df82ca0 Arnd Bergmann  2009-05-13   91  static inline u32 __raw_readl(const volatile void __iomem *addr)
3f7e212df82ca0 Arnd Bergmann  2009-05-13   92  {
3f7e212df82ca0 Arnd Bergmann  2009-05-13   93  	return *(const volatile u32 __force *)addr;
3f7e212df82ca0 Arnd Bergmann  2009-05-13   94  }
35dbc0e020c658 Mike Frysinger 2010-10-18   95  #endif
3f7e212df82ca0 Arnd Bergmann  2009-05-13   96  
9216efafc52ff9 Thierry Reding 2014-10-01   97  #ifdef CONFIG_64BIT
9216efafc52ff9 Thierry Reding 2014-10-01   98  #ifndef __raw_readq
9216efafc52ff9 Thierry Reding 2014-10-01   99  #define __raw_readq __raw_readq
9216efafc52ff9 Thierry Reding 2014-10-01  100  static inline u64 __raw_readq(const volatile void __iomem *addr)
7292e7e01cc98f Heiko Carstens 2013-01-07  101  {
9216efafc52ff9 Thierry Reding 2014-10-01  102  	return *(const volatile u64 __force *)addr;
7292e7e01cc98f Heiko Carstens 2013-01-07  103  }
9216efafc52ff9 Thierry Reding 2014-10-01  104  #endif
9216efafc52ff9 Thierry Reding 2014-10-01  105  #endif /* CONFIG_64BIT */
3f7e212df82ca0 Arnd Bergmann  2009-05-13  106  
35dbc0e020c658 Mike Frysinger 2010-10-18  107  #ifndef __raw_writeb
9216efafc52ff9 Thierry Reding 2014-10-01 @108  #define __raw_writeb __raw_writeb
9216efafc52ff9 Thierry Reding 2014-10-01  109  static inline void __raw_writeb(u8 value, volatile void __iomem *addr)
3f7e212df82ca0 Arnd Bergmann  2009-05-13  110  {
9216efafc52ff9 Thierry Reding 2014-10-01  111  	*(volatile u8 __force *)addr = value;
3f7e212df82ca0 Arnd Bergmann  2009-05-13  112  }
35dbc0e020c658 Mike Frysinger 2010-10-18  113  #endif
3f7e212df82ca0 Arnd Bergmann  2009-05-13  114  
35dbc0e020c658 Mike Frysinger 2010-10-18  115  #ifndef __raw_writew
9216efafc52ff9 Thierry Reding 2014-10-01 @116  #define __raw_writew __raw_writew
9216efafc52ff9 Thierry Reding 2014-10-01  117  static inline void __raw_writew(u16 value, volatile void __iomem *addr)
3f7e212df82ca0 Arnd Bergmann  2009-05-13  118  {
9216efafc52ff9 Thierry Reding 2014-10-01  119  	*(volatile u16 __force *)addr = value;
3f7e212df82ca0 Arnd Bergmann  2009-05-13  120  }
35dbc0e020c658 Mike Frysinger 2010-10-18  121  #endif
3f7e212df82ca0 Arnd Bergmann  2009-05-13  122  
35dbc0e020c658 Mike Frysinger 2010-10-18  123  #ifndef __raw_writel
9216efafc52ff9 Thierry Reding 2014-10-01 @124  #define __raw_writel __raw_writel
9216efafc52ff9 Thierry Reding 2014-10-01  125  static inline void __raw_writel(u32 value, volatile void __iomem *addr)
3f7e212df82ca0 Arnd Bergmann  2009-05-13  126  {
9216efafc52ff9 Thierry Reding 2014-10-01  127  	*(volatile u32 __force *)addr = value;
3f7e212df82ca0 Arnd Bergmann  2009-05-13  128  }
35dbc0e020c658 Mike Frysinger 2010-10-18  129  #endif
3f7e212df82ca0 Arnd Bergmann  2009-05-13  130  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
