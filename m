Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4C349D077
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243611AbiAZRNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:13:23 -0500
Received: from mga02.intel.com ([134.134.136.20]:16279 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236965AbiAZRNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:13:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643217199; x=1674753199;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WIgJq1vWU6jw1/jQDPrNCQhuhtK+wLmdU8VzdaGKxSI=;
  b=Si+22CeI8wyRO4aje3UNDOEIBFND29HdIWEdbxEB0/sKbU331vue70Sj
   Pqp6DExiyMUiEYz9tJyD5goxLYcnE15IEZimVHB68hlJ0zwaLZ7kF1Izy
   0prApXcMk7snNnDde0pbinpGqJSt4dyUSkztLq/Rov6AUZktTuF57StmR
   7qEsMj2DeGR74ozPEzkd7Rg2tn7Wz6tzYbiCfR8nJskmyMSgUVnFkRHQ/
   zDobfp+7qRNTDq9sSqeEdy+IyQUcvpQ9vJalhWlmtdrOSl/nQ8QapdAVF
   VIB/ygyOL0XjMWc7RCIZWgC+IviOAd0GyzDHNxxzOfLCF0nrn9+UOYFC2
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="233975418"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="233975418"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 09:11:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="696302581"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 26 Jan 2022 09:11:04 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nClp1-000LRF-Et; Wed, 26 Jan 2022 17:11:03 +0000
Date:   Thu, 27 Jan 2022 01:10:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        Will Deacon <willdeacon@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-5.10
 1026/9999] arch/arm64/kvm/hyp/include/hyp/switch.h:216:2: error: implicit
 declaration of function 'sve_cond_update_zcr_vq'
Message-ID: <202201270116.Lw5fVBBz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-5.10
head:   4b1862e4fc6967bf326107ac0d5695157f32c25d
commit: 1105b4d1cef4bc19ad20129a716194268c937eaf [1026/9999] BACKPORT: FROMGIT: KVM: arm64: Rework SVE host-save/guest-restore
config: arm64-randconfig-r022-20220124 (https://download.01.org/0day-ci/archive/20220127/202201270116.Lw5fVBBz-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 2a1b7aa016c0f4b5598806205bdfbab1ea2d92c4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/1105b4d1cef4bc19ad20129a716194268c937eaf
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-5.10
        git checkout 1105b4d1cef4bc19ad20129a716194268c937eaf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/arm64/kvm/hyp/vhe/switch.c:8:
>> arch/arm64/kvm/hyp/include/hyp/switch.h:216:2: error: implicit declaration of function 'sve_cond_update_zcr_vq' [-Werror,-Wimplicit-function-declaration]
           sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1, SYS_ZCR_EL2);
           ^
   arch/arm64/kvm/hyp/vhe/switch.c:227:17: warning: no previous prototype for function 'kvm_unexpected_el2_exception' [-Wmissing-prototypes]
   asmlinkage void kvm_unexpected_el2_exception(void)
                   ^
   arch/arm64/kvm/hyp/vhe/switch.c:227:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void kvm_unexpected_el2_exception(void)
              ^
              static 
   1 warning and 1 error generated.
--
   In file included from arch/arm64/kvm/hyp/nvhe/switch.c:8:
>> arch/arm64/kvm/hyp/include/hyp/switch.h:216:2: error: implicit declaration of function 'sve_cond_update_zcr_vq' [-Werror,-Wimplicit-function-declaration]
           sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1, SYS_ZCR_EL2);
           ^
   arch/arm64/kvm/hyp/nvhe/switch.c:282:17: warning: no previous prototype for function 'kvm_unexpected_el2_exception' [-Wmissing-prototypes]
   asmlinkage void kvm_unexpected_el2_exception(void)
                   ^
   arch/arm64/kvm/hyp/nvhe/switch.c:282:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void kvm_unexpected_el2_exception(void)
              ^
              static 
   1 warning and 1 error generated.
--
   In file included from arch/arm64/kvm/hyp/nvhe/hyp-main.c:7:
>> arch/arm64/kvm/hyp/include/hyp/switch.h:216:2: error: implicit declaration of function 'sve_cond_update_zcr_vq' [-Werror,-Wimplicit-function-declaration]
           sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1, SYS_ZCR_EL2);
           ^
   arch/arm64/kvm/hyp/nvhe/hyp-main.c:233:6: warning: no previous prototype for function 'handle_trap' [-Wmissing-prototypes]
   void handle_trap(struct kvm_cpu_context *host_ctxt)
        ^
   arch/arm64/kvm/hyp/nvhe/hyp-main.c:233:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void handle_trap(struct kvm_cpu_context *host_ctxt)
   ^
   static 
   1 warning and 1 error generated.
--
   In file included from arch/arm64/kvm/hyp/nvhe/mem_protect.c:15:
>> arch/arm64/kvm/hyp/include/hyp/switch.h:216:2: error: implicit declaration of function 'sve_cond_update_zcr_vq' [-Werror,-Wimplicit-function-declaration]
           sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1, SYS_ZCR_EL2);
           ^
   1 error generated.


vim +/sve_cond_update_zcr_vq +216 arch/arm64/kvm/hyp/include/hyp/switch.h

   213	
   214	static inline void __hyp_sve_restore_guest(struct kvm_vcpu *vcpu)
   215	{
 > 216		sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1, SYS_ZCR_EL2);
   217		__sve_restore_state(vcpu_sve_pffr(vcpu),
   218				    &vcpu->arch.ctxt.fp_regs.fpsr);
   219		write_sysreg_el1(__vcpu_sys_reg(vcpu, ZCR_EL1), SYS_ZCR);
   220	}
   221	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
