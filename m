Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D918498DBE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 20:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353897AbiAXTfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 14:35:32 -0500
Received: from mga04.intel.com ([192.55.52.120]:46673 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351946AbiAXT3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 14:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643052558; x=1674588558;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kw/Pqxn4zzEA3FRO8NnV1FqsGwZ/uPeuzfjR4yCnkRg=;
  b=T+H02f1v0iCzGFNEQBucoogCJJrjA6zVx12rZAVxaKNkaxd7Pl6M9SFC
   1xvQdJTsJ4Ma8viQ/0RtWdGNi/zRuAQIoJHG5ZodRTu9QCR8B2M2N7jc5
   /dULbVBJ++G03bQTWagTJmENk+byyxS82sVFKQ/+j9pFLi9T8soXEHN2F
   shv14GQQzussZX68nPQLCE8TGkCjhaFvNA5Gk4fWoNFGjcpLyvOsfOpf2
   aH9JE6fNeYIsKJvPGUv2rTSJWESFoTIttcw5qs2R7zE0VzPbxYfRB1GUb
   2WX8SrPO7Uwm++WwcERaq+nXX8Qw1MAZOadl62nd26Kol/D3cuA5Cr6PJ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="244962033"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="244962033"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 11:25:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="624197286"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jan 2022 11:25:05 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nC4xa-000IoX-Ry; Mon, 24 Jan 2022 19:25:02 +0000
Date:   Tue, 25 Jan 2022 03:24:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [esmil:visionfive 59/63]
 drivers/soc/sifive/sifive_l2_cache.c:148:19: warning: result of comparison
 of constant 36507222016 with expression of type 'unsigned long' is always
 false
Message-ID: <202201250206.q2ugUJBE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   fdbe623707a8f3f9b9d2cb3c4c240299a12b8302
commit: c17f07c367229d46348e9005d004d8b3416637bc [59/63] RISC-V: Enable SIFIVE_L2_FLUSH for StarFive SoCs
config: riscv-randconfig-r015-20220124 (https://download.01.org/0day-ci/archive/20220125/202201250206.q2ugUJBE-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7b3d30728816403d1fd73cc5082e9fb761262bce)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/esmil/linux/commit/c17f07c367229d46348e9005d004d8b3416637bc
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout c17f07c367229d46348e9005d004d8b3416637bc
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/soc/sifive/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/soc/sifive/sifive_l2_cache.c:158:3: error: implicit declaration of function 'writeq' [-Werror,-Wimplicit-function-declaration]
                   writeq(line, l2_base + SIFIVE_L2_FLUSH64);
                   ^
>> drivers/soc/sifive/sifive_l2_cache.c:148:19: warning: result of comparison of constant 36507222016 with expression of type 'unsigned long' is always false [-Wtautological-constant-out-of-range-compare]
              (start + len) > (CONFIG_SIFIVE_L2_FLUSH_START +
              ~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.


vim +148 drivers/soc/sifive/sifive_l2_cache.c

a967a289f16969 arch/riscv/mm/sifive_l2_cache.c      Yash Shah          2019-05-06  126  
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  127  #ifdef CONFIG_SIFIVE_L2_FLUSH
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  128  void sifive_l2_flush64_range(unsigned long start, unsigned long len)
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  129  {
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  130  	unsigned long line;
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  131  
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  132  	if(!l2_base) {
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  133  		pr_warn("L2CACHE: base addr invalid, skipping flush\n");
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  134  		return;
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  135  	}
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  136  
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  137  	/* TODO: if (len == 0), skipping flush or going on? */
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  138  	if(!len) {
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  139  		pr_debug("L2CACHE: flush64 range @ 0x%lx(len:0)\n", start);
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  140  		return;
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  141  	}
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  142  
0684fe29f5de5f drivers/soc/sifive/sifive_l2_cache.c Atish Patra        2021-06-12  143  	len = len + (start % SIFIVE_L2_FLUSH64_LINE_LEN);
0684fe29f5de5f drivers/soc/sifive/sifive_l2_cache.c Atish Patra        2021-06-12  144  	start = ALIGN_DOWN(start, SIFIVE_L2_FLUSH64_LINE_LEN);
0684fe29f5de5f drivers/soc/sifive/sifive_l2_cache.c Atish Patra        2021-06-12  145  
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  146  	/* make sure the address is in the range */
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  147  	if(start < CONFIG_SIFIVE_L2_FLUSH_START ||
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08 @148  	   (start + len) > (CONFIG_SIFIVE_L2_FLUSH_START +
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  149  			     CONFIG_SIFIVE_L2_FLUSH_SIZE)) {
b5cf3456431952 drivers/soc/sifive/sifive_l2_cache.c Geert Uytterhoeven 2021-05-21  150  		WARN(1, "L2CACHE: flush64 out of range: %lx(%lx), skip flush\n",
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  151  		     start, len);
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  152  		return;
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  153  	}
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  154  
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  155  	mb();	/* sync */
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  156  	for (line = start; line < start + len;
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  157  	     line += SIFIVE_L2_FLUSH64_LINE_LEN) {
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  158  		writeq(line, l2_base + SIFIVE_L2_FLUSH64);
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  159  		mb();
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  160  	}
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  161  }
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  162  EXPORT_SYMBOL_GPL(sifive_l2_flush64_range);
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  163  #endif
c6649e71d37210 drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  164  

:::::: The code at line 148 was first introduced by commit
:::::: c6649e71d37210bc4c33eada849aeda98c823de9 sifive/sifive_l2_cache: Add sifive_l2_flush64_range function

:::::: TO: Tom <support@vamrs.com>
:::::: CC: Emil Renner Berthing <kernel@esmil.dk>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
