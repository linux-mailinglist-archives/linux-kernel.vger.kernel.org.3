Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDBC532F49
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 18:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239712AbiEXQzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 12:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237643AbiEXQzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 12:55:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330C46D3B5
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 09:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653411351; x=1684947351;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oOuSXB2gdak0RiOLo8nGGEuEpjVHr3ygbyaFxZ3tAhU=;
  b=XF8H02hNPsZDOEM7jOadppaHkoaPDxZEA0+rQlNiSizLeEg1Aa/+F1Af
   X86x3qB27qy/snl0cwXkFDeRy+nVhapEx95O9BiH2OiBbhJ2HLQE1AVgh
   sLunfsilJyGaPDTBHM801J3soKtJqlUFbcPYRKcTExrsCYPW9ckpcgrIm
   RNRGfcEv4W5hN2lIyYorYn+sf9YF6byesCQouUyoz/48FlgIitJRv3VgC
   PFtq0+j4yKjKBOdl/zV0eebiZ596eqzy88d+u+8UQXh3EBrWVtl5mL7Nc
   TSc5MXgevPdt7xJEDkZy4SxhlxDTcDPAXp50eFEMxtKHCB/Mrk/ChH+ei
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="359977196"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="359977196"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 09:55:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="601394367"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 24 May 2022 09:55:48 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntXox-0002H4-Tq;
        Tue, 24 May 2022 16:55:47 +0000
Date:   Wed, 25 May 2022 00:54:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Jo=E3o_M=E1rio?= Domingos 
        <joao.mario@tecnico.ulisboa.pt>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Atish Patra <Atish.Patra@wdc.com>,
        linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
Subject: [atishp04:unmatched_pmu 1/4] drivers/perf/riscv_pmu_sbi.c:709:34:
 warning: shift count >= width of type
Message-ID: <202205250058.7LPnhB6e-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/atishp04/linux unmatched_pmu
head:   7b75dbb7c4c01dceb7a974c352945fd86eb88c25
commit: 04bc56e83a7e6e851694e34da95f26c57abc7132 [1/4] RISC-V: Create unique identification for SoC PMU
config: riscv-rv32_defconfig (https://download.01.org/0day-ci/archive/20220525/202205250058.7LPnhB6e-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 10c9ecce9f6096e18222a331c5e7d085bd813f75)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/atishp04/linux/commit/04bc56e83a7e6e851694e34da95f26c57abc7132
        git remote add atishp04 https://github.com/atishp04/linux
        git fetch --no-tags atishp04 unmatched_pmu
        git checkout 04bc56e83a7e6e851694e34da95f26c57abc7132
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/perf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/perf/riscv_pmu_sbi.c:709:34: warning: shift count >= width of type [-Wshift-count-overflow]
           pmuid.arch = (sbi_get_marchid() >> (63 - 15) & (1 << 15)) | (sbi_get_marchid() & 0x7FFF);
                                           ^  ~~~~~~~~~
   1 warning generated.


vim +709 drivers/perf/riscv_pmu_sbi.c

   695	
   696	static uint64_t pmu_sbi_get_pmu_id(void)
   697	{
   698		union sbi_pmu_id {
   699			uint64_t value;
   700			struct {
   701				uint16_t imp:16;
   702				uint16_t arch:16;
   703				uint32_t vendor:32;
   704			};
   705		} pmuid;
   706	
   707		pmuid.value = 0;
   708		pmuid.vendor = (uint32_t) sbi_get_mvendorid();
 > 709		pmuid.arch = (sbi_get_marchid() >> (63 - 15) & (1 << 15)) | (sbi_get_marchid() & 0x7FFF);
   710		pmuid.imp = (sbi_get_mimpid() >> 16);
   711	
   712		return pmuid.value;
   713	}
   714	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
