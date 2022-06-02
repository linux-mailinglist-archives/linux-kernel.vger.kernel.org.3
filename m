Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02C553BCFB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 19:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237369AbiFBRHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 13:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbiFBRHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 13:07:44 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F274C79E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 10:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654189660; x=1685725660;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JnnYQuhNTFUNhKwtcjn7hSFDvopVcTzrb1jUqm2cKjQ=;
  b=ERReoZP9j/Zh/JUnpB481EyOFmuNx9+UY07JowUaxkJ/AtIQX7HXiEoj
   ZyX9r4aP3YTb2WEz0BrtprdrTE+uKiHzQdpuCKmEEnRmleTlmn9Hx5bxX
   s8WdcWIs3cLPltU5f0aHgOdRpmTO9U5cujySKaySTAsP9oLqhsYdwyP/i
   /NPSwH7P9paLevasI02j4xYEs2/Uroio7TycdoE4g9zJ72zlcn7IRmF2J
   IlF2UEv5pT3kuZRPXtny9npYp5BDWT1EGNZ8erYFnzij7Rd6uJDxP5Kzg
   8sOM+TbIIjFNcxRGZgCP01jexPMwypDk05WUamBN+55ONfOvutz+bh9KO
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="256491170"
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="256491170"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 10:07:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="552930006"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 02 Jun 2022 10:07:37 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwoIL-0005Ir-6X;
        Thu, 02 Jun 2022 17:07:37 +0000
Date:   Fri, 3 Jun 2022 01:07:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.18-rc1 26/31]
 arch/riscv/include/asm/pgtable-64.h:56:26: error: 'PAGE_SIZE' undeclared;
 did you mean 'P4D_SIZE'?
Message-ID: <202206030040.Q0KUBAnr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.18-rc1
head:   8e0ac1b6b44d1c62420ad92b2a1cbc106a00f3de
commit: 969a734e01b9cf090fce853d9d706455e5a9cdf1 [26/31] riscv: Make virt_to_pfn() a static inline
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20220603/202206030040.Q0KUBAnr-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=969a734e01b9cf090fce853d9d706455e5a9cdf1
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.18-rc1
        git checkout 969a734e01b9cf090fce853d9d706455e5a9cdf1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/rcupdate.h:28,
                    from include/linux/rbtree.h:24,
                    from include/linux/mm_types.h:11,
                    from arch/riscv/include/asm/tlbflush.h:10,
                    from arch/riscv/include/asm/pgtable.h:108,
                    from arch/riscv/include/asm/page.h:14,
                    from arch/riscv/include/asm/thread_info.h:11,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from arch/riscv/kernel/asm-offsets.c:10:
   include/linux/bottom_half.h: In function '__local_bh_disable_ip':
>> include/linux/bottom_half.h:13:9: error: implicit declaration of function 'preempt_count_add'; did you mean 'refcount_add'? [-Werror=implicit-function-declaration]
      13 |         preempt_count_add(cnt);
         |         ^~~~~~~~~~~~~~~~~
         |         refcount_add
   In file included from include/linux/rbtree.h:24,
                    from include/linux/mm_types.h:11,
                    from arch/riscv/include/asm/tlbflush.h:10,
                    from arch/riscv/include/asm/pgtable.h:108,
                    from arch/riscv/include/asm/page.h:14,
                    from arch/riscv/include/asm/thread_info.h:11,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from arch/riscv/kernel/asm-offsets.c:10:
   include/linux/rcupdate.h: In function '__rcu_read_lock':
   include/linux/rcupdate.h:68:9: error: implicit declaration of function 'preempt_disable' [-Werror=implicit-function-declaration]
      68 |         preempt_disable();
         |         ^~~~~~~~~~~~~~~
   include/linux/rcupdate.h: In function '__rcu_read_unlock':
   include/linux/rcupdate.h:73:9: error: implicit declaration of function 'preempt_enable' [-Werror=implicit-function-declaration]
      73 |         preempt_enable();
         |         ^~~~~~~~~~~~~~
   In file included from include/linux/rbtree.h:24,
                    from include/linux/mm_types.h:11,
                    from arch/riscv/include/asm/tlbflush.h:10,
                    from arch/riscv/include/asm/pgtable.h:108,
                    from arch/riscv/include/asm/page.h:14,
                    from arch/riscv/include/asm/thread_info.h:11,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from arch/riscv/kernel/asm-offsets.c:10:
   include/linux/rcupdate.h: In function 'rcu_read_lock_sched_held':
