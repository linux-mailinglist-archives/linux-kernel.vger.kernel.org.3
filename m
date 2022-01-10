Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26014489ADF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbiAJNzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:55:04 -0500
Received: from mga03.intel.com ([134.134.136.65]:34264 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbiAJNzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:55:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641822901; x=1673358901;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2Zp7VMePQmtzmmh0s8Eo1QaSbTDDrEWbBROEmgXFs2I=;
  b=jlSeRhnvIEKrTDD3bEb0rLES/FRCwl4TXUZKyHxmAmSVUbWfSxhc/Hr/
   /CijFpmow8ogOi+h1fCHBBXNRYtGzx+aB1v48l4ZwxZehKERm6YYp/02F
   PWXup1N2L8JLUL49NicGlbb5RSZFli1ktxzzK5wbkU+9WXFDyp4Uf7nX7
   mZeSqFekGcCwtNE6+V1HtDnsVkfBKPjZsKMZHGccqYHEUa1uFVkphHVap
   VCXJi9xYsGehe0Y2y+Q//6ADwso04sOIIhAdfo38NrhFkvDT0Vri3eTtN
   BOEDETxukhP4H5F/j0bPpyGUf2zdvj/PncYdMfQhzCx5fCBAZRP/RW5il
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="243179109"
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="243179109"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 05:55:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="622679026"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 10 Jan 2022 05:54:59 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6v8U-0003Ze-KA; Mon, 10 Jan 2022 13:54:58 +0000
Date:   Mon, 10 Jan 2022 21:54:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1518/2380]
 arch/powerpc/include/asm/book3s/64/hash.h:248:22: error: expected '=', ',',
 ';', 'asm' or '__attribute__' before 'hash__vmemmap_create_mapping'
