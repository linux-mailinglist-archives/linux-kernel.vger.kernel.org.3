Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C1357F6B8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 21:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiGXToZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 15:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGXToX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 15:44:23 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC35DF73
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 12:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658691862; x=1690227862;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YJa7rUNklS5dsYuQGahSoOQu4ERmcNkbSrEckL26RWk=;
  b=ACCI3MNJtltn2DOG8TFUBD6EU7hx+q1jVHd6By8+/eDWrRDOoxaSUsNQ
   INDestYpntMeyz2MKU/FDaDxXcUoVSMsJ9cYTT9Ko6X9Jfx4LosZM/WnN
   Akn77RO2nqCyFNNXPOg9qF2QgBDjA5ZC3B+jH0W3AByyj7SPcux5MS5fU
   b4EAAGyqV0CVW6OGRjbtyW+E1OwAMR3T1qKKf61Nd5HlWrTxj+RHBijBr
   qIbTDoZD4t+yCd9jJZiz1iGwp8ClRcQYp0/gFeS2yEyxLJfmfFzfRYLYs
   j4EQ6g7gWVn3RJ2mJ7fNB8JKAuNMea4StNCFO2upECI5dxy21SRnzbF04
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="288751387"
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="288751387"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 12:44:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="741610976"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jul 2022 12:44:20 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFhWW-0004Ca-02;
        Sun, 24 Jul 2022 19:44:20 +0000
Date:   Mon, 25 Jul 2022 03:44:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     kbuild-all@lists.01.org, Atish Patra <Atish.Patra@wdc.com>,
        linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>
Subject: [atishp04:sstc_v5 5/5] arch/riscv/kvm/vcpu_timer.c:302:30: warning:
 variable 'csr' set but not used
Message-ID: <202207250337.g5uiYvdz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/atishp04/linux sstc_v5
head:   1b65346e11303beea1c67b3557ae56aee68e7a57
commit: 1b65346e11303beea1c67b3557ae56aee68e7a57 [5/5] RISC-V: KVM: Support sstc extension
config: riscv-randconfig-r013-20220718 (https://download.01.org/0day-ci/archive/20220725/202207250337.g5uiYvdz-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/atishp04/linux/commit/1b65346e11303beea1c67b3557ae56aee68e7a57
        git remote add atishp04 https://github.com/atishp04/linux
        git fetch --no-tags atishp04 sstc_v5
        git checkout 1b65346e11303beea1c67b3557ae56aee68e7a57
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kvm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/riscv/kvm/vcpu_timer.c: In function 'kvm_riscv_vcpu_timer_restore':
>> arch/riscv/kvm/vcpu_timer.c:302:30: warning: variable 'csr' set but not used [-Wunused-but-set-variable]
     302 |         struct kvm_vcpu_csr *csr;
         |                              ^~~
   arch/riscv/kvm/vcpu_timer.c: In function 'kvm_riscv_vcpu_timer_save':
   arch/riscv/kvm/vcpu_timer.c:327:30: warning: variable 'csr' set but not used [-Wunused-but-set-variable]
     327 |         struct kvm_vcpu_csr *csr;
         |                              ^~~


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
