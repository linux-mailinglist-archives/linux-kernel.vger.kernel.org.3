Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4951947822D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 02:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhLQBbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 20:31:35 -0500
Received: from mga18.intel.com ([134.134.136.126]:7311 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbhLQBbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 20:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639704694; x=1671240694;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ypKpg1yUs6DllvxG5E3wQNWOcvJF9DYjAoPkfeVehmo=;
  b=HIkZhbKAiWT5tZrbVPq3LBEi+PBH7+rKJTNwt9kmMroO4SlVKuu2140i
   ECFV/1jaZQc46L9laDU29ktzgktpxiITc/gVFQUPlCI6mwqvOBWBgDnoL
   EIgKqW0vV3YzCaSsOyAtkeK3RJXOBmeH89JYjhvjZtqmgpo+cDQDOozqO
   +HTYoQiX6w4W8LEmkut13E5d+59mBylT1J4v6e2BEJqT4dEqfe/oo0JgZ
   nQA9CCrCAliFvHtjMvV1NILN/9QJ9RHpvnWjEMiUEgjKwBFF7H7IHEyfZ
   t4aQMuQ6qFFsAy5CPiMdLJwDSn26l2wvGIHnaaPLC2FYLroZ9FE4o6GaP
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="226512802"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="226512802"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 17:31:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="506573953"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 16 Dec 2021 17:31:33 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1my25s-00044A-CG; Fri, 17 Dec 2021 01:31:32 +0000
Date:   Fri, 17 Dec 2021 09:30:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:kvm-upstream 126/152] arch/x86/kvm/vmx/tdx_stubs.c:13:6:
 error: no previous prototype for 'tdx_inject_nmi'
Message-ID: <202112170946.DGxiGpMv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream
head:   bdfe06c17daab60c196ff80c1d98467a1d3734fa
commit: e5add375b2478be4f63bfc75497bfaae0d514fa0 [126/152] KVM: TDX: Implement methods to inject NMI
config: i386-randconfig-m021-20211216 (https://download.01.org/0day-ci/archive/20211217/202112170946.DGxiGpMv-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/e5add375b2478be4f63bfc75497bfaae0d514fa0
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream
        git checkout e5add375b2478be4f63bfc75497bfaae0d514fa0
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
>> arch/x86/kvm/vmx/tdx_stubs.c:13:6: error: no previous prototype for 'tdx_inject_nmi' [-Werror=missing-prototypes]
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
   arch/x86/kvm/vmx/tdx_stubs.c:30:5: error: no previous prototype for 'tdx_dev_ioctl' [-Werror=missing-prototypes]
      30 | int tdx_dev_ioctl(void __user *argp) { return -EOPNOTSUPP; }
         |     ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:31:5: error: no previous prototype for 'tdx_vm_ioctl' [-Werror=missing-prototypes]
      31 | int tdx_vm_ioctl(struct kvm *kvm, void __user *argp) { return -EOPNOTSUPP; }
         |     ^~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:32:5: error: no previous prototype for 'tdx_vcpu_ioctl' [-Werror=missing-prototypes]
      32 | int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp) { return -ENOPNOTSUPP; }
         |     ^~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c: In function 'tdx_vcpu_ioctl':
   arch/x86/kvm/vmx/tdx_stubs.c:32:72: error: 'ENOPNOTSUPP' undeclared (first use in this function); did you mean 'EOPNOTSUPP'?
      32 | int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp) { return -ENOPNOTSUPP; }
         |                                                                        ^~~~~~~~~~~
         |                                                                        EOPNOTSUPP
   arch/x86/kvm/vmx/tdx_stubs.c:32:72: note: each undeclared identifier is reported only once for each function it appears in
   arch/x86/kvm/vmx/tdx_stubs.c: At top level:
   arch/x86/kvm/vmx/tdx_stubs.c:34:6: error: no previous prototype for 'tdx_flush_tlb' [-Werror=missing-prototypes]
      34 | void tdx_flush_tlb(struct kvm_vcpu *vcpu) {}
         |      ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:35:6: error: no previous prototype for 'tdx_load_mmu_pgd' [-Werror=missing-prototypes]
      35 | void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level) {}
         |      ^~~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c: In function 'tdx_vcpu_ioctl':
   arch/x86/kvm/vmx/tdx_stubs.c:32:85: error: control reaches end of non-void function [-Werror=return-type]
      32 | int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp) { return -ENOPNOTSUPP; }
         |                                                                                     ^
   cc1: all warnings being treated as errors


vim +/tdx_inject_nmi +13 arch/x86/kvm/vmx/tdx_stubs.c

     9	
  > 10	int tdx_vcpu_create(struct kvm_vcpu *vcpu) { return -EOPNOTSUPP; }
    11	void tdx_vcpu_free(struct kvm_vcpu *vcpu) {}
    12	void tdx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event) {}
  > 13	void tdx_inject_nmi(struct kvm_vcpu *vcpu) {}
    14	fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu) { return EXIT_FASTPATH_NONE; }
    15	void tdx_vcpu_load(struct kvm_vcpu *vcpu, int cpu) {}
    16	void tdx_vcpu_put(struct kvm_vcpu *vcpu) {}
    17	void tdx_prepare_switch_to_guest(struct kvm_vcpu *vcpu) {}
    18	void tdx_handle_exit_irqoff(struct kvm_vcpu *vcpu) {}
    19	int tdx_handle_exit(struct kvm_vcpu *vcpu,
    20			enum exit_fastpath_completion fastpath) { return 0; }
    21	bool tdx_is_emulated_msr(u32 index, bool write) { return false; }
    22	int tdx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr) { return 1; }
    23	int tdx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr) { return 1; }
    24	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
