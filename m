Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7304C4D702E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 18:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbiCLRnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 12:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiCLRnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 12:43:53 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE771D8324
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 09:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647106960; x=1678642960;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cOMivJ1drDDQjTqvrPVb3NlhjefbU/l5/4UEkGRuYks=;
  b=MvXuE4Srq9kF52qloTpdfrenP9xl1rkVuQ5qbRZQaXjaYkbyQS02wNhF
   Ko3sosvycHGj75KCJSNyCGl5AWowc+G5vW2/wcJvlWPOYdXLGNjTwOiac
   W95BXaR9+m/8du4CFxXHfMHRZeyHHSy/nouhESoCU2VaDUI/dTfWd+OhO
   P8pZ96xgtSjfFFb32mUe8zUf8oNjtqzEsGJxPne6AOpme+SY7Gk/41Ovv
   dT5ydfJ2kmnw+hcmIrlL7H6XzJb1tZ80Xo/qgyuLDKvmcSArYbPzKI8Q4
   DqFpiU6oHEM0dMISGyPHNpy0U0C7GtaN9plNqPZLnYUmB//FagJhZbvFy
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="237980404"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="237980404"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 09:42:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="713235001"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 12 Mar 2022 09:42:37 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nT5lE-00087s-Uv; Sat, 12 Mar 2022 17:42:36 +0000
Date:   Sun, 13 Mar 2022 01:42:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-gs-raviole-5.10-android12-qpr1-d
 1694/8858] mm/memory.c:3303:13: sparse: sparse: incorrect type in assignment
 (different base types)
