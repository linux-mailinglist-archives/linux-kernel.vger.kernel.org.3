Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FB7547352
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 11:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbiFKJiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 05:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiFKJiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 05:38:12 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B25932ECA
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 02:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654940291; x=1686476291;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WyPp8xWwZKXJocjJBH5ZU4QlEb2X0Y69k13DLl+dF98=;
  b=JSIS2paEAFHW1rIavw35t5YGZtkelFoGh8FY8OYOLLH/+XqhQPb8J78c
   JX1VrQZbFxtRY72YPfGp4wgHejbb4yEYLJZKvh9DV/pmTLm7FajnJlWqa
   4xDEEGj8a3iMU0IwXIA2qA0+WpmVyb8wZ8KlsT+oX/wfNEzTJ4lCUyG2A
   d12jfsJc4pOfh6yb3m6IQ6pLgufkpsRGaHZsYKYbcu0h2V2c4BcsEmXce
   1lOBm8vnjFy43SORWakLr+05tMa+cihc52AUEVLSThds/Y0P0UWBTXK4N
   I3p0abUifPAtO7bgHqkLQbeeTnL8O7pIkMdPFGRk77YddMfGsGcR9Zzz4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="260962292"
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="260962292"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 02:38:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="685030637"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jun 2022 02:38:10 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzxZJ-000Ilx-AE;
        Sat, 11 Jun 2022 09:38:09 +0000
Date:   Sat, 11 Jun 2022 17:37:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [esmil:visionfive 50/54]
 drivers/soc/sifive/sifive_l2_cache.c:158:17: error: implicit declaration of
 function 'writeq'; did you mean 'writel'?
Message-ID: <202206111753.evF6g3ot-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   906be7ef2fb9e2f1fcb740d3d506768cddfc52ca
commit: bfa9ff08405bc12ac52070caf85a017127c9ef23 [50/54] RISC-V: Enable SIFIVE_L2_FLUSH for StarFive SoCs
config: riscv-randconfig-c004-20220609 (https://download.01.org/0day-ci/archive/20220611/202206111753.evF6g3ot-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/bfa9ff08405bc12ac52070caf85a017127c9ef23
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout bfa9ff08405bc12ac52070caf85a017127c9ef23
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/soc/sifive/sifive_l2_cache.c: In function 'sifive_l2_flush64_range':
>> drivers/soc/sifive/sifive_l2_cache.c:158:17: error: implicit declaration of function 'writeq'; did you mean 'writel'? [-Werror=implicit-function-declaration]
     158 |                 writeq(line, l2_base + SIFIVE_L2_FLUSH64);
         |                 ^~~~~~
         |                 writel
   cc1: some warnings being treated as errors


vim +158 drivers/soc/sifive/sifive_l2_cache.c

a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah          2019-05-06  126  
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  127  #ifdef CONFIG_SIFIVE_L2_FLUSH
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  128  void sifive_l2_flush64_range(unsigned long start, unsigned long len)
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  129  {
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  130  	unsigned long line;
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  131  
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  132  	if(!l2_base) {
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  133  		pr_warn("L2CACHE: base addr invalid, skipping flush\n");
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  134  		return;
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  135  	}
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  136  
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  137  	/* TODO: if (len == 0), skipping flush or going on? */
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  138  	if(!len) {
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  139  		pr_debug("L2CACHE: flush64 range @ 0x%lx(len:0)\n", start);
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  140  		return;
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  141  	}
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  142  
716e7e2d5d69db drivers/soc/sifive/sifive_l2_cache.c Atish Patra        2021-06-12  143  	len = len + (start % SIFIVE_L2_FLUSH64_LINE_LEN);
716e7e2d5d69db drivers/soc/sifive/sifive_l2_cache.c Atish Patra        2021-06-12  144  	start = ALIGN_DOWN(start, SIFIVE_L2_FLUSH64_LINE_LEN);
716e7e2d5d69db drivers/soc/sifive/sifive_l2_cache.c Atish Patra        2021-06-12  145  
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  146  	/* make sure the address is in the range */
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  147  	if(start < CONFIG_SIFIVE_L2_FLUSH_START ||
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  148  	   (start + len) > (CONFIG_SIFIVE_L2_FLUSH_START +
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  149  			     CONFIG_SIFIVE_L2_FLUSH_SIZE)) {
085675aa07e095 drivers/soc/sifive/sifive_l2_cache.c Geert Uytterhoeven 2021-05-21  150  		WARN(1, "L2CACHE: flush64 out of range: %lx(%lx), skip flush\n",
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  151  		     start, len);
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  152  		return;
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  153  	}
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  154  
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  155  	mb();	/* sync */
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  156  	for (line = start; line < start + len;
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  157  	     line += SIFIVE_L2_FLUSH64_LINE_LEN) {
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08 @158  		writeq(line, l2_base + SIFIVE_L2_FLUSH64);
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  159  		mb();
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  160  	}
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  161  }
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  162  EXPORT_SYMBOL_GPL(sifive_l2_flush64_range);
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  163  #endif
1c9c971346b0ca drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  164  

:::::: The code at line 158 was first introduced by commit
:::::: 1c9c971346b0ca811114ae00fce28cbf3c34232b sifive/sifive_l2_cache: Add sifive_l2_flush64_range function

:::::: TO: Tom <support@vamrs.com>
:::::: CC: Emil Renner Berthing <kernel@esmil.dk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
