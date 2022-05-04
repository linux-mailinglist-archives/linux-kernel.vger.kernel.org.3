Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E92251985E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 09:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345976AbiEDHhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 03:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345873AbiEDHgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 03:36:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C562723BE8
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 00:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651649578; x=1683185578;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YcbSbN/EdUH2G37lxbPJX7/t7tkGuDEzj+QFtM1C77M=;
  b=ECkEuIYhZZ/0NbKCbTEl5EEVuR+nNhqIkKicaBbBaGX90d7ZO2CeuY18
   KagtkbFdDHeqMtrBllTj3vncs/FPLw03WTsyIDiseWOQfp1Jyi5G1v19M
   +eIs66EbxWXcd7Nf0YuKjtJRSAxmbotVltDuA4f40T0GZ1TBtA979wqKh
   BPGmNwnODXM8uzo5OFGaYUYSVuuWeKwPRCuBbFAF9QbZLA8XZYNljJVWM
   Cn2F+3vlOldMVYekahuQu3a9yjmLN5pMm5I88widGwd6SKphQHZy0Aedb
   57eMYzkXoxr4GEFI50/bGNJo9QYixh65Vw4+Zq9qHpkXx48MYlbpQjONK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="247599362"
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="247599362"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 00:32:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="734279862"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 04 May 2022 00:32:56 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nm9VH-000BAt-PN;
        Wed, 04 May 2022 07:32:55 +0000
Date:   Wed, 4 May 2022 15:32:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [niks:has_ioport_v3 39/39] include/asm-generic/io.h:713:2: error:
 'error' attribute does not appear on the first declaration
