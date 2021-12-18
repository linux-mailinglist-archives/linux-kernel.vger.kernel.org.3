Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11142479AFB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 14:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbhLRNNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 08:13:48 -0500
Received: from mga11.intel.com ([192.55.52.93]:2296 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230437AbhLRNNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 08:13:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639833226; x=1671369226;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=y4Bbl4jKdBxeeEc8XXAWWHMTCIK9Gu6H3E1Ejx8fU54=;
  b=VlLGYnPNiEE3FGU1rY4i7ENN4RWzu5SSL17dpyvSN72BaU6jAkr5BeQz
   fWMXkE0XjWs7gJMo+su10L+O3yH5y0FsnEq3onP2GthPfiZPi02TD/WyI
   xnrW+/bqBzjuuemSjYd+/U/yi+l0EFm2QXwcIdgffHpxFxoOO/DU3KAsS
   YY/bkVF/ZRV1EYtQ+IQwQv7Ld+tSp4TAEosEqz7Jb9fx5ORiK33gSYMJ0
   hTGwkSYW0DD4P9hAPhukhrUVhiXbXzBsLPb5GWDO2owVWxJz6DaXAhnZk
   TRpKLD0gtceCa8iu3jrPj5U3GaA2tDNis4LqBxLXJKHoiZVgurGtC2ZBo
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="237461629"
X-IronPort-AV: E=Sophos;i="5.88,216,1635231600"; 
   d="scan'208";a="237461629"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2021 05:13:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,216,1635231600"; 
   d="scan'208";a="683710021"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 18 Dec 2021 05:13:44 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myZWx-00060t-PX; Sat, 18 Dec 2021 13:13:43 +0000
Date:   Sat, 18 Dec 2021 21:13:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream 130/152] arch/x86/kvm/vmx/tdx_stubs.c:39:6:
 error: redefinition of 'tdx_get_exit_info'
