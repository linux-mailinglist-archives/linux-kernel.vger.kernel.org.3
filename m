Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE5B51D0EE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 07:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381212AbiEFF7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 01:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241386AbiEFF7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 01:59:08 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891CB14080
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 22:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651816524; x=1683352524;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nBcSQ+bH6N1ZIWtxa+y19KMySwpFva4ce5UPpYGkOxY=;
  b=IhTQ82MzQO7qEYYoVX8sp5tve3rkFX9jCLIwckEZcm8EuIVoguD32CU4
   mAh1bqGerAVmSPACcr6jxkBDkFrGaXyNomfvc7B6BH9XmRwyIvUTxZeGQ
   mFWz4z4S/MwTE6bGMSlkT85aj1Ggtv+fFJgc4hy3Tj1ZmWv5+kvwoXSdm
   uBQvgymjguxyf54yL1NHI8LPEPLQ+qyIiEHQAlMOIHB1GXl+PJ8ns1NJc
   j1tSKSWTSnNBzDyG6XUCymk6+XVE7B9Tze8BXH5Jn+T1jdofpukLYZgIr
   iAzRiuF7hFGs3r4rwIKz9l90p+f5CK7Yj3phregO42CDqOnK4F5/A0MNe
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="331349397"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="331349397"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 22:55:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="735415204"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 05 May 2022 22:55:22 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmqvy-000DBl-7q;
        Fri, 06 May 2022 05:55:22 +0000
Date:   Fri, 6 May 2022 13:54:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [esmil:visionfive 50/55]
 drivers/soc/sifive/sifive_l2_cache.c:158:17: error: implicit declaration of
 function 'writeq'; did you mean 'writeb'?
Message-ID: <202205061336.GeLV3Aeo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Emil,

First bad commit (maybe != root cause):

tree:   https://github.com/esmil/linux visionfive
head:   f568ecc24aebec8ce1c59b86f2a85098675a4091
commit: d9e1bb9d10657e8b58ea1d59ef125e674d1a3cf5 [50/55] RISC-V: Enable SIFIVE_L2_FLUSH for StarFive SoCs
config: riscv-randconfig-r024-20220505 (https://download.01.org/0day-ci/archive/20220506/202205061336.GeLV3Aeo-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/d9e1bb9d10657e8b58ea1d59ef125e674d1a3cf5
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout d9e1bb9d10657e8b58ea1d59ef125e674d1a3cf5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/soc/sifive/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/soc/sifive/sifive_l2_cache.c: In function 'sifive_l2_flush64_range':
>> drivers/soc/sifive/sifive_l2_cache.c:158:17: error: implicit declaration of function 'writeq'; did you mean 'writeb'? [-Werror=implicit-function-declaration]
     158 |                 writeq(line, l2_base + SIFIVE_L2_FLUSH64);
         |                 ^~~~~~
         |                 writeb
   cc1: some warnings being treated as errors


vim +158 drivers/soc/sifive/sifive_l2_cache.c

a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah          2019-05-06  126  
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  127  #ifdef CONFIG_SIFIVE_L2_FLUSH
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  128  void sifive_l2_flush64_range(unsigned long start, unsigned long len)
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  129  {
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  130  	unsigned long line;
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  131  
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  132  	if(!l2_base) {
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  133  		pr_warn("L2CACHE: base addr invalid, skipping flush\n");
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  134  		return;
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  135  	}
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  136  
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  137  	/* TODO: if (len == 0), skipping flush or going on? */
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  138  	if(!len) {
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  139  		pr_debug("L2CACHE: flush64 range @ 0x%lx(len:0)\n", start);
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  140  		return;
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  141  	}
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  142  
9b74c210c71a83 drivers/soc/sifive/sifive_l2_cache.c Atish Patra        2021-06-12  143  	len = len + (start % SIFIVE_L2_FLUSH64_LINE_LEN);
9b74c210c71a83 drivers/soc/sifive/sifive_l2_cache.c Atish Patra        2021-06-12  144  	start = ALIGN_DOWN(start, SIFIVE_L2_FLUSH64_LINE_LEN);
9b74c210c71a83 drivers/soc/sifive/sifive_l2_cache.c Atish Patra        2021-06-12  145  
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  146  	/* make sure the address is in the range */
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  147  	if(start < CONFIG_SIFIVE_L2_FLUSH_START ||
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  148  	   (start + len) > (CONFIG_SIFIVE_L2_FLUSH_START +
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  149  			     CONFIG_SIFIVE_L2_FLUSH_SIZE)) {
0725139bb25fb2 drivers/soc/sifive/sifive_l2_cache.c Geert Uytterhoeven 2021-05-21  150  		WARN(1, "L2CACHE: flush64 out of range: %lx(%lx), skip flush\n",
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  151  		     start, len);
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  152  		return;
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  153  	}
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  154  
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  155  	mb();	/* sync */
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  156  	for (line = start; line < start + len;
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  157  	     line += SIFIVE_L2_FLUSH64_LINE_LEN) {
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08 @158  		writeq(line, l2_base + SIFIVE_L2_FLUSH64);
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  159  		mb();
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  160  	}
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  161  }
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  162  EXPORT_SYMBOL_GPL(sifive_l2_flush64_range);
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  163  #endif
7fa12d2f832a42 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  164  

:::::: The code at line 158 was first introduced by commit
:::::: 7fa12d2f832a42a37ff0d8f4dd7569cee4b0b82f sifive/sifive_l2_cache: Add sifive_l2_flush64_range function

:::::: TO: Tom <support@vamrs.com>
:::::: CC: Emil Renner Berthing <kernel@esmil.dk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
