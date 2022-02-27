Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC7D4C58D8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 02:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiB0BCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 20:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiB0BCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 20:02:50 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39ADD2B9BFC
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 17:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645923735; x=1677459735;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9PAN6UZlU60xLSHp+SiSnT40QYgt4AHZ2B3SnqsZDOA=;
  b=PDZAEN/fxQd1aWec+nM9vpm5FKNOo/D5w9oiKrjB5O3/iuP/HACCdYE2
   utsq78Uyanhgkyop9Y9fElO8cTJQ9IHk/0CCWM5yR538+hAfYJedGoXHY
   e68GoUnrTTP+tbMXFm1COR0XzjhNdZZ5bawCCFN2GwoI/PKolAN3HCYWf
   lzNan5+sDVcJGOECay1oCJuuwwWqI+MXGKYt0oUrHqgM5TZzkOuZdZkmc
   UTx6kt+YG6yDUvDpUtaphzbdKglfO0h+VyPfH86RNnSwQ2jafwztjwja9
   7tkrxX72wgWJuxfdYMJLiiF8rMDN6N4386L6+BckIvTSYkDVZvYwq5MNi
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10270"; a="339130693"
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="339130693"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 17:02:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="798086316"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 26 Feb 2022 17:02:13 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nO7wy-00065c-G5; Sun, 27 Feb 2022 01:02:12 +0000
Date:   Sun, 27 Feb 2022 09:01:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [ammarfaizi2-block:next/linux-next/master 114/370]
 arch/m68k/mm/init.c:138:10: error: redefinition of 'vm_get_page_prot'
Message-ID: <202202270856.AEAWFqnv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block next/linux-next/master
head:   06aeb1495c39c86ccfaf1adadc1d2200179f16eb
commit: 8d8d82a114a972cf7b5f2f4154aafbb338f33fb7 [114/370] m68k/mm: enable ARCH_HAS_VM_GET_PAGE_PROT
config: m68k-randconfig-r024-20220227 (https://download.01.org/0day-ci/archive/20220227/202202270856.AEAWFqnv-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/8d8d82a114a972cf7b5f2f4154aafbb338f33fb7
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block next/linux-next/master
        git checkout 8d8d82a114a972cf7b5f2f4154aafbb338f33fb7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash arch/m68k/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/m68k/mm/init.c:138:10: error: redefinition of 'vm_get_page_prot'
     138 | pgprot_t vm_get_page_prot(unsigned long vm_flags)
         |          ^~~~~~~~~~~~~~~~
   In file included from arch/m68k/mm/init.c:14:
   include/linux/mm.h:2844:24: note: previous definition of 'vm_get_page_prot' with type 'pgprot_t(long unsigned int)'
    2844 | static inline pgprot_t vm_get_page_prot(unsigned long vm_flags)
         |                        ^~~~~~~~~~~~~~~~
   In file included from arch/m68k/include/asm/thread_info.h:6,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from arch/m68k/include/asm/irqflags.h:6,
                    from include/linux/irqflags.h:16,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/mm_types_task.h:13,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from arch/m68k/mm/init.c:11:
   arch/m68k/mm/init.c: In function 'vm_get_page_prot':
>> arch/m68k/mm/init.c:144:33: error: 'CF_PAGE_VALID' undeclared (first use in this function)
     144 |                 return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
         |                                 ^~~~~~~~~~~~~
   arch/m68k/include/asm/page.h:51:40: note: in definition of macro '__pgprot'
      51 | #define __pgprot(x)     ((pgprot_t) { (x) } )
         |                                        ^
   arch/m68k/mm/init.c:144:33: note: each undeclared identifier is reported only once for each function it appears in
     144 |                 return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
         |                                 ^~~~~~~~~~~~~
   arch/m68k/include/asm/page.h:51:40: note: in definition of macro '__pgprot'
      51 | #define __pgprot(x)     ((pgprot_t) { (x) } )
         |                                        ^
>> arch/m68k/mm/init.c:144:49: error: 'CF_PAGE_ACCESSED' undeclared (first use in this function); did you mean 'FGP_ACCESSED'?
     144 |                 return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
         |                                                 ^~~~~~~~~~~~~~~~
   arch/m68k/include/asm/page.h:51:40: note: in definition of macro '__pgprot'
      51 | #define __pgprot(x)     ((pgprot_t) { (x) } )
         |                                        ^
>> arch/m68k/mm/init.c:145:33: error: 'CF_PAGE_READABLE' undeclared (first use in this function); did you mean 'PAGE_READONLY'?
     145 |                                 CF_PAGE_READABLE);
         |                                 ^~~~~~~~~~~~~~~~
   arch/m68k/include/asm/page.h:51:40: note: in definition of macro '__pgprot'
      51 | #define __pgprot(x)     ((pgprot_t) { (x) } )
         |                                        ^