>> include/linux/rcupdate.h:299:17: error: implicit declaration of function 'preemptible' [-Werror=implicit-function-declaration]
     299 |         return !preemptible();
         |                 ^~~~~~~~~~~
   include/linux/rcupdate.h: In function 'rcu_read_lock_sched_notrace':
   include/linux/rcupdate.h:794:9: error: implicit declaration of function 'preempt_disable_notrace' [-Werror=implicit-function-declaration]
     794 |         preempt_disable_notrace();
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h: In function 'rcu_read_unlock_sched_notrace':
   include/linux/rcupdate.h:816:9: error: implicit declaration of function 'preempt_enable_notrace' [-Werror=implicit-function-declaration]
     816 |         preempt_enable_notrace();
         |         ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/mm_types.h:19,
                    from arch/riscv/include/asm/tlbflush.h:10,
                    from arch/riscv/include/asm/pgtable.h:108,
                    from arch/riscv/include/asm/page.h:14,
                    from arch/riscv/include/asm/thread_info.h:11,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from arch/riscv/kernel/asm-offsets.c:10:
   include/linux/seqlock.h: In function 'write_seqlock':
   include/linux/seqlock.h:890:9: error: implicit declaration of function 'spin_lock' [-Werror=implicit-function-declaration]
     890 |         spin_lock(&sl->lock);
         |         ^~~~~~~~~
   include/linux/seqlock.h: In function 'write_sequnlock':
   include/linux/seqlock.h:904:9: error: implicit declaration of function 'spin_unlock' [-Werror=implicit-function-declaration]
     904 |         spin_unlock(&sl->lock);
         |         ^~~~~~~~~~~
   include/linux/seqlock.h: In function 'write_seqlock_bh':
   include/linux/seqlock.h:916:9: error: implicit declaration of function 'spin_lock_bh' [-Werror=implicit-function-declaration]
     916 |         spin_lock_bh(&sl->lock);
         |         ^~~~~~~~~~~~
   include/linux/seqlock.h: In function 'write_sequnlock_bh':
   include/linux/seqlock.h:931:9: error: implicit declaration of function 'spin_unlock_bh' [-Werror=implicit-function-declaration]
     931 |         spin_unlock_bh(&sl->lock);
         |         ^~~~~~~~~~~~~~
   include/linux/seqlock.h: In function 'write_seqlock_irq':
   include/linux/seqlock.h:943:9: error: implicit declaration of function 'spin_lock_irq' [-Werror=implicit-function-declaration]
     943 |         spin_lock_irq(&sl->lock);
         |         ^~~~~~~~~~~~~
   include/linux/seqlock.h: In function 'write_sequnlock_irq':
>> include/linux/seqlock.h:957:9: error: implicit declaration of function 'spin_unlock_irq'; did you mean 'write_sequnlock_irq'? [-Werror=implicit-function-declaration]
     957 |         spin_unlock_irq(&sl->lock);
         |         ^~~~~~~~~~~~~~~
         |         write_sequnlock_irq
   include/linux/seqlock.h: In function '__write_seqlock_irqsave':
>> include/linux/seqlock.h:964:9: error: implicit declaration of function 'spin_lock_irqsave'; did you mean 'arch_local_irq_save'? [-Werror=implicit-function-declaration]
     964 |         spin_lock_irqsave(&sl->lock, flags);
         |         ^~~~~~~~~~~~~~~~~
         |         arch_local_irq_save
   include/linux/seqlock.h: In function 'write_sequnlock_irqrestore':
>> include/linux/seqlock.h:995:9: error: implicit declaration of function 'spin_unlock_irqrestore'; did you mean 'write_sequnlock_irqrestore'? [-Werror=implicit-function-declaration]
     995 |         spin_unlock_irqrestore(&sl->lock, flags);
         |         ^~~~~~~~~~~~~~~~~~~~~~
         |         write_sequnlock_irqrestore
   In file included from include/linux/mm_types.h:21,
                    from arch/riscv/include/asm/tlbflush.h:10,
                    from arch/riscv/include/asm/pgtable.h:108,
                    from arch/riscv/include/asm/page.h:14,
                    from arch/riscv/include/asm/thread_info.h:11,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from arch/riscv/kernel/asm-offsets.c:10:
   arch/riscv/include/asm/mmu.h: At top level:
