Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3BB599A78
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 13:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348612AbiHSLGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 07:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348532AbiHSLGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:06:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0F1FEC56
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 04:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660907155; x=1692443155;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OojHl87OofFEiZuXyy3Mpun/Qp6Et0dskOZz4kO9rOU=;
  b=eIcY6YykoHd9R4FfH9FJt3icOCA2jfm1s/8my/Ut5zDEoKJLDgoyr22c
   HO3+x6TLKmpKJtQH3TpSReDTXpCpkNPkbjCshFoy0VzVg5Kr6P49mr1hK
   0ZcNP7g8GnVJ8cy6uk5vgKlPHtwn+EcHSPGM409OQQQOMu6R4ca2fF/xG
   q7U4yHp9Kn47wuxC0eX6SJG+aNCg0ztZt4dDfLgr6tikF0vsRZzsEKiBQ
   Nly4aBVgCcuIo6CihnOXjxBt0+qmYFE4+layCDy+C43jCGezlp1E7rWvY
   3AQ20Qv+BlErAqlK4xnQdf3JDHo4+s8fF02FMHlVX2VQyfH2OIP3uY9S5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="279953755"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="279953755"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 04:05:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="584622967"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 19 Aug 2022 04:05:52 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOzp2-0001Nb-0X;
        Fri, 19 Aug 2022 11:05:52 +0000
Date:   Fri, 19 Aug 2022 19:05:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Anup Patel <anup@brainfault.org>
Subject: arch/riscv/kvm/vcpu_timer.c:302:23: warning: variable 'csr' set but
 not used
Message-ID: <202208191955.gp7xM6nG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/riscv/include/asm/kvm_vcpu_timer.h
arch/riscv/include/uapi/asm/kvm.h
arch/riscv/kvm/vcpu.c
arch/riscv/kvm/vcpu_timer.c
tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4c2d0b039c5cc0112206a5b22431b577cb1c57ad
commit: 8f5cb44b1bae8520c0705ce348b30ffb1fdda43a RISC-V: KVM: Support sstc extension
date:   7 days ago
config: riscv-randconfig-r023-20220819 (https://download.01.org/0day-ci/archive/20220819/202208191955.gp7xM6nG-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 0ac597f3cacf60479ffd36b03766fa7462dabd78)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8f5cb44b1bae8520c0705ce348b30ffb1fdda43a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8f5cb44b1bae8520c0705ce348b30ffb1fdda43a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kvm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/kvm/vcpu_timer.c:302:23: warning: variable 'csr' set but not used [-Wunused-but-set-variable]
           struct kvm_vcpu_csr *csr;
                                ^
   arch/riscv/kvm/vcpu_timer.c:327:23: warning: variable 'csr' set but not used [-Wunused-but-set-variable]
           struct kvm_vcpu_csr *csr;
                                ^
   2 warnings generated.


vim +/csr +302 arch/riscv/kvm/vcpu_timer.c

   299	
   300	void kvm_riscv_vcpu_timer_restore(struct kvm_vcpu *vcpu)
   301	{
 > 302		struct kvm_vcpu_csr *csr;
   303		struct kvm_vcpu_timer *t = &vcpu->arch.timer;
   304	
   305		kvm_riscv_vcpu_update_timedelta(vcpu);
   306	
   307		if (!t->sstc_enabled)
   308			return;
   309	
   310		csr = &vcpu->arch.guest_csr;
   311	#if defined(CONFIG_32BIT)
   312		csr_write(CSR_VSTIMECMP, (u32)t->next_cycles);
   313		csr_write(CSR_VSTIMECMPH, (u32)(t->next_cycles >> 32));
   314	#else
   315		csr_write(CSR_VSTIMECMP, t->next_cycles);
   316	#endif
   317	
   318		/* timer should be enabled for the remaining operations */
   319		if (unlikely(!t->init_done))
   320			return;
   321	
   322		kvm_riscv_vcpu_timer_unblocking(vcpu);
   323	}
   324	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
