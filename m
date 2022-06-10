Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BB3546A00
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 18:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349446AbiFJP7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 11:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243323AbiFJP7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 11:59:47 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349028FF9C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 08:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654876787; x=1686412787;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5YjDkunHMrFL7VHzmCQxtIGp1/X3vd6xJwb1Np70V5o=;
  b=dmYpCSn6034hMFZXtbhzl5pjkfsAsC8iDeUsXVcNXgiZ4BmcuAnrHmu2
   ne3vDx3HLzpYE7yk4W+TPEvj9/jDWs11rhsfwA3nRwEzGeyvP0P5jMmrS
   YrGqNowbz8v4tyAP3VOkPGu70nL0X/H5k3ajtlWUgsb6iW6tRMY2XmeDh
   HEWivibnEj4aOy0veOsTXowxRWBO/pKbddGl10+zDwj9B4/K8hfwkccoY
   yelQbKkjx4sOTuqjv/tBAbSp1bJsPm2O8oMzs8DYfdcfkP1xXpNyqU82p
   n6VSinqINUYgH68r2SwJf2UOOq53wwgjBGsCaytbh5y0EjSgWZ7AT+jc7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="266429881"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="266429881"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 08:59:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="710991379"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 10 Jun 2022 08:59:45 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzh32-000I5h-BH;
        Fri, 10 Jun 2022 15:59:44 +0000
Date:   Fri, 10 Jun 2022 23:59:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tom <support@vamrs.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [esmil:visionfive 22/54] drivers/soc/sifive/sifive_l2_cache.c:152:3:
 error: call to undeclared function 'writeq'; ISO C99 and later do not
 support implicit function declarations
Message-ID: <202206102311.0QQHm3hS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   906be7ef2fb9e2f1fcb740d3d506768cddfc52ca
commit: 1c9c971346b0ca811114ae00fce28cbf3c34232b [22/54] sifive/sifive_l2_cache: Add sifive_l2_flush64_range function
config: riscv-buildonly-randconfig-r006-20220609 (https://download.01.org/0day-ci/archive/20220610/202206102311.0QQHm3hS-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 70d35fe1257e429266b83025997b400e9f79110e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv-linux-gnu
        # https://github.com/esmil/linux/commit/1c9c971346b0ca811114ae00fce28cbf3c34232b
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 1c9c971346b0ca811114ae00fce28cbf3c34232b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/soc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/soc/sifive/sifive_l2_cache.c:152:3: error: call to undeclared function 'writeq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
