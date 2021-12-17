Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D186E47811A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhLQAJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:09:32 -0500
Received: from mga07.intel.com ([134.134.136.100]:56048 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229511AbhLQAJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:09:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639699771; x=1671235771;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xXahZ070NNoNdfiO6NbmATr5TiZ4nn1A0AR2HlhpMh4=;
  b=Pzn/16+Ekeks1Yxpuk+YPXJAvHVd7WbTu/vV4M9MzinazPfTdeT6MJlq
   HdPhUGQTWs7rYZ2aYuGf1gYTxRzhBFgGSdUq73a0Aoug2K6lRhntA4bFv
   QCrXAbhmBniOyXk9LrpQxBPg3JPc8LVroPMeXD6eYnPjxho1fR09NXChZ
   +7qoHvVbMvbo8ET5syHRGIOz5ce4Ij6HahJX53BfOjXEJygeIkxM/cruF
   5eObP6c3M/JrhY3Wc+PplOl5xrftgTnIWWvIgK2eQC0E3hPxvQUBhtnOL
   TTuTyo4fSnSHEJQQdlgMRQ3jKj23J8USDxlTlZRcFV4A6fLTRzW58Gpua
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="303013710"
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="303013710"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 16:09:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="683173896"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 16 Dec 2021 16:09:30 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1my0oT-0003yx-Ib; Fri, 17 Dec 2021 00:09:29 +0000
Date:   Fri, 17 Dec 2021 08:09:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:kvm-upstream 124/152] arch/x86/kvm/vmx/tdx_stubs.c:20:6:
 error: no previous prototype for 'tdx_is_emulated_msr'
Message-ID: <202112170856.QcwFDYIN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream
head:   bdfe06c17daab60c196ff80c1d98467a1d3734fa
commit: 99eb8f4e0badbe0b353a53c07bbb43879cbd10a9 [124/152] KVM: TDX: Implement callbacks for MSR operations for TDX
config: i386-randconfig-m021-20211216 (https://download.01.org/0day-ci/archive/20211217/202112170856.QcwFDYIN-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/99eb8f4e0badbe0b353a53c07bbb43879cbd10a9
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream
        git checkout 99eb8f4e0badbe0b353a53c07bbb43879cbd10a9
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
   arch/x86/kvm/vmx/tdx_stubs.c:13:12: error: no previous prototype for 'tdx_vcpu_run' [-Werror=missing-prototypes]
      13 | fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu) { return EXIT_FASTPATH_NONE; }
         |            ^~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:14:6: error: no previous prototype for 'tdx_vcpu_load' [-Werror=missing-prototypes]
      14 | void tdx_vcpu_load(struct kvm_vcpu *vcpu, int cpu) {}
         |      ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:15:6: error: no previous prototype for 'tdx_vcpu_put' [-Werror=missing-prototypes]
      15 | void tdx_vcpu_put(struct kvm_vcpu *vcpu) {}
         |      ^~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:16:6: error: no previous prototype for 'tdx_prepare_switch_to_guest' [-Werror=missing-prototypes]
      16 | void tdx_prepare_switch_to_guest(struct kvm_vcpu *vcpu) {}
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:17:6: error: no previous prototype for 'tdx_handle_exit_irqoff' [-Werror=missing-prototypes]
      17 | void tdx_handle_exit_irqoff(struct kvm_vcpu *vcpu) {}
         |      ^~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:18:5: error: no previous prototype for 'tdx_handle_exit' [-Werror=missing-prototypes]
      18 | int tdx_handle_exit(struct kvm_vcpu *vcpu,
         |     ^~~~~~~~~~~~~~~
>> arch/x86/kvm/vmx/tdx_stubs.c:20:6: error: no previous prototype for 'tdx_is_emulated_msr' [-Werror=missing-prototypes]
      20 | bool tdx_is_emulated_msr(u32 index, bool write) { return false; }
         |      ^~~~~~~~~~~~~~~~~~~
>> arch/x86/kvm/vmx/tdx_stubs.c:21:5: error: no previous prototype for 'tdx_get_msr' [-Werror=missing-prototypes]
      21 | int tdx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr) { return 1; }
         |     ^~~~~~~~~~~
