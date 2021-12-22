Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BDC47CBFF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 05:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242307AbhLVEQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 23:16:36 -0500
Received: from mga09.intel.com ([134.134.136.24]:4456 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242205AbhLVEQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 23:16:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640146594; x=1671682594;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yZ8dxGoPrJZXz/i00vV+0R8ve859BTlAoB4X2DkskOs=;
  b=b3s2TTwetLWnp0IqgL1VhyjKqf49A3Ui5qCP95nh1Hzj2GhwPkqMeyYc
   U/nBv/bWUYPq5xcpgyG8lh2fYGGyvwplUGcjaaH08ey4Tenz8Gj5xyIk/
   1zVTxbJxWyT1zDZUTye2sgEi1rw6hTdbMpL9TJNAXVCjH04ZswXCULqO2
   UUBUiSzTas9TrWD0b6C3D7IufyWkB9ZgA+VPJN49zh0eWFgF/2i8kofbb
   skw7pDJNsU8BDn9a9O1+wJnKs/sNANrJu0v2mk1hKacChGgLeK9n773Lw
   ibiMdFHry01A4Enr6KV9s6nJ7FJ8G5V4zOsDi9zbgUnCwZ6Xx+2t4C79z
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240348053"
X-IronPort-AV: E=Sophos;i="5.88,225,1635231600"; 
   d="scan'208";a="240348053"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 20:16:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,225,1635231600"; 
   d="scan'208";a="684886374"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 21 Dec 2021 20:16:32 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzt3I-00000o-8h; Wed, 22 Dec 2021 04:16:32 +0000
Date:   Wed, 22 Dec 2021 12:12:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbuild-all@lists.01.org,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [rw-uml:linux-next 28/29] arch/x86/kvm/mmu/spte.c:85:6: error:
 implicit declaration of function 'pat_enabled'; did you mean
 'kasan_enabled'?
Message-ID: <202112221002.dpWf8YCs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git linux-next
head:   5d0f822da145a87c38bf9162bebdce865e6ad359
commit: 59a49f02bbc8b44ed1a8b9603b1a6aa620cca3b4 [28/29] x86/mtrr: remove the mtrr_bp_init stub
config: x86_64-randconfig-a001-20211220 (https://download.01.org/0day-ci/archive/20211222/202112221002.dpWf8YCs-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git/commit/?id=59a49f02bbc8b44ed1a8b9603b1a6aa620cca3b4
        git remote add rw-uml https://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git
        git fetch --no-tags rw-uml linux-next
        git checkout 59a49f02bbc8b44ed1a8b9603b1a6aa620cca3b4
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/kvm/mmu/spte.c: In function 'kvm_is_mmio_pfn':
>> arch/x86/kvm/mmu/spte.c:85:6: error: implicit declaration of function 'pat_enabled'; did you mean 'kasan_enabled'? [-Werror=implicit-function-declaration]
      85 |    (!pat_enabled() || pat_pfn_immune_to_uc_mtrr(pfn));
         |      ^~~~~~~~~~~
         |      kasan_enabled
>> arch/x86/kvm/mmu/spte.c:85:23: error: implicit declaration of function 'pat_pfn_immune_to_uc_mtrr' [-Werror=implicit-function-declaration]
      85 |    (!pat_enabled() || pat_pfn_immune_to_uc_mtrr(pfn));
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +85 arch/x86/kvm/mmu/spte.c

5a9624affe7c74 Paolo Bonzini 2020-10-16  70  
5a9624affe7c74 Paolo Bonzini 2020-10-16  71  static bool kvm_is_mmio_pfn(kvm_pfn_t pfn)
5a9624affe7c74 Paolo Bonzini 2020-10-16  72  {
5a9624affe7c74 Paolo Bonzini 2020-10-16  73  	if (pfn_valid(pfn))
5a9624affe7c74 Paolo Bonzini 2020-10-16  74  		return !is_zero_pfn(pfn) && PageReserved(pfn_to_page(pfn)) &&
5a9624affe7c74 Paolo Bonzini 2020-10-16  75  			/*
5a9624affe7c74 Paolo Bonzini 2020-10-16  76  			 * Some reserved pages, such as those from NVDIMM
5a9624affe7c74 Paolo Bonzini 2020-10-16  77  			 * DAX devices, are not for MMIO, and can be mapped
5a9624affe7c74 Paolo Bonzini 2020-10-16  78  			 * with cached memory type for better performance.
5a9624affe7c74 Paolo Bonzini 2020-10-16  79  			 * However, the above check misconceives those pages
5a9624affe7c74 Paolo Bonzini 2020-10-16  80  			 * as MMIO, and results in KVM mapping them with UC
5a9624affe7c74 Paolo Bonzini 2020-10-16  81  			 * memory type, which would hurt the performance.
5a9624affe7c74 Paolo Bonzini 2020-10-16  82  			 * Therefore, we check the host memory type in addition
5a9624affe7c74 Paolo Bonzini 2020-10-16  83  			 * and only treat UC/UC-/WC pages as MMIO.
5a9624affe7c74 Paolo Bonzini 2020-10-16  84  			 */
5a9624affe7c74 Paolo Bonzini 2020-10-16 @85  			(!pat_enabled() || pat_pfn_immune_to_uc_mtrr(pfn));
5a9624affe7c74 Paolo Bonzini 2020-10-16  86  
5a9624affe7c74 Paolo Bonzini 2020-10-16  87  	return !e820__mapped_raw_any(pfn_to_hpa(pfn),
5a9624affe7c74 Paolo Bonzini 2020-10-16  88  				     pfn_to_hpa(pfn + 1) - 1,
5a9624affe7c74 Paolo Bonzini 2020-10-16  89  				     E820_TYPE_RAM);
5a9624affe7c74 Paolo Bonzini 2020-10-16  90  }
5a9624affe7c74 Paolo Bonzini 2020-10-16  91  

:::::: The code at line 85 was first introduced by commit
:::::: 5a9624affe7c7498fb395879d9bb613628e89e60 KVM: mmu: extract spte.h and spte.c

:::::: TO: Paolo Bonzini <pbonzini@redhat.com>
:::::: CC: Paolo Bonzini <pbonzini@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
