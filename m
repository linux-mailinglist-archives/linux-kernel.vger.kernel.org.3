Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646644A4F83
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 20:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376852AbiAaTe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 14:34:56 -0500
Received: from mga05.intel.com ([192.55.52.43]:2065 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343885AbiAaTey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 14:34:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643657694; x=1675193694;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cChH8+znn3t0kReebLQbywe4khYSpVp1da+Pn8uCcTo=;
  b=mCETvXtJXK+70Uapbi+fO43Zdjo43b11eoyj4krMY9tejSQJ7g79ek2x
   eldoNVjHhWdN/nG7zfudtH69hw/VqRwwL6cLQhMUndyCOnPNMANKA/QqB
   y8kpmTWImy1OlPXvO+qD9jVJtHAU7zDp3mcGqi9P/oF9SnEbl2SufO/7/
   d0hRFia7oDJlZ+dwDRUMmWfd1UEYqO330Rr16GPJeWm3Ts50QnFhrOo2I
   iByC2ddliLxmji4/2umswPhPHQ6y/LEXzXPxJiGr/mbDUyqxSe25imWrk
   NHKrMw/+RyiZGBzYAuxdqmkMqfcSAm8LRr5OxSUx0UGKPgS1GzVE9Cxez
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="333891481"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="333891481"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 11:34:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="675836719"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 31 Jan 2022 11:34:45 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEcRo-000SHh-D0; Mon, 31 Jan 2022 19:34:44 +0000
Date:   Tue, 1 Feb 2022 03:34:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tom <support@vamrs.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [esmil:visionfive 29/62] drivers/soc/sifive/sifive_l2_cache.c:152:3:
 error: implicit declaration of function 'writeq'
Message-ID: <202202010337.bSdnhIBF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   8c758048edfd830baceb991167131c9d55786544
commit: 601a2f4e945153ebae8645596eda50ea39369c88 [29/62] sifive/sifive_l2_cache: Add sifive_l2_flush64_range function
config: riscv-randconfig-r004-20220130 (https://download.01.org/0day-ci/archive/20220201/202202010337.bSdnhIBF-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 2cdbaca3943a4d6259119f185656328bd3805b68)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/esmil/linux/commit/601a2f4e945153ebae8645596eda50ea39369c88
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 601a2f4e945153ebae8645596eda50ea39369c88
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/soc/sifive/sifive_l2_cache.c:152:3: error: implicit declaration of function 'writeq' [-Werror,-Wimplicit-function-declaration]
                   writeq(line, l2_base + SIFIVE_L2_FLUSH64);
                   ^
   drivers/soc/sifive/sifive_l2_cache.c:142:19: warning: result of comparison of constant 36507222016 with expression of type 'unsigned long' is always false [-Wtautological-constant-out-of-range-compare]
              (start + len) > (CONFIG_SIFIVE_L2_FLUSH_START +
              ~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.


vim +/writeq +152 drivers/soc/sifive/sifive_l2_cache.c

   123	
   124	#ifdef CONFIG_SIFIVE_L2_FLUSH
   125	void sifive_l2_flush64_range(unsigned long start, unsigned long len)
   126	{
   127		unsigned long line;
   128	
   129		if(!l2_base) {
   130			pr_warn("L2CACHE: base addr invalid, skipping flush\n");
   131			return;
   132		}
   133	
   134		/* TODO: if (len == 0), skipping flush or going on? */
   135		if(!len) {
   136			pr_debug("L2CACHE: flush64 range @ 0x%lx(len:0)\n", start);
   137			return;
   138		}
   139	
   140		/* make sure the address is in the range */
   141		if(start < CONFIG_SIFIVE_L2_FLUSH_START ||
   142		   (start + len) > (CONFIG_SIFIVE_L2_FLUSH_START +
   143				     CONFIG_SIFIVE_L2_FLUSH_SIZE)) {
   144			pr_warn("L2CACHE: flush64 out of range: %lx(%lx), skip flush\n",
   145				start, len);
   146			return;
   147		}
   148	
   149		mb();	/* sync */
   150		for (line = start; line < start + len;
   151		     line += SIFIVE_L2_FLUSH64_LINE_LEN) {
 > 152			writeq(line, l2_base + SIFIVE_L2_FLUSH64);
   153			mb();
   154		}
   155	}
   156	EXPORT_SYMBOL_GPL(sifive_l2_flush64_range);
   157	#endif
   158	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
