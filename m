Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8277E50982B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385213AbiDUGtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385142AbiDUGrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:47:22 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F351580B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523440; x=1682059440;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ygZHngdtdQgPhT2s6AuUjrc1U7PiewsjepP3Vd3rSbU=;
  b=mLR1YUmoWUsZ4Uq6GONNgmYjoqATyAdd77mi6Ix/kQgFWbBKWHPLCJ/R
   AmbZ1V9BYtu179y0JK6ecES4SBc/K2Fv+7fQ19l8XvftgFhTfjg8vLqYa
   HfzxnqRyE9lRvkuYw5Fhj5Q6I0yltdOjzkD/IFaus+ueD/hthgygD+gTm
   evCdKV2wSEPRxeQn35ienrOn2oKIG6FculD+vjMPWsKp1Mix3IqgUD5lB
   qPHnc8XMgOO61x2LCPHzRO5bqxdnvr+LJaXY8tK0e5sVSR1j4xph2uBsu
   MDku8sDEhGxEzde3p5uoQklcKQOC3ohnyW/mB8dL8oqLMKKB6LN1Y3zTA
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="350704806"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="350704806"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:43:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="805384269"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 20 Apr 2022 23:43:52 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQXf-00081E-9s;
        Thu, 21 Apr 2022 06:43:51 +0000
Date:   Thu, 21 Apr 2022 14:43:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2360/2579] include/linux/huge_mm.h:207:17:
 error: implicit declaration of function 'pmd_none'; did you mean 'p4d_none'?
Message-ID: <202204210643.llJ4EjxK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: e43870d97c8fb5c656b4592457df87ac2ee05f7a [2360/2579] headers/deps: mm: Optimize <linux/mm_api.h> dependencies, remove <linux/mmzone_api.h> dependency
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220421/202204210643.llJ4EjxK-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=e43870d97c8fb5c656b4592457df87ac2ee05f7a
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout e43870d97c8fb5c656b4592457df87ac2ee05f7a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/mm_api.h:393,
                    from arch/x86/include/asm/tlbflush.h:5,
                    from arch/x86/include/asm/highmem.h:26,
                    from include/linux/mmzone_api.h:33,
                    from include/linux/pgtable_api.h:15,
                    from sound/core/pcm_native.c:14:
   include/linux/huge_mm.h: In function 'is_swap_pmd':
>> include/linux/huge_mm.h:207:17: error: implicit declaration of function 'pmd_none'; did you mean 'p4d_none'? [-Werror=implicit-function-declaration]
     207 |         return !pmd_none(pmd) && !pmd_present(pmd);
         |                 ^~~~~~~~
         |                 p4d_none
>> include/linux/huge_mm.h:207:35: error: implicit declaration of function 'pmd_present'; did you mean 'p4d_present'? [-Werror=implicit-function-declaration]
     207 |         return !pmd_none(pmd) && !pmd_present(pmd);
         |                                   ^~~~~~~~~~~
         |                                   p4d_present
   include/linux/huge_mm.h: In function 'pmd_trans_huge_lock':
>> include/linux/huge_mm.h:214:34: error: implicit declaration of function 'pmd_trans_huge'; did you mean 'pmd_trans_huge_lock'? [-Werror=implicit-function-declaration]
     214 |         if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
         |                                  ^~~~~~~~~~~~~~
         |                                  pmd_trans_huge_lock
>> include/linux/huge_mm.h:214:58: error: implicit declaration of function 'pmd_devmap' [-Werror=implicit-function-declaration]
     214 |         if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
         |                                                          ^~~~~~~~~~
   include/linux/huge_mm.h: In function 'pud_trans_huge_lock':
>> include/linux/huge_mm.h:222:13: error: implicit declaration of function 'pud_trans_huge'; did you mean 'pud_trans_huge_lock'? [-Werror=implicit-function-declaration]
     222 |         if (pud_trans_huge(*pud) || pud_devmap(*pud))
         |             ^~~~~~~~~~~~~~
         |             pud_trans_huge_lock
>> include/linux/huge_mm.h:222:37: error: implicit declaration of function 'pud_devmap'; did you mean 'pud_val'? [-Werror=implicit-function-declaration]
     222 |         if (pud_trans_huge(*pud) || pud_devmap(*pud))
         |                                     ^~~~~~~~~~
         |                                     pud_val
   include/linux/huge_mm.h: In function 'is_huge_zero_pmd':
