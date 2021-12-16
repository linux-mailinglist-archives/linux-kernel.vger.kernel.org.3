Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82723477CDD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbhLPTyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:54:24 -0500
Received: from mga02.intel.com ([134.134.136.20]:49977 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229909AbhLPTyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:54:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639684462; x=1671220462;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lEofLuke/Ho1t0zzyelAW+oORycfQAGj8oDW1+xC0mc=;
  b=BX2eu/hu6viainlbYB2CsoOCJUDTY5YM7gCHtHMZKqjHR/pB0hL03P6/
   jTNySTokcEuvwawrACGz95qDVmDH2EzhU+ExoM/vMwhQmB/n8NPPsE4ey
   WizpcWomKTwi1aVJEffQaJ2cp7lRxG+SMjQ3uBKh05sbe0Nq2FSHMZLr0
   +3wxYY8EuqRwvAVtQ5Er0tujUPvzu2w817Nz0hfiRfXxBBIZLNrLdJ7qi
   ZSYpgxV3XMuYRIwQIZplUpFBuYCqXlxyIbyla1vaIPlsVws3lMlS7KjK4
   nlud7wpHEfPO01Nx7PuOAwpuhb/qSd2cf07HzHCPRxavanjrd122HQJle
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="226868295"
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="226868295"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 11:54:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="615286297"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 16 Dec 2021 11:54:21 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxwpY-0003jw-JX; Thu, 16 Dec 2021 19:54:20 +0000
Date:   Fri, 17 Dec 2021 03:53:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:kvm-upstream 107/152] arch/x86/kvm/vmx/tdx_stubs.c:13:12:
 error: no previous prototype for 'tdx_vcpu_run'
Message-ID: <202112170303.LkHc5A7j-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream
head:   bdfe06c17daab60c196ff80c1d98467a1d3734fa
commit: 4dce28ae6facd2c06b513bc1e6fa48e397438a3a [107/152] KVM: TDX: Implement TDX vcpu enter/exit path
config: i386-randconfig-m021-20211216 (https://download.01.org/0day-ci/archive/20211217/202112170303.LkHc5A7j-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/4dce28ae6facd2c06b513bc1e6fa48e397438a3a
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream
        git checkout 4dce28ae6facd2c06b513bc1e6fa48e397438a3a
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
>> arch/x86/kvm/vmx/tdx_stubs.c:13:12: error: no previous prototype for 'tdx_vcpu_run' [-Werror=missing-prototypes]
      13 | fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu) { return EXIT_FASTPATH_NONE; }
         |            ^~~~~~~~~~~~
>> arch/x86/kvm/vmx/tdx_stubs.c:14:6: error: no previous prototype for 'tdx_vcpu_load' [-Werror=missing-prototypes]
      14 | void tdx_vcpu_load(struct kvm_vcpu *vcpu, int cpu) {}
         |      ^~~~~~~~~~~~~
>> arch/x86/kvm/vmx/tdx_stubs.c:15:6: error: no previous prototype for 'tdx_vcpu_put' [-Werror=missing-prototypes]
      15 | void tdx_vcpu_put(struct kvm_vcpu *vcpu) {}
         |      ^~~~~~~~~~~~
>> arch/x86/kvm/vmx/tdx_stubs.c:16:6: error: no previous prototype for 'tdx_prepare_switch_to_guest' [-Werror=missing-prototypes]
      16 | void tdx_prepare_switch_to_guest(struct kvm_vcpu *vcpu) {}
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:18:5: error: no previous prototype for 'tdx_dev_ioctl' [-Werror=missing-prototypes]
      18 | int tdx_dev_ioctl(void __user *argp) { return -EOPNOTSUPP; }
         |     ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:19:5: error: no previous prototype for 'tdx_vm_ioctl' [-Werror=missing-prototypes]
      19 | int tdx_vm_ioctl(struct kvm *kvm, void __user *argp) { return -EOPNOTSUPP; }
         |     ^~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:20:5: error: no previous prototype for 'tdx_vcpu_ioctl' [-Werror=missing-prototypes]
      20 | int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp) { return -ENOPNOTSUPP; }
         |     ^~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c: In function 'tdx_vcpu_ioctl':
   arch/x86/kvm/vmx/tdx_stubs.c:20:72: error: 'ENOPNOTSUPP' undeclared (first use in this function); did you mean 'EOPNOTSUPP'?
      20 | int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp) { return -ENOPNOTSUPP; }
         |                                                                        ^~~~~~~~~~~
         |                                                                        EOPNOTSUPP
   arch/x86/kvm/vmx/tdx_stubs.c:20:72: note: each undeclared identifier is reported only once for each function it appears in
   arch/x86/kvm/vmx/tdx_stubs.c: At top level:
   arch/x86/kvm/vmx/tdx_stubs.c:22:6: error: no previous prototype for 'tdx_flush_tlb' [-Werror=missing-prototypes]
      22 | void tdx_flush_tlb(struct kvm_vcpu *vcpu) {}
         |      ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:23:6: error: no previous prototype for 'tdx_load_mmu_pgd' [-Werror=missing-prototypes]
      23 | void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level) {}
         |      ^~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c: In function 'tdx_vcpu_ioctl':
   arch/x86/kvm/vmx/tdx_stubs.c:20:85: error: control reaches end of non-void function [-Werror=return-type]
      20 | int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp) { return -ENOPNOTSUPP; }
         |                                                                                     ^
   cc1: all warnings being treated as errors


vim +/tdx_vcpu_run +13 arch/x86/kvm/vmx/tdx_stubs.c

     9	
    10	int tdx_vcpu_create(struct kvm_vcpu *vcpu) { return -EOPNOTSUPP; }
    11	void tdx_vcpu_free(struct kvm_vcpu *vcpu) {}
    12	void tdx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event) {}
  > 13	fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu) { return EXIT_FASTPATH_NONE; }
  > 14	void tdx_vcpu_load(struct kvm_vcpu *vcpu, int cpu) {}
  > 15	void tdx_vcpu_put(struct kvm_vcpu *vcpu) {}
  > 16	void tdx_prepare_switch_to_guest(struct kvm_vcpu *vcpu) {}
    17	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
