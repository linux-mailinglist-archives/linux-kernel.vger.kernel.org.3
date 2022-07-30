Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553B4585C1D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 22:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbiG3Ujd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 16:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiG3Ujc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 16:39:32 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C4E5FEA
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 13:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659213571; x=1690749571;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KvxAf4qju8TdniXwWPhW+k++yayht8UzKyk/cBl/fno=;
  b=eNalnF/hh4Ks5uYvKto1nQ1kONValuN/7kTzyY3hlNxqOPYsUzQ0Oyap
   9hKYEZdj9qJPCwaeT16yVyk+xLzeuJghJmoCLLr7MKG+4hxY7Gu4lAqJR
   vk3Wt+XX14U7HptDqPK5SpQanlj3+iFDQ0MFBz5W5zSF6SS+EhKkzbIlC
   Nx47Ig3Ef3dXNxo9OXU+c7t5eFlh6WJq3yxtNRb1Jne36BDk3Mr0PeUKs
   BZJzJelK+Jmsdn7z+coy9vbBnEwHeSp4dhlIbx8PWIVoq3dY9Fusfhvv9
   Hqy2jS0gHyvHqa5M+PlCfd2y7/FM6HYw6UL///Rpo61jNwojwz5oeBOMA
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="269327746"
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="269327746"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 13:39:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="552093013"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 30 Jul 2022 13:39:29 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHtFA-000DJR-1p;
        Sat, 30 Jul 2022 20:39:28 +0000
Date:   Sun, 31 Jul 2022 04:38:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Atish Patra <Atish.Patra@wdc.com>, linux-kernel@vger.kernel.org
Subject: [atishp04:kvm_perf_rfc_snapshot 21/25]
 arch/riscv/kvm/vcpu_sbi_pmu.c:66:15: warning: no previous prototype for
 function 'kvm_sbi_ext_pmu_probe'
Message-ID: <202207310426.hXMc5CaM-lkp@intel.com>
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

tree:   https://github.com/atishp04/linux kvm_perf_rfc_snapshot
head:   42182a0a79a8768e22fd70232c3aca2bc1a26a43
commit: 657de0362946d389f50e8b65f72da5f5ba0be1da [21/25] RISC-V: KVM: Add SBI PMU extension support
config: riscv-rv32_defconfig (https://download.01.org/0day-ci/archive/20220731/202207310426.hXMc5CaM-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv-linux-gnu
        # https://github.com/atishp04/linux/commit/657de0362946d389f50e8b65f72da5f5ba0be1da
        git remote add atishp04 https://github.com/atishp04/linux
        git fetch --no-tags atishp04 kvm_perf_rfc_snapshot
        git checkout 657de0362946d389f50e8b65f72da5f5ba0be1da
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kvm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/kvm/vcpu_sbi_pmu.c:66:15: warning: no previous prototype for function 'kvm_sbi_ext_pmu_probe' [-Wmissing-prototypes]
   unsigned long kvm_sbi_ext_pmu_probe(unsigned long extid)
                 ^
   arch/riscv/kvm/vcpu_sbi_pmu.c:66:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   unsigned long kvm_sbi_ext_pmu_probe(unsigned long extid)
   ^
   static 
   1 warning generated.


vim +/kvm_sbi_ext_pmu_probe +66 arch/riscv/kvm/vcpu_sbi_pmu.c

    65	
  > 66	unsigned long kvm_sbi_ext_pmu_probe(unsigned long extid)
    67	{
    68		/*
    69		 * PMU Extension is only available to guests if privilege mode filtering
    70		 * is available. Otherwise, guest will always count events while the
    71		 * execution is in hypervisor mode.
    72		 */
    73		return riscv_isa_extension_available(NULL, SSCOFPMF);
    74	}
    75	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
