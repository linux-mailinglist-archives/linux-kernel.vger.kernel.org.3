Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3152447832D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 03:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhLQCbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 21:31:37 -0500
Received: from mga17.intel.com ([192.55.52.151]:62963 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhLQCbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 21:31:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639708296; x=1671244296;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eFF78Je0CtfG03hk3mp/iE7iGFSVUhT+xxQARKuzI6g=;
  b=ZEfWSiuKcMxykDZvVMOz5g3gZgTI/nPIe4Pw47CC8ji1Hw944v5z38p7
   9PCsdOqJJzmnyqpgpnGJxD+FDdPQYmsvU6b22QErvU+5HC32aNAceAcZO
   nGU30b86QFZI1krsdL5UkWrgT+TOTyceHfdhXW3CfZdmz4LfKsxrcv4s0
   3+5BkAb7M8wN9cD2fi1J29+60GtP9JeovnCAgSjAvCNzThAM/PCxjPfWk
   sy1mmXXpXOEIIbQwdy2U5KhAAjn8/6Qi5stBgN250SdpyE+nAeY+wgbu1
   g70zcTF/tpUTYi+u5VcBVL0gWHbjmChAcNmPuLnT8c4BXaEJQXA3hYyh2
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="220342384"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="220342384"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 18:31:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="506589963"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 16 Dec 2021 18:31:34 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1my31x-000472-Nc; Fri, 17 Dec 2021 02:31:33 +0000
Date:   Fri, 17 Dec 2021 10:31:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [intel-tdx:kvm-upstream 107/152] arch/x86/kvm/vmx/tdx_stubs.c:13:12:
 warning: no previous prototype for function 'tdx_vcpu_run'
Message-ID: <202112171042.JZamNPE0-lkp@intel.com>
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
config: x86_64-randconfig-a013-20211216 (https://download.01.org/0day-ci/archive/20211217/202112171042.JZamNPE0-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dd245bab9fbb364faa1581e4f92ba3119a872fba)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/4dce28ae6facd2c06b513bc1e6fa48e397438a3a
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream
        git checkout 4dce28ae6facd2c06b513bc1e6fa48e397438a3a
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
>> arch/x86/kvm/vmx/tdx_stubs.c:13:12: warning: no previous prototype for function 'tdx_vcpu_run' [-Wmissing-prototypes]
   fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu) { return EXIT_FASTPATH_NONE; }
              ^
   arch/x86/kvm/vmx/tdx_stubs.c:13:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu) { return EXIT_FASTPATH_NONE; }
   ^
   static 
>> arch/x86/kvm/vmx/tdx_stubs.c:14:6: warning: no previous prototype for function 'tdx_vcpu_load' [-Wmissing-prototypes]
   void tdx_vcpu_load(struct kvm_vcpu *vcpu, int cpu) {}
        ^
   arch/x86/kvm/vmx/tdx_stubs.c:14:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tdx_vcpu_load(struct kvm_vcpu *vcpu, int cpu) {}
   ^
   static 
>> arch/x86/kvm/vmx/tdx_stubs.c:15:6: warning: no previous prototype for function 'tdx_vcpu_put' [-Wmissing-prototypes]
   void tdx_vcpu_put(struct kvm_vcpu *vcpu) {}
        ^
   arch/x86/kvm/vmx/tdx_stubs.c:15:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tdx_vcpu_put(struct kvm_vcpu *vcpu) {}
   ^
   static 
>> arch/x86/kvm/vmx/tdx_stubs.c:16:6: warning: no previous prototype for function 'tdx_prepare_switch_to_guest' [-Wmissing-prototypes]
   void tdx_prepare_switch_to_guest(struct kvm_vcpu *vcpu) {}
        ^
   arch/x86/kvm/vmx/tdx_stubs.c:16:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tdx_prepare_switch_to_guest(struct kvm_vcpu *vcpu) {}
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:18:5: warning: no previous prototype for function 'tdx_dev_ioctl' [-Wmissing-prototypes]
   int tdx_dev_ioctl(void __user *argp) { return -EOPNOTSUPP; }
       ^
   arch/x86/kvm/vmx/tdx_stubs.c:18:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int tdx_dev_ioctl(void __user *argp) { return -EOPNOTSUPP; }
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:19:5: warning: no previous prototype for function 'tdx_vm_ioctl' [-Wmissing-prototypes]
   int tdx_vm_ioctl(struct kvm *kvm, void __user *argp) { return -EOPNOTSUPP; }
       ^
   arch/x86/kvm/vmx/tdx_stubs.c:19:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int tdx_vm_ioctl(struct kvm *kvm, void __user *argp) { return -EOPNOTSUPP; }
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:20:72: error: use of undeclared identifier 'ENOPNOTSUPP'
   int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp) { return -ENOPNOTSUPP; }
                                                                          ^
   arch/x86/kvm/vmx/tdx_stubs.c:20:5: warning: no previous prototype for function 'tdx_vcpu_ioctl' [-Wmissing-prototypes]
   int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp) { return -ENOPNOTSUPP; }
       ^
   arch/x86/kvm/vmx/tdx_stubs.c:20:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp) { return -ENOPNOTSUPP; }
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:22:6: warning: no previous prototype for function 'tdx_flush_tlb' [-Wmissing-prototypes]
   void tdx_flush_tlb(struct kvm_vcpu *vcpu) {}
        ^
   arch/x86/kvm/vmx/tdx_stubs.c:22:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tdx_flush_tlb(struct kvm_vcpu *vcpu) {}
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:23:6: warning: no previous prototype for function 'tdx_load_mmu_pgd' [-Wmissing-prototypes]
   void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level) {}
        ^
   arch/x86/kvm/vmx/tdx_stubs.c:23:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level) {}
   ^
   static 
   16 warnings and 1 error generated.


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
