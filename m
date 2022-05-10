Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA2A521604
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242040AbiEJM6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242264AbiEJM4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:56:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE8F2AD8
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652187160; x=1683723160;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bm2lo75Y8U82TesofbKiy9P6Lga824nihfJpemUvpXg=;
  b=aHIs8dwOY6EpJbA5A0SyRTfpbarrzivwuMDyJqFpV5eonAqlaVCikTjh
   uw0S2rSpwHbvI+tYqW0HyssYlEOzpZbq0iK20dj4rUSc8EqGP0y3pl5TA
   lYAz5WRv3M8eAqfi4hVESa0/mLg8Lzoji1VVv6eQQ8xGjkKgCEeASk1e6
   MZ3X3LJ6qniW6416Rpno6uIGiv6Vp7N6E7lSRAaJjnU361hK+1SX0iE9u
   8DD7TH3AFSPAdVnEQxlSUCvI6SuviXm5JD7tCweQ9PZleJUEugyncEStm
   lMvqTbg+mz00OYDGpbNmSVz9Io6FOO05va1b5N+ZAYSDvWJNt9n1aigTa
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="268203012"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="268203012"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 05:52:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="711005142"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 10 May 2022 05:52:38 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noPLy-000Hu2-3E;
        Tue, 10 May 2022 12:52:38 +0000
Date:   Tue, 10 May 2022 20:52:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [akpm-mm:mm-unstable 338/431] mm/nommu.c:579:2: error: call to
 undeclared function 'vma_mas_store'; ISO C99 and later do not support
 implicit function declarations
Message-ID: <202205102024.jnJMagOr-lkp@intel.com>
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
commit: a245f2ec995564195c1956813ff4fee7a894f099 [338/431] mm: remove rb tree.
config: arm-randconfig-r012-20220509 (https://download.01.org/0day-ci/archive/20220510/202205102024.jnJMagOr-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 18dd123c56754edf62c7042dcf23185c3727610f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=a245f2ec995564195c1956813ff4fee7a894f099
        git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
        git fetch --no-tags akpm-mm mm-unstable
        git checkout a245f2ec995564195c1956813ff4fee7a894f099
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> mm/nommu.c:579:2: error: call to undeclared function 'vma_mas_store'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           vma_mas_store(vma, &mas);
           ^
   mm/nommu.c:579:2: note: did you mean 'mas_store'?
   include/linux/maple_tree.h:454:7: note: 'mas_store' declared here
   void *mas_store(struct ma_state *mas, void *entry);
         ^
>> mm/nommu.c:615:2: error: call to undeclared function 'vma_mas_remove'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           vma_mas_remove(vma, &mas);
           ^
   2 errors generated.


vim +/vma_mas_store +579 mm/nommu.c

   547	
   548	/*
   549	 * add a VMA into a process's mm_struct in the appropriate place in the list
   550	 * and tree and add to the address space's page tree also if not an anonymous
   551	 * page
   552	 * - should be called with mm->mmap_lock held writelocked
   553	 */
   554	static void add_vma_to_mm(struct mm_struct *mm, struct vm_area_struct *vma)
   555	{
   556		struct address_space *mapping;
   557		struct vm_area_struct *prev;
   558		MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_end);
   559	
   560		BUG_ON(!vma->vm_region);
   561	
   562		mm->map_count++;
   563		vma->vm_mm = mm;
   564	
   565		/* add the VMA to the mapping */
   566		if (vma->vm_file) {
   567			mapping = vma->vm_file->f_mapping;
   568	
   569			i_mmap_lock_write(mapping);
   570			flush_dcache_mmap_lock(mapping);
   571			vma_interval_tree_insert(vma, &mapping->i_mmap);
   572			flush_dcache_mmap_unlock(mapping);
   573			i_mmap_unlock_write(mapping);
   574		}
   575	
   576		prev = mas_prev(&mas, 0);
   577		mas_reset(&mas);
   578		/* add the VMA to the tree */
 > 579		vma_mas_store(vma, &mas);
   580		__vma_link_list(mm, vma, prev);
   581	}
   582	
   583	/*
   584	 * delete a VMA from its owning mm_struct and address space
   585	 */
   586	static void delete_vma_from_mm(struct vm_area_struct *vma)
   587	{
   588		int i;
   589		struct address_space *mapping;
   590		struct mm_struct *mm = vma->vm_mm;
   591		struct task_struct *curr = current;
   592		MA_STATE(mas, &vma->vm_mm->mm_mt, 0, 0);
   593	
   594		mm->map_count--;
   595		for (i = 0; i < VMACACHE_SIZE; i++) {
   596			/* if the vma is cached, invalidate the entire cache */
   597			if (curr->vmacache.vmas[i] == vma) {
   598				vmacache_invalidate(mm);
   599				break;
   600			}
   601		}
   602	
   603		/* remove the VMA from the mapping */
   604		if (vma->vm_file) {
   605			mapping = vma->vm_file->f_mapping;
   606	
   607			i_mmap_lock_write(mapping);
   608			flush_dcache_mmap_lock(mapping);
   609			vma_interval_tree_remove(vma, &mapping->i_mmap);
   610			flush_dcache_mmap_unlock(mapping);
   611			i_mmap_unlock_write(mapping);
   612		}
   613	
   614		/* remove from the MM's tree and list */
 > 615		vma_mas_remove(vma, &mas);
   616		__vma_unlink_list(mm, vma);
   617	}
   618	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
