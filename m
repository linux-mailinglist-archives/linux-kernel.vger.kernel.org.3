Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51518479903
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 06:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbhLRFri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 00:47:38 -0500
Received: from mga04.intel.com ([192.55.52.120]:8908 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229729AbhLRFrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 00:47:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639806457; x=1671342457;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pV4If9Dp3fmfJH3DO68XXwXakleAL4XBU5TecZ8OLOw=;
  b=LcThwoOE9fN+vP9+NnzdCoTrlA9Jrnmqee5VS/MkmAJB7X4vWbvuB2Cp
   7HcimLZf+DcJTLqxFBwTz6/F/2MehzIkI6Fyc0mcQrPmyNJL7XqrLXvIz
   tJJjVUxuNzMJXtJD/X/HInF3iqR281dUsKuKbnMv1GCXuWQnX1WA4cgHA
   /jBrDpZ2jgaRmMAvJaoqVIznGmErO1utOZ6z1uxj+v3Bd+R1dxzfp+Puv
   gAgrKrWzHf+2Aln9IkYkscPi7HovLU+TH6iEdjZVc62YHeJmw8MeupkR4
   AW8ELF8h3ROyzqwif6kfV+IgINCn1oY3hJLWZ0/L9Q1v+CZjtlp8WM40n
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="238634142"
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="238634142"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 21:47:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="546629419"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 17 Dec 2021 21:47:34 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mySZC-0005fL-6S; Sat, 18 Dec 2021 05:47:34 +0000
Date:   Sat, 18 Dec 2021 13:46:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream 81/152] arch/x86/kvm/vmx/tdx_stubs.c:16:72:
 error: use of undeclared identifier 'ENOPNOTSUPP'
Message-ID: <202112181310.4ECj0YDS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream
head:   bdfe06c17daab60c196ff80c1d98467a1d3734fa
commit: 2a1d7e9bae19b842ad5ac81f5e0b549066b58ff7 [81/152] KVM: TDX: Do TDX specific vcpu initialization
config: x86_64-randconfig-a013-20211216 (https://download.01.org/0day-ci/archive/20211218/202112181310.4ECj0YDS-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dd245bab9fbb364faa1581e4f92ba3119a872fba)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/2a1d7e9bae19b842ad5ac81f5e0b549066b58ff7
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream
        git checkout 2a1d7e9bae19b842ad5ac81f5e0b549066b58ff7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

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
   arch/x86/kvm/vmx/tdx_stubs.c:14:5: warning: no previous prototype for function 'tdx_dev_ioctl' [-Wmissing-prototypes]
   int tdx_dev_ioctl(void __user *argp) { return -EOPNOTSUPP; }
       ^
   arch/x86/kvm/vmx/tdx_stubs.c:14:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int tdx_dev_ioctl(void __user *argp) { return -EOPNOTSUPP; }
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:15:5: warning: no previous prototype for function 'tdx_vm_ioctl' [-Wmissing-prototypes]
   int tdx_vm_ioctl(struct kvm *kvm, void __user *argp) { return -EOPNOTSUPP; }
       ^
   arch/x86/kvm/vmx/tdx_stubs.c:15:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int tdx_vm_ioctl(struct kvm *kvm, void __user *argp) { return -EOPNOTSUPP; }
   ^
   static 
>> arch/x86/kvm/vmx/tdx_stubs.c:16:72: error: use of undeclared identifier 'ENOPNOTSUPP'
   int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp) { return -ENOPNOTSUPP; }
                                                                          ^
   arch/x86/kvm/vmx/tdx_stubs.c:16:5: warning: no previous prototype for function 'tdx_vcpu_ioctl' [-Wmissing-prototypes]
   int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp) { return -ENOPNOTSUPP; }
       ^
   arch/x86/kvm/vmx/tdx_stubs.c:16:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp) { return -ENOPNOTSUPP; }
   ^
   static 
   10 warnings and 1 error generated.


vim +/ENOPNOTSUPP +16 arch/x86/kvm/vmx/tdx_stubs.c

    13	
    14	int tdx_dev_ioctl(void __user *argp) { return -EOPNOTSUPP; }
    15	int tdx_vm_ioctl(struct kvm *kvm, void __user *argp) { return -EOPNOTSUPP; }
  > 16	int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp) { return -ENOPNOTSUPP; }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
