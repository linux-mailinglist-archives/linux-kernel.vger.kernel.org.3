Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFF152FA7B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 12:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244207AbiEUJym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 05:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiEUJyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 05:54:38 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B52E64C9
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 02:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653126877; x=1684662877;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eQYNWnsx4uzsmBzUeMGWvfVQmlMLqEV4v/I3wtd9E7M=;
  b=akQUSfxgKtqizxqOnMSNGHqhag3Wv4NkmPb2flSM3LpjrXFazbiHnz9Q
   gyTa53JOVrGOWEL3U8JoAGMNEvW0NACUC8Ts0bXw8Rsk41zJHNYzq9aAj
   CHEBMMrVJwuEEOnMtjs2Q+Bex6kswtmMtuI2VUdAi30AHM0/vkpaUwGL4
   tipKhDgWZC40XPx9huf0mJJKSE4vkjVSmoNiytUH1EHCH3+HRomvqDaxA
   Al+pLDgTJbqeMb261WkgCDE6XA7hiN+gaQzZBAQfWPgrXiFjabuawQsIR
   jg/5nlMc+p5ti3fDoju//gqpR6gBX8b5Io/7vti0lKck3vCaqJCc+xdEm
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="333462179"
X-IronPort-AV: E=Sophos;i="5.91,242,1647327600"; 
   d="scan'208";a="333462179"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 02:54:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,242,1647327600"; 
   d="scan'208";a="662656575"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 21 May 2022 02:54:35 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsLoh-0006AY-21;
        Sat, 21 May 2022 09:54:35 +0000
Date:   Sat, 21 May 2022 17:54:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Jo=E3o_M=E1rio?= Domingos 
        <joao.mario@tecnico.ulisboa.pt>
Cc:     kbuild-all@lists.01.org, Atish Patra <Atish.Patra@wdc.com>,
        linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
Subject: [atishp04:unmatched_pmu 1/4] drivers/perf/riscv_pmu_sbi.c:709:41:
 warning: right shift count >= width of type
Message-ID: <202205211740.XMg1JXoD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
config: riscv-randconfig-r001-20220519 (https://download.01.org/0day-ci/archive/20220521/202205211740.XMg1JXoD-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/atishp04/linux/commit/04bc56e83a7e6e851694e34da95f26c57abc7132
        git remote add atishp04 https://github.com/atishp04/linux
        git fetch --no-tags atishp04 unmatched_pmu
        git checkout 04bc56e83a7e6e851694e34da95f26c57abc7132
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/perf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/perf/riscv_pmu_sbi.c: In function 'pmu_sbi_get_pmu_id':
>> drivers/perf/riscv_pmu_sbi.c:709:41: warning: right shift count >= width of type [-Wshift-count-overflow]
     709 |         pmuid.arch = (sbi_get_marchid() >> (63 - 15) & (1 << 15)) | (sbi_get_marchid() & 0x7FFF);
         |                                         ^~


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