Message-ID: <202112182135.CvRmQggM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream
head:   bdfe06c17daab60c196ff80c1d98467a1d3734fa
commit: 1e0deafa174c1fe4fc88f708c20e1e0b592bc77d [130/152] KVM: TDX: Add methods to ignore accesses to CPU state
config: x86_64-randconfig-a013-20211216 (https://download.01.org/0day-ci/archive/20211218/202112182135.CvRmQggM-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dd245bab9fbb364faa1581e4f92ba3119a872fba)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/1e0deafa174c1fe4fc88f708c20e1e0b592bc77d
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream
        git checkout 1e0deafa174c1fe4fc88f708c20e1e0b592bc77d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:20:6: warning: no previous prototype for function 'tdx_set_virtual_apic_mode' [-Wmissing-prototypes]
   void tdx_set_virtual_apic_mode(struct kvm_vcpu *vcpu) {}
        ^
   arch/x86/kvm/vmx/tdx_stubs.c:20:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tdx_set_virtual_apic_mode(struct kvm_vcpu *vcpu) {}
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:22:6: warning: no previous prototype for function 'tdx_get_exit_info' [-Wmissing-prototypes]
   void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason, u64 *info1,
        ^
   arch/x86/kvm/vmx/tdx_stubs.c:22:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason, u64 *info1,
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:25:6: warning: no previous prototype for function 'tdx_prepare_switch_to_guest' [-Wmissing-prototypes]
   void tdx_prepare_switch_to_guest(struct kvm_vcpu *vcpu) {}
        ^
   arch/x86/kvm/vmx/tdx_stubs.c:25:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tdx_prepare_switch_to_guest(struct kvm_vcpu *vcpu) {}
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:26:6: warning: no previous prototype for function 'tdx_handle_exit_irqoff' [-Wmissing-prototypes]
   void tdx_handle_exit_irqoff(struct kvm_vcpu *vcpu) {}
        ^
   arch/x86/kvm/vmx/tdx_stubs.c:26:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tdx_handle_exit_irqoff(struct kvm_vcpu *vcpu) {}
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:27:5: warning: no previous prototype for function 'tdx_handle_exit' [-Wmissing-prototypes]
   int tdx_handle_exit(struct kvm_vcpu *vcpu,
       ^
   arch/x86/kvm/vmx/tdx_stubs.c:27:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int tdx_handle_exit(struct kvm_vcpu *vcpu,
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:29:5: warning: no previous prototype for function 'tdx_get_cpl' [-Wmissing-prototypes]
   int tdx_get_cpl(struct kvm_vcpu *vcpu) { return 0; }
       ^
   arch/x86/kvm/vmx/tdx_stubs.c:29:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int tdx_get_cpl(struct kvm_vcpu *vcpu) { return 0; }
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:30:15: warning: no previous prototype for function 'tdx_get_rflags' [-Wmissing-prototypes]
   unsigned long tdx_get_rflags(struct kvm_vcpu *vcpu) { return 0; }
                 ^
   arch/x86/kvm/vmx/tdx_stubs.c:30:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   unsigned long tdx_get_rflags(struct kvm_vcpu *vcpu) { return 0; }
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:31:6: warning: no previous prototype for function 'tdx_is_emulated_msr' [-Wmissing-prototypes]
   bool tdx_is_emulated_msr(u32 index, bool write) { return false; }
        ^
   arch/x86/kvm/vmx/tdx_stubs.c:31:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool tdx_is_emulated_msr(u32 index, bool write) { return false; }
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:32:5: warning: no previous prototype for function 'tdx_get_msr' [-Wmissing-prototypes]
   int tdx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr) { return 1; }
       ^
   arch/x86/kvm/vmx/tdx_stubs.c:32:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int tdx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr) { return 1; }
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:33:5: warning: no previous prototype for function 'tdx_set_msr' [-Wmissing-prototypes]
   int tdx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr) { return 1; }
       ^
   arch/x86/kvm/vmx/tdx_stubs.c:33:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int tdx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr) { return 1; }
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:34:5: warning: no previous prototype for function 'tdx_get_segment_base' [-Wmissing-prototypes]
   u64 tdx_get_segment_base(struct kvm_vcpu *vcpu, int seg) { return 0; }
       ^
   arch/x86/kvm/vmx/tdx_stubs.c:34:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   u64 tdx_get_segment_base(struct kvm_vcpu *vcpu, int seg) { return 0; }
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:35:6: warning: no previous prototype for function 'tdx_get_segment' [-Wmissing-prototypes]
   void tdx_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg) {}
        ^
   arch/x86/kvm/vmx/tdx_stubs.c:35:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tdx_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg) {}
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:37:6: warning: no previous prototype for function 'tdx_apicv_post_state_restore' [-Wmissing-prototypes]
   void tdx_apicv_post_state_restore(struct kvm_vcpu *vcpu) {}
        ^
   arch/x86/kvm/vmx/tdx_stubs.c:37:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tdx_apicv_post_state_restore(struct kvm_vcpu *vcpu) {}
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:38:5: warning: no previous prototype for function 'tdx_deliver_posted_interrupt' [-Wmissing-prototypes]
   int tdx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector) { return 0; }
       ^
   arch/x86/kvm/vmx/tdx_stubs.c:38:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int tdx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector) { return 0; }
   ^
   static 
