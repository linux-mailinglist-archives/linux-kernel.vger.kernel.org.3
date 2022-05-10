Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056325214E7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241170AbiEJMPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241614AbiEJMPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:15:35 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD1648E7F
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652184695; x=1683720695;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E/TFehv0OkaLWOhOeQNecvQSz23ncBE00f881JB4CQU=;
  b=S4Mojftg3lhpT+735tsLZis7cKuHDPQTO3brz8jrUxELnx0z32Gp9drS
   O6Dh/VmWfoJqLArlue5y5qfhQ3JL+OfbovC1tVya+UO/2YatlzNu2rI3b
   qCXXBCO/NpnuDLHk1EQNTGoJDyOvRDvgOAE5y1QVa6xzMij5ujVKs72k1
   hj+MswZWWhDuHsSmKaAkpxbRmNqBQvSGIwquEcUs+IZNBJY2Ig+N2Mm1F
   cwpY2BcqN1SVLOGMLURtq8DG0sy4DTfZ+hP94PdCbjRpiRCtkc/2lqVom
   XDcL3iAVY75Q3te59eBaKkG4psRu7YsVrT+ssFp1lnsMzySwP93JMkAjv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="269017803"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="269017803"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 05:11:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="710990070"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 10 May 2022 05:11:32 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noOiC-000HrL-2e;
        Tue, 10 May 2022 12:11:32 +0000
Date:   Tue, 10 May 2022 20:11:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [akpm-mm:mm-unstable 338/431] mm/nommu.c:579:9: error: implicit
 declaration of function 'vma_mas_store'; did you mean 'mas_store'?
Message-ID: <202205102017.SiSV7Y9l-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
head:   584a50635cc1deee2eeab5a17dfdcf9db7add21b
commit: a245f2ec995564195c1956813ff4fee7a894f099 [338/431] mm: remove rb tree.
config: m68k-randconfig-r006-20220509 (https://download.01.org/0day-ci/archive/20220510/202205102017.SiSV7Y9l-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=a245f2ec995564195c1956813ff4fee7a894f099
        git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
        git fetch --no-tags akpm-mm mm-unstable
        git checkout a245f2ec995564195c1956813ff4fee7a894f099
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/nommu.c: In function 'add_vma_to_mm':
>> mm/nommu.c:579:9: error: implicit declaration of function 'vma_mas_store'; did you mean 'mas_store'? [-Werror=implicit-function-declaration]
     579 |         vma_mas_store(vma, &mas);
         |         ^~~~~~~~~~~~~
         |         mas_store
   mm/nommu.c: In function 'delete_vma_from_mm':
>> mm/nommu.c:615:9: error: implicit declaration of function 'vma_mas_remove' [-Werror=implicit-function-declaration]
     615 |         vma_mas_remove(vma, &mas);
         |         ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +579 mm/nommu.c

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