Message-ID: <202203130116.eeU6gTET-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-gs-raviole-5.10-android12-qpr1-d
head:   9771767708df4fcf51cd1642e041c804a86e740c
commit: 5835d87162afa8424c692a73a10ef5723dcc183b [1694/8858] FROMLIST: mm: make pte_unmap_same compatible with SPF
config: i386-randconfig-s001 (https://download.01.org/0day-ci/archive/20220313/202203130116.eeU6gTET-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/5835d87162afa8424c692a73a10ef5723dcc183b
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-gs-raviole-5.10-android12-qpr1-d
        git checkout 5835d87162afa8424c692a73a10ef5723dcc183b
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   mm/memory.c:2873:19: sparse: sparse: incorrect type in initializer (different base types) @@     expected int ret @@     got restricted vm_fault_t @@
   mm/memory.c:2873:19: sparse:     expected int ret
   mm/memory.c:2873:19: sparse:     got restricted vm_fault_t
   mm/memory.c:2918:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected int ret @@     got restricted vm_fault_t @@
   mm/memory.c:2918:21: sparse:     expected int ret
   mm/memory.c:2918:21: sparse:     got restricted vm_fault_t
   mm/memory.c:3012:16: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted vm_fault_t @@     got int ret @@
   mm/memory.c:3012:16: sparse:     expected restricted vm_fault_t
   mm/memory.c:3012:16: sparse:     got int ret
>> mm/memory.c:3303:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted vm_fault_t [usertype] ret @@     got int @@
   mm/memory.c:3303:13: sparse:     expected restricted vm_fault_t [usertype] ret
   mm/memory.c:3303:13: sparse:     got int
   mm/memory.c:5262:22: sparse: sparse: cast removes address space '__user' of expression
   mm/memory.c:957:17: sparse: sparse: context imbalance in 'copy_pte_range' - different lock contexts for basic block
   mm/memory.c:1637:16: sparse: sparse: context imbalance in '__get_locked_pte' - different lock contexts for basic block
   mm/memory.c:1686:9: sparse: sparse: context imbalance in 'insert_page' - different lock contexts for basic block
   mm/memory.c:2188:17: sparse: sparse: context imbalance in 'remap_pte_range' - different lock contexts for basic block
   mm/memory.c:2433:17: sparse: sparse: context imbalance in 'apply_to_pte_range' - unexpected unlock
   mm/memory.c:2712:9: sparse: sparse: context imbalance in 'wp_page_copy' - different lock contexts for basic block
   mm/memory.c:3060:17: sparse: sparse: context imbalance in 'wp_pfn_shared' - unexpected unlock
   mm/memory.c:3123:19: sparse: sparse: context imbalance in 'do_wp_page' - different lock contexts for basic block
   mm/memory.c:3719:19: sparse: sparse: context imbalance in 'pte_alloc_one_map' - different lock contexts for basic block
   mm/memory.c:3947:17: sparse: sparse: context imbalance in 'finish_fault' - unexpected unlock
   mm/memory.c:4056:9: sparse: sparse: context imbalance in 'do_fault_around' - unexpected unlock
   mm/memory.c:4775:12: sparse: sparse: context imbalance in '__follow_pte_pmd' - different lock contexts for basic block
   mm/memory.c:4861:16: sparse: sparse: context imbalance in 'follow_pte_pmd' - different lock contexts for basic block
   mm/memory.c:4921:9: sparse: sparse: context imbalance in 'follow_phys' - unexpected unlock

vim +3303 mm/memory.c

  3283	
  3284	/*
  3285	 * We enter with non-exclusive mmap_lock (to exclude vma changes,
  3286	 * but allow concurrent faults), and pte mapped but not yet locked.
  3287	 * We return with pte unmapped and unlocked.
  3288	 *
  3289	 * We return with the mmap_lock locked or unlocked in the same cases
  3290	 * as does filemap_fault().
  3291	 */
  3292	vm_fault_t do_swap_page(struct vm_fault *vmf)
  3293	{
  3294		struct vm_area_struct *vma = vmf->vma;
  3295		struct page *page = NULL, *swapcache;
  3296		swp_entry_t entry;
  3297		pte_t pte;
  3298		int locked;
  3299		int exclusive = 0;
  3300		vm_fault_t ret;
  3301		void *shadow = NULL;
  3302	
> 3303		ret = pte_unmap_same(vmf);
  3304		if (ret) {
  3305			/*
  3306			 * If pte != orig_pte, this means another thread did the
  3307			 * swap operation in our back.
  3308			 * So nothing else to do.
  3309			 */
  3310			if (ret == VM_FAULT_PTNOTSAME)
  3311				ret = 0;
  3312			goto out;
  3313		}
  3314	
  3315		entry = pte_to_swp_entry(vmf->orig_pte);
  3316		if (unlikely(non_swap_entry(entry))) {
  3317			if (is_migration_entry(entry)) {
  3318				migration_entry_wait(vma->vm_mm, vmf->pmd,
  3319						     vmf->address);
  3320			} else if (is_device_private_entry(entry)) {
  3321				vmf->page = device_private_entry_to_page(entry);
  3322				ret = vmf->page->pgmap->ops->migrate_to_ram(vmf);
  3323			} else if (is_hwpoison_entry(entry)) {
  3324				ret = VM_FAULT_HWPOISON;
  3325			} else {
  3326				print_bad_pte(vma, vmf->address, vmf->orig_pte, NULL);
  3327				ret = VM_FAULT_SIGBUS;
  3328			}
  3329			goto out;
  3330		}
  3331	
  3332	
  3333		delayacct_set_flag(DELAYACCT_PF_SWAPIN);
  3334		page = lookup_swap_cache(entry, vma, vmf->address);
  3335		swapcache = page;
  3336	
  3337		if (!page) {
  3338			struct swap_info_struct *si = swp_swap_info(entry);
  3339	
  3340			if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
  3341			    __swap_count(entry) == 1) {
  3342				/* skip swapcache */
  3343				gfp_t flags = GFP_HIGHUSER_MOVABLE;
  3344	
  3345				trace_android_rvh_set_skip_swapcache_flags(&flags);
  3346				page = alloc_page_vma(flags, vma, vmf->address);
  3347				if (page) {
  3348					int err;
  3349	
  3350					__SetPageLocked(page);
  3351					__SetPageSwapBacked(page);
  3352					set_page_private(page, entry.val);
  3353	
  3354					/* Tell memcg to use swap ownership records */
  3355					SetPageSwapCache(page);
  3356					err = mem_cgroup_charge(page, vma->vm_mm,
  3357								GFP_KERNEL);
  3358					ClearPageSwapCache(page);
  3359					if (err) {
  3360						ret = VM_FAULT_OOM;
  3361						goto out_page;
  3362					}
  3363	
  3364					shadow = get_shadow_from_swap_cache(entry);
  3365					if (shadow)
  3366						workingset_refault(page, shadow);
  3367	
  3368					lru_cache_add(page);
  3369					swap_readpage(page, true);
  3370				}
  3371			} else {
  3372				page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
  3373							vmf);
  3374				swapcache = page;
  3375			}
  3376	
  3377			if (!page) {
  3378				/*
  3379				 * Back out if the VMA has changed in our back during
  3380				 * a speculative page fault or if somebody else
  3381				 * faulted in this pte while we released the pte lock.
  3382				 */
  3383				if (!pte_map_lock(vmf)) {
  3384					delayacct_clear_flag(DELAYACCT_PF_SWAPIN);
  3385					ret = VM_FAULT_RETRY;
  3386					goto out;
  3387				}
  3388	
  3389				if (likely(pte_same(*vmf->pte, vmf->orig_pte)))
  3390					ret = VM_FAULT_OOM;
  3391				delayacct_clear_flag(DELAYACCT_PF_SWAPIN);
  3392				goto unlock;
  3393			}
  3394	
  3395			/* Had to read the page from swap area: Major fault */
  3396			ret = VM_FAULT_MAJOR;
  3397			count_vm_event(PGMAJFAULT);
  3398			count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
  3399		} else if (PageHWPoison(page)) {
  3400			/*
  3401			 * hwpoisoned dirty swapcache pages are kept for killing
  3402			 * owner processes (which may be unknown at hwpoison time)
  3403			 */
  3404			ret = VM_FAULT_HWPOISON;
  3405			delayacct_clear_flag(DELAYACCT_PF_SWAPIN);
  3406			goto out_release;
  3407		}
  3408	
  3409		locked = lock_page_or_retry(page, vma->vm_mm, vmf->flags);
  3410	
  3411		delayacct_clear_flag(DELAYACCT_PF_SWAPIN);
  3412		if (!locked) {
  3413			ret |= VM_FAULT_RETRY;
  3414			goto out_release;
  3415		}
  3416	
  3417		/*
  3418		 * Make sure try_to_free_swap or reuse_swap_page or swapoff did not
  3419		 * release the swapcache from under us.  The page pin, and pte_same
  3420		 * test below, are not enough to exclude that.  Even if it is still
  3421		 * swapcache, we need to check that the page's swap has not changed.
  3422		 */
  3423		if (unlikely((!PageSwapCache(page) ||
  3424				page_private(page) != entry.val)) && swapcache)
  3425			goto out_page;
  3426	
  3427		page = ksm_might_need_to_copy(page, vma, vmf->address);
  3428		if (unlikely(!page)) {
  3429			ret = VM_FAULT_OOM;
  3430			page = swapcache;
  3431			goto out_page;
  3432		}
  3433	
  3434		cgroup_throttle_swaprate(page, GFP_KERNEL);
  3435	
  3436		/*
  3437		 * Back out if the VMA has changed in our back during a speculative
  3438		 * page fault or if somebody else already faulted in this pte.
  3439		 */
  3440		if (!pte_map_lock(vmf)) {
  3441			ret = VM_FAULT_RETRY;
  3442			goto out_page;
  3443		}
  3444		if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte)))
  3445			goto out_nomap;
  3446	
  3447		if (unlikely(!PageUptodate(page))) {
  3448			ret = VM_FAULT_SIGBUS;
  3449			goto out_nomap;
  3450		}
  3451	
  3452		/*
  3453		 * The page isn't present yet, go ahead with the fault.
  3454		 *
  3455		 * Be careful about the sequence of operations here.
  3456		 * To get its accounting right, reuse_swap_page() must be called
  3457		 * while the page is counted on swap but not yet in mapcount i.e.
  3458		 * before page_add_anon_rmap() and swap_free(); try_to_free_swap()
  3459		 * must be called after the swap_free(), or it will never succeed.
  3460		 */
  3461	
  3462		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
  3463		dec_mm_counter_fast(vma->vm_mm, MM_SWAPENTS);
  3464		pte = mk_pte(page, vma->vm_page_prot);
  3465		if ((vmf->flags & FAULT_FLAG_WRITE) && reuse_swap_page(page, NULL)) {
  3466			pte = maybe_mkwrite(pte_mkdirty(pte), vma);
  3467			vmf->flags &= ~FAULT_FLAG_WRITE;
  3468			ret |= VM_FAULT_WRITE;
  3469			exclusive = RMAP_EXCLUSIVE;
  3470		}
  3471		flush_icache_page(vma, page);
  3472		if (pte_swp_soft_dirty(vmf->orig_pte))
  3473			pte = pte_mksoft_dirty(pte);
  3474		if (pte_swp_uffd_wp(vmf->orig_pte)) {
  3475			pte = pte_mkuffd_wp(pte);
  3476			pte = pte_wrprotect(pte);
  3477		}
  3478		set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
  3479		arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
  3480		vmf->orig_pte = pte;
  3481	
  3482		/* ksm created a completely new copy */
  3483		if (unlikely(page != swapcache && swapcache)) {
  3484			page_add_new_anon_rmap(page, vma, vmf->address, false);
  3485			lru_cache_add_inactive_or_unevictable(page, vma);
  3486		} else {
  3487			do_page_add_anon_rmap(page, vma, vmf->address, exclusive);
  3488		}
  3489	
  3490		swap_free(entry);
  3491		if (mem_cgroup_swap_full(page) ||
  3492		    (vma->vm_flags & VM_LOCKED) || PageMlocked(page))
  3493			try_to_free_swap(page);
  3494		unlock_page(page);
  3495		if (page != swapcache && swapcache) {
  3496			/*
  3497			 * Hold the lock to avoid the swap entry to be reused
  3498			 * until we take the PT lock for the pte_same() check
  3499			 * (to avoid false positives from pte_same). For
  3500			 * further safety release the lock after the swap_free
  3501			 * so that the swap count won't change under a
  3502			 * parallel locked swapcache.
  3503			 */
  3504			unlock_page(swapcache);
  3505			put_page(swapcache);
  3506		}
  3507	
  3508		if (vmf->flags & FAULT_FLAG_WRITE) {
  3509			ret |= do_wp_page(vmf);
  3510			if (ret & VM_FAULT_ERROR)
  3511				ret &= VM_FAULT_ERROR;
  3512			goto out;
  3513		}
  3514	
  3515		/* No need to invalidate - it was non-present before */
  3516		update_mmu_cache(vma, vmf->address, vmf->pte);
  3517	unlock:
  3518		pte_unmap_unlock(vmf->pte, vmf->ptl);
  3519	out:
  3520		return ret;
  3521	out_nomap:
  3522		pte_unmap_unlock(vmf->pte, vmf->ptl);
  3523	out_page:
  3524		unlock_page(page);
  3525	out_release:
  3526		put_page(page);
  3527		if (page != swapcache && swapcache) {
  3528			unlock_page(swapcache);
  3529			put_page(swapcache);
  3530		}
  3531		return ret;
  3532	}
  3533	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
