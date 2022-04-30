Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C8B515A38
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 06:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382168AbiD3EEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 00:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240704AbiD3EED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 00:04:03 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701A0192AD
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 21:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651291240; x=1682827240;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nR+dZwu2gebj05i1MvX1ezTnk9f63umTXm3Bwbuagts=;
  b=J7Qut4tNBDDxN0Hjr8zUMuwFm4G4zHFk4nkmDLTT3IIzRROivNFZd4xb
   oxhW/TSgMAuYp6/A08PdDM7ssaFKZPWrrXQMPI6XDR07KxD8fPXYhn946
   z8HrmfbcEp+c+7EU1RCGb+vBSDfAlVTSZ8E/xixAfNMwgvlyzEzOB0luu
   6tZit2rPKOO4v+7MhD35RM4fJtDBNC76pE7iiwXvS/DBz+FjlN3gQ+gSi
   VM83NjXK+9JBp1nlY8p6jeWQMKBtEY+eRE597lm4QkYRJBSMO1a/oHrOW
   awdjVHZbMgMLmdnwUWs7WgnqKBDGfVYN7EKKBbi+sscgACsA6x3pegawz
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="266378535"
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="266378535"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 21:00:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="582572538"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 29 Apr 2022 21:00:33 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkeHY-0006r5-KY;
        Sat, 30 Apr 2022 04:00:32 +0000
Date:   Sat, 30 Apr 2022 12:00:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [hnaz-mm:master 214/410] mm/madvise.c:632:36: error: implicit
 declaration of function 'is_swapin_error_entry'
Message-ID: <202204301111.d0R5xzHF-lkp@intel.com>
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

tree:   https://github.com/hnaz/linux-mm master
head:   bf4803abaa3e9d2fa207c0675a2d2abf0fd44f66
commit: fe343091405131f91dcb9230ae7649bb1ee7fe9a [214/410] mm/madvise: free hwpoison and swapin error entry in madvise_free_pte_range
config: x86_64-rhel-8.3-func (https://download.01.org/0day-ci/archive/20220430/202204301111.d0R5xzHF-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/hnaz/linux-mm/commit/fe343091405131f91dcb9230ae7649bb1ee7fe9a
        git remote add hnaz-mm https://github.com/hnaz/linux-mm
        git fetch --no-tags hnaz-mm master
        git checkout fe343091405131f91dcb9230ae7649bb1ee7fe9a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the hnaz-mm/master HEAD bf4803abaa3e9d2fa207c0675a2d2abf0fd44f66 builds fine.
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
