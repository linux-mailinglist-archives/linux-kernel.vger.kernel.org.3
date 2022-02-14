Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAC04B3FC3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 03:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238183AbiBNCsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 21:48:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235115AbiBNCsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 21:48:35 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57CD40A30
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 18:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644806906; x=1676342906;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2uN90pv+CPozaThkGoFTtxDBHYO++FKarVRLnvZuAGU=;
  b=R3/KajfYMElJlrAhZdIVsiur3bKaY7KIymU54/eq3qFSCYKDtFFVrpO1
   4/l27ULGJeUzU2iXyZS1QKnTHX2FF2DfB/RRlCzJ0hAVwyhdqtRrD+zpe
   zKSZBNYc5iI7yue+qlCw/QScYfz7ExSQvPOj3cHx2ukkE8nwPod6aldFF
   sql3Ylv4ukhKtNgIrHmwJ/nUwHHmn5eqNTbz6uTOFGWi8XC9bomxVOZQO
   V0uIOkJICktG4VK86y99I62wRsqlzahbHdM2qDgjc/JRWoIFw6YWLMTEu
   BhiqQxw/J2C+jl9N921fu6eT1E3n+XqZEYvZgrrNxU6DqYuqYtN+mfvTP
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="310735454"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="310735454"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 18:48:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="485123164"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 13 Feb 2022 18:48:24 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJRPb-00086n-LB; Mon, 14 Feb 2022 02:48:23 +0000
Date:   Mon, 14 Feb 2022 10:47:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [hnaz-mm:master 221/304] mm/migrate_device.c:236:3: error: implicit
 declaration of function 'flush_tlb_range'
