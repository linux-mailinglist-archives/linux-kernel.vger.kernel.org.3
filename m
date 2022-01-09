Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E066B488878
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 10:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbiAIJQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 04:16:33 -0500
Received: from mga07.intel.com ([134.134.136.100]:55711 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbiAIJQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 04:16:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641719791; x=1673255791;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=P7D0PM4OHDUmXxmeiLZy8Dsjc/ln6HgVX6arrmQ+DLg=;
  b=N4oWzvu8JaYISATk/LP9l0LvakqNWFvSUrT2mQBOha/AvQ5pH6d7KLf0
   wtNNRV9BjG1eXQv5/JEOug/RQjEJg+ubobDurINEFcJx2EY+fQqSCtXTa
   ObA8hOI0o+qdlLDLs1N0Vr6H7kzw73fYB8Jt7XfzzSzIz/jrepth28WTb
   eK4oDLKYyYK9yYb2ElhPcApIHEhV+G8zMkzz8T7tQkCr6O12YD5Su8Cuz
   3vdnecriLb6zEUNNJ32T1vxKfhZlzX7oiJ29SuS4cX1H1XyjXCR0KLzFa
   FfMEMS6dBWGXpPliIF/uSZDoGwveb2jPTYoMS1Tjc45ghINzSHrAeaRDO
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10221"; a="306433664"
X-IronPort-AV: E=Sophos;i="5.88,274,1635231600"; 
   d="scan'208";a="306433664"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2022 01:16:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,274,1635231600"; 
   d="scan'208";a="622376834"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 09 Jan 2022 01:16:29 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6UJQ-0001UF-NC; Sun, 09 Jan 2022 09:16:28 +0000
Date:   Sun, 9 Jan 2022 17:15:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [intel-tdx:guest-upstream 25/33] arch/x86/mm/mem_encrypt.c:69:13:
 warning: no previous prototype for function 'mem_encrypt_init'
Message-ID: <202201091704.eZKOuCWs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-upstream
head:   ce71b1628ffd76a06c99780f94767aad8e44305e
commit: 6cff98f39a336faa10ace47660265207d2f7a605 [25/33] x86/mm/cpa: Add support for TDX shared memory
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20220109/202201091704.eZKOuCWs-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f3a344d2125fa37e59bae1b0874442c650a19607)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/6cff98f39a336faa10ace47660265207d2f7a605
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-upstream
        git checkout 6cff98f39a336faa10ace47660265207d2f7a605
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/mm/mem_encrypt.c:69:13: warning: no previous prototype for function 'mem_encrypt_init' [-Wmissing-prototypes]
   void __init mem_encrypt_init(void)
               ^
   arch/x86/mm/mem_encrypt.c:69:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init mem_encrypt_init(void)
   ^
   static 
   1 warning generated.


vim +/mem_encrypt_init +69 arch/x86/mm/mem_encrypt.c

c329da7c594493 Kirill A. Shutemov 2020-03-18  67  
c329da7c594493 Kirill A. Shutemov 2020-03-18  68  /* Architecture __weak replacement functions */
c329da7c594493 Kirill A. Shutemov 2020-03-18 @69  void __init mem_encrypt_init(void)
c329da7c594493 Kirill A. Shutemov 2020-03-18  70  {
c329da7c594493 Kirill A. Shutemov 2020-03-18  71  	if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT))
c329da7c594493 Kirill A. Shutemov 2020-03-18  72  		return;
c329da7c594493 Kirill A. Shutemov 2020-03-18  73  
c329da7c594493 Kirill A. Shutemov 2020-03-18  74  	/* Call into SWIOTLB to update the SWIOTLB DMA buffers */
c329da7c594493 Kirill A. Shutemov 2020-03-18  75  	swiotlb_update_mem_attributes();
c329da7c594493 Kirill A. Shutemov 2020-03-18  76  
c329da7c594493 Kirill A. Shutemov 2020-03-18  77  	print_mem_encrypt_feature_info();
c329da7c594493 Kirill A. Shutemov 2020-03-18  78  }
c329da7c594493 Kirill A. Shutemov 2020-03-18  79  

:::::: The code at line 69 was first introduced by commit
:::::: c329da7c594493b04b3edf8941dca27fedb214c7 x86: Move common memory encryption code to mem_encrypt.c

:::::: TO: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
:::::: CC: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
