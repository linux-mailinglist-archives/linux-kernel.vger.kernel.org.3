Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877E6502752
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351101AbiDOJ2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234597AbiDOJ2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:28:01 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F8D60CF0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 02:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650014733; x=1681550733;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f10CJHYn2bemMnWK8B/1YUsnsoS7c0zQ4Liyr9UQtDg=;
  b=jXZVSW+EiZthW9VupLO5yoVlpzNlk5Tl47K0HnnTvQ2c7PVOsml0EhtZ
   KAVwKvuDOqcnQwrkjHqnyFENtPTvsPgZuiQh3xsLhBER91HoAiVMZ4O8L
   cNPbk7djVvPm2alICO7uzm2EZchXbZF/SCLSUueAiBaHqOQ+9nsy2EO25
   Y9NxlfiN774pSyPNo4UbJ68fquKAtEkVjhV4n76NAjVp5jS2Kt4RQ6dus
   tjIWXQ5kK9icLdCohRRuo7JewiIpCibvzn7RV0RJdQnn1kkoIl9VkLq0M
   A/w+A5JpOIOPWYIb9GnrAVW70OIhYLGAgnEV6ULmeTIbl1werZgmRc9lu
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="349561704"
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="349561704"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 02:25:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="725711892"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 15 Apr 2022 02:25:26 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfICj-0001nZ-Oe;
        Fri, 15 Apr 2022 09:25:25 +0000
Date:   Fri, 15 Apr 2022 17:24:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [esmil:visionfive 50/54]
 drivers/soc/sifive/sifive_l2_cache.c:148:19: warning: result of comparison
 of constant 36507222016 with expression of type 'unsigned long' is always
 false
Message-ID: <202204151722.kW2xaxTy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   4d0bf74de3a2e2bb05b6c110d3b258d005430d7f
commit: 44b4542801a3eef74aee528fcb2799afc57e5c82 [50/54] RISC-V: Enable SIFIVE_L2_FLUSH for StarFive SoCs
config: riscv-randconfig-c006-20220414 (https://download.01.org/0day-ci/archive/20220415/202204151722.kW2xaxTy-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6b7e6ea489f6dd45a9b0da9ac20871560917b9b0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/esmil/linux/commit/44b4542801a3eef74aee528fcb2799afc57e5c82
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 44b4542801a3eef74aee528fcb2799afc57e5c82
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/soc/sifive/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/soc/sifive/sifive_l2_cache.c:158:3: error: implicit declaration of function 'writeq' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   writeq(line, l2_base + SIFIVE_L2_FLUSH64);
                   ^
>> drivers/soc/sifive/sifive_l2_cache.c:148:19: warning: result of comparison of constant 36507222016 with expression of type 'unsigned long' is always false [-Wtautological-constant-out-of-range-compare]
              (start + len) > (CONFIG_SIFIVE_L2_FLUSH_START +
              ~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.


vim +148 drivers/soc/sifive/sifive_l2_cache.c

a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah          2019-05-06  126  
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  127  #ifdef CONFIG_SIFIVE_L2_FLUSH
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  128  void sifive_l2_flush64_range(unsigned long start, unsigned long len)
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  129  {
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  130  	unsigned long line;
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  131  
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  132  	if(!l2_base) {
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  133  		pr_warn("L2CACHE: base addr invalid, skipping flush\n");
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  134  		return;
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  135  	}
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  136  
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  137  	/* TODO: if (len == 0), skipping flush or going on? */
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  138  	if(!len) {
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  139  		pr_debug("L2CACHE: flush64 range @ 0x%lx(len:0)\n", start);
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  140  		return;
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  141  	}
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  142  
170da5f236a1d7 drivers/soc/sifive/sifive_l2_cache.c Atish Patra        2021-06-12  143  	len = len + (start % SIFIVE_L2_FLUSH64_LINE_LEN);
170da5f236a1d7 drivers/soc/sifive/sifive_l2_cache.c Atish Patra        2021-06-12  144  	start = ALIGN_DOWN(start, SIFIVE_L2_FLUSH64_LINE_LEN);
170da5f236a1d7 drivers/soc/sifive/sifive_l2_cache.c Atish Patra        2021-06-12  145  
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  146  	/* make sure the address is in the range */
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  147  	if(start < CONFIG_SIFIVE_L2_FLUSH_START ||
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08 @148  	   (start + len) > (CONFIG_SIFIVE_L2_FLUSH_START +
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  149  			     CONFIG_SIFIVE_L2_FLUSH_SIZE)) {
56e0bd5b6b12ff drivers/soc/sifive/sifive_l2_cache.c Geert Uytterhoeven 2021-05-21  150  		WARN(1, "L2CACHE: flush64 out of range: %lx(%lx), skip flush\n",
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  151  		     start, len);
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  152  		return;
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  153  	}
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  154  
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  155  	mb();	/* sync */
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  156  	for (line = start; line < start + len;
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  157  	     line += SIFIVE_L2_FLUSH64_LINE_LEN) {
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08 @158  		writeq(line, l2_base + SIFIVE_L2_FLUSH64);
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  159  		mb();
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  160  	}
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  161  }
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  162  EXPORT_SYMBOL_GPL(sifive_l2_flush64_range);
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  163  #endif
704151e7f415c4 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  164  

:::::: The code at line 148 was first introduced by commit
:::::: 704151e7f415c483a9c1854a8a0952f4f365c45d sifive/sifive_l2_cache: Add sifive_l2_flush64_range function

:::::: TO: Tom <support@vamrs.com>
:::::: CC: Emil Renner Berthing <kernel@esmil.dk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