>> include/linux/huge_mm.h:254:44: error: implicit declaration of function 'pmd_pfn' [-Werror=implicit-function-declaration]
     254 |         return READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd) && pmd_present(pmd);
         |                                            ^~~~~~~
   In file included from include/linux/pgtable_api.h:19,
                    from sound/core/pcm_native.c:14:
   arch/x86/include/asm/pgtable.h: At top level:
>> arch/x86/include/asm/pgtable.h:209:29: error: conflicting types for 'pmd_pfn'; have 'long unsigned int(pmd_t)'
     209 | static inline unsigned long pmd_pfn(pmd_t pmd)
         |                             ^~~~~~~
   In file included from include/linux/mm_api.h:393,
                    from arch/x86/include/asm/tlbflush.h:5,
                    from arch/x86/include/asm/highmem.h:26,
                    from include/linux/mmzone_api.h:33,
                    from include/linux/pgtable_api.h:15,
                    from sound/core/pcm_native.c:14:
   include/linux/huge_mm.h:254:44: note: previous implicit declaration of 'pmd_pfn' with type 'int()'
     254 |         return READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd) && pmd_present(pmd);
         |                                            ^~~~~~~
   In file included from include/linux/pgtable_api.h:19,
                    from sound/core/pcm_native.c:14:
   arch/x86/include/asm/pgtable.h:250:19: error: static declaration of 'pmd_trans_huge' follows non-static declaration
     250 | static inline int pmd_trans_huge(pmd_t pmd)
         |                   ^~~~~~~~~~~~~~
   In file included from include/linux/mm_api.h:393,
                    from arch/x86/include/asm/tlbflush.h:5,
                    from arch/x86/include/asm/highmem.h:26,
                    from include/linux/mmzone_api.h:33,
                    from include/linux/pgtable_api.h:15,
                    from sound/core/pcm_native.c:14:
   include/linux/huge_mm.h:214:34: note: previous implicit declaration of 'pmd_trans_huge' with type 'int()'
     214 |         if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
         |                                  ^~~~~~~~~~~~~~
   In file included from include/linux/pgtable_api.h:19,
                    from sound/core/pcm_native.c:14:
   arch/x86/include/asm/pgtable.h:744:19: error: static declaration of 'pmd_present' follows non-static declaration
     744 | static inline int pmd_present(pmd_t pmd)
         |                   ^~~~~~~~~~~
   In file included from include/linux/mm_api.h:393,
                    from arch/x86/include/asm/tlbflush.h:5,
                    from arch/x86/include/asm/highmem.h:26,
                    from include/linux/mmzone_api.h:33,
                    from include/linux/pgtable_api.h:15,
                    from sound/core/pcm_native.c:14:
   include/linux/huge_mm.h:207:35: note: previous implicit declaration of 'pmd_present' with type 'int()'
     207 |         return !pmd_none(pmd) && !pmd_present(pmd);
         |                                   ^~~~~~~~~~~
   In file included from include/linux/pgtable_api.h:19,
                    from sound/core/pcm_native.c:14:
   arch/x86/include/asm/pgtable.h:773:19: error: static declaration of 'pmd_none' follows non-static declaration
     773 | static inline int pmd_none(pmd_t pmd)
         |                   ^~~~~~~~
   In file included from include/linux/mm_api.h:393,
                    from arch/x86/include/asm/tlbflush.h:5,
                    from arch/x86/include/asm/highmem.h:26,
                    from include/linux/mmzone_api.h:33,
                    from include/linux/pgtable_api.h:15,
                    from sound/core/pcm_native.c:14:
   include/linux/huge_mm.h:207:17: note: previous implicit declaration of 'pmd_none' with type 'int()'
     207 |         return !pmd_none(pmd) && !pmd_present(pmd);
         |                 ^~~~~~~~
   In file included from sound/core/pcm_native.c:14:
   include/linux/pgtable_api.h:1201:19: error: static declaration of 'pmd_devmap' follows non-static declaration
    1201 | static inline int pmd_devmap(pmd_t pmd)
         |                   ^~~~~~~~~~
   In file included from include/linux/mm_api.h:393,
                    from arch/x86/include/asm/tlbflush.h:5,
                    from arch/x86/include/asm/highmem.h:26,
                    from include/linux/mmzone_api.h:33,
                    from include/linux/pgtable_api.h:15,
                    from sound/core/pcm_native.c:14:
   include/linux/huge_mm.h:214:58: note: previous implicit declaration of 'pmd_devmap' with type 'int()'
     214 |         if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
         |                                                          ^~~~~~~~~~
   In file included from sound/core/pcm_native.c:14:
   include/linux/pgtable_api.h:1205:19: error: static declaration of 'pud_devmap' follows non-static declaration
    1205 | static inline int pud_devmap(pud_t pud)
         |                   ^~~~~~~~~~
   In file included from include/linux/mm_api.h:393,
                    from arch/x86/include/asm/tlbflush.h:5,
                    from arch/x86/include/asm/highmem.h:26,
                    from include/linux/mmzone_api.h:33,
                    from include/linux/pgtable_api.h:15,
                    from sound/core/pcm_native.c:14:
   include/linux/huge_mm.h:222:37: note: previous implicit declaration of 'pud_devmap' with type 'int()'
     222 |         if (pud_trans_huge(*pud) || pud_devmap(*pud))
         |                                     ^~~~~~~~~~
   In file included from sound/core/pcm_native.c:14:
   include/linux/pgtable_api.h:1218:19: error: static declaration of 'pud_trans_huge' follows non-static declaration
    1218 | static inline int pud_trans_huge(pud_t pud)
         |                   ^~~~~~~~~~~~~~
   In file included from include/linux/mm_api.h:393,
                    from arch/x86/include/asm/tlbflush.h:5,
                    from arch/x86/include/asm/highmem.h:26,
                    from include/linux/mmzone_api.h:33,
                    from include/linux/pgtable_api.h:15,
                    from sound/core/pcm_native.c:14:
   include/linux/huge_mm.h:222:13: note: previous implicit declaration of 'pud_trans_huge' with type 'int()'
     222 |         if (pud_trans_huge(*pud) || pud_devmap(*pud))
         |             ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/mm_api.h:393,
                    from arch/x86/include/asm/tlbflush.h:5,
                    from arch/x86/include/asm/highmem.h:26,
                    from include/linux/mmzone_api.h:33,
                    from include/linux/pgtable_api.h:15,
                    from drivers/pci/pci.c:47:
   include/linux/huge_mm.h: In function 'is_swap_pmd':
