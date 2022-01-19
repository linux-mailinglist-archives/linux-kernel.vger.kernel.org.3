Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6614C493557
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 08:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351974AbiASHV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 02:21:29 -0500
Received: from mga06.intel.com ([134.134.136.31]:21834 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351894AbiASHVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 02:21:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642576883; x=1674112883;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=y1rQ1FmY4I3fJ1fLWSODaytYGfap72pHgteTsYdUP2c=;
  b=FIkaJbRzB6a0Jk/+IPbcU/pf4styU1gKTPyKruCQbfE5yzsMITj50XQ6
   sMSLg84MNq1EWrmT8uSjwU/1p2CwiZfm6a3I6VxRu/5ZPLTEmHOvx3MgA
   yVL3gbBBlyUkrKGjmoZgR7MEwmet5H0in+vyyGpqd8r224nmfRVtuocCy
   KhEpTcL+jRI2XQyI06sjkmFcWRLghF8emGBY9ovPvTJl/ppYP4sANTIPu
   GrYqGJs7Soi2Dq9xHlDwCBLwMUYQBZpnEZ8pTadOzzm/JYQLqF2M1NSOb
   JkWkoD2g50TU/3glqKeBLXmQ77TTapZMtNL7Tl3GVRnp5fNZfYueO/4Fk
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="305734938"
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="305734938"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 23:21:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="615615338"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Jan 2022 23:21:21 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nA5HV-000DMb-3B; Wed, 19 Jan 2022 07:21:21 +0000
Date:   Wed, 19 Jan 2022 15:20:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>
Subject: arch/mips/ralink/mt7621.c:123:22: warning: '__builtin_memcmp'
 reading between 1 and 4 bytes from a region of size 0
Message-ID: <202201191557.OISJHNMi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   99613159ad749543621da8238acf1a122880144e
commit: 139c949f7f0ac0dd1c0da132675be80e6d76c65d MIPS: ralink: mt7621: add memory detection support
date:   10 months ago
config: mips-randconfig-r036-20220119 (https://download.01.org/0day-ci/archive/20220119/202201191557.OISJHNMi-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=139c949f7f0ac0dd1c0da132675be80e6d76c65d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 139c949f7f0ac0dd1c0da132675be80e6d76c65d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/ralink/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:10,
                    from arch/mips/ralink/mt7621.c:8:
   arch/mips/ralink/mt7621.c: In function 'mt7621_memory_detect':
>> arch/mips/ralink/mt7621.c:123:22: warning: '__builtin_memcmp' reading between 1 and 4 bytes from a region of size 0 [-Wstringop-overread]
     123 |                 if (!__builtin_memcmp(dm, dm + size, sizeof(detect_magic)))
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   arch/mips/ralink/mt7621.c:123:17: note: in expansion of macro 'if'
     123 |                 if (!__builtin_memcmp(dm, dm + size, sizeof(detect_magic)))
         |                 ^~
   arch/mips/ralink/mt7621.c:54:14: note: at offset 33554432 into source object 'detect_magic' of size 4
      54 | static void *detect_magic __initdata = detect_memory_region;
         |              ^~~~~~~~~~~~
   In file included from include/linux/kernel.h:10,
                    from arch/mips/ralink/mt7621.c:8:
   arch/mips/ralink/mt7621.c:129:13: warning: '__builtin_memcmp' reading between 1 and 4 bytes from a region of size 0 [-Wstringop-overread]
     129 |             __builtin_memcmp(dm, dm + size, sizeof(detect_magic))) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:69:10: note: in definition of macro '__trace_if_value'
      69 |         (cond) ?                                        \
         |          ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   arch/mips/ralink/mt7621.c:127:9: note: in expansion of macro 'if'
     127 |         if ((size == 256 * SZ_1M) &&
         |         ^~
   arch/mips/ralink/mt7621.c:54:14: note: at offset 268435456 into source object 'detect_magic' of size 4
      54 | static void *detect_magic __initdata = detect_memory_region;
         |              ^~~~~~~~~~~~
   {standard input}: Assembler messages:
   {standard input}:127: Error: found '(', expected: ')'
   {standard input}:127: Error: found '(', expected: ')'
   {standard input}:127: Error: non-constant expression in ".if" statement
   {standard input}:127: Error: junk at end of line, first unrecognized character is `('
   {standard input}:154: Error: found '(', expected: ')'
   {standard input}:154: Error: found '(', expected: ')'
   {standard input}:154: Error: non-constant expression in ".if" statement
   {standard input}:154: Error: junk at end of line, first unrecognized character is `('


vim +/__builtin_memcmp +123 arch/mips/ralink/mt7621.c

   116	
   117	static void __init mt7621_memory_detect(void)
   118	{
   119		void *dm = &detect_magic;
   120		phys_addr_t size;
   121	
   122		for (size = 32 * SZ_1M; size < 256 * SZ_1M; size <<= 1) {
 > 123			if (!__builtin_memcmp(dm, dm + size, sizeof(detect_magic)))
   124				break;
   125		}
   126	
   127		if ((size == 256 * SZ_1M) &&
   128		    (CPHYSADDR(dm + size) < MT7621_LOWMEM_MAX_SIZE) &&
   129		    __builtin_memcmp(dm, dm + size, sizeof(detect_magic))) {
   130			memblock_add(MT7621_LOWMEM_BASE, MT7621_LOWMEM_MAX_SIZE);
   131			memblock_add(MT7621_HIGHMEM_BASE, MT7621_HIGHMEM_SIZE);
   132		} else {
   133			memblock_add(MT7621_LOWMEM_BASE, size);
   134		}
   135	}
   136	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
