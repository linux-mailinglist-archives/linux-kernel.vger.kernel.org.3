Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0B75A3793
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 14:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiH0MKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 08:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiH0MKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 08:10:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD48B804A4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 05:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661602249; x=1693138249;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E30TlKHyMpVq2+ft4kq1Ob+zQ2NSiPpWjFxEeiQQiiI=;
  b=mgWWVT6U92fYBssc/GsWxw8CJPW/C/6BacvTi9lDclpQQS15Th8yTFzd
   tNsEWBnut2NJ99xQQJQpuR2VE4TGwEmqrWIXR+w45I1ec+UVDyOIukt3l
   Zh9/k+WgiZlhUqikp0vaTRCHbNiOjj3ZnI3HOF5MLEEq1Q40Se848/ity
   dT9dE7Z9ejs91mXUlvdPDHVgtZGCis3gtIm5vXNlAnkxzfWqfgXwgwFhk
   d2UoxA+WfLTUA11QVLNodi4RY5wyoCmtBx0rlgaXMGzHWbPlAFXwOqFiy
   PEet+EcoQ8FrKBBoJGrrcjqdqtcX0eFxKZ1V8qDmdjVA82mCsaIrII0lN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="281625786"
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="281625786"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 05:10:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="587617855"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 27 Aug 2022 05:10:47 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRueE-000099-2n;
        Sat, 27 Aug 2022 12:10:46 +0000
Date:   Sat, 27 Aug 2022 20:10:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: [avpatel:riscv_pmem_v1 37/38] arch/riscv/mm/cacheflush.c:100:2:
 error: call to undeclared function 'for_each_of_cpu_node'; ISO C99 and later
 do not support implicit function declarations
Message-ID: <202208272028.IwrNZ0Ur-lkp@intel.com>
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
head:   cfb27bb3561d70cd5e00b71c5f817b7c4452ae71
commit: 2590647b8e45549f88977f6c2d87b9740e3df722 [37/38] RISC-V: Move riscv_init_cbom_blocksize() to cacheflush.c
config: riscv-randconfig-r042-20220825 (https://download.01.org/0day-ci/archive/20220827/202208272028.IwrNZ0Ur-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project a2100daf12fb980a29fd1a9c85ccf8eaaaf79730)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/avpatel/linux/commit/2590647b8e45549f88977f6c2d87b9740e3df722
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_pmem_v1
        git checkout 2590647b8e45549f88977f6c2d87b9740e3df722
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/riscv/mm/cacheflush.c:100:2: error: call to undeclared function 'for_each_of_cpu_node'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           for_each_of_cpu_node(node) {
           ^
>> arch/riscv/mm/cacheflush.c:100:28: error: expected ';' after expression
           for_each_of_cpu_node(node) {
                                     ^
                                     ;
>> arch/riscv/mm/cacheflush.c:106:4: error: 'continue' statement not in loop statement
                           continue;
                           ^
   arch/riscv/mm/cacheflush.c:109:4: error: 'continue' statement not in loop statement
                           continue;
                           ^
>> arch/riscv/mm/cacheflush.c:112:9: error: call to undeclared function 'of_property_read_u32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   ret = of_property_read_u32(node, "riscv,cbom-block-size", &val);
                         ^
   arch/riscv/mm/cacheflush.c:114:4: error: 'continue' statement not in loop statement
                           continue;
                           ^
   6 errors generated.


vim +/for_each_of_cpu_node +100 arch/riscv/mm/cacheflush.c

    92	
    93	#ifdef CONFIG_RISCV_ISA_ZICBOM
    94	void riscv_init_cbom_blocksize(void)
    95	{
    96		struct device_node *node;
    97		int ret;
    98		u32 val;
    99	
 > 100		for_each_of_cpu_node(node) {
   101			unsigned long hartid;
   102			int cbom_hartid;
   103	
   104			ret = riscv_of_processor_hartid(node, &hartid);
   105			if (ret)
 > 106				continue;
   107	
   108			if (hartid < 0)
   109				continue;
   110	
   111			/* set block-size for cbom extension if available */
 > 112			ret = of_property_read_u32(node, "riscv,cbom-block-size", &val);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