>> include/linux/huge_mm.h:207:17: error: implicit declaration of function 'pmd_none'; did you mean 'p4d_none'? [-Werror=implicit-function-declaration]
     207 |         return !pmd_none(pmd) && !pmd_present(pmd);
         |                 ^~~~~~~~
         |                 p4d_none
>> include/linux/huge_mm.h:207:35: error: implicit declaration of function 'pmd_present'; did you mean 'p4d_present'? [-Werror=implicit-function-declaration]
     207 |         return !pmd_none(pmd) && !pmd_present(pmd);
         |                                   ^~~~~~~~~~~
         |                                   p4d_present
   include/linux/huge_mm.h: In function 'pmd_trans_huge_lock':
>> include/linux/huge_mm.h:214:34: error: implicit declaration of function 'pmd_trans_huge'; did you mean 'pmd_trans_huge_lock'? [-Werror=implicit-function-declaration]
     214 |         if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
         |                                  ^~~~~~~~~~~~~~
         |                                  pmd_trans_huge_lock
>> include/linux/huge_mm.h:214:58: error: implicit declaration of function 'pmd_devmap' [-Werror=implicit-function-declaration]
     214 |         if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
         |                                                          ^~~~~~~~~~
   include/linux/huge_mm.h: In function 'pud_trans_huge_lock':
>> include/linux/huge_mm.h:222:13: error: implicit declaration of function 'pud_trans_huge'; did you mean 'pud_trans_huge_lock'? [-Werror=implicit-function-declaration]
     222 |         if (pud_trans_huge(*pud) || pud_devmap(*pud))
         |             ^~~~~~~~~~~~~~
         |             pud_trans_huge_lock
   include/linux/huge_mm.h:222:37: error: implicit declaration of function 'pud_devmap' [-Werror=implicit-function-declaration]
     222 |         if (pud_trans_huge(*pud) || pud_devmap(*pud))
         |                                     ^~~~~~~~~~
   include/linux/huge_mm.h: In function 'is_huge_zero_pmd':
