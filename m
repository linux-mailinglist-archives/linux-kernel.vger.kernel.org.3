Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2D0576C45
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 08:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiGPGuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 02:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiGPGuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 02:50:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C3828724
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 23:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657954203; x=1689490203;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lwqmXslMP4Z3529XOsXCI6g+Z3NHciSlhdXuv+OYMbE=;
  b=XQguBv6ulCRy/zY1jMap7gLz4MxyJaD2wtrfF5FzjAt4xDDd3qbrnw5r
   vM5PphMLM42HkcCxo1qC0igNTg1zF8uZ/mabu7phI0TweNUE3GvANyqw6
   VeAJ78YakpYPfCrx1fiBQPMY+XbdpnVNfTSyd7V3FxBgfIKo9jbpYFsTM
   3VrsmI4+XeBzpL2GnTAAX3TehP3tByljOI4rC3TYvM2jxHBCF0+u3AMlk
   Ng1TLQYPKq4lBs76ppeU7xpMchXA4P8kOne9SSOGlQeJKhKeWGByNGX0j
   j6kselnumuLP+my46z3vbNCN2bluJtZTUP4XVg/LHTxVyWcL2T8LNv7c5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="349917610"
X-IronPort-AV: E=Sophos;i="5.92,276,1650956400"; 
   d="scan'208";a="349917610"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 23:50:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,276,1650956400"; 
   d="scan'208";a="624129997"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 15 Jul 2022 23:50:01 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCbcm-0001F6-Ts;
        Sat, 16 Jul 2022 06:50:00 +0000
Date:   Sat, 16 Jul 2022 14:49:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     kbuild-all@lists.01.org, Atish Patra <Atish.Patra@wdc.com>,
        linux-kernel@vger.kernel.org
Subject: [atishp04:kvm_perf_rfc 24/24]
 arch/riscv/include/asm/kvm_vcpu_pmu.h:62:60: warning: 'enum
 sbi_pmu_fw_generic_events_t' declared inside parameter list will not be
 visible outside of this definition or declaration
Message-ID: <202207161431.vy05qNVI-lkp@intel.com>
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
commit: 84a3fd7f92957f64c411595a9efcc2eed18db2be [24/24] RISC-V: KVM: Implement firmware events
config: riscv-randconfig-r001-20220715 (https://download.01.org/0day-ci/archive/20220716/202207161431.vy05qNVI-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/atishp04/linux/commit/84a3fd7f92957f64c411595a9efcc2eed18db2be
        git remote add atishp04 https://github.com/atishp04/linux
        git fetch --no-tags atishp04 kvm_perf_rfc
        git checkout 84a3fd7f92957f64c411595a9efcc2eed18db2be
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/riscv/include/asm/kvm_host.h:21,
                    from arch/riscv/kernel/asm-offsets.c:12:
   arch/riscv/include/asm/kvm_vcpu_pmu.h:31:32: error: field 'cinfo' has incomplete type
      31 |         union sbi_pmu_ctr_info cinfo;
         |                                ^~~~~
   arch/riscv/include/asm/kvm_vcpu_pmu.h:38:28: error: 'RISCV_MAX_COUNTERS' undeclared here (not in a function)
      38 |         struct kvm_pmc pmc[RISCV_MAX_COUNTERS];
         |                            ^~~~~~~~~~~~~~~~~~
>> arch/riscv/include/asm/kvm_vcpu_pmu.h:62:60: warning: 'enum sbi_pmu_fw_generic_events_t' declared inside parameter list will not be visible outside of this definition or declaration
      62 | int kvm_riscv_vcpu_pmu_incr_fw(struct kvm_vcpu *vcpu, enum sbi_pmu_fw_generic_events_t fid);
         |                                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   make[2]: *** [scripts/Makefile.build:117: arch/riscv/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1200: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +62 arch/riscv/include/asm/kvm_vcpu_pmu.h

    61	
  > 62	int kvm_riscv_vcpu_pmu_incr_fw(struct kvm_vcpu *vcpu, enum sbi_pmu_fw_generic_events_t fid);
    63	int kvm_riscv_vcpu_pmu_read_hpm(struct kvm_vcpu *vcpu, unsigned int csr_num,
    64					unsigned long *val, unsigned long new_val,
    65					unsigned long wr_mask);
    66	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
