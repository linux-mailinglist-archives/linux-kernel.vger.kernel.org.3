Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDF358A278
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 22:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbiHDUrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 16:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiHDUrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 16:47:40 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6799B6D9F6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 13:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659646058; x=1691182058;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Yqn3Nnq4E2hLzUIj4+j0vVIiwVNuVzq9wUJVnH2WCBM=;
  b=cdD8auTrOBE7Rtlu0KBUOzTDIEBmK/dPFLLP7V9VMpErVVyRi6igJXy0
   VgUqP1jLKomfr9uogoB/aNx6TSUzuu5q8AepT/2jCDj2bbgJeyxxTgh0D
   sn9RpdjllEo6Bcp7b0rpVBm+YthvJfHcpWTVcIF1ptEt7+pGAteUv/B5w
   WyE9jivYn7N0dgcKpE3QHA7m4MveSqNRkYnV/WbJRQnp0QVFqchVddNdl
   9KuWRnZwEQbbA3h0rzsJ5FAaw9vmGIs8JVni86hLGc4zbwzUGCGZH4syW
   y5wC9siOlzGo78pnht1Eb+YLJMfwfPw/vHdEmzjAPDTYwIWs/uF7iwCzN
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="290818340"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="290818340"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 13:47:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="579225641"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 04 Aug 2022 13:47:35 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJhkk-000IqR-2a;
        Thu, 04 Aug 2022 20:47:34 +0000
Date:   Fri, 5 Aug 2022 04:47:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Samuel Holland <samuel@sholland.org>,
        Guo Ren <guoren@kernel.org>
Subject: [ammarfaizi2-block:palmer/linux/riscv-zicbom 6/6]
 arch/riscv/include/asm/errata_list.h:128:9: error: expected ':' or ')'
 before '__nops'
