Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0204B48C7C0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 16:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354880AbiALP7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 10:59:11 -0500
Received: from mga09.intel.com ([134.134.136.24]:33174 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243611AbiALP7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 10:59:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642003150; x=1673539150;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2h9kGZ6Ec4GeM31EL2xlZEdWmBPcDTkaLVd1B02B9gw=;
  b=axoWClXvOEMmFdhxF9idwqQMI3pxFbccwFieJc2RZ1x5jNVpJZH9IkNe
   j8T1j462WhUFOp24ePLv0JbThaemjq+fTUuJWEo/6wUQsPeGDzIi4VhJ0
   s/0G9TEq/yAhUfF64b9Kcf2SxnFy2kTlr2RCEBzRFlA5lfBEESKNAnIIM
   24F3rIeTYhC32Wu0x/IYjcv567C95DCKqCv78KHi/zRsnsNGMPRgF/vsg
   sikh9KI3KmM1Kip8dI50bHhV9I8X3kynJwy8gVW27PMOx2cpmPlHHXLnN
   PRNFdqj1qs5GFFuqHDmxGx4RIftwBruhv6hjDhMDdRO9bGIZYb1vI85SZ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="243561342"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="243561342"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 07:59:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="613610338"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jan 2022 07:59:06 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7g1c-00063e-OC; Wed, 12 Jan 2022 15:59:00 +0000
Date:   Wed, 12 Jan 2022 23:58:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     cgel.zte@gmail.com, akpm@linux-foundation.org,
        yang.shi@linux.alibaba.com, ying.huang@intel.com
Cc:     kbuild-all@lists.01.org, dave.hansen@linux.intel.com,
        yang.yang29@zte.com.cn, saravanand@fb.com, minchan@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH] mm/vmstat: add event for ksm swapping in copy
Message-ID: <202201122306.EC6LSwot-lkp@intel.com>
References: <20220112115110.669160-1-yang.yang29@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112115110.669160-1-yang.yang29@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hnaz-mm/master]

url:    https://github.com/0day-ci/linux/commits/cgel-zte-gmail-com/mm-vmstat-add-event-for-ksm-swapping-in-copy/20220112-195303
base:   https://github.com/hnaz/linux-mm master
config: alpha-buildonly-randconfig-r004-20220112 (https://download.01.org/0day-ci/archive/20220112/202201122306.EC6LSwot-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/56a4520e557228d8383f27b6aef54b2f931a0588
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review cgel-zte-gmail-com/mm-vmstat-add-event-for-ksm-swapping-in-copy/20220112-195303
        git checkout 56a4520e557228d8383f27b6aef54b2f931a0588
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/ksm.c: In function 'ksm_might_need_to_copy':
>> mm/ksm.c:2597:32: error: 'KSM_SWPIN_COPY' undeclared (first use in this function)
    2597 |                 count_vm_event(KSM_SWPIN_COPY);
         |                                ^~~~~~~~~~~~~~
   mm/ksm.c:2597:32: note: each undeclared identifier is reported only once for each function it appears in


vim +/KSM_SWPIN_COPY +2597 mm/ksm.c

  2565	
  2566	struct page *ksm_might_need_to_copy(struct page *page,
  2567				struct vm_area_struct *vma, unsigned long address)
  2568	{
  2569		struct anon_vma *anon_vma = page_anon_vma(page);
  2570		struct page *new_page;
  2571	
  2572		if (PageKsm(page)) {
  2573			if (page_stable_node(page) &&
  2574			    !(ksm_run & KSM_RUN_UNMERGE))
  2575				return page;	/* no need to copy it */
  2576		} else if (!anon_vma) {
  2577			return page;		/* no need to copy it */
  2578		} else if (anon_vma->root == vma->anon_vma->root &&
  2579			 page->index == linear_page_index(vma, address)) {
  2580			return page;		/* still no need to copy it */
  2581		}
  2582		if (!PageUptodate(page))
  2583			return page;		/* let do_swap_page report the error */
  2584	
  2585		new_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma, address);
  2586		if (new_page &&
  2587		    mem_cgroup_charge(page_folio(new_page), vma->vm_mm, GFP_KERNEL)) {
  2588			put_page(new_page);
  2589			new_page = NULL;
  2590		}
  2591		if (new_page) {
  2592			copy_user_highpage(new_page, page, address, vma);
  2593	
  2594			SetPageDirty(new_page);
  2595			__SetPageUptodate(new_page);
  2596			__SetPageLocked(new_page);
> 2597			count_vm_event(KSM_SWPIN_COPY);
  2598		}
  2599	
  2600		return new_page;
  2601	}
  2602	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
