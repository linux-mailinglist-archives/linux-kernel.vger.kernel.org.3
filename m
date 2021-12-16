Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0FD476F91
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbhLPLLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:11:00 -0500
Received: from mga11.intel.com ([192.55.52.93]:65516 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231410AbhLPLK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:10:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639653059; x=1671189059;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qPGjuuJ2jSEJKch9c2WpV+j8nzgiGOo1U3ylZb6CvZ8=;
  b=JqpmRWMza+zzj4vqNkoQxyr/vhsx7B1JTMY4S7w3uQYE5dBMeSOfi0Gi
   lMISxy/jQjL9ohmMPCJEAfyEeMLsT9+RGdeHDb2gSJMvS7ZKoyfwbDwxM
   4aBCAai+swb4zvGGKgoEPgVqPCIqkPLXeT2dhSugyVVoHY8Byn7Ce7E+2
   RikoLgHzcS5s61ZIhevlZs+ff3rCVfEYK/sUDQYCcfsekykevXaX65Kz0
   V70Ti15M1j75FivXVrKB6VESpamzNmo4ZdimFov8pjsqBSYlIfoU0PxSp
   2cUOT+iWfDvC0UavOAbVTW2SBqUveaONh4/iBAYxiyiFnlC/ej/6wHDSw
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="237003219"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="237003219"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 03:10:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="615113836"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 16 Dec 2021 03:10:57 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxof3-00033L-3G; Thu, 16 Dec 2021 11:10:57 +0000
Date:   Thu, 16 Dec 2021 19:10:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:kvm-upstream 127/152] arch/x86/kvm/vmx/tdx_stubs.c:29:5:
 warning: no previous prototype for 'tdx_smi_allowed'
Message-ID: <202112161904.IbwmZ3eU-lkp@intel.com>
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
config: x86_64-randconfig-m001-20211216 (https://download.01.org/0day-ci/archive/20211216/202112161904.IbwmZ3eU-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/11f826bfb08f30839cadce9dd9ee8bddaaf97e9f
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream
        git checkout 11f826bfb08f30839cadce9dd9ee8bddaaf97e9f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/x86/kvm/vmx/tdx_stubs.c:4:13: warning: no previous prototype for 'tdx_pre_kvm_init' [-Wmissing-prototypes]
       4 | void __init tdx_pre_kvm_init(unsigned int *vcpu_size,
         |             ^~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:6:12: warning: no previous prototype for 'tdx_hardware_setup' [-Wmissing-prototypes]
       6 | int __init tdx_hardware_setup(struct kvm_x86_ops *x86_ops) { return -EOPNOTSUPP; }
         |            ^~~~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:7:6: warning: no previous prototype for 'tdx_hardware_enable' [-Wmissing-prototypes]
       7 | void tdx_hardware_enable(void) {}
         |      ^~~~~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:8:6: warning: no previous prototype for 'tdx_hardware_disable' [-Wmissing-prototypes]
       8 | void tdx_hardware_disable(void) {}
         |      ^~~~~~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:10:5: warning: no previous prototype for 'tdx_vcpu_create' [-Wmissing-prototypes]
      10 | int tdx_vcpu_create(struct kvm_vcpu *vcpu) { return -EOPNOTSUPP; }
         |     ^~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:11:6: warning: no previous prototype for 'tdx_vcpu_free' [-Wmissing-prototypes]
      11 | void tdx_vcpu_free(struct kvm_vcpu *vcpu) {}
         |      ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:12:6: warning: no previous prototype for 'tdx_vcpu_reset' [-Wmissing-prototypes]
      12 | void tdx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event) {}
         |      ^~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:13:6: warning: no previous prototype for 'tdx_inject_nmi' [-Wmissing-prototypes]
      13 | void tdx_inject_nmi(struct kvm_vcpu *vcpu) {}
         |      ^~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:14:12: warning: no previous prototype for 'tdx_vcpu_run' [-Wmissing-prototypes]
      14 | fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu) { return EXIT_FASTPATH_NONE; }
         |            ^~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:15:6: warning: no previous prototype for 'tdx_vcpu_load' [-Wmissing-prototypes]
      15 | void tdx_vcpu_load(struct kvm_vcpu *vcpu, int cpu) {}
         |      ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:16:6: warning: no previous prototype for 'tdx_vcpu_put' [-Wmissing-prototypes]
      16 | void tdx_vcpu_put(struct kvm_vcpu *vcpu) {}
         |      ^~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:17:6: warning: no previous prototype for 'tdx_prepare_switch_to_guest' [-Wmissing-prototypes]
      17 | void tdx_prepare_switch_to_guest(struct kvm_vcpu *vcpu) {}
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:18:6: warning: no previous prototype for 'tdx_handle_exit_irqoff' [-Wmissing-prototypes]
      18 | void tdx_handle_exit_irqoff(struct kvm_vcpu *vcpu) {}
         |      ^~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:19:5: warning: no previous prototype for 'tdx_handle_exit' [-Wmissing-prototypes]
      19 | int tdx_handle_exit(struct kvm_vcpu *vcpu,
         |     ^~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:21:6: warning: no previous prototype for 'tdx_is_emulated_msr' [-Wmissing-prototypes]
      21 | bool tdx_is_emulated_msr(u32 index, bool write) { return false; }
         |      ^~~~~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:22:5: warning: no previous prototype for 'tdx_get_msr' [-Wmissing-prototypes]
      22 | int tdx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr) { return 1; }
         |     ^~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:23:5: warning: no previous prototype for 'tdx_set_msr' [-Wmissing-prototypes]
      23 | int tdx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr) { return 1; }
         |     ^~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:25:6: warning: no previous prototype for 'tdx_apicv_post_state_restore' [-Wmissing-prototypes]
      25 | void tdx_apicv_post_state_restore(struct kvm_vcpu *vcpu) {}
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:26:5: warning: no previous prototype for 'tdx_deliver_posted_interrupt' [-Wmissing-prototypes]
      26 | int tdx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector) { return 0; }
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:27:6: warning: no previous prototype for 'tdx_get_exit_info' [-Wmissing-prototypes]
      27 | void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
         |      ^~~~~~~~~~~~~~~~~