Message-ID: <202205041505.DuFfLvAz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git has_ioport_v3
head:   45df38c1492340a5c06ff7ad2966735c1f5c4d94
commit: 45df38c1492340a5c06ff7ad2966735c1f5c4d94 [39/39] asm-generic/io.h: drop inb() etc for HAS_IOPORT=n
config: powerpc-mpc512x_defconfig (https://download.01.org/0day-ci/archive/20220504/202205041505.DuFfLvAz-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 363b3a645a1e30011cc8da624f13dac5fd915628)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/commit/?id=45df38c1492340a5c06ff7ad2966735c1f5c4d94
        git remote add niks https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git
        git fetch --no-tags niks has_ioport_v3
        git checkout 45df38c1492340a5c06ff7ad2966735c1f5c4d94
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:643:
   arch/powerpc/include/asm/io-defs.h:47:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:640:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:102:1: note: expanded from here
   __do_insl
   ^
   arch/powerpc/include/asm/io.h:582:56: note: expanded from macro '__do_insl'
   #define __do_insl(p, b, n)      readsl((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from arch/powerpc/kernel/asm-offsets.c:21:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:643:
   arch/powerpc/include/asm/io-defs.h:49:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:640:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:104:1: note: expanded from here
   __do_outsb
   ^
   arch/powerpc/include/asm/io.h:583:58: note: expanded from macro '__do_outsb'
   #define __do_outsb(p, b, n)     writesb((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from arch/powerpc/kernel/asm-offsets.c:21:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:643:
   arch/powerpc/include/asm/io-defs.h:51:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:640:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:106:1: note: expanded from here
   __do_outsw
   ^
   arch/powerpc/include/asm/io.h:584:58: note: expanded from macro '__do_outsw'
   #define __do_outsw(p, b, n)     writesw((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from arch/powerpc/kernel/asm-offsets.c:21:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:643:
   arch/powerpc/include/asm/io-defs.h:53:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:640:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:108:1: note: expanded from here
   __do_outsl
   ^
   arch/powerpc/include/asm/io.h:585:58: note: expanded from macro '__do_outsl'
   #define __do_outsl(p, b, n)     writesl((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from arch/powerpc/kernel/asm-offsets.c:21:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:1027:
>> include/asm-generic/io.h:713:2: error: 'error' attribute does not appear on the first declaration
           __compiletime_error("inb()/inb_p() requires CONFIG_HAS_IOPORT");
           ^
   include/linux/compiler_attributes.h:146:56: note: expanded from macro '__compiletime_error'
   # define __compiletime_error(msg)       __attribute__((__error__(msg)))
                                                          ^
   arch/powerpc/include/asm/io-defs.h:23:16: note: previous declaration is here
   DEF_PCI_AC_RET(inb, u8, (unsigned long port), (port), pio, port)
                  ^
   In file included from arch/powerpc/kernel/asm-offsets.c:21:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:1027:
   include/asm-generic/io.h:716:2: error: 'error' attribute does not appear on the first declaration
           __compiletime_error("inw()/inw_p() requires CONFIG_HAS_IOPORT");
           ^
   include/linux/compiler_attributes.h:146:56: note: expanded from macro '__compiletime_error'
   # define __compiletime_error(msg)       __attribute__((__error__(msg)))
                                                          ^
   arch/powerpc/include/asm/io-defs.h:24:16: note: previous declaration is here
   DEF_PCI_AC_RET(inw, u16, (unsigned long port), (port), pio, port)
                  ^
   In file included from arch/powerpc/kernel/asm-offsets.c:21:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:1027:
   include/asm-generic/io.h:719:2: error: 'error' attribute does not appear on the first declaration
           __compiletime_error("inl()/inl_p() requires CONFIG_HAS_IOPORT");
           ^
   include/linux/compiler_attributes.h:146:56: note: expanded from macro '__compiletime_error'
   # define __compiletime_error(msg)       __attribute__((__error__(msg)))
                                                          ^
   arch/powerpc/include/asm/io-defs.h:25:16: note: previous declaration is here
   DEF_PCI_AC_RET(inl, u32, (unsigned long port), (port), pio, port)
                  ^
   In file included from arch/powerpc/kernel/asm-offsets.c:21:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:1027:
   include/asm-generic/io.h:722:2: error: 'error' attribute does not appear on the first declaration
           __compiletime_error("outb()/outb_p() requires CONFIG_HAS_IOPORT");
           ^
   include/linux/compiler_attributes.h:146:56: note: expanded from macro '__compiletime_error'
   # define __compiletime_error(msg)       __attribute__((__error__(msg)))
                                                          ^
   arch/powerpc/include/asm/io-defs.h:26:18: note: previous declaration is here
   DEF_PCI_AC_NORET(outb, (u8 val, unsigned long port), (val, port), pio, port)
                    ^
   In file included from arch/powerpc/kernel/asm-offsets.c:21:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:1027:
   include/asm-generic/io.h:725:2: error: 'error' attribute does not appear on the first declaration
           __compiletime_error("outw()/outw_p() requires CONFIG_HAS_IOPORT");
           ^
   include/linux/compiler_attributes.h:146:56: note: expanded from macro '__compiletime_error'
   # define __compiletime_error(msg)       __attribute__((__error__(msg)))
                                                          ^
   arch/powerpc/include/asm/io-defs.h:27:18: note: previous declaration is here
   DEF_PCI_AC_NORET(outw, (u16 val, unsigned long port), (val, port), pio, port)
                    ^
   In file included from arch/powerpc/kernel/asm-offsets.c:21:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:1027:
   include/asm-generic/io.h:728:2: error: 'error' attribute does not appear on the first declaration
           __compiletime_error("outl()/outl_p() requires CONFIG_HAS_IOPORT");
           ^
   include/linux/compiler_attributes.h:146:56: note: expanded from macro '__compiletime_error'
   # define __compiletime_error(msg)       __attribute__((__error__(msg)))
                                                          ^
   arch/powerpc/include/asm/io-defs.h:28:18: note: previous declaration is here
   DEF_PCI_AC_NORET(outl, (u32 val, unsigned long port), (val, port), pio, port)
                    ^
   In file included from arch/powerpc/kernel/asm-offsets.c:21:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:1027:
>> include/asm-generic/io.h:730:9: warning: 'inb_p' macro redefined [-Wmacro-redefined]
   #define inb_p inb
           ^
   arch/powerpc/include/asm/io.h:823:9: note: previous definition is here
   #define inb_p(port)             inb(port)
           ^
   In file included from arch/powerpc/kernel/asm-offsets.c:21:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:1027:
>> include/asm-generic/io.h:731:9: warning: 'inw_p' macro redefined [-Wmacro-redefined]
   #define inw_p inw
           ^
   arch/powerpc/include/asm/io.h:825:9: note: previous definition is here
   #define inw_p(port)             inw(port)
           ^
   In file included from arch/powerpc/kernel/asm-offsets.c:21:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:1027:
>> include/asm-generic/io.h:732:9: warning: 'inl_p' macro redefined [-Wmacro-redefined]
   #define inl_p inl
           ^
   arch/powerpc/include/asm/io.h:827:9: note: previous definition is here
   #define inl_p(port)             inl(port)
           ^
   In file included from arch/powerpc/kernel/asm-offsets.c:21:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:1027:
>> include/asm-generic/io.h:733:9: warning: 'outb_p' macro redefined [-Wmacro-redefined]
   #define outb_p outb
           ^
   arch/powerpc/include/asm/io.h:824:9: note: previous definition is here
   #define outb_p(val, port)       (udelay(1), outb((val), (port)))
           ^
   In file included from arch/powerpc/kernel/asm-offsets.c:21:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:1027:
>> include/asm-generic/io.h:734:9: warning: 'outw_p' macro redefined [-Wmacro-redefined]
   #define outw_p outw
           ^
   arch/powerpc/include/asm/io.h:826:9: note: previous definition is here
   #define outw_p(val, port)       (udelay(1), outw((val), (port)))
           ^
   In file included from arch/powerpc/kernel/asm-offsets.c:21:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:1027:
>> include/asm-generic/io.h:735:9: warning: 'outl_p' macro redefined [-Wmacro-redefined]
   #define outl_p outl
           ^
   arch/powerpc/include/asm/io.h:828:9: note: previous definition is here
   #define outl_p(val, port)       (udelay(1), outl((val), (port)))
           ^
   In file included from arch/powerpc/kernel/asm-offsets.c:21:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:1027:
   include/asm-generic/io.h:739:2: error: 'error' attribute does not appear on the first declaration
           __compiletime_error("insb()/insb_p() requires CONFIG_HAS_IOPORT");
           ^
   include/linux/compiler_attributes.h:146:56: note: expanded from macro '__compiletime_error'
   # define __compiletime_error(msg)       __attribute__((__error__(msg)))
                                                          ^
   arch/powerpc/include/asm/io-defs.h:43:18: note: previous declaration is here
   DEF_PCI_AC_NORET(insb, (unsigned long p, void *b, unsigned long c),
                    ^
   In file included from arch/powerpc/kernel/asm-offsets.c:21:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:1027:
>> include/asm-generic/io.h:738:6: error: conflicting types for 'insb'
   void insb(unsigned long addr, void *buffer, unsigned int count)
        ^
   include/asm-generic/io.h:737:14: note: expanded from macro 'insb'
   #define insb insb
                ^
   arch/powerpc/include/asm/io-defs.h:43:18: note: previous definition is here
   DEF_PCI_AC_NORET(insb, (unsigned long p, void *b, unsigned long c),
                    ^
   In file included from arch/powerpc/kernel/asm-offsets.c:21:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:1027:
   include/asm-generic/io.h:742:2: error: 'error' attribute does not appear on the first declaration
           __compiletime_error("insw()/insw_p() requires CONFIG_HAS_IOPORT");
           ^
   include/linux/compiler_attributes.h:146:56: note: expanded from macro '__compiletime_error'
   # define __compiletime_error(msg)       __attribute__((__error__(msg)))
                                                          ^
   arch/powerpc/include/asm/io-defs.h:45:18: note: previous declaration is here
   DEF_PCI_AC_NORET(insw, (unsigned long p, void *b, unsigned long c),
                    ^
   In file included from arch/powerpc/kernel/asm-offsets.c:21:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:1027:
>> include/asm-generic/io.h:741:6: error: conflicting types for 'insw'
   void insw(unsigned long addr, void *buffer, unsigned int count)
        ^
   include/asm-generic/io.h:740:14: note: expanded from macro 'insw'
   #define insw insw
                ^
   arch/powerpc/include/asm/io-defs.h:45:18: note: previous definition is here
   DEF_PCI_AC_NORET(insw, (unsigned long p, void *b, unsigned long c),
                    ^
   In file included from arch/powerpc/kernel/asm-offsets.c:21:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:1027:
   include/asm-generic/io.h:745:2: error: 'error' attribute does not appear on the first declaration
           __compiletime_error("insl()/insl_p() requires CONFIG_HAS_IOPORT");
           ^
   include/linux/compiler_attributes.h:146:56: note: expanded from macro '__compiletime_error'
   # define __compiletime_error(msg)       __attribute__((__error__(msg)))
                                                          ^
   arch/powerpc/include/asm/io-defs.h:47:18: note: previous declaration is here
   DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
                    ^
   In file included from arch/powerpc/kernel/asm-offsets.c:21:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:1027:
>> include/asm-generic/io.h:744:6: error: conflicting types for 'insl'
   void insl(unsigned long addr, void *buffer, unsigned int count)
        ^
   include/asm-generic/io.h:743:14: note: expanded from macro 'insl'
   #define insl insl
                ^
   arch/powerpc/include/asm/io-defs.h:47:18: note: previous definition is here
   DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
                    ^
   In file included from arch/powerpc/kernel/asm-offsets.c:21:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:1027:
   include/asm-generic/io.h:748:2: error: 'error' attribute does not appear on the first declaration
           __compiletime_error("outsb()/outsb_p() requires CONFIG_HAS_IOPORT");
           ^
   include/linux/compiler_attributes.h:146:56: note: expanded from macro '__compiletime_error'
   # define __compiletime_error(msg)       __attribute__((__error__(msg)))
                                                          ^
   arch/powerpc/include/asm/io-defs.h:49:18: note: previous declaration is here
   DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c),
                    ^
   In file included from arch/powerpc/kernel/asm-offsets.c:21:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:1027:
>> include/asm-generic/io.h:747:6: error: conflicting types for 'outsb'
   void outsb(unsigned long addr, const void *buffer, unsigned int count)
        ^
   include/asm-generic/io.h:746:15: note: expanded from macro 'outsb'
   #define outsb outsb
                 ^
   arch/powerpc/include/asm/io-defs.h:49:18: note: previous definition is here
   DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c),
                    ^
   In file included from arch/powerpc/kernel/asm-offsets.c:21:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:1027:
   include/asm-generic/io.h:751:2: error: 'error' attribute does not appear on the first declaration
           __compiletime_error("outsw()/outsw_p() requires CONFIG_HAS_IOPORT");
           ^
   include/linux/compiler_attributes.h:146:56: note: expanded from macro '__compiletime_error'
   # define __compiletime_error(msg)       __attribute__((__error__(msg)))
                                                          ^
   arch/powerpc/include/asm/io-defs.h:51:18: note: previous declaration is here
   DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
                    ^
   In file included from arch/powerpc/kernel/asm-offsets.c:21:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:1027:
>> include/asm-generic/io.h:750:6: error: conflicting types for 'outsw'
   void outsw(unsigned long addr, const void *buffer, unsigned int count)
        ^
   include/asm-generic/io.h:749:15: note: expanded from macro 'outsw'
   #define outsw outsw
                 ^
   arch/powerpc/include/asm/io-defs.h:51:18: note: previous definition is here
   DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
                    ^
   In file included from arch/powerpc/kernel/asm-offsets.c:21:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:1027:
   include/asm-generic/io.h:754:2: error: 'error' attribute does not appear on the first declaration
           __compiletime_error("outsl()/outsl_p() requires CONFIG_HAS_IOPORT");
           ^
   include/linux/compiler_attributes.h:146:56: note: expanded from macro '__compiletime_error'
   # define __compiletime_error(msg)       __attribute__((__error__(msg)))
                                                          ^
   arch/powerpc/include/asm/io-defs.h:53:18: note: previous declaration is here
   DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
                    ^
   In file included from arch/powerpc/kernel/asm-offsets.c:21:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:1027:
>> include/asm-generic/io.h:753:6: error: conflicting types for 'outsl'
   void outsl(unsigned long addr, const void *buffer, unsigned int count)
        ^
   include/asm-generic/io.h:752:15: note: expanded from macro 'outsl'
   #define outsl outsl
                 ^
   arch/powerpc/include/asm/io-defs.h:53:18: note: previous definition is here
   DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
                    ^
   12 warnings and 18 errors generated.
   make[2]: *** [scripts/Makefile.build:120: arch/powerpc/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/error +713 include/asm-generic/io.h

   701	
   702	#ifndef outsl_p
   703	#define outsl_p outsl_p
   704	static inline void outsl_p(unsigned long addr, const void *buffer,
   705				   unsigned int count)
   706	{
   707		outsl(addr, buffer, count);
   708	}
   709	#endif
   710	#else /* CONFIG_HAS_IOPORT */
   711	#define inb inb
   712	u8 inb(unsigned long addr)
 > 713		__compiletime_error("inb()/inb_p() requires CONFIG_HAS_IOPORT");
   714	#define inw inw
   715	u16 inw(unsigned long addr)
   716		__compiletime_error("inw()/inw_p() requires CONFIG_HAS_IOPORT");
   717	#define inl inl
   718	u32 inl(unsigned long addr)
   719		__compiletime_error("inl()/inl_p() requires CONFIG_HAS_IOPORT");
   720	#define outb outb
   721	void outb(u8 value, unsigned long addr)
   722		__compiletime_error("outb()/outb_p() requires CONFIG_HAS_IOPORT");
   723	#define outw outw
   724	void outw(u16 value, unsigned long addr)
   725		__compiletime_error("outw()/outw_p() requires CONFIG_HAS_IOPORT");
   726	#define outl outl
   727	void outl(u32 value, unsigned long addr)
   728		__compiletime_error("outl()/outl_p() requires CONFIG_HAS_IOPORT");
   729	
 > 730	#define inb_p inb
 > 731	#define inw_p inw
 > 732	#define inl_p inl
 > 733	#define outb_p outb
 > 734	#define outw_p outw
 > 735	#define outl_p outl
   736	
   737	#define insb insb
 > 738	void insb(unsigned long addr, void *buffer, unsigned int count)
   739		__compiletime_error("insb()/insb_p() requires CONFIG_HAS_IOPORT");
   740	#define insw insw
 > 741	void insw(unsigned long addr, void *buffer, unsigned int count)
   742		__compiletime_error("insw()/insw_p() requires CONFIG_HAS_IOPORT");
   743	#define insl insl
 > 744	void insl(unsigned long addr, void *buffer, unsigned int count)
   745		__compiletime_error("insl()/insl_p() requires CONFIG_HAS_IOPORT");
   746	#define outsb outsb
 > 747	void outsb(unsigned long addr, const void *buffer, unsigned int count)
   748		__compiletime_error("outsb()/outsb_p() requires CONFIG_HAS_IOPORT");
   749	#define outsw outsw
 > 750	void outsw(unsigned long addr, const void *buffer, unsigned int count)
   751		__compiletime_error("outsw()/outsw_p() requires CONFIG_HAS_IOPORT");
   752	#define outsl outsl
 > 753	void outsl(unsigned long addr, const void *buffer, unsigned int count)
   754		__compiletime_error("outsl()/outsl_p() requires CONFIG_HAS_IOPORT");
   755	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
