Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1B04B8BE8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 15:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbiBPO75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 09:59:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiBPO7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 09:59:55 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23131CA710
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 06:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645023582; x=1676559582;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6ywupRWlNjaUc9i0M28oV/XlRiEK0fEzU19gStShp18=;
  b=lxpuAHxHKyhSsVoxhFMiXOvP3yJ5HfTGw0RaoQCldRUNgvqgZoAliJYx
   VClPZ0HC7Esw7TPvkaexQHpQg2L0J7A98USWwjV+5XH7lYyT0HPnyPdVz
   5ytnLWxwsf9ggn1RTaPKm7EtQSOkWpRLJEHvqA7r/t9Xh2epzOvZ0O6tF
   zvjg8JM80j+Kyydpuygx5Av/wtgCuShVxfjenBlU/xHAvR0J1Im1sx+PY
   iz2+O9OZ2gWp3t9bhvRyVtew5FZuKNGOviVltKIVjGoTJaG8HhiAvY6Ib
   4EBvcE5K0vzTD5xjD+v1N/k1Pp5Ox0qZzkprT8cDRHPowyg/GJ+SerPB+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="234156414"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="234156414"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 06:59:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="774076094"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 16 Feb 2022 06:59:40 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKLmN-000Asp-Mh; Wed, 16 Feb 2022 14:59:39 +0000
Date:   Wed, 16 Feb 2022 22:59:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oded Gabbay <ogabbay@habana.ai>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ogabbay:numa_debug_5.17 4/4] mm/memory.c:3319:7: error: too many
 arguments to function 'reuse_swap_page'