>> include/linux/huge_mm.h:254:44: error: implicit declaration of function 'pmd_pfn' [-Werror=implicit-function-declaration]
     254 |         return READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd) && pmd_present(pmd);
         |                                            ^~~~~~~
   In file included from include/linux/pgtable_api.h:19,
                    from drivers/pci/pci.c:47:
   arch/x86/include/asm/pgtable.h: At top level:
>> arch/x86/include/asm/pgtable.h:209:29: error: conflicting types for 'pmd_pfn'; have 'long unsigned int(pmd_t)'
     209 | static inline unsigned long pmd_pfn(pmd_t pmd)
         |                             ^~~~~~~
   In file included from include/linux/mm_api.h:393,
                    from arch/x86/include/asm/tlbflush.h:5,
                    from arch/x86/include/asm/highmem.h:26,
                    from include/linux/mmzone_api.h:33,
                    from include/linux/pgtable_api.h:15,
                    from drivers/pci/pci.c:47:
   include/linux/huge_mm.h:254:44: note: previous implicit declaration of 'pmd_pfn' with type 'int()'
     254 |         return READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd) && pmd_present(pmd);
         |                                            ^~~~~~~
   In file included from include/linux/pgtable_api.h:19,
                    from drivers/pci/pci.c:47:
   arch/x86/include/asm/pgtable.h:250:19: error: static declaration of 'pmd_trans_huge' follows non-static declaration
     250 | static inline int pmd_trans_huge(pmd_t pmd)
         |                   ^~~~~~~~~~~~~~
   In file included from include/linux/mm_api.h:393,
                    from arch/x86/include/asm/tlbflush.h:5,
                    from arch/x86/include/asm/highmem.h:26,
                    from include/linux/mmzone_api.h:33,
                    from include/linux/pgtable_api.h:15,
                    from drivers/pci/pci.c:47:
   include/linux/huge_mm.h:214:34: note: previous implicit declaration of 'pmd_trans_huge' with type 'int()'
     214 |         if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
         |                                  ^~~~~~~~~~~~~~
   In file included from include/linux/pgtable_api.h:19,
                    from drivers/pci/pci.c:47:
   arch/x86/include/asm/pgtable.h:744:19: error: static declaration of 'pmd_present' follows non-static declaration
     744 | static inline int pmd_present(pmd_t pmd)
         |                   ^~~~~~~~~~~
   In file included from include/linux/mm_api.h:393,
                    from arch/x86/include/asm/tlbflush.h:5,
                    from arch/x86/include/asm/highmem.h:26,
                    from include/linux/mmzone_api.h:33,
                    from include/linux/pgtable_api.h:15,
                    from drivers/pci/pci.c:47:
   include/linux/huge_mm.h:207:35: note: previous implicit declaration of 'pmd_present' with type 'int()'
     207 |         return !pmd_none(pmd) && !pmd_present(pmd);
         |                                   ^~~~~~~~~~~
   In file included from include/linux/pgtable_api.h:19,
                    from drivers/pci/pci.c:47:
   arch/x86/include/asm/pgtable.h:773:19: error: static declaration of 'pmd_none' follows non-static declaration
     773 | static inline int pmd_none(pmd_t pmd)
         |                   ^~~~~~~~
   In file included from include/linux/mm_api.h:393,
                    from arch/x86/include/asm/tlbflush.h:5,
                    from arch/x86/include/asm/highmem.h:26,
                    from include/linux/mmzone_api.h:33,
                    from include/linux/pgtable_api.h:15,
                    from drivers/pci/pci.c:47:
   include/linux/huge_mm.h:207:17: note: previous implicit declaration of 'pmd_none' with type 'int()'
     207 |         return !pmd_none(pmd) && !pmd_present(pmd);
         |                 ^~~~~~~~
   In file included from drivers/pci/pci.c:47:
   include/linux/pgtable_api.h:1201:19: error: static declaration of 'pmd_devmap' follows non-static declaration
    1201 | static inline int pmd_devmap(pmd_t pmd)
         |                   ^~~~~~~~~~
   In file included from include/linux/mm_api.h:393,
                    from arch/x86/include/asm/tlbflush.h:5,
                    from arch/x86/include/asm/highmem.h:26,
                    from include/linux/mmzone_api.h:33,
                    from include/linux/pgtable_api.h:15,
                    from drivers/pci/pci.c:47:
   include/linux/huge_mm.h:214:58: note: previous implicit declaration of 'pmd_devmap' with type 'int()'
     214 |         if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
         |                                                          ^~~~~~~~~~
   In file included from drivers/pci/pci.c:47:
   include/linux/pgtable_api.h:1205:19: error: static declaration of 'pud_devmap' follows non-static declaration
    1205 | static inline int pud_devmap(pud_t pud)
         |                   ^~~~~~~~~~
   In file included from include/linux/mm_api.h:393,
                    from arch/x86/include/asm/tlbflush.h:5,
                    from arch/x86/include/asm/highmem.h:26,
                    from include/linux/mmzone_api.h:33,
                    from include/linux/pgtable_api.h:15,
                    from drivers/pci/pci.c:47:
   include/linux/huge_mm.h:222:37: note: previous implicit declaration of 'pud_devmap' with type 'int()'
     222 |         if (pud_trans_huge(*pud) || pud_devmap(*pud))
         |                                     ^~~~~~~~~~
   In file included from drivers/pci/pci.c:47:
   include/linux/pgtable_api.h:1218:19: error: static declaration of 'pud_trans_huge' follows non-static declaration
    1218 | static inline int pud_trans_huge(pud_t pud)
         |                   ^~~~~~~~~~~~~~
   In file included from include/linux/mm_api.h:393,
                    from arch/x86/include/asm/tlbflush.h:5,
                    from arch/x86/include/asm/highmem.h:26,
                    from include/linux/mmzone_api.h:33,
                    from include/linux/pgtable_api.h:15,
                    from drivers/pci/pci.c:47:
   include/linux/huge_mm.h:222:13: note: previous implicit declaration of 'pud_trans_huge' with type 'int()'
     222 |         if (pud_trans_huge(*pud) || pud_devmap(*pud))
         |             ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/mm_api.h:393,
                    from arch/x86/include/asm/tlbflush.h:5,
                    from arch/x86/include/asm/highmem.h:26,
                    from include/linux/mmzone_api.h:33,
                    from include/linux/pgtable_api.h:15,
                    from kernel/trace/trace.c:25:
   include/linux/huge_mm.h: In function 'is_swap_pmd':
