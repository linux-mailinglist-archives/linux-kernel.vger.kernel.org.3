Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359BD5A7A35
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbiHaJ3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiHaJ3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:29:06 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD68DCE45F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661938143; x=1693474143;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GBJ1KL0AS+/TPkB2lGtEyWWMhZQldDqNk+PrCAI4uQs=;
  b=h0M6UOesleKXJb5miF51bl60qQDXFpoQ8qDQEXKIYhRAWH+i9XdeBmhf
   s5mQk/j6/j9jdfZz6AUQLvx6Brw3wBBsot+3neV5Zsk1V1z8P1DIe4T7a
   0b5W7Kkr6HJ08sR+x7Nnk5JpzjLhfi1QnSZdw5ftYaj1Mp1Ajkc8u5RUy
   NhQdXzmpAEzuV/q7SjH2J0VFbRakTdU6NBZe7PQBa/7m++H2o57cLPgjR
   +fApcGpslgWGiQfkwed+87viepHYJUG8c9yRfSNbtMGa6HkP2M4Qm2+G2
   PdTgS/35+U4j695uJkeT8FnEEp47v+3Ah2x+FIFFsHfX23IWCjSpAg5Cn
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="359370151"
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="359370151"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 02:29:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="680369182"
Received: from lkp-server02.sh.intel.com (HELO 811e2ceaf0e5) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 31 Aug 2022 02:29:01 -0700
Received: from kbuild by 811e2ceaf0e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTK1t-0000AD-0N;
        Wed, 31 Aug 2022 09:29:01 +0000
Date:   Wed, 31 Aug 2022 17:28:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: [avpatel:riscv_pmem_v1 9/11] arch/riscv/mm/cacheflush.c:99:2: error:
 call to undeclared function 'for_each_of_cpu_node'; ISO C99 and later do not
 support implicit function declarations
Message-ID: <202208311748.kkZGf9sX-lkp@intel.com>
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

tree:   https://github.com/avpatel/linux.git riscv_pmem_v1
head:   3d8ca09f6ee6f53dd03a1eeda6a68ef73056601e
commit: 1cb8ad397aba3a012059dacd724ac7772bf6ea54 [9/11] RISC-V: Move riscv_init_cbom_blocksize() to cacheflush.c
config: riscv-randconfig-r042-20220830 (https://download.01.org/0day-ci/archive/20220831/202208311748.kkZGf9sX-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c7df82e4693c19e3fd2e25c83eb04d9deb7b7b59)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/avpatel/linux/commit/1cb8ad397aba3a012059dacd724ac7772bf6ea54
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_pmem_v1
        git checkout 1cb8ad397aba3a012059dacd724ac7772bf6ea54
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/mm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/riscv/mm/cacheflush.c:99:2: error: call to undeclared function 'for_each_of_cpu_node'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           for_each_of_cpu_node(node) {
           ^
>> arch/riscv/mm/cacheflush.c:99:28: error: expected ';' after expression
           for_each_of_cpu_node(node) {
                                     ^
                                     ;
>> arch/riscv/mm/cacheflush.c:105:4: error: 'continue' statement not in loop statement
                           continue;
                           ^
   arch/riscv/mm/cacheflush.c:108:4: error: 'continue' statement not in loop statement
                           continue;
                           ^
>> arch/riscv/mm/cacheflush.c:111:9: error: call to undeclared function 'of_property_read_u32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   ret = of_property_read_u32(node, "riscv,cbom-block-size", &val);
                         ^
   arch/riscv/mm/cacheflush.c:113:4: error: 'continue' statement not in loop statement
                           continue;
                           ^
   6 errors generated.


vim +/for_each_of_cpu_node +99 arch/riscv/mm/cacheflush.c

    91	
    92	#ifdef CONFIG_RISCV_ISA_ZICBOM
    93	void riscv_init_cbom_blocksize(void)
    94	{
    95		struct device_node *node;
    96		int ret;
    97		u32 val;
    98	
  > 99		for_each_of_cpu_node(node) {
   100			unsigned long hartid;
   101			int cbom_hartid;
   102	
   103			ret = riscv_of_processor_hartid(node, &hartid);
   104			if (ret)
 > 105				continue;
   106	
   107			if (hartid < 0)
   108				continue;
   109	
   110			/* set block-size for cbom extension if available */
 > 111			ret = of_property_read_u32(node, "riscv,cbom-block-size", &val);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
