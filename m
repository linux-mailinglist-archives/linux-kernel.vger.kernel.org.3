Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01D64D62CE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349047AbiCKOF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349042AbiCKOFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:05:20 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A748FCB43
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 06:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647007457; x=1678543457;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eZ0mjAN7vVx+UnkwEjoPi7KN1IG1d+D3MvRtVGuPSRM=;
  b=nuw0lkLdJ2mO7BVGnYXhln2vaRjnXnX4tKHSG0Cm/lH4L1ZOiquR38vu
   h5R2F+Jj+aCVUU12v6xx6cJpkAGNgZYt854cVd0LbgFou4WDz6GDfggbP
   a0cH2eM51o4vvFL8Y85jUTQ2Q/34CrAd7lHG/NIhUDIckMS2jyZwLe15c
   0zsXyQ1pvY89tBXaIavAZH+qvXsAkIXC8q8AV0Bu0fs9vfWV2+qY7HPgw
   nPqPYkGdywHJ3PDQkcwbHMlO1tywPGoXo9Cas5uCVbse1Rfkh7L07YOk7
   0wM/IazEwrftn1PYFVTY0MFKoKhlj0ZFF9uxoufK0yIriiXpk7ceIOuF/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="253138749"
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="253138749"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 06:04:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="597116767"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 11 Mar 2022 06:04:08 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSfsF-0006WD-Nh; Fri, 11 Mar 2022 14:04:07 +0000
Date:   Fri, 11 Mar 2022 22:03:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [davidhildenbrand:cow_fixes_part_3 31/37]
 arch/powerpc/include/asm/book3s/64/pgtable.h:762:84: error: expected ')'
 before '}' token
Message-ID: <202203112115.rlyxdAhi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/davidhildenbrand/linux cow_fixes_part_3
head:   1eea84efeea5e210bb4f92b7d64f4c1cc1aa761d
commit: 43a8e5bbb3d2fe2cd131400b98cbac8f79ba5290 [31/37] powerpc/pgtable: remove _PAGE_BIT_SWAP_TYPE for book3s
config: powerpc64-buildonly-randconfig-r003-20220310 (https://download.01.org/0day-ci/archive/20220311/202203112115.rlyxdAhi-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/davidhildenbrand/linux/commit/43a8e5bbb3d2fe2cd131400b98cbac8f79ba5290
        git remote add davidhildenbrand git://github.com/davidhildenbrand/linux
        git fetch --no-tags davidhildenbrand cow_fixes_part_3
        git checkout 43a8e5bbb3d2fe2cd131400b98cbac8f79ba5290
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash fs/proc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20,
                    from arch/powerpc/include/asm/book3s/64/mmu.h:38,
                    from arch/powerpc/include/asm/mmu.h:405,
                    from arch/powerpc/include/asm/lppaca.h:46,
                    from arch/powerpc/include/asm/paca.h:17,
                    from arch/powerpc/include/asm/current.h:13,
                    from include/linux/thread_info.h:23,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/powerpc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:10,
                    from include/linux/pagewalk.h:5,
                    from fs/proc/task_mmu.c:2:
   include/linux/swapops.h: In function 'swp_entry_to_pte':
>> arch/powerpc/include/asm/book3s/64/pgtable.h:762:84: error: expected ')' before '}' token
     762 |                                 ((type) | (((offset) << PAGE_SHIFT) & PTE_RPN_MASK)})
         |                                 ~                                                  ^
   include/linux/swapops.h:94:22: note: in expansion of macro '__swp_entry'
      94 |         arch_entry = __swp_entry(swp_type(entry), swp_offset(entry));
         |                      ^~~~~~~~~~~


vim +762 arch/powerpc/include/asm/book3s/64/pgtable.h

   745	
   746	/* Encode and de-code a swap entry */
   747	#define MAX_SWAPFILES_CHECK() do { \
   748		BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > SWP_TYPE_BITS); \
   749		/*							\
   750		 * Don't have overlapping bits with _PAGE_HPTEFLAGS	\
   751		 * We filter HPTEFLAGS on set_pte.			\
   752		 */							\
   753		BUILD_BUG_ON(_PAGE_HPTEFLAGS & SWP_TYPE_MASK); \
   754		BUILD_BUG_ON(_PAGE_HPTEFLAGS & _PAGE_SWP_SOFT_DIRTY);	\
   755		} while (0)
   756	
   757	#define SWP_TYPE_BITS 5
   758	#define SWP_TYPE_MASK		((1UL << SWP_TYPE_BITS) - 1)
   759	#define __swp_type(x)		((x).val & SWP_TYPE_MASK)
   760	#define __swp_offset(x)		(((x).val & PTE_RPN_MASK) >> PAGE_SHIFT)
   761	#define __swp_entry(type, offset)	((swp_entry_t) { \
 > 762					((type) | (((offset) << PAGE_SHIFT) & PTE_RPN_MASK)})
   763	/*
   764	 * swp_entry_t must be independent of pte bits. We build a swp_entry_t from
   765	 * swap type and offset we get from swap and convert that to pte to find a
   766	 * matching pte in linux page table.
   767	 * Clear bits not found in swap entries here.
   768	 */
   769	#define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val((pte)) & ~_PAGE_PTE })
   770	#define __swp_entry_to_pte(x)	__pte((x).val | _PAGE_PTE)
   771	#define __pmd_to_swp_entry(pmd)	(__pte_to_swp_entry(pmd_pte(pmd)))
   772	#define __swp_entry_to_pmd(x)	(pte_pmd(__swp_entry_to_pte(x)))
   773	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
