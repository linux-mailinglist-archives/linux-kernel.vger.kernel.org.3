Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE664772D0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbhLPNOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:14:06 -0500
Received: from mga18.intel.com ([134.134.136.126]:3576 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234006AbhLPNOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:14:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639660446; x=1671196446;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DNvzDMeT+XZgO89dspmJUKtjopxAoJTg/j008G+c06o=;
  b=fEfhwyZXuCYz8/RrDuZ/cCMGFcTVG5cPIdAfJc4pGmi7Li+bjtAQkStM
   G8DqV3eWrqtA7cuplpuCOA2SzGsDGG4uWiBiSVTi0qpJ1zd0DwQu4BvBx
   e9S05wfwo6y59Kj0LAIL5LXW5KoLqQPA9wNotoM9GJxl+QoZVrYZphJIY
   KppHCgcSH4VoqeVoZazEqyDKq8yP2RXGM02Gv32ampPYxJYxE9QnnAjAe
   pokmgxEwquaxKpZwvyGvTWK+YIwvi2uzxdz9YrtlQ+tE4nur4Tamrnz05
   2ZQGb3WwofDP/lgEzupIAxxZfrgxAQh4Ekl7TF6S1jXgjLRwz/Lvju308
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="226344913"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="226344913"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 05:14:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="506274340"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 16 Dec 2021 05:14:02 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxqa9-0003Bb-Si; Thu, 16 Dec 2021 13:14:01 +0000
Date:   Thu, 16 Dec 2021 21:13:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream 72/152] arch/x86/kvm/vmx/tdx_stubs.c:4:13:
 warning: no previous prototype for function 'tdx_pre_kvm_init'
Message-ID: <202112162144.0WgRhoCw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream
head:   bdfe06c17daab60c196ff80c1d98467a1d3734fa
commit: bf8636a6b18c9a4a17d11dd306dcc7809db9cc9c [72/152] KVM: TDX: Stub in tdx.h with structs, accessors, and VMCS helpers
config: x86_64-randconfig-a013-20211216 (https://download.01.org/0day-ci/archive/20211216/202112162144.0WgRhoCw-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dd245bab9fbb364faa1581e4f92ba3119a872fba)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/bf8636a6b18c9a4a17d11dd306dcc7809db9cc9c
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream
        git checkout bf8636a6b18c9a4a17d11dd306dcc7809db9cc9c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kvm/vmx/tdx_stubs.c:4:13: warning: no previous prototype for function 'tdx_pre_kvm_init' [-Wmissing-prototypes]
   void __init tdx_pre_kvm_init(unsigned int *vcpu_size,
               ^
   arch/x86/kvm/vmx/tdx_stubs.c:4:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init tdx_pre_kvm_init(unsigned int *vcpu_size,
   ^
   static 
   1 warning generated.


vim +/tdx_pre_kvm_init +4 arch/x86/kvm/vmx/tdx_stubs.c

     3	
   > 4	void __init tdx_pre_kvm_init(unsigned int *vcpu_size,

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
