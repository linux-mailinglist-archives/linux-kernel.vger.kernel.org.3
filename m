Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E404A0281
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 22:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350900AbiA1VEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 16:04:16 -0500
Received: from mga01.intel.com ([192.55.52.88]:47290 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240302AbiA1VEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 16:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643403846; x=1674939846;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=wtc0j7yTVPn/fGZgRzU9pGe00zSBwjJiSMdzaYkT8oo=;
  b=npXSamgAbiA0ozWgP687mWMKNKlsXv3CD3vNX0yielFTM2K4BWzSYfue
   fGIosUsxslWlwrSqpangQHJry76n5fVgZ6XLlC1Thvw1MMYp9y9sOc8DG
   SSVn8eI9g4ukUB1WX5iYF7HVxSrIPEKNpQrlPg3YlwKjGMyXxjhhCALHs
   3nEmNFwAI/eP7g0lrgduuhAM4qj/SrPtF9Tnp/hzoIH7LbUJhdoiGYJJG
   iawO+BZi/NVOCqoHuz+HJSHP64IwNQ0QcsEYVz/zjz9kesmj+cyNmeDOZ
   MUVhgIjnWlMARxzuisC6c2zIFM5sGfN2sConuX/GQneFgk59dxoNx27hl
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="271659604"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="271659604"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 13:04:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="480864144"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Jan 2022 13:04:02 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDYPZ-000OJY-WC; Fri, 28 Jan 2022 21:04:01 +0000
Date:   Sat, 29 Jan 2022 05:03:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [avpatel:memperf_test_v1 7/7]
 include/asm-generic/memory_model.h:26:58: error: 'vmemmap' undeclared; did
 you mean 'mem_map'?
Message-ID: <202201290422.wXXPptlV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git memperf_test_v1
head:   ad86979ac717673ec1647f1148a5c7cd214a1f39
commit: ad86979ac717673ec1647f1148a5c7cd214a1f39 [7/7] lib: Add memperf test
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20220129/202201290422.wXXPptlV-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/avpatel/linux/commit/ad86979ac717673ec1647f1148a5c7cd214a1f39
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel memperf_test_v1
        git checkout ad86979ac717673ec1647f1148a5c7cd214a1f39
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   lib/memperf_test.c: In function 'memset_perf_test':
   lib/memperf_test.c:33:15: error: implicit declaration of function 'page_to_virt'; did you mean 'phys_to_virt'? [-Werror=implicit-function-declaration]
      33 |         dst = page_to_virt(dpage);
         |               ^~~~~~~~~~~~
         |               phys_to_virt
   lib/memperf_test.c:33:13: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      33 |         dst = page_to_virt(dpage);
         |             ^
   In file included from arch/sparc/include/asm/page_64.h:130,
                    from arch/sparc/include/asm/page.h:8,
                    from include/linux/mm_types_task.h:16,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from lib/memperf_test.c:3:
>> include/asm-generic/memory_model.h:26:58: error: 'vmemmap' undeclared (first use in this function); did you mean 'mem_map'?
      26 | #define __page_to_pfn(page)     (unsigned long)((page) - vmemmap)
         |                                                          ^~~~~~~
   include/asm-generic/memory_model.h:52:21: note: in expansion of macro '__page_to_pfn'
      52 | #define page_to_pfn __page_to_pfn
         |                     ^~~~~~~~~~~~~
   lib/memperf_test.c:44:27: note: in expansion of macro 'page_to_pfn'
      44 |         free_contig_range(page_to_pfn(dpage), MEM_PAGES);
         |                           ^~~~~~~~~~~
   include/asm-generic/memory_model.h:26:58: note: each undeclared identifier is reported only once for each function it appears in
      26 | #define __page_to_pfn(page)     (unsigned long)((page) - vmemmap)
         |                                                          ^~~~~~~
   include/asm-generic/memory_model.h:52:21: note: in expansion of macro '__page_to_pfn'
      52 | #define page_to_pfn __page_to_pfn
         |                     ^~~~~~~~~~~~~
   lib/memperf_test.c:44:27: note: in expansion of macro 'page_to_pfn'
      44 |         free_contig_range(page_to_pfn(dpage), MEM_PAGES);
         |                           ^~~~~~~~~~~
   lib/memperf_test.c: In function 'memcpy_memmove_perf_test':
   lib/memperf_test.c:62:13: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      62 |         src = page_to_virt(spage);
         |             ^
   lib/memperf_test.c:64:13: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      64 |         dst = page_to_virt(dpage);
         |             ^
   In file included from arch/sparc/include/asm/page_64.h:130,
                    from arch/sparc/include/asm/page.h:8,
                    from include/linux/mm_types_task.h:16,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from lib/memperf_test.c:3:
>> include/asm-generic/memory_model.h:26:58: error: 'vmemmap' undeclared (first use in this function); did you mean 'mem_map'?
      26 | #define __page_to_pfn(page)     (unsigned long)((page) - vmemmap)
         |                                                          ^~~~~~~
   include/asm-generic/memory_model.h:52:21: note: in expansion of macro '__page_to_pfn'
      52 | #define page_to_pfn __page_to_pfn
         |                     ^~~~~~~~~~~~~
   lib/memperf_test.c:83:27: note: in expansion of macro 'page_to_pfn'
      83 |         free_contig_range(page_to_pfn(dpage), MEM_PAGES);
         |                           ^~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +26 include/asm-generic/memory_model.h

8f6aac419bd590 Christoph Lameter  2007-10-16  23  
af901ca181d92a André Goddard Rosa 2009-11-14  24  /* memmap is virtually contiguous.  */
8f6aac419bd590 Christoph Lameter  2007-10-16  25  #define __pfn_to_page(pfn)	(vmemmap + (pfn))
32272a26974d20 Martin Schwidefsky 2008-12-25 @26  #define __page_to_pfn(page)	(unsigned long)((page) - vmemmap)
8f6aac419bd590 Christoph Lameter  2007-10-16  27  

:::::: The code at line 26 was first introduced by commit
:::::: 32272a26974d2027384fd4010cd1780fca425d94 [S390] __page_to_pfn warnings

:::::: TO: Martin Schwidefsky <schwidefsky@de.ibm.com>
:::::: CC: Martin Schwidefsky <schwidefsky@de.ibm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