Message-ID: <202202162225.nfqEMkRv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git numa_debug_5.17
head:   fe86c77005a1cce384156fe165c7a6df42c6bc92
commit: fe86c77005a1cce384156fe165c7a6df42c6bc92 [4/4] Revert "mm: do_wp_page() simplification"
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220216/202202162225.nfqEMkRv-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/commit/?id=fe86c77005a1cce384156fe165c7a6df42c6bc92
        git remote add ogabbay https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
        git fetch --no-tags ogabbay numa_debug_5.17
        git checkout fe86c77005a1cce384156fe165c7a6df42c6bc92
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/memory.c: In function 'do_wp_page':
>> mm/memory.c:3319:7: error: too many arguments to function 'reuse_swap_page'
    3319 |   if (reuse_swap_page(vmf->page, &total_map_swapcount)) {
         |       ^~~~~~~~~~~~~~~
   In file included from include/linux/mm_inline.h:7,
                    from mm/memory.c:44:
   include/linux/swap.h:517:13: note: declared here
     517 | extern bool reuse_swap_page(struct page *);
         |             ^~~~~~~~~~~~~~~


vim +/reuse_swap_page +3319 mm/memory.c

  3232	
  3233	/*
  3234	 * This routine handles present pages, when users try to write
  3235	 * to a shared page. It is done by copying the page to a new address
  3236	 * and decrementing the shared-page counter for the old page.
  3237	 *
  3238	 * Note that this routine assumes that the protection checks have been
  3239	 * done by the caller (the low-level page fault routine in most cases).
  3240	 * Thus we can safely just mark it writable once we've done any necessary
  3241	 * COW.
  3242	 *
  3243	 * We also mark the page dirty at this point even though the page will
  3244	 * change only once the write actually happens. This avoids a few races,
  3245	 * and potentially makes it more efficient.
  3246	 *
  3247	 * We enter with non-exclusive mmap_lock (to exclude vma changes,
  3248	 * but allow concurrent faults), with pte both mapped and locked.
  3249	 * We return with mmap_lock still held, but pte unmapped and unlocked.
  3250	 */
  3251	static vm_fault_t do_wp_page(struct vm_fault *vmf)
  3252		__releases(vmf->ptl)
  3253	{
  3254		struct vm_area_struct *vma = vmf->vma;
  3255	
  3256		if (userfaultfd_pte_wp(vma, *vmf->pte)) {
  3257			pte_unmap_unlock(vmf->pte, vmf->ptl);
  3258			return handle_userfault(vmf, VM_UFFD_WP);
  3259		}
  3260	
  3261		/*
  3262		 * Userfaultfd write-protect can defer flushes. Ensure the TLB
  3263		 * is flushed in this case before copying.
  3264		 */
  3265		if (unlikely(userfaultfd_wp(vmf->vma) &&
  3266			     mm_tlb_flush_pending(vmf->vma->vm_mm)))
  3267			flush_tlb_page(vmf->vma, vmf->address);
  3268	
  3269		vmf->page = vm_normal_page(vma, vmf->address, vmf->orig_pte);
  3270		if (!vmf->page) {
  3271			/*
  3272			 * VM_MIXEDMAP !pfn_valid() case, or VM_SOFTDIRTY clear on a
  3273			 * VM_PFNMAP VMA.
  3274			 *
  3275			 * We should not cow pages in a shared writeable mapping.
  3276			 * Just mark the pages writable and/or call ops->pfn_mkwrite.
  3277			 */
  3278			if ((vma->vm_flags & (VM_WRITE|VM_SHARED)) ==
  3279					     (VM_WRITE|VM_SHARED))
  3280				return wp_pfn_shared(vmf);
  3281	
  3282			pte_unmap_unlock(vmf->pte, vmf->ptl);
  3283			return wp_page_copy(vmf);
  3284		}
  3285	
  3286		/*
  3287		 * Take out anonymous pages first, anonymous shared vmas are
  3288		 * not dirty accountable.
  3289		 */
  3290		if (PageAnon(vmf->page)) {
  3291			int total_map_swapcount;
  3292			if (PageKsm(vmf->page) && (PageSwapCache(vmf->page) ||
  3293						   page_count(vmf->page) != 1))
  3294				goto copy;
  3295			if (!trylock_page(vmf->page)) {
  3296				get_page(vmf->page);
  3297				pte_unmap_unlock(vmf->pte, vmf->ptl);
  3298				lock_page(vmf->page);
  3299				vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
  3300						vmf->address, &vmf->ptl);
  3301				if (!pte_same(*vmf->pte, vmf->orig_pte)) {
  3302					update_mmu_tlb(vma, vmf->address, vmf->pte);
  3303					unlock_page(vmf->page);
  3304					pte_unmap_unlock(vmf->pte, vmf->ptl);
  3305					put_page(vmf->page);
  3306					return 0;
  3307				}
  3308				put_page(vmf->page);
  3309			}
  3310			if (PageKsm(vmf->page)) {
  3311				bool reused = reuse_ksm_page(vmf->page, vmf->vma,
  3312							     vmf->address);
  3313				unlock_page(vmf->page);
  3314				if (!reused)
  3315					goto copy;
  3316				wp_page_reuse(vmf);
  3317				return VM_FAULT_WRITE;
  3318			}
> 3319			if (reuse_swap_page(vmf->page, &total_map_swapcount)) {
  3320				if (total_map_swapcount == 1) {
  3321					/*
  3322					 * The page is all ours. Move it to
  3323					 * our anon_vma so the rmap code will
  3324					 * not search our parent or siblings.
  3325					 * Protected against the rmap code by
  3326					 * the page lock.
  3327					 */
  3328					page_move_anon_rmap(vmf->page, vma);
  3329				}
  3330				unlock_page(vmf->page);
  3331				wp_page_reuse(vmf);
  3332				return VM_FAULT_WRITE;
  3333			}
  3334			unlock_page(vmf->page);
  3335		} else if (unlikely((vma->vm_flags & (VM_WRITE|VM_SHARED)) ==
  3336						(VM_WRITE|VM_SHARED))) {
  3337			return wp_page_shared(vmf);
  3338		}
  3339	copy:
  3340		/*
  3341		 * Ok, we need to copy. Oh, well..
  3342		 */
  3343		get_page(vmf->page);
  3344	
  3345		pte_unmap_unlock(vmf->pte, vmf->ptl);
  3346		return wp_page_copy(vmf);
  3347	}
  3348	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
