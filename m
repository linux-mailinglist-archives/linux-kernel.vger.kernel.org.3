Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D4A478377
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 04:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbhLQDDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 22:03:38 -0500
Received: from mga11.intel.com ([192.55.52.93]:18471 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232089AbhLQDDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 22:03:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639710217; x=1671246217;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=98LFEvZPX1gAfoGMOoBkBv7yxj9Hqh1d4rcB7IIi28A=;
  b=QM+unBbYpZy2mAE7b9Ry43k45ngTv/F+MAr5nWyZkjAQIeo8CmyOxc6I
   fJPMvGLIES/KmT2ORSv5S52f/hGpXtzjq/yrX1J32aCuLF4Wyg9xOuJhY
   WYjg6FTYqwx30CfYiENSO+AooauYEnF6P6mM7miVEPPm3vSk6rNEVivhJ
   r4OltmrvAa5G433gcIfGPurh8V8W/Tr7x0zSc0GTaPxBcp4aKCa/x5TYd
   wBSBUB7KIIX0qXc+IUEiqhKfSzSHb7aoeDg5pJEzg1J9pCYEJ9I++kzOC
   8eD7HDA70SSealce8PPsgNuwZdBjuEWm7n/+Uc/2NnVzl2GVG2uJgeGvK
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="237205925"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="237205925"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 19:03:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="546251600"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 16 Dec 2021 19:03:35 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1my3Ww-00049M-Jp; Fri, 17 Dec 2021 03:03:34 +0000
Date:   Fri, 17 Dec 2021 11:02:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:kvm-upstream 127/152] arch/x86/kvm/vmx/tdx_stubs.c:29:5:
 error: no previous prototype for 'tdx_smi_allowed'
Message-ID: <202112171034.iEVTvdx3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream
head:   bdfe06c17daab60c196ff80c1d98467a1d3734fa
commit: 11f826bfb08f30839cadce9dd9ee8bddaaf97e9f [127/152] KVM: TDX: silently discard SMI request
config: i386-randconfig-m021-20211216 (https://download.01.org/0day-ci/archive/20211217/202112171034.iEVTvdx3-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/11f826bfb08f30839cadce9dd9ee8bddaaf97e9f
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream
        git checkout 11f826bfb08f30839cadce9dd9ee8bddaaf97e9f
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
   arch/x86/kvm/vmx/tdx_stubs.c:13:6: error: no previous prototype for 'tdx_inject_nmi' [-Werror=missing-prototypes]
      13 | void tdx_inject_nmi(struct kvm_vcpu *vcpu) {}
         |      ^~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:14:12: error: no previous prototype for 'tdx_vcpu_run' [-Werror=missing-prototypes]
      14 | fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu) { return EXIT_FASTPATH_NONE; }
         |            ^~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:15:6: error: no previous prototype for 'tdx_vcpu_load' [-Werror=missing-prototypes]
      15 | void tdx_vcpu_load(struct kvm_vcpu *vcpu, int cpu) {}
         |      ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:16:6: error: no previous prototype for 'tdx_vcpu_put' [-Werror=missing-prototypes]
      16 | void tdx_vcpu_put(struct kvm_vcpu *vcpu) {}
         |      ^~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:17:6: error: no previous prototype for 'tdx_prepare_switch_to_guest' [-Werror=missing-prototypes]
      17 | void tdx_prepare_switch_to_guest(struct kvm_vcpu *vcpu) {}
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:18:6: error: no previous prototype for 'tdx_handle_exit_irqoff' [-Werror=missing-prototypes]
      18 | void tdx_handle_exit_irqoff(struct kvm_vcpu *vcpu) {}
         |      ^~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:19:5: error: no previous prototype for 'tdx_handle_exit' [-Werror=missing-prototypes]
      19 | int tdx_handle_exit(struct kvm_vcpu *vcpu,
         |     ^~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:21:6: error: no previous prototype for 'tdx_is_emulated_msr' [-Werror=missing-prototypes]
      21 | bool tdx_is_emulated_msr(u32 index, bool write) { return false; }
         |      ^~~~~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:22:5: error: no previous prototype for 'tdx_get_msr' [-Werror=missing-prototypes]
      22 | int tdx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr) { return 1; }
         |     ^~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:23:5: error: no previous prototype for 'tdx_set_msr' [-Werror=missing-prototypes]
      23 | int tdx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr) { return 1; }
         |     ^~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:25:6: error: no previous prototype for 'tdx_apicv_post_state_restore' [-Werror=missing-prototypes]
      25 | void tdx_apicv_post_state_restore(struct kvm_vcpu *vcpu) {}
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:26:5: error: no previous prototype for 'tdx_deliver_posted_interrupt' [-Werror=missing-prototypes]
      26 | int tdx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector) { return 0; }
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:27:6: error: no previous prototype for 'tdx_get_exit_info' [-Werror=missing-prototypes]
      27 | void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
         |      ^~~~~~~~~~~~~~~~~
