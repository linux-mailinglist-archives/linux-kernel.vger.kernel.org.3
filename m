Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7B54786A4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 10:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbhLQJCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 04:02:09 -0500
Received: from mga02.intel.com ([134.134.136.20]:27075 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232544AbhLQJCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 04:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639731729; x=1671267729;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4PCaldpWtbovduGDfm1gPlrd41u++3W3PVljxhmYNzc=;
  b=JkEAapK4Kwl9v+QrLkc0avxkBv0z/yyG15W9nAJ/v74xylL8vtBPhO2q
   nLSrdo8rCf9VpMfrDMgxCAx7XGfe0X5Et9U5ilJUNh6QdCRMZ5cgXZ13l
   vZ+JfYEl9x4y5tV9aMIvF6H5IuU2YgDYhtXbTIxIylvuIZ+F3Cd2xK1fa
   S+H0PaIBTgVDSeANYifqLFk3vunhfUSnZl3Vf9AVpE72N4lbuJ6ezVTnO
   3pL+PyBI1rg/crQSnRMN2FUGS5RswfImnwKTQo4J6OAh9ne3zYnOo0qMh
   wl6/Yiz7f4X90hLPcYZqC/A8hE5N/4B1slp3Qx6QqNXDBglGPbDAZOTTC
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="227002455"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="227002455"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 01:02:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="466436386"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 17 Dec 2021 01:02:02 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1my97q-0004WB-AA; Fri, 17 Dec 2021 09:02:02 +0000
Date:   Fri, 17 Dec 2021 17:01:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [intel-tdx:kvm-upstream 126/152] arch/x86/kvm/vmx/tdx_stubs.c:13:6:
 warning: no previous prototype for function 'tdx_inject_nmi'
Message-ID: <202112171611.EkYfPiKg-lkp@intel.com>
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
config: x86_64-randconfig-a013-20211216 (https://download.01.org/0day-ci/archive/20211217/202112171611.EkYfPiKg-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dd245bab9fbb364faa1581e4f92ba3119a872fba)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/e5add375b2478be4f63bfc75497bfaae0d514fa0
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream
        git checkout e5add375b2478be4f63bfc75497bfaae0d514fa0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/x86/kvm/vmx/tdx_stubs.c:4:13: warning: no previous prototype for function 'tdx_pre_kvm_init' [-Wmissing-prototypes]
   void __init tdx_pre_kvm_init(unsigned int *vcpu_size,
               ^
   arch/x86/kvm/vmx/tdx_stubs.c:4:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init tdx_pre_kvm_init(unsigned int *vcpu_size,
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:6:12: warning: no previous prototype for function 'tdx_hardware_setup' [-Wmissing-prototypes]
   int __init tdx_hardware_setup(struct kvm_x86_ops *x86_ops) { return -EOPNOTSUPP; }
              ^
   arch/x86/kvm/vmx/tdx_stubs.c:6:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __init tdx_hardware_setup(struct kvm_x86_ops *x86_ops) { return -EOPNOTSUPP; }
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:7:6: warning: no previous prototype for function 'tdx_hardware_enable' [-Wmissing-prototypes]
   void tdx_hardware_enable(void) {}
        ^
   arch/x86/kvm/vmx/tdx_stubs.c:7:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tdx_hardware_enable(void) {}
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:8:6: warning: no previous prototype for function 'tdx_hardware_disable' [-Wmissing-prototypes]
   void tdx_hardware_disable(void) {}
        ^
   arch/x86/kvm/vmx/tdx_stubs.c:8:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tdx_hardware_disable(void) {}
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:10:5: warning: no previous prototype for function 'tdx_vcpu_create' [-Wmissing-prototypes]
   int tdx_vcpu_create(struct kvm_vcpu *vcpu) { return -EOPNOTSUPP; }
       ^
   arch/x86/kvm/vmx/tdx_stubs.c:10:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int tdx_vcpu_create(struct kvm_vcpu *vcpu) { return -EOPNOTSUPP; }
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:11:6: warning: no previous prototype for function 'tdx_vcpu_free' [-Wmissing-prototypes]
   void tdx_vcpu_free(struct kvm_vcpu *vcpu) {}
        ^
   arch/x86/kvm/vmx/tdx_stubs.c:11:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tdx_vcpu_free(struct kvm_vcpu *vcpu) {}
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:12:6: warning: no previous prototype for function 'tdx_vcpu_reset' [-Wmissing-prototypes]
   void tdx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event) {}
        ^
   arch/x86/kvm/vmx/tdx_stubs.c:12:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tdx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event) {}
   ^
   static 
>> arch/x86/kvm/vmx/tdx_stubs.c:13:6: warning: no previous prototype for function 'tdx_inject_nmi' [-Wmissing-prototypes]
   void tdx_inject_nmi(struct kvm_vcpu *vcpu) {}
        ^
   arch/x86/kvm/vmx/tdx_stubs.c:13:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tdx_inject_nmi(struct kvm_vcpu *vcpu) {}
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:14:12: warning: no previous prototype for function 'tdx_vcpu_run' [-Wmissing-prototypes]
   fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu) { return EXIT_FASTPATH_NONE; }
              ^
   arch/x86/kvm/vmx/tdx_stubs.c:14:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu) { return EXIT_FASTPATH_NONE; }
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:15:6: warning: no previous prototype for function 'tdx_vcpu_load' [-Wmissing-prototypes]
   void tdx_vcpu_load(struct kvm_vcpu *vcpu, int cpu) {}
        ^
   arch/x86/kvm/vmx/tdx_stubs.c:15:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tdx_vcpu_load(struct kvm_vcpu *vcpu, int cpu) {}
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:16:6: warning: no previous prototype for function 'tdx_vcpu_put' [-Wmissing-prototypes]
   void tdx_vcpu_put(struct kvm_vcpu *vcpu) {}
        ^
   arch/x86/kvm/vmx/tdx_stubs.c:16:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tdx_vcpu_put(struct kvm_vcpu *vcpu) {}
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:17:6: warning: no previous prototype for function 'tdx_prepare_switch_to_guest' [-Wmissing-prototypes]
   void tdx_prepare_switch_to_guest(struct kvm_vcpu *vcpu) {}
        ^
   arch/x86/kvm/vmx/tdx_stubs.c:17:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tdx_prepare_switch_to_guest(struct kvm_vcpu *vcpu) {}
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:18:6: warning: no previous prototype for function 'tdx_handle_exit_irqoff' [-Wmissing-prototypes]
   void tdx_handle_exit_irqoff(struct kvm_vcpu *vcpu) {}
        ^
   arch/x86/kvm/vmx/tdx_stubs.c:18:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tdx_handle_exit_irqoff(struct kvm_vcpu *vcpu) {}
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:19:5: warning: no previous prototype for function 'tdx_handle_exit' [-Wmissing-prototypes]
   int tdx_handle_exit(struct kvm_vcpu *vcpu,
       ^
   arch/x86/kvm/vmx/tdx_stubs.c:19:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int tdx_handle_exit(struct kvm_vcpu *vcpu,
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:21:6: warning: no previous prototype for function 'tdx_is_emulated_msr' [-Wmissing-prototypes]
   bool tdx_is_emulated_msr(u32 index, bool write) { return false; }
        ^
   arch/x86/kvm/vmx/tdx_stubs.c:21:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool tdx_is_emulated_msr(u32 index, bool write) { return false; }
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:22:5: warning: no previous prototype for function 'tdx_get_msr' [-Wmissing-prototypes]
   int tdx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr) { return 1; }
       ^
   arch/x86/kvm/vmx/tdx_stubs.c:22:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int tdx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr) { return 1; }
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:23:5: warning: no previous prototype for function 'tdx_set_msr' [-Wmissing-prototypes]
   int tdx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr) { return 1; }
       ^
   arch/x86/kvm/vmx/tdx_stubs.c:23:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int tdx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr) { return 1; }
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:25:6: warning: no previous prototype for function 'tdx_apicv_post_state_restore' [-Wmissing-prototypes]
   void tdx_apicv_post_state_restore(struct kvm_vcpu *vcpu) {}
        ^
   arch/x86/kvm/vmx/tdx_stubs.c:25:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tdx_apicv_post_state_restore(struct kvm_vcpu *vcpu) {}
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:26:5: warning: no previous prototype for function 'tdx_deliver_posted_interrupt' [-Wmissing-prototypes]
   int tdx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector) { return 0; }
       ^
   arch/x86/kvm/vmx/tdx_stubs.c:26:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int tdx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector) { return 0; }
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:27:6: warning: no previous prototype for function 'tdx_get_exit_info' [-Wmissing-prototypes]
   void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
        ^
   arch/x86/kvm/vmx/tdx_stubs.c:27:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:30:5: warning: no previous prototype for function 'tdx_dev_ioctl' [-Wmissing-prototypes]
   int tdx_dev_ioctl(void __user *argp) { return -EOPNOTSUPP; }
       ^
   arch/x86/kvm/vmx/tdx_stubs.c:30:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int tdx_dev_ioctl(void __user *argp) { return -EOPNOTSUPP; }
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:31:5: warning: no previous prototype for function 'tdx_vm_ioctl' [-Wmissing-prototypes]
   int tdx_vm_ioctl(struct kvm *kvm, void __user *argp) { return -EOPNOTSUPP; }
       ^


vim +/tdx_inject_nmi +13 arch/x86/kvm/vmx/tdx_stubs.c

     9	
    10	int tdx_vcpu_create(struct kvm_vcpu *vcpu) { return -EOPNOTSUPP; }
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