Message-ID: <202202141000.yiusACzP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/hnaz/linux-mm master
head:   31e523f69aa14a1f4ba298c63034d8dc62c4aae7
commit: 4dde2cf1e43ead900b72f260528ed42c2a13e266 [221/304] mm: build migrate_vma_* for all configs with ZONE_DEVICE support
config: x86_64-randconfig-a006-20220214 (https://download.01.org/0day-ci/archive/20220214/202202141000.yiusACzP-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project ea071884b0cc7210b3cc5fe858f0e892a779a23b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/hnaz/linux-mm/commit/4dde2cf1e43ead900b72f260528ed42c2a13e266
        git remote add hnaz-mm https://github.com/hnaz/linux-mm
        git fetch --no-tags hnaz-mm master
        git checkout 4dde2cf1e43ead900b72f260528ed42c2a13e266
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> mm/migrate_device.c:236:3: error: implicit declaration of function 'flush_tlb_range' [-Werror,-Wimplicit-function-declaration]
                   flush_tlb_range(walk->vma, start, end);
                   ^
   mm/migrate_device.c:236:3: note: did you mean 'flush_cache_range'?
   include/asm-generic/cacheflush.h:33:20: note: 'flush_cache_range' declared here
   static inline void flush_cache_range(struct vm_area_struct *vma,
                      ^
   1 error generated.


vim +/flush_tlb_range +236 mm/migrate_device.c

85854f9b0061e4 Christoph Hellwig 2022-02-11   54  
85854f9b0061e4 Christoph Hellwig 2022-02-11   55  static int migrate_vma_collect_pmd(pmd_t *pmdp,
85854f9b0061e4 Christoph Hellwig 2022-02-11   56  				   unsigned long start,
85854f9b0061e4 Christoph Hellwig 2022-02-11   57  				   unsigned long end,
85854f9b0061e4 Christoph Hellwig 2022-02-11   58  				   struct mm_walk *walk)
85854f9b0061e4 Christoph Hellwig 2022-02-11   59  {
85854f9b0061e4 Christoph Hellwig 2022-02-11   60  	struct migrate_vma *migrate = walk->private;
85854f9b0061e4 Christoph Hellwig 2022-02-11   61  	struct vm_area_struct *vma = walk->vma;
85854f9b0061e4 Christoph Hellwig 2022-02-11   62  	struct mm_struct *mm = vma->vm_mm;
85854f9b0061e4 Christoph Hellwig 2022-02-11   63  	unsigned long addr = start, unmapped = 0;
85854f9b0061e4 Christoph Hellwig 2022-02-11   64  	spinlock_t *ptl;
85854f9b0061e4 Christoph Hellwig 2022-02-11   65  	pte_t *ptep;
85854f9b0061e4 Christoph Hellwig 2022-02-11   66  
85854f9b0061e4 Christoph Hellwig 2022-02-11   67  again:
85854f9b0061e4 Christoph Hellwig 2022-02-11   68  	if (pmd_none(*pmdp))
85854f9b0061e4 Christoph Hellwig 2022-02-11   69  		return migrate_vma_collect_hole(start, end, -1, walk);
85854f9b0061e4 Christoph Hellwig 2022-02-11   70  
85854f9b0061e4 Christoph Hellwig 2022-02-11   71  	if (pmd_trans_huge(*pmdp)) {
85854f9b0061e4 Christoph Hellwig 2022-02-11   72  		struct page *page;
85854f9b0061e4 Christoph Hellwig 2022-02-11   73  
85854f9b0061e4 Christoph Hellwig 2022-02-11   74  		ptl = pmd_lock(mm, pmdp);
85854f9b0061e4 Christoph Hellwig 2022-02-11   75  		if (unlikely(!pmd_trans_huge(*pmdp))) {
85854f9b0061e4 Christoph Hellwig 2022-02-11   76  			spin_unlock(ptl);
85854f9b0061e4 Christoph Hellwig 2022-02-11   77  			goto again;
85854f9b0061e4 Christoph Hellwig 2022-02-11   78  		}
85854f9b0061e4 Christoph Hellwig 2022-02-11   79  
85854f9b0061e4 Christoph Hellwig 2022-02-11   80  		page = pmd_page(*pmdp);
85854f9b0061e4 Christoph Hellwig 2022-02-11   81  		if (is_huge_zero_page(page)) {
85854f9b0061e4 Christoph Hellwig 2022-02-11   82  			spin_unlock(ptl);
85854f9b0061e4 Christoph Hellwig 2022-02-11   83  			split_huge_pmd(vma, pmdp, addr);
85854f9b0061e4 Christoph Hellwig 2022-02-11   84  			if (pmd_trans_unstable(pmdp))
85854f9b0061e4 Christoph Hellwig 2022-02-11   85  				return migrate_vma_collect_skip(start, end,
85854f9b0061e4 Christoph Hellwig 2022-02-11   86  								walk);
85854f9b0061e4 Christoph Hellwig 2022-02-11   87  		} else {
85854f9b0061e4 Christoph Hellwig 2022-02-11   88  			int ret;
85854f9b0061e4 Christoph Hellwig 2022-02-11   89  
85854f9b0061e4 Christoph Hellwig 2022-02-11   90  			get_page(page);
85854f9b0061e4 Christoph Hellwig 2022-02-11   91  			spin_unlock(ptl);
85854f9b0061e4 Christoph Hellwig 2022-02-11   92  			if (unlikely(!trylock_page(page)))
85854f9b0061e4 Christoph Hellwig 2022-02-11   93  				return migrate_vma_collect_skip(start, end,
85854f9b0061e4 Christoph Hellwig 2022-02-11   94  								walk);
85854f9b0061e4 Christoph Hellwig 2022-02-11   95  			ret = split_huge_page(page);
85854f9b0061e4 Christoph Hellwig 2022-02-11   96  			unlock_page(page);
85854f9b0061e4 Christoph Hellwig 2022-02-11   97  			put_page(page);
85854f9b0061e4 Christoph Hellwig 2022-02-11   98  			if (ret)
85854f9b0061e4 Christoph Hellwig 2022-02-11   99  				return migrate_vma_collect_skip(start, end,
85854f9b0061e4 Christoph Hellwig 2022-02-11  100  								walk);
85854f9b0061e4 Christoph Hellwig 2022-02-11  101  			if (pmd_none(*pmdp))
85854f9b0061e4 Christoph Hellwig 2022-02-11  102  				return migrate_vma_collect_hole(start, end, -1,
85854f9b0061e4 Christoph Hellwig 2022-02-11  103  								walk);
85854f9b0061e4 Christoph Hellwig 2022-02-11  104  		}
85854f9b0061e4 Christoph Hellwig 2022-02-11  105  	}
85854f9b0061e4 Christoph Hellwig 2022-02-11  106  
85854f9b0061e4 Christoph Hellwig 2022-02-11  107  	if (unlikely(pmd_bad(*pmdp)))
85854f9b0061e4 Christoph Hellwig 2022-02-11  108  		return migrate_vma_collect_skip(start, end, walk);
85854f9b0061e4 Christoph Hellwig 2022-02-11  109  
85854f9b0061e4 Christoph Hellwig 2022-02-11  110  	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
85854f9b0061e4 Christoph Hellwig 2022-02-11  111  	arch_enter_lazy_mmu_mode();
85854f9b0061e4 Christoph Hellwig 2022-02-11  112  
85854f9b0061e4 Christoph Hellwig 2022-02-11  113  	for (; addr < end; addr += PAGE_SIZE, ptep++) {
85854f9b0061e4 Christoph Hellwig 2022-02-11  114  		unsigned long mpfn = 0, pfn;
85854f9b0061e4 Christoph Hellwig 2022-02-11  115  		struct page *page;
85854f9b0061e4 Christoph Hellwig 2022-02-11  116  		swp_entry_t entry;
85854f9b0061e4 Christoph Hellwig 2022-02-11  117  		pte_t pte;
85854f9b0061e4 Christoph Hellwig 2022-02-11  118  
85854f9b0061e4 Christoph Hellwig 2022-02-11  119  		pte = *ptep;
85854f9b0061e4 Christoph Hellwig 2022-02-11  120  
85854f9b0061e4 Christoph Hellwig 2022-02-11  121  		if (pte_none(pte)) {
85854f9b0061e4 Christoph Hellwig 2022-02-11  122  			if (vma_is_anonymous(vma)) {
85854f9b0061e4 Christoph Hellwig 2022-02-11  123  				mpfn = MIGRATE_PFN_MIGRATE;
85854f9b0061e4 Christoph Hellwig 2022-02-11  124  				migrate->cpages++;
85854f9b0061e4 Christoph Hellwig 2022-02-11  125  			}
85854f9b0061e4 Christoph Hellwig 2022-02-11  126  			goto next;
85854f9b0061e4 Christoph Hellwig 2022-02-11  127  		}
85854f9b0061e4 Christoph Hellwig 2022-02-11  128  
85854f9b0061e4 Christoph Hellwig 2022-02-11  129  		if (!pte_present(pte)) {
85854f9b0061e4 Christoph Hellwig 2022-02-11  130  			/*
85854f9b0061e4 Christoph Hellwig 2022-02-11  131  			 * Only care about unaddressable device page special
85854f9b0061e4 Christoph Hellwig 2022-02-11  132  			 * page table entry. Other special swap entries are not
85854f9b0061e4 Christoph Hellwig 2022-02-11  133  			 * migratable, and we ignore regular swapped page.
85854f9b0061e4 Christoph Hellwig 2022-02-11  134  			 */
85854f9b0061e4 Christoph Hellwig 2022-02-11  135  			entry = pte_to_swp_entry(pte);
85854f9b0061e4 Christoph Hellwig 2022-02-11  136  			if (!is_device_private_entry(entry))
85854f9b0061e4 Christoph Hellwig 2022-02-11  137  				goto next;
85854f9b0061e4 Christoph Hellwig 2022-02-11  138  
85854f9b0061e4 Christoph Hellwig 2022-02-11  139  			page = pfn_swap_entry_to_page(entry);
85854f9b0061e4 Christoph Hellwig 2022-02-11  140  			if (!(migrate->flags &
85854f9b0061e4 Christoph Hellwig 2022-02-11  141  				MIGRATE_VMA_SELECT_DEVICE_PRIVATE) ||
85854f9b0061e4 Christoph Hellwig 2022-02-11  142  			    page->pgmap->owner != migrate->pgmap_owner)
85854f9b0061e4 Christoph Hellwig 2022-02-11  143  				goto next;
85854f9b0061e4 Christoph Hellwig 2022-02-11  144  
85854f9b0061e4 Christoph Hellwig 2022-02-11  145  			mpfn = migrate_pfn(page_to_pfn(page)) |
85854f9b0061e4 Christoph Hellwig 2022-02-11  146  					MIGRATE_PFN_MIGRATE;
85854f9b0061e4 Christoph Hellwig 2022-02-11  147  			if (is_writable_device_private_entry(entry))
85854f9b0061e4 Christoph Hellwig 2022-02-11  148  				mpfn |= MIGRATE_PFN_WRITE;
85854f9b0061e4 Christoph Hellwig 2022-02-11  149  		} else {
85854f9b0061e4 Christoph Hellwig 2022-02-11  150  			if (!(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM))
85854f9b0061e4 Christoph Hellwig 2022-02-11  151  				goto next;
85854f9b0061e4 Christoph Hellwig 2022-02-11  152  			pfn = pte_pfn(pte);
85854f9b0061e4 Christoph Hellwig 2022-02-11  153  			if (is_zero_pfn(pfn)) {
85854f9b0061e4 Christoph Hellwig 2022-02-11  154  				mpfn = MIGRATE_PFN_MIGRATE;
85854f9b0061e4 Christoph Hellwig 2022-02-11  155  				migrate->cpages++;
85854f9b0061e4 Christoph Hellwig 2022-02-11  156  				goto next;
85854f9b0061e4 Christoph Hellwig 2022-02-11  157  			}
85854f9b0061e4 Christoph Hellwig 2022-02-11  158  			page = vm_normal_page(migrate->vma, addr, pte);
85854f9b0061e4 Christoph Hellwig 2022-02-11  159  			mpfn = migrate_pfn(pfn) | MIGRATE_PFN_MIGRATE;
85854f9b0061e4 Christoph Hellwig 2022-02-11  160  			mpfn |= pte_write(pte) ? MIGRATE_PFN_WRITE : 0;
85854f9b0061e4 Christoph Hellwig 2022-02-11  161  		}
85854f9b0061e4 Christoph Hellwig 2022-02-11  162  
85854f9b0061e4 Christoph Hellwig 2022-02-11  163  		/* FIXME support THP */
85854f9b0061e4 Christoph Hellwig 2022-02-11  164  		if (!page || !page->mapping || PageTransCompound(page)) {
85854f9b0061e4 Christoph Hellwig 2022-02-11  165  			mpfn = 0;
85854f9b0061e4 Christoph Hellwig 2022-02-11  166  			goto next;
85854f9b0061e4 Christoph Hellwig 2022-02-11  167  		}
85854f9b0061e4 Christoph Hellwig 2022-02-11  168  
85854f9b0061e4 Christoph Hellwig 2022-02-11  169  		/*
85854f9b0061e4 Christoph Hellwig 2022-02-11  170  		 * By getting a reference on the page we pin it and that blocks
85854f9b0061e4 Christoph Hellwig 2022-02-11  171  		 * any kind of migration. Side effect is that it "freezes" the
85854f9b0061e4 Christoph Hellwig 2022-02-11  172  		 * pte.
85854f9b0061e4 Christoph Hellwig 2022-02-11  173  		 *
85854f9b0061e4 Christoph Hellwig 2022-02-11  174  		 * We drop this reference after isolating the page from the lru
85854f9b0061e4 Christoph Hellwig 2022-02-11  175  		 * for non device page (device page are not on the lru and thus
85854f9b0061e4 Christoph Hellwig 2022-02-11  176  		 * can't be dropped from it).
85854f9b0061e4 Christoph Hellwig 2022-02-11  177  		 */
85854f9b0061e4 Christoph Hellwig 2022-02-11  178  		get_page(page);
85854f9b0061e4 Christoph Hellwig 2022-02-11  179  
85854f9b0061e4 Christoph Hellwig 2022-02-11  180  		/*
85854f9b0061e4 Christoph Hellwig 2022-02-11  181  		 * Optimize for the common case where page is only mapped once
85854f9b0061e4 Christoph Hellwig 2022-02-11  182  		 * in one process. If we can lock the page, then we can safely
85854f9b0061e4 Christoph Hellwig 2022-02-11  183  		 * set up a special migration page table entry now.
85854f9b0061e4 Christoph Hellwig 2022-02-11  184  		 */
85854f9b0061e4 Christoph Hellwig 2022-02-11  185  		if (trylock_page(page)) {
85854f9b0061e4 Christoph Hellwig 2022-02-11  186  			pte_t swp_pte;
85854f9b0061e4 Christoph Hellwig 2022-02-11  187  
85854f9b0061e4 Christoph Hellwig 2022-02-11  188  			migrate->cpages++;
85854f9b0061e4 Christoph Hellwig 2022-02-11  189  			ptep_get_and_clear(mm, addr, ptep);
85854f9b0061e4 Christoph Hellwig 2022-02-11  190  
85854f9b0061e4 Christoph Hellwig 2022-02-11  191  			/* Setup special migration page table entry */
85854f9b0061e4 Christoph Hellwig 2022-02-11  192  			if (mpfn & MIGRATE_PFN_WRITE)
85854f9b0061e4 Christoph Hellwig 2022-02-11  193  				entry = make_writable_migration_entry(
85854f9b0061e4 Christoph Hellwig 2022-02-11  194  							page_to_pfn(page));
85854f9b0061e4 Christoph Hellwig 2022-02-11  195  			else
85854f9b0061e4 Christoph Hellwig 2022-02-11  196  				entry = make_readable_migration_entry(
85854f9b0061e4 Christoph Hellwig 2022-02-11  197  							page_to_pfn(page));
85854f9b0061e4 Christoph Hellwig 2022-02-11  198  			swp_pte = swp_entry_to_pte(entry);
85854f9b0061e4 Christoph Hellwig 2022-02-11  199  			if (pte_present(pte)) {
85854f9b0061e4 Christoph Hellwig 2022-02-11  200  				if (pte_soft_dirty(pte))
85854f9b0061e4 Christoph Hellwig 2022-02-11  201  					swp_pte = pte_swp_mksoft_dirty(swp_pte);
85854f9b0061e4 Christoph Hellwig 2022-02-11  202  				if (pte_uffd_wp(pte))
85854f9b0061e4 Christoph Hellwig 2022-02-11  203  					swp_pte = pte_swp_mkuffd_wp(swp_pte);
85854f9b0061e4 Christoph Hellwig 2022-02-11  204  			} else {
85854f9b0061e4 Christoph Hellwig 2022-02-11  205  				if (pte_swp_soft_dirty(pte))
85854f9b0061e4 Christoph Hellwig 2022-02-11  206  					swp_pte = pte_swp_mksoft_dirty(swp_pte);
85854f9b0061e4 Christoph Hellwig 2022-02-11  207  				if (pte_swp_uffd_wp(pte))
85854f9b0061e4 Christoph Hellwig 2022-02-11  208  					swp_pte = pte_swp_mkuffd_wp(swp_pte);
85854f9b0061e4 Christoph Hellwig 2022-02-11  209  			}
85854f9b0061e4 Christoph Hellwig 2022-02-11  210  			set_pte_at(mm, addr, ptep, swp_pte);
85854f9b0061e4 Christoph Hellwig 2022-02-11  211  
85854f9b0061e4 Christoph Hellwig 2022-02-11  212  			/*
85854f9b0061e4 Christoph Hellwig 2022-02-11  213  			 * This is like regular unmap: we remove the rmap and
85854f9b0061e4 Christoph Hellwig 2022-02-11  214  			 * drop page refcount. Page won't be freed, as we took
85854f9b0061e4 Christoph Hellwig 2022-02-11  215  			 * a reference just above.
85854f9b0061e4 Christoph Hellwig 2022-02-11  216  			 */
85854f9b0061e4 Christoph Hellwig 2022-02-11  217  			page_remove_rmap(page, vma, false);
85854f9b0061e4 Christoph Hellwig 2022-02-11  218  			put_page(page);
85854f9b0061e4 Christoph Hellwig 2022-02-11  219  
85854f9b0061e4 Christoph Hellwig 2022-02-11  220  			if (pte_present(pte))
85854f9b0061e4 Christoph Hellwig 2022-02-11  221  				unmapped++;
85854f9b0061e4 Christoph Hellwig 2022-02-11  222  		} else {
85854f9b0061e4 Christoph Hellwig 2022-02-11  223  			put_page(page);
85854f9b0061e4 Christoph Hellwig 2022-02-11  224  			mpfn = 0;
85854f9b0061e4 Christoph Hellwig 2022-02-11  225  		}
85854f9b0061e4 Christoph Hellwig 2022-02-11  226  
85854f9b0061e4 Christoph Hellwig 2022-02-11  227  next:
85854f9b0061e4 Christoph Hellwig 2022-02-11  228  		migrate->dst[migrate->npages] = 0;
85854f9b0061e4 Christoph Hellwig 2022-02-11  229  		migrate->src[migrate->npages++] = mpfn;
85854f9b0061e4 Christoph Hellwig 2022-02-11  230  	}
85854f9b0061e4 Christoph Hellwig 2022-02-11  231  	arch_leave_lazy_mmu_mode();
85854f9b0061e4 Christoph Hellwig 2022-02-11  232  	pte_unmap_unlock(ptep - 1, ptl);
85854f9b0061e4 Christoph Hellwig 2022-02-11  233  
85854f9b0061e4 Christoph Hellwig 2022-02-11  234  	/* Only flush the TLB if we actually modified any entries */
85854f9b0061e4 Christoph Hellwig 2022-02-11  235  	if (unmapped)
85854f9b0061e4 Christoph Hellwig 2022-02-11 @236  		flush_tlb_range(walk->vma, start, end);
85854f9b0061e4 Christoph Hellwig 2022-02-11  237  
85854f9b0061e4 Christoph Hellwig 2022-02-11  238  	return 0;
85854f9b0061e4 Christoph Hellwig 2022-02-11  239  }
85854f9b0061e4 Christoph Hellwig 2022-02-11  240  

:::::: The code at line 236 was first introduced by commit
:::::: 85854f9b0061e47f43a835799780054c7f9c03b6 mm: move the migrate_vma_* device migration code into it's own file

:::::: TO: Christoph Hellwig <hch@lst.de>
:::::: CC: Johannes Weiner <hannes@cmpxchg.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