>> arch/riscv/include/asm/mmu.h:25:32: error: unknown type name 'pgd_t'; did you mean 'pid_t'?
      25 | void __init create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t pa,
         |                                ^~~~~
         |                                pid_t
   arch/riscv/include/asm/mmu.h:26:48: error: unknown type name 'pgprot_t'
      26 |                                phys_addr_t sz, pgprot_t prot);
         |                                                ^~~~~~~~
   In file included from arch/riscv/include/asm/tlbflush.h:10,
                    from arch/riscv/include/asm/pgtable.h:108,
                    from arch/riscv/include/asm/page.h:14,
                    from arch/riscv/include/asm/thread_info.h:11,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from arch/riscv/kernel/asm-offsets.c:10:
   include/linux/mm_types.h:151:25: error: unknown type name 'pgtable_t'
     151 |                         pgtable_t pmd_huge_pte; /* protected by page->ptl */
         |                         ^~~~~~~~~
   include/linux/mm_types.h:337:6: warning: "PAGE_SIZE" is not defined, evaluates to 0 [-Wundef]
     337 | #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
         |      ^~~~~~~~~
   In file included from include/vdso/const.h:5,
                    from include/linux/const.h:4,
                    from arch/riscv/include/asm/bug.h:10,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:6,
                    from arch/riscv/kernel/asm-offsets.c:10:
   include/linux/mm_types.h:314:62: warning: "PAGE_MASK" is not defined, evaluates to 0 [-Wundef]
     314 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
         |                                                              ^~~~~~~~~
   include/uapi/linux/const.h:32:50: note: in definition of macro '__ALIGN_KERNEL_MASK'
      32 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
         |                                                  ^~~~
   include/linux/mm_types.h:314:41: note: in expansion of macro '__ALIGN_MASK'
     314 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
         |                                         ^~~~~~~~~~~~
   include/linux/mm_types.h:337:18: note: in expansion of macro 'PAGE_FRAG_CACHE_MAX_SIZE'
     337 | #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mm_types.h:314:62: warning: "PAGE_MASK" is not defined, evaluates to 0 [-Wundef]
     314 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
         |                                                              ^~~~~~~~~
   include/uapi/linux/const.h:32:61: note: in definition of macro '__ALIGN_KERNEL_MASK'
      32 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
         |                                                             ^~~~
   include/linux/mm_types.h:314:41: note: in expansion of macro '__ALIGN_MASK'
     314 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
         |                                         ^~~~~~~~~~~~
   include/linux/mm_types.h:337:18: note: in expansion of macro 'PAGE_FRAG_CACHE_MAX_SIZE'
     337 | #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/riscv/include/asm/tlbflush.h:10,
                    from arch/riscv/include/asm/pgtable.h:108,
                    from arch/riscv/include/asm/page.h:14,
                    from arch/riscv/include/asm/thread_info.h:11,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from arch/riscv/kernel/asm-offsets.c:10:
   include/linux/mm_types.h:421:9: error: unknown type name 'pgprot_t'
     421 |         pgprot_t vm_page_prot;
         |         ^~~~~~~~
   include/linux/mm_types.h:495:17: error: unknown type name 'pgd_t'
     495 |                 pgd_t * pgd;
         |                 ^~~~~
   In file included from arch/riscv/include/asm/pgtable.h:112,
                    from arch/riscv/include/asm/page.h:14,
                    from arch/riscv/include/asm/thread_info.h:11,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from arch/riscv/kernel/asm-offsets.c:10:
   arch/riscv/include/asm/pgtable-64.h:99:48: error: unknown type name 'pgprot_t'
      99 | static inline pud_t pfn_pud(unsigned long pfn, pgprot_t prot)
         |                                                ^~~~~~~~
   arch/riscv/include/asm/pgtable-64.h: In function 'pud_pgtable':
   arch/riscv/include/asm/pgtable-64.h:111:25: error: implicit declaration of function 'pfn_to_virt' [-Werror=implicit-function-declaration]
     111 |         return (pmd_t *)pfn_to_virt(pud_val(pud) >> _PAGE_PFN_SHIFT);
         |                         ^~~~~~~~~~~
   arch/riscv/include/asm/pgtable-64.h:111:16: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     111 |         return (pmd_t *)pfn_to_virt(pud_val(pud) >> _PAGE_PFN_SHIFT);
         |                ^
   arch/riscv/include/asm/pgtable-64.h: In function 'pud_page':
   arch/riscv/include/asm/pgtable-64.h:116:16: error: implicit declaration of function 'pfn_to_page' [-Werror=implicit-function-declaration]
     116 |         return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
         |                ^~~~~~~~~~~
   arch/riscv/include/asm/pgtable-64.h:116:16: warning: returning 'int' from a function with return type 'struct page *' makes pointer from integer without a cast [-Wint-conversion]
     116 |         return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/pgtable-64.h: At top level:
   arch/riscv/include/asm/pgtable-64.h:139:48: error: unknown type name 'pgprot_t'
     139 | static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
         |                                                ^~~~~~~~
   arch/riscv/include/asm/pgtable-64.h:198:48: error: unknown type name 'pgprot_t'
     198 | static inline p4d_t pfn_p4d(unsigned long pfn, pgprot_t prot)
         |                                                ^~~~~~~~
   arch/riscv/include/asm/pgtable-64.h: In function 'p4d_pgtable':
   arch/riscv/include/asm/pgtable-64.h:211:24: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     211 |                 return (pud_t *)pfn_to_virt(p4d_val(p4d) >> _PAGE_PFN_SHIFT);
         |                        ^
   arch/riscv/include/asm/pgtable-64.h: In function 'p4d_page':
   arch/riscv/include/asm/pgtable-64.h:219:16: warning: returning 'int' from a function with return type 'struct page *' makes pointer from integer without a cast [-Wint-conversion]
     219 |         return pfn_to_page(p4d_val(p4d) >> _PAGE_PFN_SHIFT);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/pgtable-64.h: In function 'pud_offset':
>> arch/riscv/include/asm/pgtable-64.h:56:26: error: 'PAGE_SIZE' undeclared (first use in this function); did you mean 'P4D_SIZE'?
      56 | #define PTRS_PER_PUD    (PAGE_SIZE / sizeof(pud_t))
         |                          ^~~~~~~~~
   arch/riscv/include/asm/pgtable-64.h:222:51: note: in expansion of macro 'PTRS_PER_PUD'
     222 | #define pud_index(addr) (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
         |                                                   ^~~~~~~~~~~~
   arch/riscv/include/asm/pgtable-64.h:228:44: note: in expansion of macro 'pud_index'
     228 |                 return p4d_pgtable(*p4d) + pud_index(address);
         |                                            ^~~~~~~~~
   arch/riscv/include/asm/pgtable-64.h:56:26: note: each undeclared identifier is reported only once for each function it appears in
      56 | #define PTRS_PER_PUD    (PAGE_SIZE / sizeof(pud_t))
         |                          ^~~~~~~~~
   arch/riscv/include/asm/pgtable-64.h:222:51: note: in expansion of macro 'PTRS_PER_PUD'
     222 | #define pud_index(addr) (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
         |                                                   ^~~~~~~~~~~~
   arch/riscv/include/asm/pgtable-64.h:228:44: note: in expansion of macro 'pud_index'
     228 |                 return p4d_pgtable(*p4d) + pud_index(address);
         |                                            ^~~~~~~~~
   arch/riscv/include/asm/pgtable-64.h: At top level:
