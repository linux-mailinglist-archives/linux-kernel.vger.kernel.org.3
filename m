Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054354A4951
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 15:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236358AbiAaO33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 09:29:29 -0500
Received: from mga04.intel.com ([192.55.52.120]:16893 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236177AbiAaO32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 09:29:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643639368; x=1675175368;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=t27D63dmU5/P6d/whQMsjWjh1WkpG0ASB00upGtkJzY=;
  b=PFlB+obD37Y1N+B0dpMMs9MxYPtnxCMAfjjrflYOeYtTdVD0P4IGz+w2
   4TYyCuiFGMBz1WmiFMJaT6C+HpgJPIH9XiTwQUqoovAzSLDc4vi+9I2Y+
   UntqMDCjOWraB/YK47VJ9ej+JPPk0NSasvd2toYO/JJt5sAr5LVob5c22
   1HMSoqjQ6gSPoYyxAej/v5Y8B1+0cT8bKQgJiDD/hWJA8dgDSzJBry6pk
   MsfCgO7X9ysOJRAQZ/5+U6meOByRjCOfb7/yMTKqiP6UYu45GTJfTe6J7
   2Lt8iGmA2aTx/SwFcGixGhqdMJ7+BxJBuJ3Amdk/+KsS3vGs/fXU8jYid
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="246303702"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="246303702"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 06:29:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="768603543"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 31 Jan 2022 06:29:26 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEXgM-000Rzt-9p; Mon, 31 Jan 2022 14:29:26 +0000
Date:   Mon, 31 Jan 2022 22:29:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tom <support@vamrs.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [esmil:visionfive 29/62]
 drivers/soc/sifive/sifive_l2_cache.c:142:19: warning: result of comparison
 of constant 36507222016 with expression of type 'unsigned long' is always
 false
Message-ID: <202201312255.K6MgEaRZ-lkp@intel.com>
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
config: riscv-randconfig-r004-20220130 (https://download.01.org/0day-ci/archive/20220131/202201312255.K6MgEaRZ-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/soc/sifive/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/soc/sifive/sifive_l2_cache.c:152:3: error: implicit declaration of function 'writeq' [-Werror,-Wimplicit-function-declaration]
                   writeq(line, l2_base + SIFIVE_L2_FLUSH64);
                   ^
>> drivers/soc/sifive/sifive_l2_cache.c:142:19: warning: result of comparison of constant 36507222016 with expression of type 'unsigned long' is always false [-Wtautological-constant-out-of-range-compare]
              (start + len) > (CONFIG_SIFIVE_L2_FLUSH_START +
              ~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.


vim +142 drivers/soc/sifive/sifive_l2_cache.c

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
 > 142		   (start + len) > (CONFIG_SIFIVE_L2_FLUSH_START +
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
