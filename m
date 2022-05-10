Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B625225B0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 22:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbiEJUnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 16:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbiEJUng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 16:43:36 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1819F29BC53
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 13:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652215415; x=1683751415;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oAp4kv4wUhBg4cbo8eT2V+VQAbZdV+FZDr7miDk6eqg=;
  b=Qf2qspNf/leffFF04Y4H3SAW1xn8bYQtjyN3ouRwkqPweTlZn3G2IOrU
   fDQlxXtx3tCDWyanWXFq67KD+qLHI5xulCC6ShY3VjKGIcjTr7HE9jVZO
   4DIFMExObQEtaA8MBY/6bmPFS73ROQ6lzvDnSkp9nPMsRKIhaZGWUX6Px
   ABVTVHjAL4AobDn4nuHakiRLqfjXdjBtLODlGu+twZG8R54wQg8Uz59Nw
   YSu5gdpSa6rlgeFayJ4uwfHSDr6aCh6p3Dtf71f69kC1V4S2P2+c5Wixy
   VhRMcxQb75wrlTTq4oNKo/uFyvFbC5QZMLe0gjHe+3EBV/BBjelm3oIHV
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="332534548"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="332534548"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 13:43:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="711198632"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 10 May 2022 13:43:32 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noWhg-000IMQ-0C;
        Tue, 10 May 2022 20:43:32 +0000
Date:   Wed, 11 May 2022 04:42:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Subject: [akpm-mm:mm-unstable 175/431] mm/madvise.c:632:36: error: implicit
 declaration of function 'is_swapin_error_entry'
Message-ID: <202205110409.O9A7aFSX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
head:   584a50635cc1deee2eeab5a17dfdcf9db7add21b
commit: 8296b60c4ec05505344455818a30cb2774304acd [175/431] mm/madvise: free hwpoison and swapin error entry in madvise_free_pte_range
config: parisc-randconfig-r036-20220509 (https://download.01.org/0day-ci/archive/20220511/202205110409.O9A7aFSX-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=8296b60c4ec05505344455818a30cb2774304acd
        git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
        git fetch --no-tags akpm-mm mm-unstable
        git checkout 8296b60c4ec05505344455818a30cb2774304acd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the akpm-mm/mm-unstable HEAD 584a50635cc1deee2eeab5a17dfdcf9db7add21b builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   mm/madvise.c: In function 'madvise_free_pte_range':
>> mm/madvise.c:632:36: error: implicit declaration of function 'is_swapin_error_entry' [-Werror=implicit-function-declaration]
     632 |                                    is_swapin_error_entry(entry)) {
         |                                    ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/is_swapin_error_entry +632 mm/madvise.c

   587	
   588	static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
   589					unsigned long end, struct mm_walk *walk)
   590	
   591	{
   592		struct mmu_gather *tlb = walk->private;
   593		struct mm_struct *mm = tlb->mm;
   594		struct vm_area_struct *vma = walk->vma;
   595		spinlock_t *ptl;
   596		pte_t *orig_pte, *pte, ptent;
   597		struct page *page;
   598		int nr_swap = 0;
   599		unsigned long next;
   600	
   601		next = pmd_addr_end(addr, end);
   602		if (pmd_trans_huge(*pmd))
   603			if (madvise_free_huge_pmd(tlb, vma, pmd, addr, next))
   604				goto next;
   605	
   606		if (pmd_trans_unstable(pmd))
   607			return 0;
   608	
   609		tlb_change_page_size(tlb, PAGE_SIZE);
   610		orig_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
   611		flush_tlb_batched_pending(mm);
   612		arch_enter_lazy_mmu_mode();
   613		for (; addr != end; pte++, addr += PAGE_SIZE) {
   614			ptent = *pte;
   615	
   616			if (pte_none(ptent))
   617				continue;
   618			/*
   619			 * If the pte has swp_entry, just clear page table to
   620			 * prevent swap-in which is more expensive rather than
   621			 * (page allocation + zeroing).
   622			 */
   623			if (!pte_present(ptent)) {
   624				swp_entry_t entry;
   625	
   626				entry = pte_to_swp_entry(ptent);
   627				if (!non_swap_entry(entry)) {
   628					nr_swap--;
   629					free_swap_and_cache(entry);
   630					pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
   631				} else if (is_hwpoison_entry(entry) ||
 > 632					   is_swapin_error_entry(entry)) {
   633					pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
   634				}
   635				continue;
   636			}
   637	
   638			page = vm_normal_page(vma, addr, ptent);
   639			if (!page)
   640				continue;
   641	
   642			/*
   643			 * If pmd isn't transhuge but the page is THP and
   644			 * is owned by only this process, split it and
   645			 * deactivate all pages.
   646			 */
   647			if (PageTransCompound(page)) {
   648				if (page_mapcount(page) != 1)
   649					goto out;
   650				get_page(page);
   651				if (!trylock_page(page)) {
   652					put_page(page);
   653					goto out;
   654				}
   655				pte_unmap_unlock(orig_pte, ptl);
   656				if (split_huge_page(page)) {
   657					unlock_page(page);
   658					put_page(page);
   659					orig_pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
   660					goto out;
   661				}
   662				unlock_page(page);
   663				put_page(page);
   664				orig_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
   665				pte--;
   666				addr -= PAGE_SIZE;
   667				continue;
   668			}
   669	
   670			VM_BUG_ON_PAGE(PageTransCompound(page), page);
   671	
   672			if (PageSwapCache(page) || PageDirty(page)) {
   673				if (!trylock_page(page))
   674					continue;
   675				/*
   676				 * If page is shared with others, we couldn't clear
   677				 * PG_dirty of the page.
   678				 */
   679				if (page_mapcount(page) != 1) {
   680					unlock_page(page);
   681					continue;
   682				}
   683	
   684				if (PageSwapCache(page) && !try_to_free_swap(page)) {
   685					unlock_page(page);
   686					continue;
   687				}
   688	
   689				ClearPageDirty(page);
   690				unlock_page(page);
   691			}
   692	
   693			if (pte_young(ptent) || pte_dirty(ptent)) {
   694				/*
   695				 * Some of architecture(ex, PPC) don't update TLB
   696				 * with set_pte_at and tlb_remove_tlb_entry so for
   697				 * the portability, remap the pte with old|clean
   698				 * after pte clearing.
   699				 */
   700				ptent = ptep_get_and_clear_full(mm, addr, pte,
   701								tlb->fullmm);
   702	
   703				ptent = pte_mkold(ptent);
   704				ptent = pte_mkclean(ptent);
   705				set_pte_at(mm, addr, pte, ptent);
   706				tlb_remove_tlb_entry(tlb, pte, addr);
   707			}
   708			mark_page_lazyfree(page);
   709		}
   710	out:
   711		if (nr_swap) {
   712			if (current->mm == mm)
   713				sync_mm_rss(mm);
   714	
   715			add_mm_counter(mm, MM_SWAPENTS, nr_swap);
   716		}
   717		arch_leave_lazy_mmu_mode();
   718		pte_unmap_unlock(orig_pte, ptl);
   719		cond_resched();
   720	next:
   721		return 0;
   722	}
   723	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