>> arch/riscv/include/asm/pgtable-64.h:233:28: error: unknown type name 'pgd_t'; did you mean 'pmd_t'?
     233 | static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
         |                            ^~~~~
         |                            pmd_t
   arch/riscv/include/asm/pgtable-64.h:233:41: error: unknown type name 'pgd_t'; did you mean 'pmd_t'?
     233 | static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
         |                                         ^~~~~
         |                                         pmd_t
   arch/riscv/include/asm/pgtable-64.h:241:28: error: unknown type name 'pgd_t'; did you mean 'pmd_t'?
     241 | static inline int pgd_none(pgd_t pgd)
         |                            ^~~~~
         |                            pmd_t
   arch/riscv/include/asm/pgtable-64.h:249:31: error: unknown type name 'pgd_t'; did you mean 'pmd_t'?
     249 | static inline int pgd_present(pgd_t pgd)
         |                               ^~~~~
         |                               pmd_t
   arch/riscv/include/asm/pgtable-64.h:257:27: error: unknown type name 'pgd_t'; did you mean 'pmd_t'?
     257 | static inline int pgd_bad(pgd_t pgd)
         |                           ^~~~~
         |                           pmd_t
   arch/riscv/include/asm/pgtable-64.h:265:30: error: unknown type name 'pgd_t'; did you mean 'pmd_t'?
     265 | static inline void pgd_clear(pgd_t *pgd)
         |                              ^~~~~
         |                              pmd_t
   arch/riscv/include/asm/pgtable-64.h:271:34: error: unknown type name 'pgd_t'; did you mean 'pmd_t'?
     271 | static inline p4d_t *pgd_pgtable(pgd_t pgd)
         |                                  ^~~~~
         |                                  pmd_t
   arch/riscv/include/asm/pgtable-64.h:280:37: error: unknown type name 'pgd_t'; did you mean 'pmd_t'?
     280 | static inline struct page *pgd_page(pgd_t pgd)
         |                                     ^~~~~
         |                                     pmd_t
   arch/riscv/include/asm/pgtable-64.h:289:33: error: unknown type name 'pgd_t'; did you mean 'pmd_t'?
     289 | static inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
         |                                 ^~~~~
         |                                 pmd_t
   In file included from arch/riscv/include/asm/page.h:14,
                    from arch/riscv/include/asm/thread_info.h:11,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from arch/riscv/kernel/asm-offsets.c:10:
   arch/riscv/include/asm/pgtable.h:130:9: error: unknown type name 'pte_t'
     130 |         pte_t *(*get_pte_virt)(phys_addr_t pa);
         |         ^~~~~
>> arch/riscv/include/asm/pgtable.h:750:38: error: 'PAGE_SIZE' undeclared here (not in a function); did you mean 'P4D_SIZE'?
     750 | extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
         |                                      ^~~~~~~~~
         |                                      P4D_SIZE
   In file included from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from arch/riscv/kernel/asm-offsets.c:10:
>> include/linux/spinlock.h:347:29: warning: conflicting types for 'spin_lock'; have 'void(spinlock_t *)' {aka 'void(struct spinlock *)'}
     347 | static __always_inline void spin_lock(spinlock_t *lock)
         |                             ^~~~~~~~~
   include/linux/spinlock.h:347:29: error: static declaration of 'spin_lock' follows non-static declaration
   In file included from include/linux/mm_types.h:19,
                    from arch/riscv/include/asm/tlbflush.h:10,
                    from arch/riscv/include/asm/pgtable.h:108,
                    from arch/riscv/include/asm/page.h:14,
                    from arch/riscv/include/asm/thread_info.h:11,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from arch/riscv/kernel/asm-offsets.c:10:
   include/linux/seqlock.h:890:9: note: previous implicit declaration of 'spin_lock' with type 'void(spinlock_t *)' {aka 'void(struct spinlock *)'}
     890 |         spin_lock(&sl->lock);
         |         ^~~~~~~~~
   In file included from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from arch/riscv/kernel/asm-offsets.c:10:
>> include/linux/spinlock.h:352:29: warning: conflicting types for 'spin_lock_bh'; have 'void(spinlock_t *)' {aka 'void(struct spinlock *)'}
     352 | static __always_inline void spin_lock_bh(spinlock_t *lock)
         |                             ^~~~~~~~~~~~
   include/linux/spinlock.h:352:29: error: static declaration of 'spin_lock_bh' follows non-static declaration
   In file included from include/linux/mm_types.h:19,
                    from arch/riscv/include/asm/tlbflush.h:10,
                    from arch/riscv/include/asm/pgtable.h:108,
                    from arch/riscv/include/asm/page.h:14,
                    from arch/riscv/include/asm/thread_info.h:11,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from arch/riscv/kernel/asm-offsets.c:10:
   include/linux/seqlock.h:916:9: note: previous implicit declaration of 'spin_lock_bh' with type 'void(spinlock_t *)' {aka 'void(struct spinlock *)'}
     916 |         spin_lock_bh(&sl->lock);
         |         ^~~~~~~~~~~~
   In file included from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from arch/riscv/kernel/asm-offsets.c:10:
>> include/linux/spinlock.h:372:29: warning: conflicting types for 'spin_lock_irq'; have 'void(spinlock_t *)' {aka 'void(struct spinlock *)'}
     372 | static __always_inline void spin_lock_irq(spinlock_t *lock)
         |                             ^~~~~~~~~~~~~
   include/linux/spinlock.h:372:29: error: static declaration of 'spin_lock_irq' follows non-static declaration
   In file included from include/linux/mm_types.h:19,
                    from arch/riscv/include/asm/tlbflush.h:10,
                    from arch/riscv/include/asm/pgtable.h:108,
                    from arch/riscv/include/asm/page.h:14,
                    from arch/riscv/include/asm/thread_info.h:11,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from arch/riscv/kernel/asm-offsets.c:10:
   include/linux/seqlock.h:943:9: note: previous implicit declaration of 'spin_lock_irq' with type 'void(spinlock_t *)' {aka 'void(struct spinlock *)'}
     943 |         spin_lock_irq(&sl->lock);
         |         ^~~~~~~~~~~~~
   In file included from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from arch/riscv/kernel/asm-offsets.c:10:
>> include/linux/spinlock.h:387:29: warning: conflicting types for 'spin_unlock'; have 'void(spinlock_t *)' {aka 'void(struct spinlock *)'}
     387 | static __always_inline void spin_unlock(spinlock_t *lock)
         |                             ^~~~~~~~~~~
   include/linux/spinlock.h:387:29: error: static declaration of 'spin_unlock' follows non-static declaration
   In file included from include/linux/mm_types.h:19,
                    from arch/riscv/include/asm/tlbflush.h:10,
                    from arch/riscv/include/asm/pgtable.h:108,
                    from arch/riscv/include/asm/page.h:14,
                    from arch/riscv/include/asm/thread_info.h:11,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from arch/riscv/kernel/asm-offsets.c:10:
   include/linux/seqlock.h:904:9: note: previous implicit declaration of 'spin_unlock' with type 'void(spinlock_t *)' {aka 'void(struct spinlock *)'}
     904 |         spin_unlock(&sl->lock);
         |         ^~~~~~~~~~~
   In file included from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from arch/riscv/kernel/asm-offsets.c:10:
>> include/linux/spinlock.h:392:29: warning: conflicting types for 'spin_unlock_bh'; have 'void(spinlock_t *)' {aka 'void(struct spinlock *)'}
     392 | static __always_inline void spin_unlock_bh(spinlock_t *lock)
         |                             ^~~~~~~~~~~~~~
   include/linux/spinlock.h:392:29: error: static declaration of 'spin_unlock_bh' follows non-static declaration
   In file included from include/linux/mm_types.h:19,
                    from arch/riscv/include/asm/tlbflush.h:10,
                    from arch/riscv/include/asm/pgtable.h:108,
                    from arch/riscv/include/asm/page.h:14,
                    from arch/riscv/include/asm/thread_info.h:11,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from arch/riscv/kernel/asm-offsets.c:10:
   include/linux/seqlock.h:931:9: note: previous implicit declaration of 'spin_unlock_bh' with type 'void(spinlock_t *)' {aka 'void(struct spinlock *)'}
     931 |         spin_unlock_bh(&sl->lock);
         |         ^~~~~~~~~~~~~~
   In file included from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from arch/riscv/kernel/asm-offsets.c:10:
>> include/linux/spinlock.h:397:29: warning: conflicting types for 'spin_unlock_irq'; have 'void(spinlock_t *)' {aka 'void(struct spinlock *)'}
     397 | static __always_inline void spin_unlock_irq(spinlock_t *lock)
         |                             ^~~~~~~~~~~~~~~
   include/linux/spinlock.h:397:29: error: static declaration of 'spin_unlock_irq' follows non-static declaration
   In file included from include/linux/mm_types.h:19,
                    from arch/riscv/include/asm/tlbflush.h:10,
                    from arch/riscv/include/asm/pgtable.h:108,
                    from arch/riscv/include/asm/page.h:14,
                    from arch/riscv/include/asm/thread_info.h:11,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from arch/riscv/kernel/asm-offsets.c:10:
   include/linux/seqlock.h:957:9: note: previous implicit declaration of 'spin_unlock_irq' with type 'void(spinlock_t *)' {aka 'void(struct spinlock *)'}
     957 |         spin_unlock_irq(&sl->lock);
         |         ^~~~~~~~~~~~~~~
   In file included from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from arch/riscv/kernel/asm-offsets.c:10:
   include/linux/spinlock.h:402:29: warning: conflicting types for 'spin_unlock_irqrestore'; have 'void(spinlock_t *, long unsigned int)' {aka 'void(struct spinlock *, long unsigned int)'}
     402 | static __always_inline void spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
         |                             ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock.h:402:29: error: static declaration of 'spin_unlock_irqrestore' follows non-static declaration
   In file included from include/linux/mm_types.h:19,
                    from arch/riscv/include/asm/tlbflush.h:10,
                    from arch/riscv/include/asm/pgtable.h:108,
                    from arch/riscv/include/asm/page.h:14,
                    from arch/riscv/include/asm/thread_info.h:11,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from arch/riscv/kernel/asm-offsets.c:10:
   include/linux/seqlock.h:995:9: note: previous implicit declaration of 'spin_unlock_irqrestore' with type 'void(spinlock_t *, long unsigned int)' {aka 'void(struct spinlock *, long unsigned int)'}
     995 |         spin_unlock_irqrestore(&sl->lock, flags);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/mm.h:700,
                    from arch/riscv/kernel/asm-offsets.c:10:
   include/linux/huge_mm.h: In function 'vmf_insert_pfn_pmd':
   include/linux/huge_mm.h:58:58: error: incompatible type for argument 3 of 'vmf_insert_pfn_pmd_prot'
      58 |         return vmf_insert_pfn_pmd_prot(vmf, pfn, vmf->vma->vm_page_prot, write);
         |                                                  ~~~~~~~~^~~~~~~~~~~~~~
         |                                                          |
         |                                                          int
   include/linux/huge_mm.h:42:45: note: expected 'pgprot_t' but argument is of type 'int'
      42 |                                    pgprot_t pgprot, bool write);
         |                                    ~~~~~~~~~^~~~~~
   include/linux/huge_mm.h: In function 'vmf_insert_pfn_pud':
   include/linux/huge_mm.h:77:58: error: incompatible type for argument 3 of 'vmf_insert_pfn_pud_prot'
      77 |         return vmf_insert_pfn_pud_prot(vmf, pfn, vmf->vma->vm_page_prot, write);
         |                                                  ~~~~~~~~^~~~~~~~~~~~~~
         |                                                          |
         |                                                          int
   include/linux/huge_mm.h:61:45: note: expected 'pgprot_t' but argument is of type 'int'
      61 |                                    pgprot_t pgprot, bool write);
         |                                    ~~~~~~~~~^~~~~~
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   include/linux/mm.h: In function 'vma_set_page_prot':
   include/linux/mm.h:2853:29: error: incompatible types when assigning to type 'int' from type 'pgprot_t'
    2853 |         vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
         |                             ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:120: arch/riscv/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +56 arch/riscv/include/asm/pgtable-64.h