>> include/linux/huge_mm.h:207:17: error: implicit declaration of function 'pmd_none'; did you mean 'p4d_none'? [-Werror=implicit-function-declaration]
     207 |         return !pmd_none(pmd) && !pmd_present(pmd);
         |                 ^~~~~~~~
         |                 p4d_none
>> include/linux/huge_mm.h:207:35: error: implicit declaration of function 'pmd_present'; did you mean 'p4d_present'? [-Werror=implicit-function-declaration]
     207 |         return !pmd_none(pmd) && !pmd_present(pmd);
         |                                   ^~~~~~~~~~~
         |                                   p4d_present
   include/linux/huge_mm.h: In function 'pmd_trans_huge_lock':
>> include/linux/huge_mm.h:214:34: error: implicit declaration of function 'pmd_trans_huge'; did you mean 'pmd_trans_huge_lock'? [-Werror=implicit-function-declaration]
     214 |         if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
         |                                  ^~~~~~~~~~~~~~
         |                                  pmd_trans_huge_lock
>> include/linux/huge_mm.h:214:58: error: implicit declaration of function 'pmd_devmap' [-Werror=implicit-function-declaration]
     214 |         if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
         |                                                          ^~~~~~~~~~
   include/linux/huge_mm.h: In function 'pud_trans_huge_lock':
>> include/linux/huge_mm.h:222:13: error: implicit declaration of function 'pud_trans_huge'; did you mean 'pud_trans_huge_lock'? [-Werror=implicit-function-declaration]
     222 |         if (pud_trans_huge(*pud) || pud_devmap(*pud))
         |             ^~~~~~~~~~~~~~
         |             pud_trans_huge_lock
