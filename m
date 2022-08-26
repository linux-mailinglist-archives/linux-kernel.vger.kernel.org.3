Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7A75A3105
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 23:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344918AbiHZVeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 17:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241517AbiHZVeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 17:34:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5809350D
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 14:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661549658; x=1693085658;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ujl9D/OFhNeGrrCmjpCf3+79hRWPwevSZtdRSxa/7uw=;
  b=NESbliV5XsF+TDwkAwhdWnkgGsvnEfDAG9AwIeh95VM/AofiTPtCpyJe
   j6muEjpoGIYWgozIx5FSKijByx4LZkkcNb/3GcLQ7xQu4Q8wlmpFezLLU
   dyRBZobJu7LXq/0lzKV9vHlgQIoZn27x2VQTRwprS6e29TzJs6D5F9crG
   6MhZZL0jrn5VFURv1BcdHcYY/tKC7shTEnakVElYL2Knls6eur4hVfgef
   i+iVsvTFXtzdsBg56TF6k+EVqIm1DrlNkHEgGfZ4KkyJj1w2g4sC8teqt
   3yM/qYC6ZTzdIbLKGykiWNYImGfYNGBMdj4pZmf915xfdAuivnDVOvYBy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="281567416"
X-IronPort-AV: E=Sophos;i="5.93,266,1654585200"; 
   d="scan'208";a="281567416"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 14:34:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,266,1654585200"; 
   d="scan'208";a="671624071"
Received: from lkp-server01.sh.intel.com (HELO 71b0d3b5b1bc) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 26 Aug 2022 14:34:16 -0700
Received: from kbuild by 71b0d3b5b1bc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRgy0-0000Sz-0h;
        Fri, 26 Aug 2022 21:34:16 +0000
Date:   Sat, 27 Aug 2022 05:33:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [avpatel:riscv_pmem_v1 65/78] arch/riscv/kernel/cpu.c:236:6:
 warning: no previous prototype for 'acpi_print_hart_info'
Message-ID: <202208270554.hMhYeLmO-lkp@intel.com>
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

tree:   https://github.com/avpatel/linux.git riscv_pmem_v1
head:   abd658639cf42f64e3b2cfe9f646ffeedb8e54d0
commit: 3a0948be4a1449e082b77cc023a8cf9098753aa8 [65/78] RISC-V: ACPI: cpu: Enable cpuinfo for ACPI systems
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20220827/202208270554.hMhYeLmO-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/avpatel/linux/commit/3a0948be4a1449e082b77cc023a8cf9098753aa8
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_pmem_v1
        git checkout 3a0948be4a1449e082b77cc023a8cf9098753aa8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/ arch/riscv/lib/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/kernel/cpu.c:236:6: warning: no previous prototype for 'acpi_print_hart_info' [-Wmissing-prototypes]
     236 | void acpi_print_hart_info(struct seq_file *m,
         |      ^~~~~~~~~~~~~~~~~~~~


vim +/acpi_print_hart_info +236 arch/riscv/kernel/cpu.c

   234	
   235	#ifdef CONFIG_ACPI
 > 236	void acpi_print_hart_info(struct seq_file *m,
   237				  unsigned long cpu)
   238	{
   239		char isa[256];
   240	
   241		if(!acpi_get_riscv_isa(cpu, isa))
   242			print_isa(m, isa);
   243	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
