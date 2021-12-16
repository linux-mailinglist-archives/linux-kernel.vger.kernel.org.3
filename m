Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40333477293
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237196AbhLPNE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:04:26 -0500
Received: from mga09.intel.com ([134.134.136.24]:62559 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237170AbhLPNEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:04:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639659865; x=1671195865;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oNpLkVi4GKlPIxxKcxH82U6oZs0nPLpdX9MkBy/+qu0=;
  b=Im4+KUFAHCmIyUCVApe4NSdzMpQrAmzYm27lWdOz0tyRrKB0s2xI49FN
   zt37Efby7zLWfPDBz++R0NCu7055AFtaBbycTGbCEwmnfiNV0voC7Jxar
   DIMd+NmcKaAof7Ck7odoUth7VXqFzFPQkQuiLvoLt2SGnidHEzkpLP9UL
   UVZJjblc20ZEpLBr3oTi55fWd0FjRdlG5ylXN9jFEkCeeIfEm8HpTuViB
   /M5/mCCq0XaA4lcIusDsvIAKuYcIVgiBRc5r8TVSjcFAp/1PcDDVMWmGS
   4DToXhPPP/RGSC5wXP9Ne3rdf3SlGh5K8vL/jYSBwoU5yyTFcJI5+7Fq8
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="239292545"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="239292545"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 05:04:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="464665939"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 16 Dec 2021 05:04:02 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxqQT-0003Ah-Jb; Thu, 16 Dec 2021 13:04:01 +0000
Date:   Thu, 16 Dec 2021 21:03:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [intel-tdx:kvm-upstream 74/152] arch/x86/kvm/vmx/tdx_stubs.c:10:5:
 error: no previous prototype for 'tdx_dev_ioctl'
Message-ID: <202112162154.fSEMJNMD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream
head:   bdfe06c17daab60c196ff80c1d98467a1d3734fa
commit: a7aca922f6abdf63d234853308401894d6c4106d [74/152] KVM: TDX: x86: Add support for device-scoped KVM_MEMORY_ENCRYPT_OP
config: i386-randconfig-m021-20211216 (https://download.01.org/0day-ci/archive/20211216/202112162154.fSEMJNMD-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/a7aca922f6abdf63d234853308401894d6c4106d
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream
        git checkout a7aca922f6abdf63d234853308401894d6c4106d
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/kvm/vmx/tdx_stubs.c:4:13: error: no previous prototype for 'tdx_pre_kvm_init' [-Werror=missing-prototypes]
       4 | void __init tdx_pre_kvm_init(unsigned int *vcpu_size,
         |             ^~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:6:12: error: no previous prototype for 'tdx_hardware_setup' [-Werror=missing-prototypes]
       6 | int __init tdx_hardware_setup(struct kvm_x86_ops *x86_ops) { return -EOPNOTSUPP; }
         |            ^~~~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:7:6: error: no previous prototype for 'tdx_hardware_enable' [-Werror=missing-prototypes]
       7 | void tdx_hardware_enable(void) {}
         |      ^~~~~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:8:6: error: no previous prototype for 'tdx_hardware_disable' [-Werror=missing-prototypes]
       8 | void tdx_hardware_disable(void) {}
         |      ^~~~~~~~~~~~~~~~~~~~
>> arch/x86/kvm/vmx/tdx_stubs.c:10:5: error: no previous prototype for 'tdx_dev_ioctl' [-Werror=missing-prototypes]
      10 | int tdx_dev_ioctl(void __user *argp) { return -EOPNOTSUPP; }
         |     ^~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/tdx_dev_ioctl +10 arch/x86/kvm/vmx/tdx_stubs.c

     9	
  > 10	int tdx_dev_ioctl(void __user *argp) { return -EOPNOTSUPP; }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
