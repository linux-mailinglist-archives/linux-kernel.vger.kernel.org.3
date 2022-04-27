Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F769511484
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 11:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiD0Jun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 05:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiD0Juf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 05:50:35 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ED028C2BF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 02:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651052786; x=1682588786;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gZJgqAoeFMNUtsZovCvOzH9l4BnSsHLcKnYp1fr9X7Y=;
  b=Ryoe99DE6KC05GK9PQnTEk9bA2boSoBph7hm2sMds+WVrljrouXzZJM6
   Y5tXy+wnxpoRwQYaDp1gpIKYKusBltuTdFUTM1UN+SKmR4K3veVij36VD
   6AscjOt4w6xDYDR6gooWTTfKcLlWRwP0vzue5W5MkvoaCs8hDETfkFVX0
   0q/2QovUvlWDq5L3ajKSTpZ4wDaU6xT+VEDhiTXT/n73K5CRooIqZEARp
   vEUaPpjuUxhJJbNdaubvb8kUnH3WCvDM1vp7OWcnA9KbnruZr8OQild1m
   LffYbT4V/KMu3MCmFS4C4CJq88lwEzRZfsbqnvI5Bo0KtocH+d/gO9W3d
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="246438768"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="246438768"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 02:36:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="596202340"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 Apr 2022 02:36:36 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nje67-0004Yk-Hq;
        Wed, 27 Apr 2022 09:36:35 +0000
Date:   Wed, 27 Apr 2022 17:36:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: [ammarfaizi2-block:palmer/linux/riscv-compat 18/20]
 arch/riscv/include/asm/signal32.h:10:5: warning: no previous prototype for
 function 'compat_setup_rt_frame'
Message-ID: <202204271718.xbiawVrz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/riscv-compat
head:   8d05fa26dd28024fc3f915bf06be41ab7c3204ab
commit: 299073d795e482ae6a762105fbc3953ec445badd [18/20] riscv: compat: signal: Add rt_frame implementation
config: riscv-randconfig-r002-20220425 (https://download.01.org/0day-ci/archive/20220427/202204271718.xbiawVrz-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/299073d795e482ae6a762105fbc3953ec445badd
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/riscv-compat
        git checkout 299073d795e482ae6a762105fbc3953ec445badd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/ kernel/bpf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/riscv/kernel/signal.c:12:
   In file included from include/linux/syscalls.h:88:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:9:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from arch/riscv/kernel/signal.c:12:
   In file included from include/linux/syscalls.h:88:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:9:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from arch/riscv/kernel/signal.c:12:
   In file included from include/linux/syscalls.h:88:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:9:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:1024:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
                                                     ~~~~~~~~~~ ^
   In file included from arch/riscv/kernel/signal.c:18:
>> arch/riscv/include/asm/signal32.h:10:5: warning: no previous prototype for function 'compat_setup_rt_frame' [-Wmissing-prototypes]
   int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
       ^
   arch/riscv/include/asm/signal32.h:10:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
   ^
   static 
   arch/riscv/kernel/signal.c:316:27: warning: no previous prototype for function 'do_notify_resume' [-Wmissing-prototypes]
   asmlinkage __visible void do_notify_resume(struct pt_regs *regs,
                             ^
   arch/riscv/kernel/signal.c:316:22: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage __visible void do_notify_resume(struct pt_regs *regs,
                        ^
                        static 
   9 warnings generated.


vim +/compat_setup_rt_frame +10 arch/riscv/include/asm/signal32.h

     5	
     6	#if IS_ENABLED(CONFIG_COMPAT)
     7	int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
     8				  struct pt_regs *regs);
     9	#else
  > 10	int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
    11				  struct pt_regs *regs)
    12	{
    13		return -1;
    14	}
    15	#endif
    16	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