>> include/linux/huge_mm.h:222:37: error: implicit declaration of function 'pud_devmap'; did you mean 'pud_val'? [-Werror=implicit-function-declaration]
     222 |         if (pud_trans_huge(*pud) || pud_devmap(*pud))
         |                                     ^~~~~~~~~~
         |                                     pud_val
   include/linux/huge_mm.h: In function 'is_huge_zero_pmd':
>> include/linux/huge_mm.h:254:44: error: implicit declaration of function 'pmd_pfn' [-Werror=implicit-function-declaration]
     254 |         return READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd) && pmd_present(pmd);
         |                                            ^~~~~~~
   In file included from include/linux/pgtable_api.h:19,
                    from kernel/trace/trace.c:25:
   arch/x86/include/asm/pgtable.h: At top level:
>> arch/x86/include/asm/pgtable.h:209:29: error: conflicting types for 'pmd_pfn'; have 'long unsigned int(pmd_t)'
     209 | static inline unsigned long pmd_pfn(pmd_t pmd)
         |                             ^~~~~~~
   In file included from include/linux/mm_api.h:393,
                    from arch/x86/include/asm/tlbflush.h:5,
                    from arch/x86/include/asm/highmem.h:26,
                    from include/linux/mmzone_api.h:33,
                    from include/linux/pgtable_api.h:15,
                    from kernel/trace/trace.c:25:
   include/linux/huge_mm.h:254:44: note: previous implicit declaration of 'pmd_pfn' with type 'int()'
     254 |         return READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd) && pmd_present(pmd);
         |                                            ^~~~~~~
   In file included from include/linux/pgtable_api.h:19,
                    from kernel/trace/trace.c:25:
   arch/x86/include/asm/pgtable.h:250:19: error: static declaration of 'pmd_trans_huge' follows non-static declaration
     250 | static inline int pmd_trans_huge(pmd_t pmd)
         |                   ^~~~~~~~~~~~~~
   In file included from include/linux/mm_api.h:393,
                    from arch/x86/include/asm/tlbflush.h:5,
                    from arch/x86/include/asm/highmem.h:26,
                    from include/linux/mmzone_api.h:33,
                    from include/linux/pgtable_api.h:15,
                    from kernel/trace/trace.c:25:
   include/linux/huge_mm.h:214:34: note: previous implicit declaration of 'pmd_trans_huge' with type 'int()'
     214 |         if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
         |                                  ^~~~~~~~~~~~~~
   In file included from include/linux/pgtable_api.h:19,
                    from kernel/trace/trace.c:25:
   arch/x86/include/asm/pgtable.h:744:19: error: static declaration of 'pmd_present' follows non-static declaration
     744 | static inline int pmd_present(pmd_t pmd)
         |                   ^~~~~~~~~~~
   In file included from include/linux/mm_api.h:393,
                    from arch/x86/include/asm/tlbflush.h:5,
                    from arch/x86/include/asm/highmem.h:26,
                    from include/linux/mmzone_api.h:33,
                    from include/linux/pgtable_api.h:15,
                    from kernel/trace/trace.c:25:
   include/linux/huge_mm.h:207:35: note: previous implicit declaration of 'pmd_present' with type 'int()'
     207 |         return !pmd_none(pmd) && !pmd_present(pmd);
         |                                   ^~~~~~~~~~~
   In file included from include/linux/pgtable_api.h:19,
                    from kernel/trace/trace.c:25:
   arch/x86/include/asm/pgtable.h:773:19: error: static declaration of 'pmd_none' follows non-static declaration
     773 | static inline int pmd_none(pmd_t pmd)
         |                   ^~~~~~~~
   In file included from include/linux/mm_api.h:393,
                    from arch/x86/include/asm/tlbflush.h:5,
                    from arch/x86/include/asm/highmem.h:26,
                    from include/linux/mmzone_api.h:33,
                    from include/linux/pgtable_api.h:15,
                    from kernel/trace/trace.c:25:
   include/linux/huge_mm.h:207:17: note: previous implicit declaration of 'pmd_none' with type 'int()'
     207 |         return !pmd_none(pmd) && !pmd_present(pmd);
         |                 ^~~~~~~~
   In file included from kernel/trace/trace.c:25:
   include/linux/pgtable_api.h:1201:19: error: static declaration of 'pmd_devmap' follows non-static declaration
    1201 | static inline int pmd_devmap(pmd_t pmd)
         |                   ^~~~~~~~~~
   In file included from include/linux/mm_api.h:393,
                    from arch/x86/include/asm/tlbflush.h:5,
                    from arch/x86/include/asm/highmem.h:26,
                    from include/linux/mmzone_api.h:33,
                    from include/linux/pgtable_api.h:15,
                    from kernel/trace/trace.c:25:
   include/linux/huge_mm.h:214:58: note: previous implicit declaration of 'pmd_devmap' with type 'int()'
     214 |         if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
         |                                                          ^~~~~~~~~~
   In file included from kernel/trace/trace.c:25:
   include/linux/pgtable_api.h:1205:19: error: static declaration of 'pud_devmap' follows non-static declaration
    1205 | static inline int pud_devmap(pud_t pud)
         |                   ^~~~~~~~~~
   In file included from include/linux/mm_api.h:393,
                    from arch/x86/include/asm/tlbflush.h:5,
                    from arch/x86/include/asm/highmem.h:26,
                    from include/linux/mmzone_api.h:33,
                    from include/linux/pgtable_api.h:15,
                    from kernel/trace/trace.c:25:
   include/linux/huge_mm.h:222:37: note: previous implicit declaration of 'pud_devmap' with type 'int()'
     222 |         if (pud_trans_huge(*pud) || pud_devmap(*pud))
         |                                     ^~~~~~~~~~
   In file included from kernel/trace/trace.c:25:
   include/linux/pgtable_api.h:1218:19: error: static declaration of 'pud_trans_huge' follows non-static declaration
    1218 | static inline int pud_trans_huge(pud_t pud)
         |                   ^~~~~~~~~~~~~~
   In file included from include/linux/mm_api.h:393,
                    from arch/x86/include/asm/tlbflush.h:5,
                    from arch/x86/include/asm/highmem.h:26,
                    from include/linux/mmzone_api.h:33,
                    from include/linux/pgtable_api.h:15,
                    from kernel/trace/trace.c:25:
   include/linux/huge_mm.h:222:13: note: previous implicit declaration of 'pud_trans_huge' with type 'int()'
     222 |         if (pud_trans_huge(*pud) || pud_devmap(*pud))
         |             ^~~~~~~~~~~~~~
   kernel/trace/trace.c: In function 'trace_check_vprintf':
   kernel/trace/trace.c:3868:17: warning: function 'trace_check_vprintf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    3868 |                 trace_seq_vprintf(&iter->seq, iter->fmt, ap);
         |                 ^~~~~~~~~~~~~~~~~
   kernel/trace/trace.c:3935:17: warning: function 'trace_check_vprintf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    3935 |                 trace_seq_vprintf(&iter->seq, p, ap);
         |                 ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
