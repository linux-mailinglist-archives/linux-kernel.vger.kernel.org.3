Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029D55A31CC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344992AbiHZWOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242965AbiHZWO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:14:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB431E398C
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 15:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661552066; x=1693088066;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vXMkBmHxoh+dr605lfcVIYbNdyaZ5MfumEu2yigwtkg=;
  b=jBNiRuPBBKpJD8+80S+HFuQQi98jjSN0kFOHcmwMFNld/ByQa5HBAJ9Q
   xUyrwRsK1gvcNBmzs/APxKCdtw2cE+XP1AQieaak9W5FtRliTJL8lSkek
   Idh5C/fzNt4g/QC4gyjXMwndQ7L/i6zL0NoXsj/TORRHcf9/Tz9la0ouK
   0UZ3qjJGyS2jj+frCYu/Y/7zM5VMvmID80HAigWYX6wOiypaY5A5AwNYf
   8hnBFcOQOzcH0gmFJWc9F4BYcq139jGHMnIX7q3FtAYzRq6LH7Lt+LnEl
   AFD06iQI2AAMRPnevR6SKLz1/npBtZU2B8u+HSzTwSJSiJbrqeT3KBm44
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="358566816"
X-IronPort-AV: E=Sophos;i="5.93,266,1654585200"; 
   d="scan'208";a="358566816"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 15:14:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,266,1654585200"; 
   d="scan'208";a="587454763"
Received: from lkp-server01.sh.intel.com (HELO 71b0d3b5b1bc) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Aug 2022 15:14:18 -0700
Received: from kbuild by 71b0d3b5b1bc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRhak-0000WJ-06;
        Fri, 26 Aug 2022 22:14:18 +0000
Date:   Sat, 27 Aug 2022 06:14:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [avpatel:riscv_pmem_v1 76/78] arch/riscv/kernel/cpuidle.c:40:5:
 warning: no previous prototype for 'acpi_processor_ffh_lpi_probe'
Message-ID: <202208270656.LqZSOs76-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sunil,

First bad commit (maybe != root cause):

tree:   https://github.com/avpatel/linux.git riscv_pmem_v1
head:   abd658639cf42f64e3b2cfe9f646ffeedb8e54d0
commit: f3915b6afe3a8394a8bc250074dc0da940f789d6 [76/78] RISC-V: ACPI: Enable ACPI LPI driver
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20220827/202208270656.LqZSOs76-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/avpatel/linux/commit/f3915b6afe3a8394a8bc250074dc0da940f789d6
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_pmem_v1
        git checkout f3915b6afe3a8394a8bc250074dc0da940f789d6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/kernel/cpuidle.c:40:5: warning: no previous prototype for 'acpi_processor_ffh_lpi_probe' [-Wmissing-prototypes]
      40 | int acpi_processor_ffh_lpi_probe(unsigned int cpu)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/riscv/kernel/cpuidle.c:45:5: warning: no previous prototype for 'acpi_processor_ffh_lpi_enter' [-Wmissing-prototypes]
      45 | int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/acpi_processor_ffh_lpi_probe +40 arch/riscv/kernel/cpuidle.c

d7aa2311ae6001 Sunil V L 2022-07-16  39  
d7aa2311ae6001 Sunil V L 2022-07-16 @40  int acpi_processor_ffh_lpi_probe(unsigned int cpu)
d7aa2311ae6001 Sunil V L 2022-07-16  41  {
d7aa2311ae6001 Sunil V L 2022-07-16  42  	return acpi_cpu_init_idle(cpu);
d7aa2311ae6001 Sunil V L 2022-07-16  43  }
d7aa2311ae6001 Sunil V L 2022-07-16  44  
d7aa2311ae6001 Sunil V L 2022-07-16 @45  int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
d7aa2311ae6001 Sunil V L 2022-07-16  46  {
d7aa2311ae6001 Sunil V L 2022-07-16  47  	u32 state = lpi->address;
d7aa2311ae6001 Sunil V L 2022-07-16  48  
d7aa2311ae6001 Sunil V L 2022-07-16  49  	if (state & SBI_HSM_SUSP_NON_RET_BIT)
d7aa2311ae6001 Sunil V L 2022-07-16  50  		return CPU_PM_CPU_IDLE_ENTER_PARAM(sbi_suspend,
d7aa2311ae6001 Sunil V L 2022-07-16  51  						   lpi->index,
d7aa2311ae6001 Sunil V L 2022-07-16  52  						   state);
d7aa2311ae6001 Sunil V L 2022-07-16  53  	else
d7aa2311ae6001 Sunil V L 2022-07-16  54  		return CPU_PM_CPU_IDLE_ENTER_RETENTION_PARAM(sbi_suspend,
d7aa2311ae6001 Sunil V L 2022-07-16  55  							     lpi->index,
d7aa2311ae6001 Sunil V L 2022-07-16  56  							     state);
d7aa2311ae6001 Sunil V L 2022-07-16  57  }
d7aa2311ae6001 Sunil V L 2022-07-16  58  

:::::: The code at line 40 was first introduced by commit
:::::: d7aa2311ae60016c3ed214942d8dc2729a60c6fb RISC-V: ACPI: Add LPI driver

:::::: TO: Sunil V L <sunilvl@ventanamicro.com>
:::::: CC: Anup Patel <anup@brainfault.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
