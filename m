Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A27B48E0BA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 00:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238169AbiAMXFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 18:05:10 -0500
Received: from mga17.intel.com ([192.55.52.151]:34654 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238121AbiAMXFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 18:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642115109; x=1673651109;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=y852HQMw4u5D0ubyX1gpYlrd4r/IGyxUerARi8FfLFM=;
  b=D4e6FnayyzT1FZaRmtiAzid3EO7iVzsu3ouwegqlp3fIfILTsgldgJQG
   Ro5qMSDqMdZhIfv4lFeAitNSt694btuOuqeL7/yU2xJ6A6c3sj5IGGKt1
   R/+y1iIQtGimY3r9DAGd7KawMCpLiK4SLS4CjQTtCYQcPLWsR0clwJVBZ
   5D9MjZNEaeKKdv7vdSvkuKxxgp8LldmXfxlbJHay8IGfIVwiX8y8hO1fE
   xRmtFlzvtsLDUUqA9WVibHBJVk2I4N3GZ/SWVG/M0gT0Yu4sa02lS4rx9
   xwMGH/TNGyfA9MKtJ916+voY0gnhMyIGrqyTOCN7xwy6/5tqihsuRGs7x
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="224821183"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="224821183"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 15:05:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="765699287"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jan 2022 15:05:06 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n899W-0007kZ-9W; Thu, 13 Jan 2022 23:05:06 +0000
Date:   Fri, 14 Jan 2022 07:04:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [intel-tdx:guest-upstream 25/33]
 arch/x86/mm/pat/set_memory.c:2012:6: warning: variable 'ret' set but not
 used
Message-ID: <202201140659.QkMQQEy9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-upstream
head:   33b1329c49e6d5f961b29c5cafd6571a5de523f0
commit: 5364ea9ede9af9f08041cacf140f8feef077d375 [25/33] x86/mm/cpa: Add support for TDX shared memory
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220114/202201140659.QkMQQEy9-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/5364ea9ede9af9f08041cacf140f8feef077d375
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-upstream
        git checkout 5364ea9ede9af9f08041cacf140f8feef077d375
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/mm/pat/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/x86/mm/pat/set_memory.c: In function '__set_memory_enc_pgtable':
>> arch/x86/mm/pat/set_memory.c:2012:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
    2012 |  int ret;
         |      ^~~


vim +/ret +2012 arch/x86/mm/pat/set_memory.c

5364ea9ede9af9f arch/x86/mm/pat/set_memory.c Kirill A. Shutemov 2020-03-30  2004  
810a521265023a1 arch/x86/mm/pat/set_memory.c Tianyu Lan         2021-10-25  2005  /*
810a521265023a1 arch/x86/mm/pat/set_memory.c Tianyu Lan         2021-10-25  2006   * __set_memory_enc_pgtable() is used for the hypervisors that get
810a521265023a1 arch/x86/mm/pat/set_memory.c Tianyu Lan         2021-10-25  2007   * informed about "encryption" status via page tables.
810a521265023a1 arch/x86/mm/pat/set_memory.c Tianyu Lan         2021-10-25  2008   */
810a521265023a1 arch/x86/mm/pat/set_memory.c Tianyu Lan         2021-10-25  2009  static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
77bd2342d4304bd arch/x86/mm/pageattr.c       Tom Lendacky       2017-07-17  2010  {
77bd2342d4304bd arch/x86/mm/pageattr.c       Tom Lendacky       2017-07-17  2011  	struct cpa_data cpa;
77bd2342d4304bd arch/x86/mm/pageattr.c       Tom Lendacky       2017-07-17 @2012  	int ret;
77bd2342d4304bd arch/x86/mm/pageattr.c       Tom Lendacky       2017-07-17  2013  
77bd2342d4304bd arch/x86/mm/pageattr.c       Tom Lendacky       2017-07-17  2014  	/* Should not be working on unaligned addresses */
77bd2342d4304bd arch/x86/mm/pageattr.c       Tom Lendacky       2017-07-17  2015  	if (WARN_ONCE(addr & ~PAGE_MASK, "misaligned address: %#lx\n", addr))
77bd2342d4304bd arch/x86/mm/pageattr.c       Tom Lendacky       2017-07-17  2016  		addr &= PAGE_MASK;
77bd2342d4304bd arch/x86/mm/pageattr.c       Tom Lendacky       2017-07-17  2017  
77bd2342d4304bd arch/x86/mm/pageattr.c       Tom Lendacky       2017-07-17  2018  	memset(&cpa, 0, sizeof(cpa));
77bd2342d4304bd arch/x86/mm/pageattr.c       Tom Lendacky       2017-07-17  2019  	cpa.vaddr = &addr;
77bd2342d4304bd arch/x86/mm/pageattr.c       Tom Lendacky       2017-07-17  2020  	cpa.numpages = numpages;
5364ea9ede9af9f arch/x86/mm/pat/set_memory.c Kirill A. Shutemov 2020-03-30  2021  
5364ea9ede9af9f arch/x86/mm/pat/set_memory.c Kirill A. Shutemov 2020-03-30  2022  	cpa.mask_set = pgprot_cc_mask(enc);
5364ea9ede9af9f arch/x86/mm/pat/set_memory.c Kirill A. Shutemov 2020-03-30  2023  	cpa.mask_clr = pgprot_cc_mask(!enc);
5364ea9ede9af9f arch/x86/mm/pat/set_memory.c Kirill A. Shutemov 2020-03-30  2024  
77bd2342d4304bd arch/x86/mm/pageattr.c       Tom Lendacky       2017-07-17  2025  	cpa.pgd = init_mm.pgd;
77bd2342d4304bd arch/x86/mm/pageattr.c       Tom Lendacky       2017-07-17  2026  
77bd2342d4304bd arch/x86/mm/pageattr.c       Tom Lendacky       2017-07-17  2027  	/* Must avoid aliasing mappings in the highmem code */
77bd2342d4304bd arch/x86/mm/pageattr.c       Tom Lendacky       2017-07-17  2028  	kmap_flush_unused();
77bd2342d4304bd arch/x86/mm/pageattr.c       Tom Lendacky       2017-07-17  2029  	vm_unmap_aliases();
77bd2342d4304bd arch/x86/mm/pageattr.c       Tom Lendacky       2017-07-17  2030  
77bd2342d4304bd arch/x86/mm/pageattr.c       Tom Lendacky       2017-07-17  2031  	/*
5364ea9ede9af9f arch/x86/mm/pat/set_memory.c Kirill A. Shutemov 2020-03-30  2032  	 * Before changing the encryption attribute, flush caches.
5364ea9ede9af9f arch/x86/mm/pat/set_memory.c Kirill A. Shutemov 2020-03-30  2033  	 *
5364ea9ede9af9f arch/x86/mm/pat/set_memory.c Kirill A. Shutemov 2020-03-30  2034  	 * For TDX, guest is responsible for flushing caches on private->shared
5364ea9ede9af9f arch/x86/mm/pat/set_memory.c Kirill A. Shutemov 2020-03-30  2035  	 * transition. VMM is responsible for flushing on shared->private.
77bd2342d4304bd arch/x86/mm/pageattr.c       Tom Lendacky       2017-07-17  2036  	 */
5364ea9ede9af9f arch/x86/mm/pat/set_memory.c Kirill A. Shutemov 2020-03-30  2037  	if (cc_platform_has(CC_ATTR_GUEST_TDX)) {
5364ea9ede9af9f arch/x86/mm/pat/set_memory.c Kirill A. Shutemov 2020-03-30  2038  		if (!enc)
5364ea9ede9af9f arch/x86/mm/pat/set_memory.c Kirill A. Shutemov 2020-03-30  2039  			cpa_flush(&cpa, 1);
5364ea9ede9af9f arch/x86/mm/pat/set_memory.c Kirill A. Shutemov 2020-03-30  2040  	} else {
75d1cc0e05af579 arch/x86/mm/pat/set_memory.c Krish Sadhukhan    2020-09-17  2041  		cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
5364ea9ede9af9f arch/x86/mm/pat/set_memory.c Kirill A. Shutemov 2020-03-30  2042  	}
77bd2342d4304bd arch/x86/mm/pageattr.c       Tom Lendacky       2017-07-17  2043  
77bd2342d4304bd arch/x86/mm/pageattr.c       Tom Lendacky       2017-07-17  2044  	ret = __change_page_attr_set_clr(&cpa, 1);
77bd2342d4304bd arch/x86/mm/pageattr.c       Tom Lendacky       2017-07-17  2045  
77bd2342d4304bd arch/x86/mm/pageattr.c       Tom Lendacky       2017-07-17  2046  	/*
fe0937b24ff5d7b arch/x86/mm/pageattr.c       Peter Zijlstra     2018-12-03  2047  	 * After changing the encryption attribute, we need to flush TLBs again
fe0937b24ff5d7b arch/x86/mm/pageattr.c       Peter Zijlstra     2018-12-03  2048  	 * in case any speculative TLB caching occurred (but no need to flush
fe0937b24ff5d7b arch/x86/mm/pageattr.c       Peter Zijlstra     2018-12-03  2049  	 * caches again).  We could just use cpa_flush_all(), but in case TLB
fe0937b24ff5d7b arch/x86/mm/pageattr.c       Peter Zijlstra     2018-12-03  2050  	 * flushing gets optimized in the cpa_flush() path use the same logic
fe0937b24ff5d7b arch/x86/mm/pageattr.c       Peter Zijlstra     2018-12-03  2051  	 * as above.
77bd2342d4304bd arch/x86/mm/pageattr.c       Tom Lendacky       2017-07-17  2052  	 */
fe0937b24ff5d7b arch/x86/mm/pageattr.c       Peter Zijlstra     2018-12-03  2053  	cpa_flush(&cpa, 0);
77bd2342d4304bd arch/x86/mm/pageattr.c       Tom Lendacky       2017-07-17  2054  
064ce6c550a0630 arch/x86/mm/pat/set_memory.c Brijesh Singh      2021-08-24  2055  	/*
064ce6c550a0630 arch/x86/mm/pat/set_memory.c Brijesh Singh      2021-08-24  2056  	 * Notify hypervisor that a given memory range is mapped encrypted
064ce6c550a0630 arch/x86/mm/pat/set_memory.c Brijesh Singh      2021-08-24  2057  	 * or decrypted.
064ce6c550a0630 arch/x86/mm/pat/set_memory.c Brijesh Singh      2021-08-24  2058  	 */
5364ea9ede9af9f arch/x86/mm/pat/set_memory.c Kirill A. Shutemov 2020-03-30  2059  	return notify_range_enc_status_changed(addr, numpages, enc);
77bd2342d4304bd arch/x86/mm/pageattr.c       Tom Lendacky       2017-07-17  2060  }
77bd2342d4304bd arch/x86/mm/pageattr.c       Tom Lendacky       2017-07-17  2061  

:::::: The code at line 2012 was first introduced by commit
:::::: 77bd2342d4304bda7896c953d424d15deb314ca3 x86/mm: Add support for changing the memory encryption attribute

:::::: TO: Tom Lendacky <thomas.lendacky@amd.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
