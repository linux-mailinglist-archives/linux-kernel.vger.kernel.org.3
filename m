Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7FF486E29
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 00:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343612AbiAFXyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 18:54:44 -0500
Received: from mga17.intel.com ([192.55.52.151]:64776 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343516AbiAFXyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 18:54:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641513283; x=1673049283;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ev/jufds9gXwyD6IAz7KwS8ATTwmnx3cOp5OJdNQ5Gs=;
  b=L6jk1pZtBUBmTWrH7RNzU1yC8kun9hznaB3sSzYwceE/txFfJStcHyDQ
   Z4g+sf7uOBYoIE0+fyxMuKUEgvVHuv5E+7uCCGK2lK/DatQnV4X5hKt8x
   8UVfw6udSOiTofeD8X7t4pigJ/j7pY4PxB64zGLstKxNyjHLIVGYmdCEF
   ZvRF3ZTDE9hyZVcbL7IDLF0AvVjyhuNj7WQg8oGHrpe2K+Ya8r0z/VvFU
   u+Jv65lfk2ZVD3RKHKBKmXjVGyRZeNUuP5jNrDevxz0zS0Mw5yfGLBAL4
   JU0cUOlGXr7EUZ2DPkPdIuGJMwIIPVDn+CJjomFTSVQnLtbeI5B+MJmcD
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="223458751"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="223458751"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 15:54:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="527171640"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 06 Jan 2022 15:54:34 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5caX-000I5z-E1; Thu, 06 Jan 2022 23:54:33 +0000
Date:   Fri, 7 Jan 2022 07:54:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mark:kvm/entry-rework 1/5] include/linux/kvm_host.h:434:30: error:
 use of undeclared identifier 'CALLER_ADDR0'
Message-ID: <202201070726.gjZvQM6R-lkp@intel.com>
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
config: s390-alldefconfig (https://download.01.org/0day-ci/archive/20220107/202201070726.gjZvQM6R-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project ca7ffe09dc6e525109e3cd570cc5182ce568be13)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=0515c622963b34a5fc0aeee6dbd18f47b7e40563
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark kvm/entry-rework
        git checkout 0515c622963b34a5fc0aeee6dbd18f47b7e40563
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:35:
   In file included from include/linux/kvm_para.h:5:
   In file included from include/uapi/linux/kvm_para.h:37:
   In file included from arch/s390/include/asm/kvm_para.h:25:
   In file included from arch/s390/include/asm/diag.h:12:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
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
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:35:
   In file included from include/linux/kvm_para.h:5:
   In file included from include/uapi/linux/kvm_para.h:37:
   In file included from arch/s390/include/asm/kvm_para.h:25:
   In file included from arch/s390/include/asm/diag.h:12:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
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
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:35:
   In file included from include/linux/kvm_para.h:5:
   In file included from include/uapi/linux/kvm_para.h:37:
   In file included from arch/s390/include/asm/kvm_para.h:25:
   In file included from arch/s390/include/asm/diag.h:12:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
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
   In file included from arch/s390/kernel/asm-offsets.c:11:
>> include/linux/kvm_host.h:434:30: error: use of undeclared identifier 'CALLER_ADDR0'
           lockdep_hardirqs_on_prepare(CALLER_ADDR0);
                                       ^
   include/linux/kvm_host.h:438:22: error: use of undeclared identifier 'CALLER_ADDR0'
           lockdep_hardirqs_on(CALLER_ADDR0);
                               ^
   include/linux/kvm_host.h:502:23: error: use of undeclared identifier 'CALLER_ADDR0'
           lockdep_hardirqs_off(CALLER_ADDR0);
                                ^
   12 warnings and 3 errors generated.
   make[2]: *** [scripts/Makefile.build:121: arch/s390/kernel/asm-offsets.s] Error 1
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
