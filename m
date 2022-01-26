Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9987749C22D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 04:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiAZDfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 22:35:36 -0500
Received: from mga09.intel.com ([134.134.136.24]:14240 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229989AbiAZDff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 22:35:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643168135; x=1674704135;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mYwI8bDS9yfrx46xlY20lLzXkU2HBYLSGC1UflU8rKk=;
  b=U3QJS6ZGoxQsWisz3y0gch1bvqNUPHg69Dse25tmSp6WihHSVr5/ys4f
   JTGZzv/6GFHehLGxivFB8DshEc7+rDjST+AgEHaO0CtdQCG3BMTGHKR2R
   McOkZxf40oTq4D5vWHsT1Tnu2zI2+WgOSUoWn0OGmYX4PR7CrYhA5SrDa
   6DYOjvH2BWD42nfLKdVB/BCawWFoiQvxlytTskGClULIvgHKjDMFVpjcM
   SIJOWErGdf6GyJrauXmIoOU06pXPtAK6nOgujc4FBgjmWXIjwur1oTzG4
   g0GHRnn3bMosn526zRTHO+TDFgnpd0gORweAnzPfx/QrtGqTCWapu/9ng
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246253850"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="246253850"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 19:35:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="479753515"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 25 Jan 2022 19:35:33 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCZ5n-000KkE-Az; Wed, 26 Jan 2022 03:35:31 +0000
Date:   Wed, 26 Jan 2022 11:34:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [intel-tdx:guest-upstream 24/33] arch/x86/mm/mem_encrypt.c:69:13:
 warning: no previous prototype for function 'mem_encrypt_init'
Message-ID: <202201261113.3P3URW2n-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-upstream
head:   5891b2d3ab5941ec7f5fefaa09fdd84a46ec82f5
commit: 0484e85cb3942b81e2b07162a363bda055c762a0 [24/33] x86/mm/cpa: Add support for TDX shared memory
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20220126/202201261113.3P3URW2n-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 997e128e2a78f5a5434fc75997441ae1ee76f8a4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/0484e85cb3942b81e2b07162a363bda055c762a0
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-upstream
        git checkout 0484e85cb3942b81e2b07162a363bda055c762a0
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

20f07a044a76ae Kirill A. Shutemov 2021-12-06  67  
20f07a044a76ae Kirill A. Shutemov 2021-12-06  68  /* Architecture __weak replacement functions */
20f07a044a76ae Kirill A. Shutemov 2021-12-06 @69  void __init mem_encrypt_init(void)
20f07a044a76ae Kirill A. Shutemov 2021-12-06  70  {
20f07a044a76ae Kirill A. Shutemov 2021-12-06  71  	if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT))
20f07a044a76ae Kirill A. Shutemov 2021-12-06  72  		return;
20f07a044a76ae Kirill A. Shutemov 2021-12-06  73  
20f07a044a76ae Kirill A. Shutemov 2021-12-06  74  	/* Call into SWIOTLB to update the SWIOTLB DMA buffers */
20f07a044a76ae Kirill A. Shutemov 2021-12-06  75  	swiotlb_update_mem_attributes();
20f07a044a76ae Kirill A. Shutemov 2021-12-06  76  
20f07a044a76ae Kirill A. Shutemov 2021-12-06  77  	print_mem_encrypt_feature_info();
20f07a044a76ae Kirill A. Shutemov 2021-12-06  78  }
20f07a044a76ae Kirill A. Shutemov 2021-12-06  79  

:::::: The code at line 69 was first introduced by commit
:::::: 20f07a044a76aebaaa0603038857229b5c460d69 x86/sev: Move common memory encryption code to mem_encrypt.c

:::::: TO: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
:::::: CC: Borislav Petkov <bp@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
