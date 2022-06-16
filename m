Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1088154DE4E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 11:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359751AbiFPJj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 05:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiFPJj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 05:39:58 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C876959312
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 02:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655372396; x=1686908396;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=W/+52W6xVzB0f3kukDyNrSKN6m+fH4uvlhVHm9n1Pg8=;
  b=cEqAy+spHFHoWZesZPz7EDsYqjzfoMsGfZM8LWtLzjcXsaLzPpn+acaD
   udMJZg9ny3UsoDxYhAA/v9L2SzF+0xdgSjXVOBB9Cz9bTOIBbvIAViEH1
   yjtKARzXi/c6Didl1XQ3EEsN33vpyOSCyDnozPC3ap6mdus2wC++5Ez1P
   z6mRE8LjffPsc4mLofrnKp1nSRPQykInLufhgQuoqq1f9QUtgFRD79zff
   x4nBXmTXQ9LQ2NglGtNfhzlI5OI30lqczdVpUaiJAqZ29kzsstb+OMK/s
   yvqUiOnWOfFCkivA3zcFE83FEIo3FMvC5ivCeUUS8EAPCzyOD0XlbMEeJ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="340865599"
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="340865599"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 02:39:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="831485598"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jun 2022 02:39:54 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1lyk-000OFd-8L;
        Thu, 16 Jun 2022 09:39:54 +0000
Date:   Thu, 16 Jun 2022 17:39:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Atish Patra <Atish.Patra@wdc.com>, linux-kernel@vger.kernel.org
Subject: [atishp04:kvm_isa_ext_v1 1/1]
 arch/riscv/include/asm/kvm_host.h:173:22: error: use of undeclared
 identifier 'RISCV_ISA_EXT_MAX'; did you mean 'KVM_RISCV_ISA_EXT_MAX'?
Message-ID: <202206161714.QeqmmF3R-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/atishp04/linux kvm_isa_ext_v1
head:   f581904c5e3c943b3ad5fbaf91606d5f5e12018a
commit: f581904c5e3c943b3ad5fbaf91606d5f5e12018a [1/1] RISC-V: KVM: Improve ISA extension by using a bitmap
config: riscv-buildonly-randconfig-r003-20220616 (https://download.01.org/0day-ci/archive/20220616/202206161714.QeqmmF3R-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f0e608de27b3d568000046eebf3712ab542979d6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/atishp04/linux/commit/f581904c5e3c943b3ad5fbaf91606d5f5e12018a
        git remote add atishp04 https://github.com/atishp04/linux
        git fetch --no-tags atishp04 kvm_isa_ext_v1
        git checkout f581904c5e3c943b3ad5fbaf91606d5f5e12018a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/riscv/kernel/asm-offsets.c:12:
>> arch/riscv/include/asm/kvm_host.h:173:22: error: use of undeclared identifier 'RISCV_ISA_EXT_MAX'; did you mean 'KVM_RISCV_ISA_EXT_MAX'?
           DECLARE_BITMAP(isa, RISCV_ISA_EXT_MAX);
                               ^~~~~~~~~~~~~~~~~
                               KVM_RISCV_ISA_EXT_MAX
   include/linux/types.h:11:35: note: expanded from macro 'DECLARE_BITMAP'
           unsigned long name[BITS_TO_LONGS(bits)]
                                            ^
   include/linux/bitops.h:19:49: note: expanded from macro 'BITS_TO_LONGS'
   #define BITS_TO_LONGS(nr)       __KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
                                                         ^
   include/uapi/linux/const.h:34:40: note: expanded from macro '__KERNEL_DIV_ROUND_UP'
   #define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
                                          ^
   arch/riscv/include/uapi/asm/kvm.h:99:2: note: 'KVM_RISCV_ISA_EXT_MAX' declared here
           KVM_RISCV_ISA_EXT_MAX,
           ^
   1 error generated.
   make[2]: *** [scripts/Makefile.build:117: arch/riscv/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1200: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +173 arch/riscv/include/asm/kvm_host.h

   164	
   165	struct kvm_vcpu_arch {
   166		/* VCPU ran at least once */
   167		bool ran_atleast_once;
   168	
   169		/* Last Host CPU on which Guest VCPU exited */
   170		int last_exit_cpu;
   171	
   172		/* ISA feature bits (similar to MISA) */
 > 173		DECLARE_BITMAP(isa, RISCV_ISA_EXT_MAX);
   174	
   175		/* SSCRATCH, STVEC, and SCOUNTEREN of Host */
   176		unsigned long host_sscratch;
   177		unsigned long host_stvec;
   178		unsigned long host_scounteren;
   179	
   180		/* CPU context of Host */
   181		struct kvm_cpu_context host_context;
   182	
   183		/* CPU context of Guest VCPU */
   184		struct kvm_cpu_context guest_context;
   185	
   186		/* CPU CSR context of Guest VCPU */
   187		struct kvm_vcpu_csr guest_csr;
   188	
   189		/* CPU context upon Guest VCPU reset */
   190		struct kvm_cpu_context guest_reset_context;
   191	
   192		/* CPU CSR context upon Guest VCPU reset */
   193		struct kvm_vcpu_csr guest_reset_csr;
   194	
   195		/*
   196		 * VCPU interrupts
   197		 *
   198		 * We have a lockless approach for tracking pending VCPU interrupts
   199		 * implemented using atomic bitops. The irqs_pending bitmap represent
   200		 * pending interrupts whereas irqs_pending_mask represent bits changed
   201		 * in irqs_pending. Our approach is modeled around multiple producer
   202		 * and single consumer problem where the consumer is the VCPU itself.
   203		 */
   204		unsigned long irqs_pending;
   205		unsigned long irqs_pending_mask;
   206	
   207		/* VCPU Timer */
   208		struct kvm_vcpu_timer timer;
   209	
   210		/* HFENCE request queue */
   211		spinlock_t hfence_lock;
   212		unsigned long hfence_head;
   213		unsigned long hfence_tail;
   214		struct kvm_riscv_hfence hfence_queue[KVM_RISCV_VCPU_MAX_HFENCE];
   215	
   216		/* MMIO instruction details */
   217		struct kvm_mmio_decode mmio_decode;
   218	
   219		/* SBI context */
   220		struct kvm_sbi_context sbi_context;
   221	
   222		/* Cache pages needed to program page tables with spinlock held */
   223		struct kvm_mmu_memory_cache mmu_page_cache;
   224	
   225		/* VCPU power-off state */
   226		bool power_off;
   227	
   228		/* Don't run the VCPU (blocked) */
   229		bool pause;
   230	};
   231	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
