Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A174C5A15
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 09:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiB0IbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 03:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiB0IbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 03:31:03 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B9F4160E
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 00:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645950628; x=1677486628;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=j10G1VcLXMBXLEFFIwFDntw3fr0Vz7dkZs8XQ0beStE=;
  b=RE25MaJc0GD8OMrgjO97Rp10hBc8Or2AuaQ85JCBoXdisP8GJHeN4qjB
   TmcAHBMJqjpVoyxhwR+n6T09dbTsSM9hF92yUHOL6G5NnU9F0ZYNdKEvN
   kuVg4KY76dcO4cw6hZMYHPIZCGkYJ1qb62tVyYM2QVy+QDTDkJmwOylwV
   0jIcdJOPjLO9k1AET0UkCRAMbvO4LDl+7TWM6V7ZURMQKX5r+UN/EBlLO
   6Z50CU+LHIhGYof3uVtdjNGbeySEAIj65/WXOYNCLtBk2p/5mfINqS6s1
   7CMNVz2uJsKyzxaG9J1rjHP4G1EmuBCfGqn8bENXQ0zOgScFJQcraVj08
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10270"; a="251549522"
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="251549522"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2022 00:30:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="777796788"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 27 Feb 2022 00:30:26 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOEwj-0006Nc-Bn; Sun, 27 Feb 2022 08:30:25 +0000
Date:   Sun, 27 Feb 2022 16:29:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Atish Patra <Atish.Patra@wdc.com>, linux-kernel@vger.kernel.org
Subject: [atishp04:sstc_v1 14/14] arch/riscv/kvm/vcpu_timer.c:312:48:
 warning: shift count >= width of type
Message-ID: <202202271658.AtS8XIAq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/atishp04/linux sstc_v1
head:   8904ca0d06f70e6d150b60b72d5ce21044ac9208
commit: 8904ca0d06f70e6d150b60b72d5ce21044ac9208 [14/14] RISC-V: KVM: Support sstc extension
config: riscv-randconfig-c006-20220227 (https://download.01.org/0day-ci/archive/20220227/202202271658.AtS8XIAq-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/atishp04/linux/commit/8904ca0d06f70e6d150b60b72d5ce21044ac9208
        git remote add atishp04 https://github.com/atishp04/linux
        git fetch --no-tags atishp04 sstc_v1
        git checkout 8904ca0d06f70e6d150b60b72d5ce21044ac9208
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/kvm/vcpu_timer.c:312:48: warning: shift count >= width of type [-Wshift-count-overflow]
           csr_write(CSR_VSTIMECMPH, (u32)csr->vstimecmp >> 32);
                                                         ^  ~~
   arch/riscv/include/asm/csr.h:283:38: note: expanded from macro 'csr_write'
           unsigned long __v = (unsigned long)(val);               \
                                               ^~~
   arch/riscv/kvm/vcpu_timer.c:337:45: warning: shift count >= width of type [-Wshift-count-overflow]
           csr->vstimecmp |= csr_read(CSR_VSTIMECMPH) >> 32;
                                                      ^  ~~
   2 warnings generated.


vim +312 arch/riscv/kvm/vcpu_timer.c

   295	
   296	void kvm_riscv_vcpu_timer_restore(struct kvm_vcpu *vcpu)
   297	{
   298		struct kvm_vcpu_timer *vst;
   299		struct kvm_vcpu_csr *csr;
   300	
   301		kvm_riscv_vcpu_update_timedelta(vcpu);
   302	
   303		if (!cpu_sstc_ext_available)
   304			return;
   305	
   306		vst = &vcpu->arch.vstimer;
   307		csr = &vcpu->arch.guest_csr;
   308	#ifdef CONFIG_64BIT
   309		csr_write(CSR_VSTIMECMP, csr->vstimecmp);
   310	#else
   311		csr_write(CSR_VSTIMECMP, (u32)csr->vstimecmp);
 > 312		csr_write(CSR_VSTIMECMPH, (u32)csr->vstimecmp >> 32);
   313	#endif
   314	
   315		/* vstimer should be enabled for the remaining operations */
   316		if (unlikely(!vst->init_done))
   317			return;
   318	
   319		if (kvm_vcpu_is_blocking(vcpu))
   320			kvm_riscv_vcpu_timer_blocking(vcpu);
   321	}
   322	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