e8a62cc26ddf53 Alexandre Ghiti  2021-12-06   53  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06   54  #define pud_val(x)      ((x).pud)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06   55  #define __pud(x)        ((pud_t) { (x) })
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  @56  #define PTRS_PER_PUD    (PAGE_SIZE / sizeof(pud_t))
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06   57  
07037db5d479f9 Palmer Dabbelt   2017-07-10   58  /* Page Middle Directory entry */
07037db5d479f9 Palmer Dabbelt   2017-07-10   59  typedef struct {
07037db5d479f9 Palmer Dabbelt   2017-07-10   60  	unsigned long pmd;
07037db5d479f9 Palmer Dabbelt   2017-07-10   61  } pmd_t;
07037db5d479f9 Palmer Dabbelt   2017-07-10   62  
07037db5d479f9 Palmer Dabbelt   2017-07-10   63  #define pmd_val(x)      ((x).pmd)
07037db5d479f9 Palmer Dabbelt   2017-07-10   64  #define __pmd(x)        ((pmd_t) { (x) })
07037db5d479f9 Palmer Dabbelt   2017-07-10   65  
07037db5d479f9 Palmer Dabbelt   2017-07-10   66  #define PTRS_PER_PMD    (PAGE_SIZE / sizeof(pmd_t))
07037db5d479f9 Palmer Dabbelt   2017-07-10   67  
07037db5d479f9 Palmer Dabbelt   2017-07-10   68  static inline int pud_present(pud_t pud)
07037db5d479f9 Palmer Dabbelt   2017-07-10   69  {
07037db5d479f9 Palmer Dabbelt   2017-07-10   70  	return (pud_val(pud) & _PAGE_PRESENT);
07037db5d479f9 Palmer Dabbelt   2017-07-10   71  }
07037db5d479f9 Palmer Dabbelt   2017-07-10   72  
07037db5d479f9 Palmer Dabbelt   2017-07-10   73  static inline int pud_none(pud_t pud)
07037db5d479f9 Palmer Dabbelt   2017-07-10   74  {
07037db5d479f9 Palmer Dabbelt   2017-07-10   75  	return (pud_val(pud) == 0);
07037db5d479f9 Palmer Dabbelt   2017-07-10   76  }
07037db5d479f9 Palmer Dabbelt   2017-07-10   77  
07037db5d479f9 Palmer Dabbelt   2017-07-10   78  static inline int pud_bad(pud_t pud)
07037db5d479f9 Palmer Dabbelt   2017-07-10   79  {
07037db5d479f9 Palmer Dabbelt   2017-07-10   80  	return !pud_present(pud);
07037db5d479f9 Palmer Dabbelt   2017-07-10   81  }
07037db5d479f9 Palmer Dabbelt   2017-07-10   82  
af6513ead0462c Steven Price     2020-02-03   83  #define pud_leaf	pud_leaf
af6513ead0462c Steven Price     2020-02-03   84  static inline int pud_leaf(pud_t pud)
af6513ead0462c Steven Price     2020-02-03   85  {
f5397c3ee0a3e2 Nanyong Sun      2021-04-30   86  	return pud_present(pud) && (pud_val(pud) & _PAGE_LEAF);
af6513ead0462c Steven Price     2020-02-03   87  }
af6513ead0462c Steven Price     2020-02-03   88  
07037db5d479f9 Palmer Dabbelt   2017-07-10   89  static inline void set_pud(pud_t *pudp, pud_t pud)
07037db5d479f9 Palmer Dabbelt   2017-07-10   90  {
07037db5d479f9 Palmer Dabbelt   2017-07-10   91  	*pudp = pud;
07037db5d479f9 Palmer Dabbelt   2017-07-10   92  }
07037db5d479f9 Palmer Dabbelt   2017-07-10   93  
07037db5d479f9 Palmer Dabbelt   2017-07-10   94  static inline void pud_clear(pud_t *pudp)
07037db5d479f9 Palmer Dabbelt   2017-07-10   95  {
07037db5d479f9 Palmer Dabbelt   2017-07-10   96  	set_pud(pudp, __pud(0));
07037db5d479f9 Palmer Dabbelt   2017-07-10   97  }
07037db5d479f9 Palmer Dabbelt   2017-07-10   98  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06   99  static inline pud_t pfn_pud(unsigned long pfn, pgprot_t prot)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  100  {
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  101  	return __pud((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  102  }
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  103  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  104  static inline unsigned long _pud_pfn(pud_t pud)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  105  {
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  106  	return pud_val(pud) >> _PAGE_PFN_SHIFT;
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  107  }
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  108  
9cf6fa24584431 Aneesh Kumar K.V 2021-07-07  109  static inline pmd_t *pud_pgtable(pud_t pud)
07037db5d479f9 Palmer Dabbelt   2017-07-10  110  {
9cf6fa24584431 Aneesh Kumar K.V 2021-07-07  111  	return (pmd_t *)pfn_to_virt(pud_val(pud) >> _PAGE_PFN_SHIFT);
07037db5d479f9 Palmer Dabbelt   2017-07-10  112  }
07037db5d479f9 Palmer Dabbelt   2017-07-10  113  
8ad8b72721d0f0 Nick Hu          2020-01-06  114  static inline struct page *pud_page(pud_t pud)
8ad8b72721d0f0 Nick Hu          2020-01-06  115  {
8ad8b72721d0f0 Nick Hu          2020-01-06  116  	return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
8ad8b72721d0f0 Nick Hu          2020-01-06  117  }
8ad8b72721d0f0 Nick Hu          2020-01-06  118  
d10efa21a93748 Qinglin Pan      2022-01-27  119  #define mm_p4d_folded  mm_p4d_folded
d10efa21a93748 Qinglin Pan      2022-01-27  120  static inline bool mm_p4d_folded(struct mm_struct *mm)
d10efa21a93748 Qinglin Pan      2022-01-27  121  {
d10efa21a93748 Qinglin Pan      2022-01-27  122  	if (pgtable_l5_enabled)
d10efa21a93748 Qinglin Pan      2022-01-27  123  		return false;
d10efa21a93748 Qinglin Pan      2022-01-27  124  
d10efa21a93748 Qinglin Pan      2022-01-27  125  	return true;
d10efa21a93748 Qinglin Pan      2022-01-27  126  }
d10efa21a93748 Qinglin Pan      2022-01-27  127  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  128  #define mm_pud_folded  mm_pud_folded
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  129  static inline bool mm_pud_folded(struct mm_struct *mm)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  130  {
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  131  	if (pgtable_l4_enabled)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  132  		return false;
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  133  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  134  	return true;
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  135  }
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  136  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  137  #define pmd_index(addr) (((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  138  
07037db5d479f9 Palmer Dabbelt   2017-07-10  139  static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
07037db5d479f9 Palmer Dabbelt   2017-07-10  140  {
07037db5d479f9 Palmer Dabbelt   2017-07-10  141  	return __pmd((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
07037db5d479f9 Palmer Dabbelt   2017-07-10  142  }
07037db5d479f9 Palmer Dabbelt   2017-07-10  143  
671f9a3e2e24cd Anup Patel       2019-06-28  144  static inline unsigned long _pmd_pfn(pmd_t pmd)
671f9a3e2e24cd Anup Patel       2019-06-28  145  {
671f9a3e2e24cd Anup Patel       2019-06-28  146  	return pmd_val(pmd) >> _PAGE_PFN_SHIFT;
671f9a3e2e24cd Anup Patel       2019-06-28  147  }
671f9a3e2e24cd Anup Patel       2019-06-28  148  
9eb4fcff220790 Nanyong Sun      2021-06-17  149  #define mk_pmd(page, prot)    pfn_pmd(page_to_pfn(page), prot)
9eb4fcff220790 Nanyong Sun      2021-06-17  150  
07037db5d479f9 Palmer Dabbelt   2017-07-10  151  #define pmd_ERROR(e) \
07037db5d479f9 Palmer Dabbelt   2017-07-10  152  	pr_err("%s:%d: bad pmd %016lx.\n", __FILE__, __LINE__, pmd_val(e))
07037db5d479f9 Palmer Dabbelt   2017-07-10  153  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  154  #define pud_ERROR(e)   \
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  155  	pr_err("%s:%d: bad pud %016lx.\n", __FILE__, __LINE__, pud_val(e))
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  156  
d10efa21a93748 Qinglin Pan      2022-01-27  157  #define p4d_ERROR(e)   \
d10efa21a93748 Qinglin Pan      2022-01-27  158  	pr_err("%s:%d: bad p4d %016lx.\n", __FILE__, __LINE__, p4d_val(e))
d10efa21a93748 Qinglin Pan      2022-01-27  159  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  160  static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  161  {
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  162  	if (pgtable_l4_enabled)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  163  		*p4dp = p4d;
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  164  	else
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  165  		set_pud((pud_t *)p4dp, (pud_t){ p4d_val(p4d) });
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  166  }
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  167  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  168  static inline int p4d_none(p4d_t p4d)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  169  {
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  170  	if (pgtable_l4_enabled)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  171  		return (p4d_val(p4d) == 0);
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  172  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  173  	return 0;
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  174  }
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  175  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  176  static inline int p4d_present(p4d_t p4d)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  177  {
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  178  	if (pgtable_l4_enabled)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  179  		return (p4d_val(p4d) & _PAGE_PRESENT);
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  180  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  181  	return 1;
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  182  }
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  183  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  184  static inline int p4d_bad(p4d_t p4d)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  185  {
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  186  	if (pgtable_l4_enabled)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  187  		return !p4d_present(p4d);
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  188  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  189  	return 0;
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  190  }
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  191  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  192  static inline void p4d_clear(p4d_t *p4d)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  193  {
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  194  	if (pgtable_l4_enabled)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  195  		set_p4d(p4d, __p4d(0));
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  196  }
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  197  
d10efa21a93748 Qinglin Pan      2022-01-27  198  static inline p4d_t pfn_p4d(unsigned long pfn, pgprot_t prot)
d10efa21a93748 Qinglin Pan      2022-01-27  199  {
d10efa21a93748 Qinglin Pan      2022-01-27  200  	return __p4d((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
d10efa21a93748 Qinglin Pan      2022-01-27  201  }
d10efa21a93748 Qinglin Pan      2022-01-27  202  
d10efa21a93748 Qinglin Pan      2022-01-27  203  static inline unsigned long _p4d_pfn(p4d_t p4d)
d10efa21a93748 Qinglin Pan      2022-01-27  204  {
d10efa21a93748 Qinglin Pan      2022-01-27  205  	return p4d_val(p4d) >> _PAGE_PFN_SHIFT;
d10efa21a93748 Qinglin Pan      2022-01-27  206  }
d10efa21a93748 Qinglin Pan      2022-01-27  207  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  208  static inline pud_t *p4d_pgtable(p4d_t p4d)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  209  {
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  210  	if (pgtable_l4_enabled)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  211  		return (pud_t *)pfn_to_virt(p4d_val(p4d) >> _PAGE_PFN_SHIFT);
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  212  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  213  	return (pud_t *)pud_pgtable((pud_t) { p4d_val(p4d) });
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  214  }
d10efa21a93748 Qinglin Pan      2022-01-27  215  #define p4d_page_vaddr(p4d)	((unsigned long)p4d_pgtable(p4d))
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  216  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  217  static inline struct page *p4d_page(p4d_t p4d)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  218  {
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  219  	return pfn_to_page(p4d_val(p4d) >> _PAGE_PFN_SHIFT);
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  220  }
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  221  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  222  #define pud_index(addr) (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  223  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  224  #define pud_offset pud_offset
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  225  static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  226  {
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  227  	if (pgtable_l4_enabled)
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  228  		return p4d_pgtable(*p4d) + pud_index(address);
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  229  
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  230  	return (pud_t *)p4d;
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  231  }
e8a62cc26ddf53 Alexandre Ghiti  2021-12-06  232  
d10efa21a93748 Qinglin Pan      2022-01-27 @233  static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
d10efa21a93748 Qinglin Pan      2022-01-27  234  {
d10efa21a93748 Qinglin Pan      2022-01-27  235  	if (pgtable_l5_enabled)
d10efa21a93748 Qinglin Pan      2022-01-27  236  		*pgdp = pgd;
d10efa21a93748 Qinglin Pan      2022-01-27  237  	else
d10efa21a93748 Qinglin Pan      2022-01-27  238  		set_p4d((p4d_t *)pgdp, (p4d_t){ pgd_val(pgd) });
d10efa21a93748 Qinglin Pan      2022-01-27  239  }
d10efa21a93748 Qinglin Pan      2022-01-27  240  

:::::: The code at line 56 was first introduced by commit
:::::: e8a62cc26ddf53a3c6ba2a8d33036cf7b84f3923 riscv: Implement sv48 support

:::::: TO: Alexandre Ghiti <alexandre.ghiti@canonical.com>
:::::: CC: Palmer Dabbelt <palmer@rivosinc.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