>> arch/x86/kvm/vmx/tdx_stubs.c:29:5: warning: no previous prototype for 'tdx_smi_allowed' [-Wmissing-prototypes]
      29 | int tdx_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection) { return false; }
         |     ^~~~~~~~~~~~~~~
>> arch/x86/kvm/vmx/tdx_stubs.c:30:5: warning: no previous prototype for 'tdx_enter_smm' [-Wmissing-prototypes]
      30 | int tdx_enter_smm(struct kvm_vcpu *vcpu, char *smstate) { return 0; }
         |     ^~~~~~~~~~~~~
>> arch/x86/kvm/vmx/tdx_stubs.c:31:5: warning: no previous prototype for 'tdx_leave_smm' [-Wmissing-prototypes]
      31 | int tdx_leave_smm(struct kvm_vcpu *vcpu, const char *smstate) { return 0; }
         |     ^~~~~~~~~~~~~
>> arch/x86/kvm/vmx/tdx_stubs.c:32:6: warning: no previous prototype for 'tdx_enable_smi_window' [-Wmissing-prototypes]
      32 | void tdx_enable_smi_window(struct kvm_vcpu *vcpu) {}
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:34:5: warning: no previous prototype for 'tdx_dev_ioctl' [-Wmissing-prototypes]
      34 | int tdx_dev_ioctl(void __user *argp) { return -EOPNOTSUPP; }
         |     ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:35:5: warning: no previous prototype for 'tdx_vm_ioctl' [-Wmissing-prototypes]
      35 | int tdx_vm_ioctl(struct kvm *kvm, void __user *argp) { return -EOPNOTSUPP; }
         |     ^~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:36:5: warning: no previous prototype for 'tdx_vcpu_ioctl' [-Wmissing-prototypes]
      36 | int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp) { return -ENOPNOTSUPP; }
         |     ^~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c: In function 'tdx_vcpu_ioctl':
   arch/x86/kvm/vmx/tdx_stubs.c:36:72: error: 'ENOPNOTSUPP' undeclared (first use in this function); did you mean 'EOPNOTSUPP'?
      36 | int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp) { return -ENOPNOTSUPP; }
         |                                                                        ^~~~~~~~~~~
         |                                                                        EOPNOTSUPP
   arch/x86/kvm/vmx/tdx_stubs.c:36:72: note: each undeclared identifier is reported only once for each function it appears in
   arch/x86/kvm/vmx/tdx_stubs.c: At top level:
   arch/x86/kvm/vmx/tdx_stubs.c:38:6: warning: no previous prototype for 'tdx_flush_tlb' [-Wmissing-prototypes]
      38 | void tdx_flush_tlb(struct kvm_vcpu *vcpu) {}
         |      ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:39:6: warning: no previous prototype for 'tdx_load_mmu_pgd' [-Wmissing-prototypes]
      39 | void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level) {}
         |      ^~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c: In function 'tdx_vcpu_ioctl':
   arch/x86/kvm/vmx/tdx_stubs.c:36:85: error: control reaches end of non-void function [-Werror=return-type]
      36 | int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp) { return -ENOPNOTSUPP; }
         |                                                                                     ^
   cc1: some warnings being treated as errors


vim +/tdx_smi_allowed +29 arch/x86/kvm/vmx/tdx_stubs.c

    24	
    25	void tdx_apicv_post_state_restore(struct kvm_vcpu *vcpu) {}
    26	int tdx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector) { return 0; }
    27	void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
    28			u64 *info1, u64 *info2, u32 *intr_info, u32 *error_code) {}
  > 29	int tdx_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection) { return false; }
  > 30	int tdx_enter_smm(struct kvm_vcpu *vcpu, char *smstate) { return 0; }
  > 31	int tdx_leave_smm(struct kvm_vcpu *vcpu, const char *smstate) { return 0; }
  > 32	void tdx_enable_smi_window(struct kvm_vcpu *vcpu) {}
    33	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