>> arch/x86/kvm/vmx/tdx_stubs.c:22:5: error: no previous prototype for 'tdx_set_msr' [-Werror=missing-prototypes]
      22 | int tdx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr) { return 1; }
         |     ^~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:24:6: error: no previous prototype for 'tdx_apicv_post_state_restore' [-Werror=missing-prototypes]
      24 | void tdx_apicv_post_state_restore(struct kvm_vcpu *vcpu) {}
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:25:5: error: no previous prototype for 'tdx_deliver_posted_interrupt' [-Werror=missing-prototypes]
      25 | int tdx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector) { return 0; }
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:26:6: error: no previous prototype for 'tdx_get_exit_info' [-Werror=missing-prototypes]
      26 | void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
         |      ^~~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:29:5: error: no previous prototype for 'tdx_dev_ioctl' [-Werror=missing-prototypes]
      29 | int tdx_dev_ioctl(void __user *argp) { return -EOPNOTSUPP; }
         |     ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:30:5: error: no previous prototype for 'tdx_vm_ioctl' [-Werror=missing-prototypes]
      30 | int tdx_vm_ioctl(struct kvm *kvm, void __user *argp) { return -EOPNOTSUPP; }
         |     ^~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:31:5: error: no previous prototype for 'tdx_vcpu_ioctl' [-Werror=missing-prototypes]
      31 | int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp) { return -ENOPNOTSUPP; }
         |     ^~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c: In function 'tdx_vcpu_ioctl':
   arch/x86/kvm/vmx/tdx_stubs.c:31:72: error: 'ENOPNOTSUPP' undeclared (first use in this function); did you mean 'EOPNOTSUPP'?
      31 | int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp) { return -ENOPNOTSUPP; }
         |                                                                        ^~~~~~~~~~~
         |                                                                        EOPNOTSUPP
   arch/x86/kvm/vmx/tdx_stubs.c:31:72: note: each undeclared identifier is reported only once for each function it appears in
   arch/x86/kvm/vmx/tdx_stubs.c: At top level:
   arch/x86/kvm/vmx/tdx_stubs.c:33:6: error: no previous prototype for 'tdx_flush_tlb' [-Werror=missing-prototypes]
      33 | void tdx_flush_tlb(struct kvm_vcpu *vcpu) {}
         |      ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:34:6: error: no previous prototype for 'tdx_load_mmu_pgd' [-Werror=missing-prototypes]
      34 | void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level) {}
         |      ^~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c: In function 'tdx_vcpu_ioctl':
   arch/x86/kvm/vmx/tdx_stubs.c:31:85: error: control reaches end of non-void function [-Werror=return-type]
      31 | int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp) { return -ENOPNOTSUPP; }
         |                                                                                     ^
   cc1: all warnings being treated as errors


vim +/tdx_is_emulated_msr +20 arch/x86/kvm/vmx/tdx_stubs.c

     9	
    10	int tdx_vcpu_create(struct kvm_vcpu *vcpu) { return -EOPNOTSUPP; }
    11	void tdx_vcpu_free(struct kvm_vcpu *vcpu) {}
    12	void tdx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event) {}
    13	fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu) { return EXIT_FASTPATH_NONE; }
    14	void tdx_vcpu_load(struct kvm_vcpu *vcpu, int cpu) {}
    15	void tdx_vcpu_put(struct kvm_vcpu *vcpu) {}
  > 16	void tdx_prepare_switch_to_guest(struct kvm_vcpu *vcpu) {}
  > 17	void tdx_handle_exit_irqoff(struct kvm_vcpu *vcpu) {}
  > 18	int tdx_handle_exit(struct kvm_vcpu *vcpu,
    19			enum exit_fastpath_completion fastpath) { return 0; }
  > 20	bool tdx_is_emulated_msr(u32 index, bool write) { return false; }
  > 21	int tdx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr) { return 1; }
  > 22	int tdx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr) { return 1; }
    23	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