>> arch/x86/kvm/vmx/tdx_stubs.c:29:5: error: no previous prototype for 'tdx_smi_allowed' [-Werror=missing-prototypes]
      29 | int tdx_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection) { return false; }
         |     ^~~~~~~~~~~~~~~
>> arch/x86/kvm/vmx/tdx_stubs.c:30:5: error: no previous prototype for 'tdx_enter_smm' [-Werror=missing-prototypes]
      30 | int tdx_enter_smm(struct kvm_vcpu *vcpu, char *smstate) { return 0; }
         |     ^~~~~~~~~~~~~
>> arch/x86/kvm/vmx/tdx_stubs.c:31:5: error: no previous prototype for 'tdx_leave_smm' [-Werror=missing-prototypes]
      31 | int tdx_leave_smm(struct kvm_vcpu *vcpu, const char *smstate) { return 0; }
         |     ^~~~~~~~~~~~~
>> arch/x86/kvm/vmx/tdx_stubs.c:32:6: error: no previous prototype for 'tdx_enable_smi_window' [-Werror=missing-prototypes]
      32 | void tdx_enable_smi_window(struct kvm_vcpu *vcpu) {}
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:34:5: error: no previous prototype for 'tdx_dev_ioctl' [-Werror=missing-prototypes]
      34 | int tdx_dev_ioctl(void __user *argp) { return -EOPNOTSUPP; }
         |     ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:35:5: error: no previous prototype for 'tdx_vm_ioctl' [-Werror=missing-prototypes]
      35 | int tdx_vm_ioctl(struct kvm *kvm, void __user *argp) { return -EOPNOTSUPP; }
         |     ^~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:36:5: error: no previous prototype for 'tdx_vcpu_ioctl' [-Werror=missing-prototypes]
      36 | int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp) { return -ENOPNOTSUPP; }
         |     ^~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c: In function 'tdx_vcpu_ioctl':
   arch/x86/kvm/vmx/tdx_stubs.c:36:72: error: 'ENOPNOTSUPP' undeclared (first use in this function); did you mean 'EOPNOTSUPP'?
      36 | int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp) { return -ENOPNOTSUPP; }
         |                                                                        ^~~~~~~~~~~
         |                                                                        EOPNOTSUPP
   arch/x86/kvm/vmx/tdx_stubs.c:36:72: note: each undeclared identifier is reported only once for each function it appears in
   arch/x86/kvm/vmx/tdx_stubs.c: At top level:
   arch/x86/kvm/vmx/tdx_stubs.c:38:6: error: no previous prototype for 'tdx_flush_tlb' [-Werror=missing-prototypes]
      38 | void tdx_flush_tlb(struct kvm_vcpu *vcpu) {}
         |      ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:39:6: error: no previous prototype for 'tdx_load_mmu_pgd' [-Werror=missing-prototypes]
      39 | void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level) {}
         |      ^~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c: In function 'tdx_vcpu_ioctl':
   arch/x86/kvm/vmx/tdx_stubs.c:36:85: error: control reaches end of non-void function [-Werror=return-type]
      36 | int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp) { return -ENOPNOTSUPP; }
         |                                                                                     ^
   cc1: all warnings being treated as errors


vim +/tdx_smi_allowed +29 arch/x86/kvm/vmx/tdx_stubs.c

    24	
  > 25	void tdx_apicv_post_state_restore(struct kvm_vcpu *vcpu) {}
  > 26	int tdx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector) { return 0; }
  > 27	void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
    28			u64 *info1, u64 *info2, u32 *intr_info, u32 *error_code) {}
  > 29	int tdx_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection) { return false; }
  > 30	int tdx_enter_smm(struct kvm_vcpu *vcpu, char *smstate) { return 0; }
  > 31	int tdx_leave_smm(struct kvm_vcpu *vcpu, const char *smstate) { return 0; }
  > 32	void tdx_enable_smi_window(struct kvm_vcpu *vcpu) {}
    33	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
