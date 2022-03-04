Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A348F4CCBF7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 03:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237757AbiCDCsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 21:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237744AbiCDCsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 21:48:35 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA1E2B180
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 18:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646362066; x=1677898066;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KPejFLhSLiRFwnBIsWVMsqywVX9c3siyTdMRHTdDKyg=;
  b=VPRV5Ew7VFwW2JZ+kBmgcGgioL+lVqQSAFsJofNvu64RcpdYnO+Dji4I
   WUSTL9s8ql6w/Hf7pDixuTLhJj5XX+lNt1kcw2vbREuLB7rLPxj0X2KYc
   suHeFffkUnAWHozM5XQVEqMfWgMoFBWBshbkg06ly9ojDEWsfN49BKrOu
   05UsrCZ+k1vMX/BiW7cvr//HaXIxBVLp5jVR8dx6WkW6RVR8SU3aHtvjp
   6XpPtUsxaeJzhHyd7kh62BOs5HKrwXLLBsw7MZjC8bkThkEuqgybMowgV
   nirOzav2cqCzlzE+O/9hcsHtrIfGXP3pZGKp+QjIfKEDOsnvoHyMgwYic
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="233837698"
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; 
   d="scan'208";a="233837698"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 18:47:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,153,1643702400"; 
   d="scan'208";a="552042292"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 03 Mar 2022 18:47:38 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPxyj-0001BT-TI; Fri, 04 Mar 2022 02:47:37 +0000
Date:   Fri, 4 Mar 2022 10:47:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Atish Patra <Atish.Patra@wdc.com>, linux-kernel@vger.kernel.org
Subject: [atishp04:sstc_v2 11/14] arch/riscv/kvm/vcpu.c:98:73: error:
 expected ')'
