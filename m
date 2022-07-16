Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BEF576C41
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 08:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiGPGjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 02:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGPGjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 02:39:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454FF15732
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 23:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657953543; x=1689489543;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=R4qBAeJ9nvPzfc6yO948nK00aQXCW0kQtvjCqbr84lw=;
  b=jMF5kh9f+eIUSQGaa4G0HrXGjfNaMsR/ZFKak5sK+/0jYFkdEtibpFyC
   +hhorrS9xYACAoOe277MRG28m+2tBz77kZd/3J6ANqLeqv1HeD+XGIw6s
   B1UcGbBtuuaKc8Glyw+59j3Zg/jJWfQ72hXRmgz8aUtSF/Z6giRJRJp0R
   kM7Xj3SVseWvcLDC66TJQbsk3IYUZBCBXEF0jgICQKKt4/fVpmqVq0h3z
   OExmnL+C/eXEBcELawZnOd6ADXw++u82Jz5HA2DB+6xNp/jpAql6pWpQD
   r6q11NrIdllYl+LapTnXpebXsRxRNbLeuvyCOZ81yoeu5Bg8z7aVLSN6X
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="349917111"
X-IronPort-AV: E=Sophos;i="5.92,276,1650956400"; 
   d="scan'208";a="349917111"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 23:39:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,276,1650956400"; 
   d="scan'208";a="664452341"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jul 2022 23:39:01 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCbS8-0001EW-Fn;
        Sat, 16 Jul 2022 06:39:00 +0000
Date:   Sat, 16 Jul 2022 14:38:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Atish Patra <Atish.Patra@wdc.com>, linux-kernel@vger.kernel.org
Subject: [atishp04:kvm_perf_rfc 20/24]
 arch/riscv/include/asm/kvm_vcpu_pmu.h:28:21: error: use of undeclared
 identifier 'RISCV_MAX_COUNTERS'
Message-ID: <202207161459.vX2e7oiS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/atishp04/linux kvm_perf_rfc
head:   84a3fd7f92957f64c411595a9efcc2eed18db2be
commit: bb00c153861bc5d86bab2b4335f3f0e1ca970925 [20/24] RISC-V: KVM: Add skeleton support for perf
config: riscv-randconfig-r042-20220715 (https://download.01.org/0day-ci/archive/20220716/202207161459.vX2e7oiS-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 07022e6cf9b5b3baa642be53d0b3c3f1c403dbfd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv-linux-gnu
        # https://github.com/atishp04/linux/commit/bb00c153861bc5d86bab2b4335f3f0e1ca970925
        git remote add atishp04 https://github.com/atishp04/linux
        git fetch --no-tags atishp04 kvm_perf_rfc
        git checkout bb00c153861bc5d86bab2b4335f3f0e1ca970925
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/riscv/kernel/asm-offsets.c:12:
   In file included from arch/riscv/include/asm/kvm_host.h:21:
>> arch/riscv/include/asm/kvm_vcpu_pmu.h:28:21: error: use of undeclared identifier 'RISCV_MAX_COUNTERS'
           struct kvm_pmc pmc[RISCV_MAX_COUNTERS];
                              ^
   arch/riscv/include/asm/kvm_vcpu_pmu.h:34:27: error: use of undeclared identifier 'RISCV_MAX_COUNTERS'
           DECLARE_BITMAP(used_pmc, RISCV_MAX_COUNTERS);
                                    ^
   2 errors generated.
   make[2]: *** [scripts/Makefile.build:117: arch/riscv/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1200: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/RISCV_MAX_COUNTERS +28 arch/riscv/include/asm/kvm_vcpu_pmu.h

    25	
    26	/* PMU data structure per vcpu */
    27	struct kvm_pmu {
  > 28		struct kvm_pmc pmc[RISCV_MAX_COUNTERS];
    29		/* Number of the virtual firmware counters available */
    30		int num_fw_ctrs;
    31		/* Number of the virtual hardware counters available */
    32		int num_hw_ctrs;
    33		/* Bit map of all the virtual counter used */
    34		DECLARE_BITMAP(used_pmc, RISCV_MAX_COUNTERS);
    35	};
    36	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