>> arch/x86/kvm/vmx/tdx_stubs.c:39:6: error: redefinition of 'tdx_get_exit_info'
   void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
        ^
   arch/x86/kvm/vmx/tdx_stubs.c:22:6: note: previous definition is here
   void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason, u64 *info1,
        ^
   arch/x86/kvm/vmx/tdx_stubs.c:41:5: warning: no previous prototype for function 'tdx_smi_allowed' [-Wmissing-prototypes]
   int tdx_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection) { return false; }
       ^
   arch/x86/kvm/vmx/tdx_stubs.c:41:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int tdx_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection) { return false; }
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:42:5: warning: no previous prototype for function 'tdx_enter_smm' [-Wmissing-prototypes]
   int tdx_enter_smm(struct kvm_vcpu *vcpu, char *smstate) { return 0; }
       ^
   arch/x86/kvm/vmx/tdx_stubs.c:42:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int tdx_enter_smm(struct kvm_vcpu *vcpu, char *smstate) { return 0; }
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:43:5: warning: no previous prototype for function 'tdx_leave_smm' [-Wmissing-prototypes]
   int tdx_leave_smm(struct kvm_vcpu *vcpu, const char *smstate) { return 0; }
       ^
   arch/x86/kvm/vmx/tdx_stubs.c:43:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int tdx_leave_smm(struct kvm_vcpu *vcpu, const char *smstate) { return 0; }
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:44:6: warning: no previous prototype for function 'tdx_enable_smi_window' [-Wmissing-prototypes]
   void tdx_enable_smi_window(struct kvm_vcpu *vcpu) {}
        ^
   arch/x86/kvm/vmx/tdx_stubs.c:44:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tdx_enable_smi_window(struct kvm_vcpu *vcpu) {}
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:46:5: warning: no previous prototype for function 'tdx_dev_ioctl' [-Wmissing-prototypes]
   int tdx_dev_ioctl(void __user *argp) { return -EOPNOTSUPP; }
       ^
   arch/x86/kvm/vmx/tdx_stubs.c:46:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int tdx_dev_ioctl(void __user *argp) { return -EOPNOTSUPP; }
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:47:5: warning: no previous prototype for function 'tdx_vm_ioctl' [-Wmissing-prototypes]
   int tdx_vm_ioctl(struct kvm *kvm, void __user *argp) { return -EOPNOTSUPP; }
       ^
   arch/x86/kvm/vmx/tdx_stubs.c:47:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int tdx_vm_ioctl(struct kvm *kvm, void __user *argp) { return -EOPNOTSUPP; }
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:48:72: error: use of undeclared identifier 'ENOPNOTSUPP'
   int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp) { return -ENOPNOTSUPP; }
                                                                          ^
   arch/x86/kvm/vmx/tdx_stubs.c:48:5: warning: no previous prototype for function 'tdx_vcpu_ioctl' [-Wmissing-prototypes]
   int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp) { return -ENOPNOTSUPP; }
       ^
   arch/x86/kvm/vmx/tdx_stubs.c:48:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp) { return -ENOPNOTSUPP; }
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:50:6: warning: no previous prototype for function 'tdx_flush_tlb' [-Wmissing-prototypes]
   void tdx_flush_tlb(struct kvm_vcpu *vcpu) {}
        ^
   arch/x86/kvm/vmx/tdx_stubs.c:50:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tdx_flush_tlb(struct kvm_vcpu *vcpu) {}
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:51:6: warning: no previous prototype for function 'tdx_load_mmu_pgd' [-Wmissing-prototypes]
   void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level) {}
        ^
   arch/x86/kvm/vmx/tdx_stubs.c:51:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level) {}
   ^
   static 
   37 warnings and 2 errors generated.


vim +/tdx_get_exit_info +39 arch/x86/kvm/vmx/tdx_stubs.c

bd5ba6a8b26525 Isaku Yamahata 2021-12-14  36  
dee2c199d79b20 Isaku Yamahata 2021-12-14  37  void tdx_apicv_post_state_restore(struct kvm_vcpu *vcpu) {}
dee2c199d79b20 Isaku Yamahata 2021-12-14  38  int tdx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector) { return 0; }
23fe81f995e342 Isaku Yamahata 2021-12-14 @39  void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
23fe81f995e342 Isaku Yamahata 2021-12-14  40  		u64 *info1, u64 *info2, u32 *intr_info, u32 *error_code) {}
11f826bfb08f30 Isaku Yamahata 2021-12-08  41  int tdx_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection) { return false; }
11f826bfb08f30 Isaku Yamahata 2021-12-08  42  int tdx_enter_smm(struct kvm_vcpu *vcpu, char *smstate) { return 0; }
11f826bfb08f30 Isaku Yamahata 2021-12-08  43  int tdx_leave_smm(struct kvm_vcpu *vcpu, const char *smstate) { return 0; }
11f826bfb08f30 Isaku Yamahata 2021-12-08  44  void tdx_enable_smi_window(struct kvm_vcpu *vcpu) {}
dee2c199d79b20 Isaku Yamahata 2021-12-14  45  

:::::: The code at line 39 was first introduced by commit
:::::: 23fe81f995e342b4152daa56cad4105a72277d4f KVM: TDX: Add a place holder to handle TDX VM exit

:::::: TO: Isaku Yamahata <isaku.yamahata@intel.com>
:::::: CC: Isaku Yamahata <isaku.yamahata@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