Message-ID: <202203040424.EQFdRwqc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/atishp04/linux sstc_v2
head:   6879757e47dea7a727848fd90ca30007dc5771fb
commit: 0add5712857784b48861902daaf18870e6cd41e5 [11/14] RISC-V: KVM: Remove 's' & 'u' as valid ISA extension
config: riscv-buildonly-randconfig-r001-20220303 (https://download.01.org/0day-ci/archive/20220304/202203040424.EQFdRwqc-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/atishp04/linux/commit/0add5712857784b48861902daaf18870e6cd41e5
        git remote add atishp04 https://github.com/atishp04/linux
        git fetch --no-tags atishp04 sstc_v2
        git checkout 0add5712857784b48861902daaf18870e6cd41e5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/riscv/kvm/vcpu.c:98:73: error: expected ')'
           vcpu->arch.isa = riscv_isa_extension_base(NULL) & KVM_RISCV_ISA_ALLOWED;
                                                                                  ^
   arch/riscv/kvm/vcpu.c:98:52: note: to match this '('
           vcpu->arch.isa = riscv_isa_extension_base(NULL) & KVM_RISCV_ISA_ALLOWED;
                                                             ^
   arch/riscv/kvm/vcpu.c:41:31: note: expanded from macro 'KVM_RISCV_ISA_ALLOWED'
   #define KVM_RISCV_ISA_ALLOWED   (riscv_isa_extension_mask(a) | \
                                   ^
   arch/riscv/kvm/vcpu.c:222:43: error: expected ')'
                           vcpu->arch.isa &= KVM_RISCV_ISA_ALLOWED;
                                                                  ^
   arch/riscv/kvm/vcpu.c:222:22: note: to match this '('
                           vcpu->arch.isa &= KVM_RISCV_ISA_ALLOWED;
                                             ^
   arch/riscv/kvm/vcpu.c:41:31: note: expanded from macro 'KVM_RISCV_ISA_ALLOWED'
   #define KVM_RISCV_ISA_ALLOWED   (riscv_isa_extension_mask(a) | \
                                   ^
   2 errors generated.


vim +98 arch/riscv/kvm/vcpu.c

99cdc6c18c2d81 Anup Patel          2021-09-27   87  
99cdc6c18c2d81 Anup Patel          2021-09-27   88  int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
99cdc6c18c2d81 Anup Patel          2021-09-27   89  {
a33c72faf2d73a Anup Patel          2021-09-27   90  	struct kvm_cpu_context *cntx;
de1d7b6a51dab5 Mayuresh Chitale    2022-01-31   91  	struct kvm_vcpu_csr *reset_csr = &vcpu->arch.guest_reset_csr;
a33c72faf2d73a Anup Patel          2021-09-27   92  
a33c72faf2d73a Anup Patel          2021-09-27   93  	/* Mark this VCPU never ran */
a33c72faf2d73a Anup Patel          2021-09-27   94  	vcpu->arch.ran_atleast_once = false;
cc4f602bc4365d Sean Christopherson 2021-11-04   95  	vcpu->arch.mmu_page_cache.gfp_zero = __GFP_ZERO;
a33c72faf2d73a Anup Patel          2021-09-27   96  
a33c72faf2d73a Anup Patel          2021-09-27   97  	/* Setup ISA features available to VCPU */
a33c72faf2d73a Anup Patel          2021-09-27  @98  	vcpu->arch.isa = riscv_isa_extension_base(NULL) & KVM_RISCV_ISA_ALLOWED;
a33c72faf2d73a Anup Patel          2021-09-27   99  
a33c72faf2d73a Anup Patel          2021-09-27  100  	/* Setup reset state of shadow SSTATUS and HSTATUS CSRs */
a33c72faf2d73a Anup Patel          2021-09-27  101  	cntx = &vcpu->arch.guest_reset_context;
a33c72faf2d73a Anup Patel          2021-09-27  102  	cntx->sstatus = SR_SPP | SR_SPIE;
a33c72faf2d73a Anup Patel          2021-09-27  103  	cntx->hstatus = 0;
a33c72faf2d73a Anup Patel          2021-09-27  104  	cntx->hstatus |= HSTATUS_VTW;
a33c72faf2d73a Anup Patel          2021-09-27  105  	cntx->hstatus |= HSTATUS_SPVP;
a33c72faf2d73a Anup Patel          2021-09-27  106  	cntx->hstatus |= HSTATUS_SPV;
a33c72faf2d73a Anup Patel          2021-09-27  107  
de1d7b6a51dab5 Mayuresh Chitale    2022-01-31  108  	/* By default, make CY, TM, and IR counters accessible in VU mode */
de1d7b6a51dab5 Mayuresh Chitale    2022-01-31  109  	reset_csr->scounteren = 0x7;
de1d7b6a51dab5 Mayuresh Chitale    2022-01-31  110  
3a9f66cb25e18a Atish Patra         2021-09-27  111  	/* Setup VCPU timer */
3a9f66cb25e18a Atish Patra         2021-09-27  112  	kvm_riscv_vcpu_timer_init(vcpu);
3a9f66cb25e18a Atish Patra         2021-09-27  113  
a33c72faf2d73a Anup Patel          2021-09-27  114  	/* Reset VCPU */
a33c72faf2d73a Anup Patel          2021-09-27  115  	kvm_riscv_reset_vcpu(vcpu);
a33c72faf2d73a Anup Patel          2021-09-27  116  
99cdc6c18c2d81 Anup Patel          2021-09-27  117  	return 0;
99cdc6c18c2d81 Anup Patel          2021-09-27  118  }
99cdc6c18c2d81 Anup Patel          2021-09-27  119  

:::::: The code at line 98 was first introduced by commit
:::::: a33c72faf2d73a35d85c8da4b65402a50aa7647c RISC-V: KVM: Implement VCPU create, init and destroy functions

:::::: TO: Anup Patel <anup.patel@wdc.com>
:::::: CC: Anup Patel <anup@brainfault.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
