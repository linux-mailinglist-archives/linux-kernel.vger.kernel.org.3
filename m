Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FF8512D52
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245736AbiD1Hvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234235AbiD1Hvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:51:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077319D4E1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:48:27 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KpnlQ27X0zfbF6;
        Thu, 28 Apr 2022 15:47:30 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 15:48:25 +0800
Subject: Re: [hnaz-mm:master 214/410] mm/madvise.c:632:8: error: call to
 undeclared function 'is_swapin_error_entry'; ISO C99 and later do not support
 implicit function declarations
To:     kernel test robot <lkp@intel.com>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <202204281452.cEOGcf4p-lkp@intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b45ac0cd-ba02-c5ab-a91b-1289a7c05120@huawei.com>
Date:   Thu, 28 Apr 2022 15:48:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <202204281452.cEOGcf4p-lkp@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/28 14:54, kernel test robot wrote:
> tree:   https://github.com/hnaz/linux-mm master
> head:   bf4803abaa3e9d2fa207c0675a2d2abf0fd44f66
> commit: fe343091405131f91dcb9230ae7649bb1ee7fe9a [214/410] mm/madvise: free hwpoison and swapin error entry in madvise_free_pte_range
> config: i386-randconfig-a005-20220425 (https://download.01.org/0day-ci/archive/20220428/202204281452.cEOGcf4p-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/hnaz/linux-mm/commit/fe343091405131f91dcb9230ae7649bb1ee7fe9a
>         git remote add hnaz-mm https://github.com/hnaz/linux-mm
>         git fetch --no-tags hnaz-mm master
>         git checkout fe343091405131f91dcb9230ae7649bb1ee7fe9a
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> Note: the hnaz-mm/master HEAD bf4803abaa3e9d2fa207c0675a2d2abf0fd44f66 builds fine.
>       It only hurts bisectability.
> 
> All errors (new ones prefixed by >>):
> 
>>> mm/madvise.c:632:8: error: call to undeclared function 'is_swapin_error_entry'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>                                       is_swapin_error_entry(entry)) {
>                                       ^
>    1 error generated.

I browsed the config file and found that CONFIG_SWAP is not set. But when I test it on my env, it works.
And I'm somewhat confused now:

is_swapin_error_entry and pte_to_swp_entry are both defined in include/linux/swapops.h. But pte_to_swp_entry
can be used normally but is_swapin_error_entry breaks the compile.

Will take a more close look later. Thanks for report!

> 
> 
> vim +/is_swapin_error_entry +632 mm/madvise.c
> 
>    587	
>    588	static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>    589					unsigned long end, struct mm_walk *walk)
>    590	
>    591	{
>    592		struct mmu_gather *tlb = walk->private;
>    593		struct mm_struct *mm = tlb->mm;
>    594		struct vm_area_struct *vma = walk->vma;
>    595		spinlock_t *ptl;
>    596		pte_t *orig_pte, *pte, ptent;
>    597		struct page *page;
>    598		int nr_swap = 0;
>    599		unsigned long next;
>    600	
>    601		next = pmd_addr_end(addr, end);
>    602		if (pmd_trans_huge(*pmd))
>    603			if (madvise_free_huge_pmd(tlb, vma, pmd, addr, next))
>    604				goto next;
>    605	
>    606		if (pmd_trans_unstable(pmd))
>    607			return 0;
>    608	
>    609		tlb_change_page_size(tlb, PAGE_SIZE);
>    610		orig_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
>    611		flush_tlb_batched_pending(mm);
>    612		arch_enter_lazy_mmu_mode();
>    613		for (; addr != end; pte++, addr += PAGE_SIZE) {
>    614			ptent = *pte;
>    615	
>    616			if (pte_none(ptent))
>    617				continue;
>    618			/*
>    619			 * If the pte has swp_entry, just clear page table to
>    620			 * prevent swap-in which is more expensive rather than
>    621			 * (page allocation + zeroing).
>    622			 */
>    623			if (!pte_present(ptent)) {
>    624				swp_entry_t entry;
>    625	
>    626				entry = pte_to_swp_entry(ptent);
>    627				if (!non_swap_entry(entry)) {
>    628					nr_swap--;
>    629					free_swap_and_cache(entry);
>    630					pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
>    631				} else if (is_hwpoison_entry(entry) ||
>  > 632					   is_swapin_error_entry(entry)) {
>    633					pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
>    634				}
>    635				continue;
>    636			}
>    637	
>    638			page = vm_normal_page(vma, addr, ptent);
>    639			if (!page)
>    640				continue;
>    641	
>    642			/*
>    643			 * If pmd isn't transhuge but the page is THP and
>    644			 * is owned by only this process, split it and
>    645			 * deactivate all pages.
>    646			 */
>    647			if (PageTransCompound(page)) {
>    648				if (page_mapcount(page) != 1)
>    649					goto out;
>    650				get_page(page);
>    651				if (!trylock_page(page)) {
>    652					put_page(page);
>    653					goto out;
>    654				}
>    655				pte_unmap_unlock(orig_pte, ptl);
>    656				if (split_huge_page(page)) {
>    657					unlock_page(page);
>    658					put_page(page);
>    659					orig_pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
>    660					goto out;
>    661				}
>    662				unlock_page(page);
>    663				put_page(page);
>    664				orig_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
>    665				pte--;
>    666				addr -= PAGE_SIZE;
>    667				continue;
>    668			}
>    669	
>    670			VM_BUG_ON_PAGE(PageTransCompound(page), page);
>    671	
>    672			if (PageSwapCache(page) || PageDirty(page)) {
>    673				if (!trylock_page(page))
>    674					continue;
>    675				/*
>    676				 * If page is shared with others, we couldn't clear
>    677				 * PG_dirty of the page.
>    678				 */
>    679				if (page_mapcount(page) != 1) {
>    680					unlock_page(page);
>    681					continue;
>    682				}
>    683	
>    684				if (PageSwapCache(page) && !try_to_free_swap(page)) {
>    685					unlock_page(page);
>    686					continue;
>    687				}
>    688	
>    689				ClearPageDirty(page);
>    690				unlock_page(page);
>    691			}
>    692	
>    693			if (pte_young(ptent) || pte_dirty(ptent)) {
>    694				/*
>    695				 * Some of architecture(ex, PPC) don't update TLB
>    696				 * with set_pte_at and tlb_remove_tlb_entry so for
>    697				 * the portability, remap the pte with old|clean
>    698				 * after pte clearing.
>    699				 */
>    700				ptent = ptep_get_and_clear_full(mm, addr, pte,
>    701								tlb->fullmm);
>    702	
>    703				ptent = pte_mkold(ptent);
>    704				ptent = pte_mkclean(ptent);
>    705				set_pte_at(mm, addr, pte, ptent);
>    706				tlb_remove_tlb_entry(tlb, pte, addr);
>    707			}
>    708			mark_page_lazyfree(page);
>    709		}
>    710	out:
>    711		if (nr_swap) {
>    712			if (current->mm == mm)
>    713				sync_mm_rss(mm);
>    714	
>    715			add_mm_counter(mm, MM_SWAPENTS, nr_swap);
>    716		}
>    717		arch_leave_lazy_mmu_mode();
>    718		pte_unmap_unlock(orig_pte, ptl);
>    719		cond_resched();
>    720	next:
>    721		return 0;
>    722	}
>    723	
> 