Message-ID: <202201102123.ZtrMza46-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   351bfbf7f1e8dce84b605c8007c98dd603c4ca4d
commit: 2df1932116ea94f774804fbd4fcfc0eb60704764 [1518/2380] headers/deps: printk: Reduce <linux/printk.h> header dependencies
config: powerpc64-randconfig-r001-20220109 (https://download.01.org/0day-ci/archive/20220110/202201102123.ZtrMza46-lkp@intel.com/config)
compiler: powerpc64le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=2df1932116ea94f774804fbd4fcfc0eb60704764
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 2df1932116ea94f774804fbd4fcfc0eb60704764
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/include/asm/lppaca.h:46,
                    from arch/powerpc/include/asm/paca.h:17,
                    from arch/powerpc/include/asm/current.h:13,
                    from include/linux/preempt.h:10,
                    from arch/powerpc/kernel/asm-offsets.c:12:
   arch/powerpc/include/asm/mmu.h: In function 'strict_kernel_rwx_enabled':
   arch/powerpc/include/asm/mmu.h:340:16: error: 'rodata_enabled' undeclared (first use in this function); did you mean 'radix_enabled'?
     340 |         return rodata_enabled;
         |                ^~~~~~~~~~~~~~
         |                radix_enabled
   arch/powerpc/include/asm/mmu.h:340:16: note: each undeclared identifier is reported only once for each function it appears in
   In file included from arch/powerpc/include/asm/book3s/64/pgtable.h:299,
                    from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20,
                    from arch/powerpc/include/asm/book3s/64/mmu.h:33,
                    from arch/powerpc/include/asm/mmu.h:395,
                    from arch/powerpc/include/asm/lppaca.h:46,
                    from arch/powerpc/include/asm/paca.h:17,
                    from arch/powerpc/include/asm/current.h:13,
                    from include/linux/preempt.h:10,
                    from arch/powerpc/kernel/asm-offsets.c:12:
   arch/powerpc/include/asm/book3s/64/hash.h: At top level:
>> arch/powerpc/include/asm/book3s/64/hash.h:248:22: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'hash__vmemmap_create_mapping'
     248 | extern int __meminit hash__vmemmap_create_mapping(unsigned long start,
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/powerpc/include/asm/book3s/64/pgtable.h:300,
                    from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20,
                    from arch/powerpc/include/asm/book3s/64/mmu.h:33,
                    from arch/powerpc/include/asm/mmu.h:395,
                    from arch/powerpc/include/asm/lppaca.h:46,
                    from arch/powerpc/include/asm/paca.h:17,
                    from arch/powerpc/include/asm/current.h:13,
                    from include/linux/preempt.h:10,
                    from arch/powerpc/kernel/asm-offsets.c:12:
>> arch/powerpc/include/asm/book3s/64/radix.h:289:22: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'radix__vmemmap_create_mapping'
     289 | extern int __meminit radix__vmemmap_create_mapping(unsigned long start,
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20,
                    from arch/powerpc/include/asm/book3s/64/mmu.h:33,
                    from arch/powerpc/include/asm/mmu.h:395,
                    from arch/powerpc/include/asm/lppaca.h:46,
                    from arch/powerpc/include/asm/paca.h:17,
                    from arch/powerpc/include/asm/current.h:13,
                    from include/linux/preempt.h:10,
                    from arch/powerpc/kernel/asm-offsets.c:12:
>> arch/powerpc/include/asm/book3s/64/pgtable.h:1085:29: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'vmemmap_create_mapping'
    1085 | static inline int __meminit vmemmap_create_mapping(unsigned long start,
         |                             ^~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/powerpc/include/asm/mmu.h:395,
                    from arch/powerpc/include/asm/lppaca.h:46,
                    from arch/powerpc/include/asm/paca.h:17,
                    from arch/powerpc/include/asm/current.h:13,
                    from include/linux/preempt.h:10,
                    from arch/powerpc/kernel/asm-offsets.c:12:
>> arch/powerpc/include/asm/book3s/64/mmu.h:212:27: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'early_init_mmu'
     212 | static inline void __init early_init_mmu(void)
         |                           ^~~~~~~~~~~~~~
   In file included from include/linux/sched.h:12,
                    from include/linux/sched/thread_info_api.h:5,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/powerpc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from arch/powerpc/kernel/asm-offsets.c:12:
   include/linux/sched/per_task.h:48:11: fatal error: generated/asm-offsets.h: No such file or directory
      48 | # include <generated/asm-offsets.h>
         |           ^~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
   make[2]: *** [scripts/Makefile.build:121: arch/powerpc/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1197: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +248 arch/powerpc/include/asm/book3s/64/hash.h

c605782b1c3f1c arch/powerpc/include/asm/pte-hash64.h     Benjamin Herrenschmidt 2009-03-10  245  
31a14fae92b29b arch/powerpc/include/asm/book3s/64/hash.h Aneesh Kumar K.V       2016-04-29  246  
c766ee72235d09 arch/powerpc/include/asm/book3s/64/hash.h Christophe Leroy       2018-10-09  247  int hash__map_kernel_page(unsigned long ea, unsigned long pa, pgprot_t prot);
31a14fae92b29b arch/powerpc/include/asm/book3s/64/hash.h Aneesh Kumar K.V       2016-04-29 @248  extern int __meminit hash__vmemmap_create_mapping(unsigned long start,
31a14fae92b29b arch/powerpc/include/asm/book3s/64/hash.h Aneesh Kumar K.V       2016-04-29  249  					      unsigned long page_size,
31a14fae92b29b arch/powerpc/include/asm/book3s/64/hash.h Aneesh Kumar K.V       2016-04-29  250  					      unsigned long phys);
31a14fae92b29b arch/powerpc/include/asm/book3s/64/hash.h Aneesh Kumar K.V       2016-04-29  251  extern void hash__vmemmap_remove_mapping(unsigned long start,
31a14fae92b29b arch/powerpc/include/asm/book3s/64/hash.h Aneesh Kumar K.V       2016-04-29  252  				     unsigned long page_size);
32b53c012e0bfe arch/powerpc/include/asm/book3s/64/hash.h Reza Arbab             2017-01-03  253  

:::::: The code at line 248 was first introduced by commit
:::::: 31a14fae92b29b7a7fcc65600f072bf448d3b0eb powerpc/mm: Abstraction for vmemmap and map_kernel_page()

:::::: TO: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
