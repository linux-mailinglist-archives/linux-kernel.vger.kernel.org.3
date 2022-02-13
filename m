Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD6E4B3AB5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 11:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbiBMJ7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 04:59:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiBMJ7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 04:59:31 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8B75C875
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 01:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644746366; x=1676282366;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=X9ASimI59B63ZIuoPajuiaBbYrNgYqeyS/rNDV+VtuE=;
  b=jRi6LvE6T0tJi5XiEC+gxFZSdjMHrtYIUh51WkundP6jgsgqO1gLGPyU
   vWGhwC2zspvVfq9zre95aj6LW6AinjAwtDnPZ7tsYGPm9MlUYxmUWKs6X
   XjwiJbIfVLw8oLTPd+rvDrSMWZ7ESOz+ijmZext/qPJpqjom7P4H5bUeK
   A7oSk5++UVA7w9VBGn7W2VM8TnLLdB7YeXfb805wArMSP+6UhjpjuvAQg
   srgWYjR2iCCK2dZrjOE18IzVZaNPFm5po33Q0Tl3oGiJepJz5CAyBm1Sa
   ZJDU4a+tR3IKWIna6MrVL3QDJJUDiVik5UUcszrYzcs1GACpFceWkG4nr
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10256"; a="237345983"
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="237345983"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 01:59:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="493672944"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 13 Feb 2022 01:59:24 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJBf9-0007LT-Ke; Sun, 13 Feb 2022 09:59:23 +0000
Date:   Sun, 13 Feb 2022 17:59:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Helge Deller <deller@gmx.de>
Subject: include/linux/smp.h:34:33: error: requested alignment '20' is not a
 positive power of 2
