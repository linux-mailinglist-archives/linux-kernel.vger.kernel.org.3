Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BB04D126B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345038AbiCHIkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344993AbiCHIkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:40:15 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB35338B4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 00:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646728758; x=1678264758;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ojJn4Qayf0tbV7qscSJpjL73hYZJUR6Sn3DeCgJ06Kw=;
  b=mD6hn6NfLvmfolzmAGYcYVIaoYYJcLfyxinb52yehFrppd2q6+K69kwO
   zP5YDZF8Fh8/GbYaQrKGJ2dNi8RawU8qopXv/FDTHN5H/enWrWgsZ6TR+
   b+67PtCn3h0UTyT71YJDKvS1RoJcZL3+Tfw3ovuYqehD0amuKKVetZpoT
   YtxfIxg49iSdpjXK2eL8LkPItwtcPA6Sro69RudMyamXaVrTvULrGI8b8
   ODnoSMLuLrGkKHHj8CF/clgae5zLc2cNTEGjNP8dC+c3996oNXDNnu+UY
   WbrqlCinAqfwFDFcjfsKQyLzkzbTvA9HR8ZFYTlZKCr+ktc55xQOnh4UI
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="254358597"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="254358597"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 00:39:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="643582887"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 08 Mar 2022 00:39:17 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRVNE-00019Y-Bv; Tue, 08 Mar 2022 08:39:16 +0000
Date:   Tue, 8 Mar 2022 16:38:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [esmil:visionfive 57/61] drivers/soc/sifive/sifive_l2_cache.c:158:3:
 error: implicit declaration of function 'writeq'
Message-ID: <202203081628.ECRiVnPH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Emil,

First bad commit (maybe != root cause):

tree:   https://github.com/esmil/linux visionfive
head:   b75fcbba0e03fd9655bc4c8854422d51474664d3
commit: ad49c3fa8088809d886f993496240bd41155ab2a [57/61] RISC-V: Enable SIFIVE_L2_FLUSH for StarFive SoCs
config: riscv-randconfig-r042-20220307 (https://download.01.org/0day-ci/archive/20220308/202203081628.ECRiVnPH-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/esmil/linux/commit/ad49c3fa8088809d886f993496240bd41155ab2a
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout ad49c3fa8088809d886f993496240bd41155ab2a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/soc/sifive/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/soc/sifive/sifive_l2_cache.c:158:3: error: implicit declaration of function 'writeq' [-Werror,-Wimplicit-function-declaration]
                   writeq(line, l2_base + SIFIVE_L2_FLUSH64);
                   ^
>> drivers/soc/sifive/sifive_l2_cache.c:148:19: warning: result of comparison of constant 36507222016 with expression of type 'unsigned long' is always false [-Wtautological-constant-out-of-range-compare]
              (start + len) > (CONFIG_SIFIVE_L2_FLUSH_START +
              ~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.


vim +/writeq +158 drivers/soc/sifive/sifive_l2_cache.c

a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah          2019-05-06  126  
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  127  #ifdef CONFIG_SIFIVE_L2_FLUSH
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  128  void sifive_l2_flush64_range(unsigned long start, unsigned long len)
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  129  {
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  130  	unsigned long line;
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  131  
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  132  	if(!l2_base) {
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  133  		pr_warn("L2CACHE: base addr invalid, skipping flush\n");
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  134  		return;
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  135  	}
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  136  
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  137  	/* TODO: if (len == 0), skipping flush or going on? */
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  138  	if(!len) {
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  139  		pr_debug("L2CACHE: flush64 range @ 0x%lx(len:0)\n", start);
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  140  		return;
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  141  	}
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  142  
95728482b5e3e7 drivers/soc/sifive/sifive_l2_cache.c Atish Patra        2021-06-12  143  	len = len + (start % SIFIVE_L2_FLUSH64_LINE_LEN);
95728482b5e3e7 drivers/soc/sifive/sifive_l2_cache.c Atish Patra        2021-06-12  144  	start = ALIGN_DOWN(start, SIFIVE_L2_FLUSH64_LINE_LEN);
95728482b5e3e7 drivers/soc/sifive/sifive_l2_cache.c Atish Patra        2021-06-12  145  
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  146  	/* make sure the address is in the range */
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  147  	if(start < CONFIG_SIFIVE_L2_FLUSH_START ||
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08 @148  	   (start + len) > (CONFIG_SIFIVE_L2_FLUSH_START +
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  149  			     CONFIG_SIFIVE_L2_FLUSH_SIZE)) {
b2ba91ef9c8b60 drivers/soc/sifive/sifive_l2_cache.c Geert Uytterhoeven 2021-05-21  150  		WARN(1, "L2CACHE: flush64 out of range: %lx(%lx), skip flush\n",
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  151  		     start, len);
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  152  		return;
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  153  	}
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  154  
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  155  	mb();	/* sync */
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  156  	for (line = start; line < start + len;
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  157  	     line += SIFIVE_L2_FLUSH64_LINE_LEN) {
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08 @158  		writeq(line, l2_base + SIFIVE_L2_FLUSH64);
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  159  		mb();
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  160  	}
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  161  }
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  162  EXPORT_SYMBOL_GPL(sifive_l2_flush64_range);
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  163  #endif
def7ba448ac4b5 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  164  

:::::: The code at line 158 was first introduced by commit
:::::: def7ba448ac4b53b788d238985ef97702dc802a1 sifive/sifive_l2_cache: Add sifive_l2_flush64_range function

:::::: TO: Tom <support@vamrs.com>
:::::: CC: Emil Renner Berthing <kernel@esmil.dk>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