..


vim +207 include/linux/huge_mm.h

84c3fc4e9c563d8 Zi Yan                  2017-09-08  204  
84c3fc4e9c563d8 Zi Yan                  2017-09-08  205  static inline int is_swap_pmd(pmd_t pmd)
84c3fc4e9c563d8 Zi Yan                  2017-09-08  206  {
84c3fc4e9c563d8 Zi Yan                  2017-09-08 @207  	return !pmd_none(pmd) && !pmd_present(pmd);
84c3fc4e9c563d8 Zi Yan                  2017-09-08  208  }
84c3fc4e9c563d8 Zi Yan                  2017-09-08  209  
c1e8d7c6a7a682e Michel Lespinasse       2020-06-08  210  /* mmap_lock must be held on entry */
b6ec57f4b92e9ba Kirill A. Shutemov      2016-01-21  211  static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
b6ec57f4b92e9ba Kirill A. Shutemov      2016-01-21  212  		struct vm_area_struct *vma)
025c5b2451e42c9 Naoya Horiguchi         2012-03-21  213  {
84c3fc4e9c563d8 Zi Yan                  2017-09-08 @214  	if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
b6ec57f4b92e9ba Kirill A. Shutemov      2016-01-21  215  		return __pmd_trans_huge_lock(pmd, vma);
025c5b2451e42c9 Naoya Horiguchi         2012-03-21  216  	else
969e8d7e47f93ef Chen Gang               2016-04-01  217  		return NULL;
025c5b2451e42c9 Naoya Horiguchi         2012-03-21  218  }
a00cc7d9dd93d66 Matthew Wilcox          2017-02-24  219  static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
a00cc7d9dd93d66 Matthew Wilcox          2017-02-24  220  		struct vm_area_struct *vma)
a00cc7d9dd93d66 Matthew Wilcox          2017-02-24  221  {
a00cc7d9dd93d66 Matthew Wilcox          2017-02-24 @222  	if (pud_trans_huge(*pud) || pud_devmap(*pud))
a00cc7d9dd93d66 Matthew Wilcox          2017-02-24  223  		return __pud_trans_huge_lock(pud, vma);
a00cc7d9dd93d66 Matthew Wilcox          2017-02-24  224  	else
a00cc7d9dd93d66 Matthew Wilcox          2017-02-24  225  		return NULL;
a00cc7d9dd93d66 Matthew Wilcox          2017-02-24  226  }
6ffbb45826f5d9a Matthew Wilcox (Oracle  2020-08-14  227) 
5bf34d7c7ffe773 Matthew Wilcox (Oracle  2021-11-28  228) /**
5bf34d7c7ffe773 Matthew Wilcox (Oracle  2021-11-28  229)  * folio_test_pmd_mappable - Can we map this folio with a PMD?
5bf34d7c7ffe773 Matthew Wilcox (Oracle  2021-11-28  230)  * @folio: The folio to test
5bf34d7c7ffe773 Matthew Wilcox (Oracle  2021-11-28  231)  */
5bf34d7c7ffe773 Matthew Wilcox (Oracle  2021-11-28  232) static inline bool folio_test_pmd_mappable(struct folio *folio)
5bf34d7c7ffe773 Matthew Wilcox (Oracle  2021-11-28  233) {
5bf34d7c7ffe773 Matthew Wilcox (Oracle  2021-11-28  234) 	return folio_order(folio) >= HPAGE_PMD_ORDER;
5bf34d7c7ffe773 Matthew Wilcox (Oracle  2021-11-28  235) }
5bf34d7c7ffe773 Matthew Wilcox (Oracle  2021-11-28  236) 
a00cc7d9dd93d66 Matthew Wilcox          2017-02-24  237  struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
df06b37ffe5a442 Keith Busch             2018-10-26  238  		pmd_t *pmd, int flags, struct dev_pagemap **pgmap);
a00cc7d9dd93d66 Matthew Wilcox          2017-02-24  239  struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
df06b37ffe5a442 Keith Busch             2018-10-26  240  		pud_t *pud, int flags, struct dev_pagemap **pgmap);
a00cc7d9dd93d66 Matthew Wilcox          2017-02-24  241  
5db4f15c4fd7ae7 Yang Shi                2021-06-30  242  vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf);
d10e63f29488b0f Mel Gorman              2012-10-25  243  
56873f43abdcd57 Wang, Yalin             2015-02-11  244  extern struct page *huge_zero_page;
3b77e8c8cde581d Hugh Dickins            2021-06-15  245  extern unsigned long huge_zero_pfn;
56873f43abdcd57 Wang, Yalin             2015-02-11  246  
56873f43abdcd57 Wang, Yalin             2015-02-11  247  static inline bool is_huge_zero_page(struct page *page)
56873f43abdcd57 Wang, Yalin             2015-02-11  248  {
6aa7de059173a98 Mark Rutland            2017-10-23  249  	return READ_ONCE(huge_zero_page) == page;
56873f43abdcd57 Wang, Yalin             2015-02-11  250  }
56873f43abdcd57 Wang, Yalin             2015-02-11  251  
fc43704437ebe40 Matthew Wilcox          2015-09-08  252  static inline bool is_huge_zero_pmd(pmd_t pmd)
fc43704437ebe40 Matthew Wilcox          2015-09-08  253  {
3b77e8c8cde581d Hugh Dickins            2021-06-15 @254  	return READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd) && pmd_present(pmd);
fc43704437ebe40 Matthew Wilcox          2015-09-08  255  }
fc43704437ebe40 Matthew Wilcox          2015-09-08  256  

:::::: The code at line 207 was first introduced by commit
:::::: 84c3fc4e9c563d8fb91cfdf5948da48fe1af34d3 mm: thp: check pmd migration entry in common path

:::::: TO: Zi Yan <zi.yan@cs.rutgers.edu>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
