Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39494D2811
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 06:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiCIFI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 00:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiCIFIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 00:08:55 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070F9637D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 21:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646802475; x=1678338475;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jD8qpVUFnShFh8snyKRJ/SUwDifn2tQekvrmipzgOJI=;
  b=fNBCVOp9RIkZQVEAlG5Qb4XOS3O9XTkSFRc469MBhRR96Uz7zGP9lSFU
   y1aHiPPtAXd3LyZ9MfjmAHNH51ymABCREB0SA3m/9SLwVMeyYJhBZjTW8
   CYRv2Zge0i3+5SaPxaLF0t0F6cfnwI+WBATHObpGb+O5o2RTLx2YN9tKU
   agggFj5R5EqBtQ/XZ7ajfJgy1S3hRBH+h/6OW3sm60ARpKCVOzZbpoWEy
   7XbXQudl9i/GKSVyOF8w2gFys5gIKYX5/Z+7wC5LfKG8PtOeCu+sIkS/O
   MfPv9GYALcJXSc/GSl1VRr3mo6bg5flB2LUtVcu81Q+X/9pD+jvGdWDDp
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="315605801"
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="315605801"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 21:07:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="711805326"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 08 Mar 2022 21:07:52 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRoYB-0002ct-Es; Wed, 09 Mar 2022 05:07:51 +0000
Date:   Wed, 9 Mar 2022 13:07:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: mm/memory.c:709:25: sparse: sparse: cast to non-scalar
Message-ID: <202203091301.CQlNi3CF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   330f4c53d3c2d8b11d86ec03a964b86dc81452f5
commit: b756a3b5e7ead8f6f4b03cea8ac22478ce04c8a8 mm: device exclusive memory access
date:   8 months ago
config: alpha-randconfig-s031-20220308 (https://download.01.org/0day-ci/archive/20220309/202203091301.CQlNi3CF-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b756a3b5e7ead8f6f4b03cea8ac22478ce04c8a8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b756a3b5e7ead8f6f4b03cea8ac22478ce04c8a8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> mm/memory.c:709:25: sparse: sparse: cast to non-scalar
>> mm/memory.c:709:25: sparse: sparse: cast from non-scalar
   mm/memory.c:1023:17: sparse: sparse: context imbalance in 'copy_pte_range' - different lock contexts for basic block
   mm/memory.c:1736:16: sparse: sparse: context imbalance in '__get_locked_pte' - different lock contexts for basic block
   mm/memory.c:1785:9: sparse: sparse: context imbalance in 'insert_page' - different lock contexts for basic block
   mm/memory.c:2287:17: sparse: sparse: context imbalance in 'remap_pte_range' - different lock contexts for basic block
   mm/memory.c:2543:17: sparse: sparse: context imbalance in 'apply_to_pte_range' - unexpected unlock
   mm/memory.c:2831:17: sparse: sparse: context imbalance in 'wp_page_copy' - unexpected unlock
   mm/memory.c:3180:17: sparse: sparse: context imbalance in 'wp_pfn_shared' - unexpected unlock
   mm/memory.c:3243:19: sparse: sparse: context imbalance in 'do_wp_page' - different lock contexts for basic block
   mm/memory.c: note: in included file (through include/linux/mm.h, arch/alpha/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
   include/linux/pgtable.h:275:16: sparse: sparse: cast to non-scalar
   include/linux/pgtable.h:275:16: sparse: sparse: cast from non-scalar
   mm/memory.c:4874:5: sparse: sparse: context imbalance in 'follow_invalidate_pte' - different lock contexts for basic block
   mm/memory.c:4995:9: sparse: sparse: context imbalance in 'follow_pfn' - unexpected unlock

vim +709 mm/memory.c

   701	
   702	static void restore_exclusive_pte(struct vm_area_struct *vma,
   703					  struct page *page, unsigned long address,
   704					  pte_t *ptep)
   705	{
   706		pte_t pte;
   707		swp_entry_t entry;
   708	
 > 709		pte = pte_mkold(mk_pte(page, READ_ONCE(vma->vm_page_prot)));
   710		if (pte_swp_soft_dirty(*ptep))
   711			pte = pte_mksoft_dirty(pte);
   712	
   713		entry = pte_to_swp_entry(*ptep);
   714		if (pte_swp_uffd_wp(*ptep))
   715			pte = pte_mkuffd_wp(pte);
   716		else if (is_writable_device_exclusive_entry(entry))
   717			pte = maybe_mkwrite(pte_mkdirty(pte), vma);
   718	
   719		set_pte_at(vma->vm_mm, address, ptep, pte);
   720	
   721		/*
   722		 * No need to take a page reference as one was already
   723		 * created when the swap entry was made.
   724		 */
   725		if (PageAnon(page))
   726			page_add_anon_rmap(page, vma, address, false);
   727		else
   728			/*
   729			 * Currently device exclusive access only supports anonymous
   730			 * memory so the entry shouldn't point to a filebacked page.
   731			 */
   732			WARN_ON_ONCE(!PageAnon(page));
   733	
   734		if (vma->vm_flags & VM_LOCKED)
   735			mlock_vma_page(page);
   736	
   737		/*
   738		 * No need to invalidate - it was non-present before. However
   739		 * secondary CPUs may have mappings that need invalidating.
   740		 */
   741		update_mmu_cache(vma, address, ptep);
   742	}
   743	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
