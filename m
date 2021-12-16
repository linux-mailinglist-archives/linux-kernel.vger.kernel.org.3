Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0135A477A73
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240141AbhLPRUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:20:48 -0500
Received: from mga03.intel.com ([134.134.136.65]:37418 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235933AbhLPRUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639675247; x=1671211247;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Rd5PmsxPC54Sa9eaKvwKRUtIOQAvf8bjBEuVyN9CNdQ=;
  b=bp/M2UYEK6E+OnAaGcNxJGcNwyXS6h65obtiKToPhVTBQYe6zoxREdqG
   QmUaRRBIcS8toY0Qk/Icuk/VlMORAV9IAKKs0QBQyUDUQT1F1kdXp+z3y
   UGOJTQRVahbbIEN5MZWi3qjNy3RS4App62RxGVIWRawgyM8ao+hBVb4zp
   dYrHRQm5IeIlX6BMyqUqgWTy+xvo+h6G89zTsGayK8xHw1s8gWmdETM3C
   m+MYU6sO69vKkWcEpcPxyW8oBF5r5AkEKqGojLcNafbZrvTCdsiovahJ2
   u9bpuQ5cPsmMbL81NeM3n1zcIJsFSXn/kDZ96HrQN0Z0clNVA/VBH3FbQ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="239496414"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="239496414"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 09:20:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="683022722"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 16 Dec 2021 09:20:13 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxuQO-0003WE-HK; Thu, 16 Dec 2021 17:20:12 +0000
Date:   Fri, 17 Dec 2021 01:20:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:kvm-upstream 99/152] arch/x86/kvm/vmx/tdx_stubs.c:18:6:
 error: no previous prototype for 'tdx_load_mmu_pgd'
Message-ID: <202112170142.ENwsI9A2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream
head:   bdfe06c17daab60c196ff80c1d98467a1d3734fa
commit: f1849f253c0fb86f0b08b979afc907b445858372 [99/152] KVM: TDX: Add load_mmu_pgd method for TDX
config: i386-randconfig-m021-20211216 (https://download.01.org/0day-ci/archive/20211217/202112170142.ENwsI9A2-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/f1849f253c0fb86f0b08b979afc907b445858372
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream
        git checkout f1849f253c0fb86f0b08b979afc907b445858372
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
   arch/x86/kvm/vmx/tdx_stubs.c:10:5: error: no previous prototype for 'tdx_vcpu_create' [-Werror=missing-prototypes]
      10 | int tdx_vcpu_create(struct kvm_vcpu *vcpu) { return -EOPNOTSUPP; }
         |     ^~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:11:6: error: no previous prototype for 'tdx_vcpu_free' [-Werror=missing-prototypes]
      11 | void tdx_vcpu_free(struct kvm_vcpu *vcpu) {}
         |      ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:12:6: error: no previous prototype for 'tdx_vcpu_reset' [-Werror=missing-prototypes]
      12 | void tdx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event) {}
         |      ^~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:14:5: error: no previous prototype for 'tdx_dev_ioctl' [-Werror=missing-prototypes]
      14 | int tdx_dev_ioctl(void __user *argp) { return -EOPNOTSUPP; }
         |     ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:15:5: error: no previous prototype for 'tdx_vm_ioctl' [-Werror=missing-prototypes]
      15 | int tdx_vm_ioctl(struct kvm *kvm, void __user *argp) { return -EOPNOTSUPP; }
         |     ^~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:16:5: error: no previous prototype for 'tdx_vcpu_ioctl' [-Werror=missing-prototypes]
      16 | int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp) { return -ENOPNOTSUPP; }
         |     ^~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c: In function 'tdx_vcpu_ioctl':
   arch/x86/kvm/vmx/tdx_stubs.c:16:72: error: 'ENOPNOTSUPP' undeclared (first use in this function); did you mean 'EOPNOTSUPP'?
      16 | int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp) { return -ENOPNOTSUPP; }
         |                                                                        ^~~~~~~~~~~
         |                                                                        EOPNOTSUPP
   arch/x86/kvm/vmx/tdx_stubs.c:16:72: note: each undeclared identifier is reported only once for each function it appears in
   arch/x86/kvm/vmx/tdx_stubs.c: At top level:
>> arch/x86/kvm/vmx/tdx_stubs.c:18:6: error: no previous prototype for 'tdx_load_mmu_pgd' [-Werror=missing-prototypes]
      18 | void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level) {}
         |      ^~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c: In function 'tdx_vcpu_ioctl':
   arch/x86/kvm/vmx/tdx_stubs.c:16:85: error: control reaches end of non-void function [-Werror=return-type]
      16 | int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp) { return -ENOPNOTSUPP; }
         |                                                                                     ^
   cc1: all warnings being treated as errors


vim +/tdx_load_mmu_pgd +18 arch/x86/kvm/vmx/tdx_stubs.c

    13	
    14	int tdx_dev_ioctl(void __user *argp) { return -EOPNOTSUPP; }
    15	int tdx_vm_ioctl(struct kvm *kvm, void __user *argp) { return -EOPNOTSUPP; }
  > 16	int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp) { return -ENOPNOTSUPP; }
    17	
  > 18	void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level) {}

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
