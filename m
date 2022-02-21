Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD974BD2F0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 01:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242657AbiBUAk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 19:40:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiBUAkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 19:40:24 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1D249693
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 16:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645404002; x=1676940002;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eS/AFJZJSPUEV+/29UtYDFjHNVl4pXXe7ObP2I7de64=;
  b=nlZfP7eZU/5fmhym5W7hbGPGga35V4Vg0x9cikBJ5h7X67xF2ZzooLXj
   I3czacczkTzAsyUH7k6zrjSuGa3PdrK9eAIjc1CcNFP2XsMGlnnBw1fX4
   v1SEGgcHmQfTb9Z4CIJ4R+Q2zbI5FFDrXrsOPEIdyAPbentCdCrKStgI7
   VcDkJUt5OvY3rFoo/FNhVpQ91TvJsQsS0/QYuhK61Z3hpB+uk1NQcJdS5
   oOSAjwhBkjnQdTQG4Y5uucoWCZGaB3uJO1IYzC8WdA4PSmR0UlwYLHioH
   LMRewgQfLWVZwLH+ZG/bjamkXqIJ6Seg6JHOArOu+o1oa0YeSQqd5ataF
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="337844884"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="337844884"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 16:40:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="504714216"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 20 Feb 2022 16:40:00 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLwkB-00015X-WD; Mon, 21 Feb 2022 00:39:59 +0000
Date:   Mon, 21 Feb 2022 08:39:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1479/2574]
 arch/powerpc/include/asm/book3s/64/hash.h:244:22: error: expected '=', ',',
 ';', 'asm' or '__attribute__' before 'hash__vmemmap_create_mapping'
Message-ID: <202202210850.xjJMDz2l-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   39e8a0edc8fae20758051dadf7846849edc18b88
commit: f840383878181d9f7f49fd96536a579548b7b101 [1479/2574] headers/deps: printk: Reduce <linux/printk.h> header dependencies
config: powerpc64-randconfig-r015-20220220 (https://download.01.org/0day-ci/archive/20220221/202202210850.xjJMDz2l-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=f840383878181d9f7f49fd96536a579548b7b101
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout f840383878181d9f7f49fd96536a579548b7b101
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/include/asm/book3s/64/pgtable.h:299,
                    from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20,
                    from arch/powerpc/include/asm/book3s/64/mmu.h:39,
                    from arch/powerpc/include/asm/mmu.h:405,
                    from arch/powerpc/include/asm/lppaca.h:46,
                    from arch/powerpc/include/asm/paca.h:17,
                    from arch/powerpc/include/asm/current.h:13,
                    from include/linux/preempt.h:10,
                    from arch/powerpc/kernel/asm-offsets.c:12:
>> arch/powerpc/include/asm/book3s/64/hash.h:244:22: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'hash__vmemmap_create_mapping'
     244 | extern int __meminit hash__vmemmap_create_mapping(unsigned long start,
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/powerpc/include/asm/book3s/64/pgtable.h:300,
                    from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20,
                    from arch/powerpc/include/asm/book3s/64/mmu.h:39,
                    from arch/powerpc/include/asm/mmu.h:405,
                    from arch/powerpc/include/asm/lppaca.h:46,
                    from arch/powerpc/include/asm/paca.h:17,
                    from arch/powerpc/include/asm/current.h:13,
                    from include/linux/preempt.h:10,
                    from arch/powerpc/kernel/asm-offsets.c:12:
>> arch/powerpc/include/asm/book3s/64/radix.h:289:22: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'radix__vmemmap_create_mapping'
     289 | extern int __meminit radix__vmemmap_create_mapping(unsigned long start,
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20,
                    from arch/powerpc/include/asm/book3s/64/mmu.h:39,
                    from arch/powerpc/include/asm/mmu.h:405,
                    from arch/powerpc/include/asm/lppaca.h:46,
                    from arch/powerpc/include/asm/paca.h:17,
                    from arch/powerpc/include/asm/current.h:13,
                    from include/linux/preempt.h:10,
                    from arch/powerpc/kernel/asm-offsets.c:12:
>> arch/powerpc/include/asm/book3s/64/pgtable.h:1085:29: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'vmemmap_create_mapping'
    1085 | static inline int __meminit vmemmap_create_mapping(unsigned long start,
         |                             ^~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/powerpc/include/asm/mmu.h:405,
                    from arch/powerpc/include/asm/lppaca.h:46,
                    from arch/powerpc/include/asm/paca.h:17,
                    from arch/powerpc/include/asm/current.h:13,
                    from include/linux/preempt.h:10,
                    from arch/powerpc/kernel/asm-offsets.c:12:
>> arch/powerpc/include/asm/book3s/64/mmu.h:231:27: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'early_init_mmu'
     231 | static inline void __init early_init_mmu(void)
         |                           ^~~~~~~~~~~~~~
>> arch/powerpc/include/asm/book3s/64/mmu.h:262:13: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'radix_init_pseries'
     262 | void __init radix_init_pseries(void);
         |             ^~~~~~~~~~~~~~~~~~
   In file included from arch/powerpc/include/asm/paca.h:30,
                    from arch/powerpc/include/asm/current.h:13,
                    from include/linux/preempt.h:10,
                    from arch/powerpc/kernel/asm-offsets.c:12:
>> arch/powerpc/include/asm/cpuidle.h:88:12: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'validate_psscr_val_mask'
      88 | int __init validate_psscr_val_mask(u64 *psscr_val, u64 *psscr_mask, u32 flags);
         |            ^~~~~~~~~~~~~~~~~~~~~~~
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
   make[1]: *** [Makefile:1191: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +244 arch/powerpc/include/asm/book3s/64/hash.h

c605782b1c3f1c arch/powerpc/include/asm/pte-hash64.h     Benjamin Herrenschmidt 2009-03-10  241  
31a14fae92b29b arch/powerpc/include/asm/book3s/64/hash.h Aneesh Kumar K.V       2016-04-29  242  
c766ee72235d09 arch/powerpc/include/asm/book3s/64/hash.h Christophe Leroy       2018-10-09  243  int hash__map_kernel_page(unsigned long ea, unsigned long pa, pgprot_t prot);
31a14fae92b29b arch/powerpc/include/asm/book3s/64/hash.h Aneesh Kumar K.V       2016-04-29 @244  extern int __meminit hash__vmemmap_create_mapping(unsigned long start,
31a14fae92b29b arch/powerpc/include/asm/book3s/64/hash.h Aneesh Kumar K.V       2016-04-29  245  					      unsigned long page_size,
31a14fae92b29b arch/powerpc/include/asm/book3s/64/hash.h Aneesh Kumar K.V       2016-04-29  246  					      unsigned long phys);
31a14fae92b29b arch/powerpc/include/asm/book3s/64/hash.h Aneesh Kumar K.V       2016-04-29  247  extern void hash__vmemmap_remove_mapping(unsigned long start,
31a14fae92b29b arch/powerpc/include/asm/book3s/64/hash.h Aneesh Kumar K.V       2016-04-29  248  				     unsigned long page_size);
32b53c012e0bfe arch/powerpc/include/asm/book3s/64/hash.h Reza Arbab             2017-01-03  249  

:::::: The code at line 244 was first introduced by commit
:::::: 31a14fae92b29b7a7fcc65600f072bf448d3b0eb powerpc/mm: Abstraction for vmemmap and map_kernel_page()

:::::: TO: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