Message-ID: <202208050445.jnUp8dLc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/riscv-zicbom
head:   d20ec7529236a2fcdb2d856fc0bd80b409a217fc
commit: d20ec7529236a2fcdb2d856fc0bd80b409a217fc [6/6] riscv: implement cache-management errata for T-Head SoCs
config: riscv-randconfig-r035-20220804 (https://download.01.org/0day-ci/archive/20220805/202208050445.jnUp8dLc-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/d20ec7529236a2fcdb2d856fc0bd80b409a217fc
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/riscv-zicbom
        git checkout d20ec7529236a2fcdb2d856fc0bd80b409a217fc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/mm/ kernel/dma/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/riscv/include/asm/alternative.h:11,
                    from arch/riscv/include/asm/errata_list.h:8,
                    from arch/riscv/include/asm/tlbflush.h:12,
                    from arch/riscv/include/asm/pgtable.h:108,
                    from arch/riscv/include/asm/uaccess.h:12,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/compat.h:17,
                    from arch/riscv/include/asm/elf.h:12,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:19,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/dma-mapping.h:7,
                    from include/linux/dma-direct.h:9,
                    from arch/riscv/mm/dma-noncoherent.c:8:
   arch/riscv/mm/dma-noncoherent.c: In function 'arch_sync_dma_for_device':
>> arch/riscv/include/asm/errata_list.h:128:9: error: expected ':' or ')' before '__nops'
     128 |         __nops(6),                                                      \
         |         ^~~~~~
   arch/riscv/include/asm/alternative-macros.h:123:9: note: in definition of macro '__ALTERNATIVE_CFG_2'
     123 |         old_c "\n"                                                      \
         |         ^~~~~
   arch/riscv/include/asm/alternative-macros.h:200:9: note: in expansion of macro '_ALTERNATIVE_CFG_2'
     200 |         _ALTERNATIVE_CFG_2(old_content, new_content_1, vendor_id_1,     \
         |         ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/errata_list.h:127:14: note: in expansion of macro 'ALTERNATIVE_2'
     127 | asm volatile(ALTERNATIVE_2(                                             \
         |              ^~~~~~~~~~~~~
   arch/riscv/mm/dma-noncoherent.c:25:17: note: in expansion of macro 'ALT_CMO_OP'
      25 |                 ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
         |                 ^~~~~~~~~~
>> arch/riscv/include/asm/errata_list.h:128:9: error: expected ':' or ')' before '__nops'
     128 |         __nops(6),                                                      \
         |         ^~~~~~
   arch/riscv/include/asm/alternative-macros.h:123:9: note: in definition of macro '__ALTERNATIVE_CFG_2'
     123 |         old_c "\n"                                                      \
         |         ^~~~~
   arch/riscv/include/asm/alternative-macros.h:200:9: note: in expansion of macro '_ALTERNATIVE_CFG_2'
     200 |         _ALTERNATIVE_CFG_2(old_content, new_content_1, vendor_id_1,     \
         |         ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/errata_list.h:127:14: note: in expansion of macro 'ALTERNATIVE_2'
     127 | asm volatile(ALTERNATIVE_2(                                             \
         |              ^~~~~~~~~~~~~
   arch/riscv/mm/dma-noncoherent.c:28:17: note: in expansion of macro 'ALT_CMO_OP'
      28 |                 ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
         |                 ^~~~~~~~~~
>> arch/riscv/include/asm/errata_list.h:128:9: error: expected ':' or ')' before '__nops'
     128 |         __nops(6),                                                      \
         |         ^~~~~~
   arch/riscv/include/asm/alternative-macros.h:123:9: note: in definition of macro '__ALTERNATIVE_CFG_2'
     123 |         old_c "\n"                                                      \
         |         ^~~~~
   arch/riscv/include/asm/alternative-macros.h:200:9: note: in expansion of macro '_ALTERNATIVE_CFG_2'
     200 |         _ALTERNATIVE_CFG_2(old_content, new_content_1, vendor_id_1,     \
         |         ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/errata_list.h:127:14: note: in expansion of macro 'ALTERNATIVE_2'
     127 | asm volatile(ALTERNATIVE_2(                                             \
         |              ^~~~~~~~~~~~~
   arch/riscv/mm/dma-noncoherent.c:31:17: note: in expansion of macro 'ALT_CMO_OP'
      31 |                 ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
         |                 ^~~~~~~~~~
   arch/riscv/mm/dma-noncoherent.c:21:15: warning: unused variable 'vaddr' [-Wunused-variable]
      21 |         void *vaddr = phys_to_virt(paddr);
         |               ^~~~~
   arch/riscv/mm/dma-noncoherent.c: In function 'arch_sync_dma_for_cpu':
>> arch/riscv/include/asm/errata_list.h:128:9: error: expected ':' or ')' before '__nops'
     128 |         __nops(6),                                                      \
         |         ^~~~~~
   arch/riscv/include/asm/alternative-macros.h:123:9: note: in definition of macro '__ALTERNATIVE_CFG_2'
     123 |         old_c "\n"                                                      \
         |         ^~~~~
   arch/riscv/include/asm/alternative-macros.h:200:9: note: in expansion of macro '_ALTERNATIVE_CFG_2'
     200 |         _ALTERNATIVE_CFG_2(old_content, new_content_1, vendor_id_1,     \
         |         ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/errata_list.h:127:14: note: in expansion of macro 'ALTERNATIVE_2'
     127 | asm volatile(ALTERNATIVE_2(                                             \
         |              ^~~~~~~~~~~~~
   arch/riscv/mm/dma-noncoherent.c:48:17: note: in expansion of macro 'ALT_CMO_OP'
      48 |                 ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
         |                 ^~~~~~~~~~
   arch/riscv/mm/dma-noncoherent.c:41:15: warning: unused variable 'vaddr' [-Wunused-variable]
      41 |         void *vaddr = phys_to_virt(paddr);
         |               ^~~~~
   arch/riscv/mm/dma-noncoherent.c: In function 'arch_dma_prep_coherent':
>> arch/riscv/include/asm/errata_list.h:128:9: error: expected ':' or ')' before '__nops'
     128 |         __nops(6),                                                      \
         |         ^~~~~~
   arch/riscv/include/asm/alternative-macros.h:123:9: note: in definition of macro '__ALTERNATIVE_CFG_2'
     123 |         old_c "\n"                                                      \
         |         ^~~~~
   arch/riscv/include/asm/alternative-macros.h:200:9: note: in expansion of macro '_ALTERNATIVE_CFG_2'
     200 |         _ALTERNATIVE_CFG_2(old_content, new_content_1, vendor_id_1,     \
         |         ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/errata_list.h:127:14: note: in expansion of macro 'ALTERNATIVE_2'
     127 | asm volatile(ALTERNATIVE_2(                                             \
         |              ^~~~~~~~~~~~~
   arch/riscv/mm/dma-noncoherent.c:59:9: note: in expansion of macro 'ALT_CMO_OP'
      59 |         ALT_CMO_OP(flush, flush_addr, size, riscv_cbom_block_size);
         |         ^~~~~~~~~~
   arch/riscv/mm/dma-noncoherent.c:57:15: warning: unused variable 'flush_addr' [-Wunused-variable]
      57 |         void *flush_addr = page_address(page);
         |               ^~~~~~~~~~
--
   kernel/dma/pool.c: In function 'atomic_pool_expand':
>> kernel/dma/pool.c:105:44: error: implicit declaration of function 'pgprot_dmacoherent' [-Werror=implicit-function-declaration]
     105 |                                            pgprot_dmacoherent(PAGE_KERNEL),
         |                                            ^~~~~~~~~~~~~~~~~~
>> kernel/dma/pool.c:105:44: error: incompatible type for argument 3 of 'dma_common_contiguous_remap'
     105 |                                            pgprot_dmacoherent(PAGE_KERNEL),
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                            |
         |                                            int
   In file included from kernel/dma/pool.c:8:
   include/linux/dma-map-ops.h:235:76: note: expected 'pgprot_t' but argument is of type 'int'
     235 | void *dma_common_contiguous_remap(struct page *page, size_t size, pgprot_t prot,
         |                                                                   ~~~~~~~~~^~~~
   cc1: some warnings being treated as errors


vim +128 arch/riscv/include/asm/errata_list.h

   125	
   126	#define ALT_CMO_OP(_op, _start, _size, _cachesize)			\
   127	asm volatile(ALTERNATIVE_2(						\
 > 128		__nops(6),							\
   129		"mv a0, %1\n\t"							\
   130		"j 2f\n\t"							\
   131		"3:\n\t"							\
   132		"cbo." __stringify(_op) " (a0)\n\t"				\
   133		"add a0, a0, %0\n\t"						\
   134		"2:\n\t"							\
   135		"bltu a0, %2, 3b\n\t"						\
   136		"nop", 0, CPUFEATURE_ZICBOM, CONFIG_RISCV_ISA_ZICBOM,		\
   137		"mv a0, %1\n\t"							\
   138		"j 2f\n\t"							\
   139		"3:\n\t"							\
   140		THEAD_##_op##_A0 "\n\t"						\
   141		"add a0, a0, %0\n\t"						\
   142		"2:\n\t"							\
   143		"bltu a0, %2, 3b\n\t"						\
   144		THEAD_SYNC_S, THEAD_VENDOR_ID,					\
   145				ERRATA_THEAD_CMO, CONFIG_ERRATA_THEAD_CMO)	\
   146		: : "r"(_cachesize),						\
   147		    "r"((unsigned long)(_start) & ~((_cachesize) - 1UL)),	\
   148		    "r"((unsigned long)(_start) + (_size))			\
   149		: "a0")
   150	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
