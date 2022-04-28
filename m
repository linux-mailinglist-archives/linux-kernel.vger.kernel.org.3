Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4ABF512C0F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244638AbiD1G6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbiD1G62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:58:28 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4581CB86A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651128914; x=1682664914;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GkXzFjSl4GwWQShXem59TPCXJDcVdFutR1uAC1+s/7w=;
  b=b28dpmDhh9sjZB1WklqhZG63ZiWem1pDInVwedmdHAKhF581mX1rH5yN
   tnJoyjwU9gxHaeAZelfEYWErYWceC554MHPYOas3/soyS0DNSoW84ffot
   bgtIXDozETFO/hqTuga/VxvUbaiCEDJ6S0t4JdmnS4MY7hmRgZ2soKseS
   cngjAPcDOWAlfTb+40GR+Lt26rM/47JW5E3t22qSphRDSJP4vFWKvLvL4
   OG2mKcC3/mRdJsp4iaVEElijBaObUbIvHdfhaVlGVdeQt3L4/xY4M1GYj
   0EFwfyYY0c8OftSOk5d0x2XTp/uO2Ad7ysmNC5aoR0O2cH6WrT2k7Q4ZU
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="352615366"
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="352615366"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 23:55:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="731247367"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 Apr 2022 23:55:11 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njy3S-00058w-NF;
        Thu, 28 Apr 2022 06:55:10 +0000
Date:   Thu, 28 Apr 2022 14:54:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [hnaz-mm:master 214/410] mm/madvise.c:632:8: error: call to
 undeclared function 'is_swapin_error_entry'; ISO C99 and later do not
 support implicit function declarations
Message-ID: <202204281452.cEOGcf4p-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/hnaz/linux-mm master
head:   bf4803abaa3e9d2fa207c0675a2d2abf0fd44f66
commit: fe343091405131f91dcb9230ae7649bb1ee7fe9a [214/410] mm/madvise: free hwpoison and swapin error entry in madvise_free_pte_range
config: i386-randconfig-a005-20220425 (https://download.01.org/0day-ci/archive/20220428/202204281452.cEOGcf4p-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/hnaz/linux-mm/commit/fe343091405131f91dcb9230ae7649bb1ee7fe9a
        git remote add hnaz-mm https://github.com/hnaz/linux-mm
        git fetch --no-tags hnaz-mm master
        git checkout fe343091405131f91dcb9230ae7649bb1ee7fe9a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the hnaz-mm/master HEAD bf4803abaa3e9d2fa207c0675a2d2abf0fd44f66 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

>> mm/madvise.c:632:8: error: call to undeclared function 'is_swapin_error_entry'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                                      is_swapin_error_entry(entry)) {
                                      ^
   1 error generated.


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
