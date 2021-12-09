Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C20E46F7CF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 01:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbhLJAEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 19:04:44 -0500
Received: from mga01.intel.com ([192.55.52.88]:11728 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230490AbhLJAEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 19:04:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639094469; x=1670630469;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ns55OeCdhnWy6O+UAopBMsgcN1hw7GLsLJeQrVbni1I=;
  b=IlSSBcaRQHSj9kGsZ7ZUkQlUXOSXVGBIa1KQ+NMh44knu9UK0CxXk/zx
   kti7p0t45UNrlwk5W/87GqN1iDzpCK/sxuHlqfBAzyQXwWRtvHRPcZ4sp
   N+OGrO/NSb2OK6FsVs+CSUFWLH0SCXlsSJNggFHGJf2f1Kdr55Iu+xp12
   4BUEvy7uF+QokaiqJMwG1krDSN+hJ/w2osgCJMu41PwFkMfJMjfFW873U
   gvwQhNNdy21fR43trkQJUsY8RTdl2TlwwKiBIoU2s8b2GCjHW3tDPx3hs
   JzHXhmWIOLFTaApgcCTRGX/aQ56gMW2U+U5Utl83WTaZwih8eR3lDs6ju
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="262340990"
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="262340990"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 16:00:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="543781468"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 09 Dec 2021 16:00:47 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvTLC-0002Wj-SE; Fri, 10 Dec 2021 00:00:46 +0000
Date:   Fri, 10 Dec 2021 07:59:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [ardb:for-kernelci 1/1] arch/arm/boot/compressed/head.S:315:3:
 error: invalid instruction, any one of the following would fix this:
Message-ID: <202112100747.znK7leLP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git for-kernelci
head:   3d803745c0cdcca58579eb2654530bf4be3bef72
commit: 3d803745c0cdcca58579eb2654530bf4be3bef72 [1/1] ARM: set textoffset to 4 MiB unconditionally
config: arm-randconfig-r034-20211207 (https://download.01.org/0day-ci/archive/20211210/202112100747.znK7leLP-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=3d803745c0cdcca58579eb2654530bf4be3bef72
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb for-kernelci
        git checkout 3d803745c0cdcca58579eb2654530bf4be3bef72
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/arm/boot/compressed/head.S:315:3: error: invalid instruction, any one of the following would fix this:
     add r4, r0, #0x00408000
     ^
   arch/arm/boot/compressed/head.S:315:16: note: invalid operand for instruction
     add r4, r0, #0x00408000
                  ^
   arch/arm/boot/compressed/head.S:315:16: note: operand must be a register in range [r0, r15]
     add r4, r0, #0x00408000
                  ^
   arch/arm/boot/compressed/head.S:315:3: note: instruction requires: thumb2
     add r4, r0, #0x00408000
     ^
   arch/arm/boot/compressed/head.S:413:3: error: invalid instruction, any one of the following would fix this:
     sub r0, r4, #0x00408000
     ^
   arch/arm/boot/compressed/head.S:413:16: note: invalid operand for instruction
     sub r0, r4, #0x00408000
                  ^
   arch/arm/boot/compressed/head.S:413:16: note: operand must be a register in range [r0, r15]
     sub r0, r4, #0x00408000
                  ^
   arch/arm/boot/compressed/head.S:413:3: note: instruction requires: thumb2
     sub r0, r4, #0x00408000
     ^


vim +315 arch/arm/boot/compressed/head.S

0673cb38951215 Geert Uytterhoeven 2021-01-04  300  
0673cb38951215 Geert Uytterhoeven 2021-01-04  301  		/*
0673cb38951215 Geert Uytterhoeven 2021-01-04  302  		 * Make sure we have some stack before calling C code.
0673cb38951215 Geert Uytterhoeven 2021-01-04  303  		 * No GOT fixup has occurred yet, but none of the code we're
0673cb38951215 Geert Uytterhoeven 2021-01-04  304  		 * about to call uses any global variables.
0673cb38951215 Geert Uytterhoeven 2021-01-04  305  		 */
0673cb38951215 Geert Uytterhoeven 2021-01-04  306  		ldr	sp, [r1]	@ get stack location
0673cb38951215 Geert Uytterhoeven 2021-01-04  307  		add	sp, sp, r1	@ apply relocation
0673cb38951215 Geert Uytterhoeven 2021-01-04  308  
0673cb38951215 Geert Uytterhoeven 2021-01-04  309  		/* Validate calculated start against passed DTB */
0673cb38951215 Geert Uytterhoeven 2021-01-04  310  		mov	r1, r8
0673cb38951215 Geert Uytterhoeven 2021-01-04  311  		bl	fdt_check_mem_start
0673cb38951215 Geert Uytterhoeven 2021-01-04  312  1:
0673cb38951215 Geert Uytterhoeven 2021-01-04  313  #endif /* CONFIG_USE_OF */
0a6a78b8b3c1c1 Russell King       2015-03-26  314  		/* Determine final kernel image address. */
0673cb38951215 Geert Uytterhoeven 2021-01-04 @315  		add	r4, r0, #TEXT_OFFSET
e69edc7939abda Eric Miao          2010-07-05  316  #else
9e84ed63dc71e1 Russell King       2010-09-09  317  		ldr	r4, =zreladdr
e69edc7939abda Eric Miao          2010-07-05  318  #endif
^1da177e4c3f41 Linus Torvalds     2005-04-16  319  
2874865c1271cc Nicolas Pitre      2013-06-06  320  		/*
2874865c1271cc Nicolas Pitre      2013-06-06  321  		 * Set up a page table only if it won't overwrite ourself.
7d57909bf69f21 Masahiro Yamada    2015-01-20  322  		 * That means r4 < pc || r4 - 16k page directory > &_end.
2874865c1271cc Nicolas Pitre      2013-06-06  323  		 * Given that r4 > &_end is most unfrequent, we add a rough
2874865c1271cc Nicolas Pitre      2013-06-06  324  		 * additional 1MB of room for a possible appended DTB.
2874865c1271cc Nicolas Pitre      2013-06-06  325  		 */
2874865c1271cc Nicolas Pitre      2013-06-06  326  		mov	r0, pc
2874865c1271cc Nicolas Pitre      2013-06-06  327  		cmp	r0, r4
691cbe5ba5f77f Ard Biesheuvel     2020-04-13  328  		ldrcc	r0, .Lheadroom
2874865c1271cc Nicolas Pitre      2013-06-06  329  		addcc	r0, r0, pc
2874865c1271cc Nicolas Pitre      2013-06-06  330  		cmpcc	r4, r0
2874865c1271cc Nicolas Pitre      2013-06-06  331  		orrcc	r4, r4, #1		@ remember we skipped cache_on
2874865c1271cc Nicolas Pitre      2013-06-06  332  		blcs	cache_on
6d7d0ae5157494 Nicolas Pitre      2011-02-21  333  

:::::: The code at line 315 was first introduced by commit
:::::: 0673cb38951215060d7993b43ad3c45cd413c2c3 ARM: 9045/1: uncompress: Validate start of physical memory against passed DTB

:::::: TO: Geert Uytterhoeven <geert+renesas@glider.be>
:::::: CC: Russell King <rmk+kernel@armlinux.org.uk>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