>> arch/m68k/mm/init.c:148:33: error: 'CF_PAGE_WRITABLE' undeclared (first use in this function); did you mean 'NR_PAGETABLE'?
     148 |                                 CF_PAGE_WRITABLE);
         |                                 ^~~~~~~~~~~~~~~~
   arch/m68k/include/asm/page.h:51:40: note: in definition of macro '__pgprot'
      51 | #define __pgprot(x)     ((pgprot_t) { (x) } )
         |                                        ^
>> arch/m68k/mm/init.c:154:33: error: 'CF_PAGE_EXEC' undeclared (first use in this function)
     154 |                                 CF_PAGE_EXEC);
         |                                 ^~~~~~~~~~~~
   arch/m68k/include/asm/page.h:51:40: note: in definition of macro '__pgprot'
      51 | #define __pgprot(x)     ((pgprot_t) { (x) } )
         |                                        ^
>> arch/m68k/mm/init.c:174:52: error: 'CF_PAGE_SHARED' undeclared (first use in this function); did you mean 'PAGE_SHARED'?
     174 |                                 CF_PAGE_READABLE | CF_PAGE_SHARED);
         |                                                    ^~~~~~~~~~~~~~
   arch/m68k/include/asm/page.h:51:40: note: in definition of macro '__pgprot'
      51 | #define __pgprot(x)     ((pgprot_t) { (x) } )
         |                                        ^


vim +/vm_get_page_prot +138 arch/m68k/mm/init.c

   131	
   132	#ifdef CONFIG_COLDFIRE
   133	/*
   134	 * Page protections for initialising protection_map. See mm/mmap.c
   135	 * for use. In general, the bit positions are xwr, and P-items are
   136	 * private, the S-items are shared.
   137	 */
 > 138	pgprot_t vm_get_page_prot(unsigned long vm_flags)
   139	{
   140		switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
   141		case VM_NONE:
   142			return PAGE_NONE;
   143		case VM_READ:
 > 144			return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
 > 145					CF_PAGE_READABLE);
   146		case VM_WRITE:
   147			return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
 > 148					CF_PAGE_WRITABLE);
   149		case VM_WRITE | VM_READ:
   150			return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
   151					CF_PAGE_READABLE | CF_PAGE_WRITABLE);
   152		case VM_EXEC:
   153			return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
 > 154					CF_PAGE_EXEC);
   155		case VM_EXEC | VM_READ:
   156			return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
   157					CF_PAGE_READABLE | CF_PAGE_EXEC);
   158		case VM_EXEC | VM_WRITE:
   159			return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
   160					CF_PAGE_WRITABLE | CF_PAGE_EXEC);
   161		case VM_EXEC | VM_WRITE | VM_READ:
   162			return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
   163					CF_PAGE_READABLE | CF_PAGE_WRITABLE |
   164					CF_PAGE_EXEC);
   165		case VM_SHARED:
   166			return PAGE_NONE;
   167		case VM_SHARED | VM_READ:
   168			return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
   169					CF_PAGE_READABLE);
   170		case VM_SHARED | VM_WRITE:
   171			return PAGE_SHARED;
   172		case VM_SHARED | VM_WRITE | VM_READ:
   173			return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
 > 174					CF_PAGE_READABLE | CF_PAGE_SHARED);
   175		case VM_SHARED | VM_EXEC:
   176			return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
   177					CF_PAGE_EXEC);
   178		case VM_SHARED | VM_EXEC | VM_READ:
   179			return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
   180					CF_PAGE_READABLE | CF_PAGE_EXEC);
   181		case VM_SHARED | VM_EXEC | VM_WRITE:
   182			return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
   183					CF_PAGE_SHARED | CF_PAGE_EXEC);
   184		case VM_SHARED | VM_EXEC | VM_WRITE | VM_READ:
   185			return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
   186					CF_PAGE_READABLE | CF_PAGE_SHARED |
   187					CF_PAGE_EXEC);
   188		default:
   189			BUILD_BUG();
   190		}
   191	}
   192	#endif
   193	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