Message-ID: <202202131741.c6BPpfzd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b81b1829e7e39f6cebdf6e4d5484eacbceda8554
commit: 5f6e0fe01b6b33894cf6f61b359ab5a6d2b7674e parisc: Fix compile failure when building 64-bit kernel natively
date:   6 months ago
config: parisc-randconfig-r004-20220213 (https://download.01.org/0day-ci/archive/20220213/202202131741.c6BPpfzd-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5f6e0fe01b6b33894cf6f61b359ab5a6d2b7674e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5f6e0fe01b6b33894cf6f61b359ab5a6d2b7674e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from arch/parisc/include/asm/bitops.h:203,
                    from include/linux/bitops.h:32,
                    from include/linux/kernel.h:12,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/asm-generic/bitops/__fls.h: In function '__fls':
>> include/asm-generic/bitops/__fls.h:18:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      18 |         if (!(word & (~0ul << 32))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:20:22: warning: left shift count >= width of type [-Wshift-count-overflow]
      20 |                 word <<= 32;
         |                      ^~~
   include/asm-generic/bitops/__fls.h:23:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      23 |         if (!(word & (~0ul << (BITS_PER_LONG-16)))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:27:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      27 |         if (!(word & (~0ul << (BITS_PER_LONG-8)))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:31:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      31 |         if (!(word & (~0ul << (BITS_PER_LONG-4)))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:35:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         if (!(word & (~0ul << (BITS_PER_LONG-2)))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:39:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      39 |         if (!(word & (~0ul << (BITS_PER_LONG-1))))
         |                            ^~
   In file included from arch/parisc/include/asm/bitops.h:203,
                    from include/linux/bitops.h:32,
                    from include/linux/kernel.h:12,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:5,
                    from ./arch/parisc/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from arch/parisc/kernel/asm-offsets.c:18:
   include/asm-generic/bitops/__fls.h: In function '__fls':
>> include/asm-generic/bitops/__fls.h:18:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      18 |         if (!(word & (~0ul << 32))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:20:22: warning: left shift count >= width of type [-Wshift-count-overflow]
      20 |                 word <<= 32;
         |                      ^~~
   include/asm-generic/bitops/__fls.h:23:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      23 |         if (!(word & (~0ul << (BITS_PER_LONG-16)))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:27:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      27 |         if (!(word & (~0ul << (BITS_PER_LONG-8)))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:31:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      31 |         if (!(word & (~0ul << (BITS_PER_LONG-4)))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:35:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         if (!(word & (~0ul << (BITS_PER_LONG-2)))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:39:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      39 |         if (!(word & (~0ul << (BITS_PER_LONG-1))))
         |                            ^~
   In file included from arch/parisc/include/asm/processor.h:17,
                    from arch/parisc/include/asm/thread_info.h:8,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/current.h:5,
                    from ./arch/parisc/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from arch/parisc/kernel/asm-offsets.c:18:
   arch/parisc/include/asm/pdc.h: At top level:
>> arch/parisc/include/asm/pdc.h:75:24: warning: 'struct pdc_memory_table' declared inside parameter list will not be visible outside of this definition or declaration
      75 |                 struct pdc_memory_table *tbl, unsigned long entries);
         |                        ^~~~~~~~~~~~~~~~
>> arch/parisc/include/asm/pdc.h:74:30: warning: 'struct pdc_memory_table_raddr' declared inside parameter list will not be visible outside of this definition or declaration
      74 | int pdc_mem_mem_table(struct pdc_memory_table_raddr *r_addr,
         |                              ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/compiler_types.h:65,
                    from <command-line>:
>> include/linux/smp.h:34:33: error: requested alignment '20' is not a positive power of 2
      34 |         __aligned(sizeof(struct __call_single_data));
         |                                 ^~~~~~~~~~~~~~~~~~
   include/linux/compiler_attributes.h:53:68: note: in definition of macro '__aligned'
      53 | #define __aligned(x)                    __attribute__((__aligned__(x)))
         |                                                                    ^
   In file included from include/linux/mm.h:33,
                    from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/parisc/kernel/asm-offsets.c:20:
   include/linux/pgtable.h: In function 'pud_index':
>> include/linux/pgtable.h:77:25: warning: right shift count >= width of type [-Wshift-count-overflow]
      77 |         return (address >> PUD_SHIFT) & (PTRS_PER_PUD - 1);
         |                         ^~
   include/linux/pgtable.h: In function 'pgd_offset_pgd':
   include/linux/pgtable.h:84:29: warning: right shift count >= width of type [-Wshift-count-overflow]
      84 | #define pgd_index(a)  (((a) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
         |                             ^~
   include/linux/pgtable.h:124:23: note: in expansion of macro 'pgd_index'
     124 |         return (pgd + pgd_index(address));
         |                       ^~~~~~~~~
   In file included from include/linux/stringhash.h:7,
                    from include/linux/dcache.h:15,
                    from include/linux/fs.h:8,
                    from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:728,
                    from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/parisc/kernel/asm-offsets.c:20:
   include/linux/hash.h: In function 'hash32_ptr':
>> include/linux/hash.h:99:21: warning: right shift count >= width of type [-Wshift-count-overflow]
      99 |         val ^= (val >> 32);
         |                     ^~
   In file included from arch/parisc/kernel/asm-offsets.c:22:
   arch/parisc/kernel/asm-offsets.c: In function 'main':
>> arch/parisc/kernel/asm-offsets.c:271:43: warning: right shift count >= width of type [-Wshift-count-overflow]
     271 |         DEFINE(ASM_PGD_ENTRY, PAGE_OFFSET >> PGDIR_SHIFT);
         |                                           ^~
   include/linux/kbuild.h:6:69: note: in definition of macro 'DEFINE'
       6 |         asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                                     ^~~
   make[2]: *** [scripts/Makefile.build:117: arch/parisc/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1217: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:220: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/20 +34 include/linux/smp.h

3d4422332711ef Jens Axboe     2008-06-26  28  
545b8c8df41f9e Peter Zijlstra 2020-06-15  29  #define CSD_INIT(_func, _info) \
545b8c8df41f9e Peter Zijlstra 2020-06-15  30  	(struct __call_single_data){ .func = (_func), .info = (_info), }
545b8c8df41f9e Peter Zijlstra 2020-06-15  31  
966a967116e699 Ying Huang     2017-08-08  32  /* Use __aligned() to avoid to use 2 cache lines for 1 csd */
966a967116e699 Ying Huang     2017-08-08  33  typedef struct __call_single_data call_single_data_t
966a967116e699 Ying Huang     2017-08-08 @34  	__aligned(sizeof(struct __call_single_data));
966a967116e699 Ying Huang     2017-08-08  35  

:::::: The code at line 34 was first introduced by commit
:::::: 966a967116e699762dbf4af7f9e0d1955c25aa37 smp: Avoid using two cache lines for struct call_single_data

:::::: TO: Ying Huang <ying.huang@intel.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
