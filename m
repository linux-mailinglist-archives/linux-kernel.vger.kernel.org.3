Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE7B49D568
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 23:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbiAZW11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 17:27:27 -0500
Received: from mga04.intel.com ([192.55.52.120]:55651 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbiAZW1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 17:27:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643236045; x=1674772045;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FiUdITY5Eu5ZGdXWjoskPBCnS9kcaGk9t5jjocwL+nc=;
  b=Z7hxhhkMPclGjhCu5Rdt48eUd/WhjnreCR6Dxpn4/g6VzdgNM5pVwwC9
   H+eqAv2QEqM+RCAjpi6mG6AhQ53RBYoNKPzNe7nuTx1r8PBPJx5PHodEg
   le1FJ3O1zdOuKAc0cRlA1SWM10P3DM1FeJUYIHEWqAK7G71m19tGiIMsk
   1e6RNfEYGOxg/rIlGHXK7kH/mFVvRBAmZNgcDJtDCsOJ963h8Zp+HuCLk
   +TKeECzNeEBgpWAuiiTOddIk7OZB/TjTyrrDo0ujpiLXL+dhyicKRKFgK
   oug8CjchNm+GR1iiLjfRRhQ01y3yf01BUklFFeZ+OYCSiPZ+hJ2Wou0dR
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="245503598"
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="245503598"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 14:27:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="696391770"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 26 Jan 2022 14:27:23 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCql8-000Lj7-BJ; Wed, 26 Jan 2022 22:27:22 +0000
Date:   Thu, 27 Jan 2022 06:26:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        Will Deacon <willdeacon@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-trusty-5.10
 4728/5866] arch/arm64/kvm/fpsimd.c:129:5: error: implicit declaration of
 function 'sve_cond_update_zcr_vq'
Message-ID: <202201270637.CwoQKBGC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-trusty-5.10
head:   52cdd137fae0b001197a51646289e3cbdda921d5
commit: b0e15c8c44275afef4aacfb1560e38b974b02ac8 [4728/5866] FROMGIT: KVM: arm64: Save/restore SVE state for nVHE
config: arm64-randconfig-r022-20220124 (https://download.01.org/0day-ci/archive/20220127/202201270637.CwoQKBGC-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 2a1b7aa016c0f4b5598806205bdfbab1ea2d92c4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/b0e15c8c44275afef4aacfb1560e38b974b02ac8
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-trusty-5.10
        git checkout b0e15c8c44275afef4aacfb1560e38b974b02ac8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/arm64/kvm/fpsimd.c:129:5: error: implicit declaration of function 'sve_cond_update_zcr_vq' [-Werror,-Wimplicit-function-declaration]
                                   sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1,
                                   ^
   1 error generated.


vim +/sve_cond_update_zcr_vq +129 arch/arm64/kvm/fpsimd.c

   108	
   109	/*
   110	 * Write back the vcpu FPSIMD regs if they are dirty, and invalidate the
   111	 * cpu FPSIMD regs so that they can't be spuriously reused if this vcpu
   112	 * disappears and another task or vcpu appears that recycles the same
   113	 * struct fpsimd_state.
   114	 */
   115	void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
   116	{
   117		unsigned long flags;
   118		bool host_has_sve = system_supports_sve();
   119		bool guest_has_sve = vcpu_has_sve(vcpu);
   120	
   121		local_irq_save(flags);
   122	
   123		if (vcpu->arch.flags & KVM_ARM64_FP_ENABLED) {
   124			if (guest_has_sve) {
   125				__vcpu_sys_reg(vcpu, ZCR_EL1) = read_sysreg_el1(SYS_ZCR);
   126	
   127				/* Restore the VL that was saved when bound to the CPU */
   128				if (!has_vhe())
 > 129					sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1,

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
