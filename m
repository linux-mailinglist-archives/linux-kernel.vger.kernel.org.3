Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9576D4EFFD2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 10:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239456AbiDBIzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 04:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiDBIzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 04:55:49 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7D929C83
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 01:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648889637; x=1680425637;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OsDbHI/cRT5Q/uLzBEUBDLB9FC/AmZf0xIpeMnx3+6Q=;
  b=RxHrF8ontJIYPrYvJV+QjyEi+Tv1HUkb3FArsXQcMGvsVqNTCh4aEIW4
   UHqHfVLkXt1WsF2mUIklJ6Gyq4brZz7AUvhpPr37jzuFGI+UNWBUm5tYs
   TSHgkWRu0vk5F9u65B6tSAUgSIdwFipSYt28Gty5wQn5sJ5ia8SelpwGm
   wodMx7rl+KhLQPv9+mT72ENmiXBfcz5X56deXEJprzX+0Iz1GnkrH5A+E
   I7rXIZ5WNo0tt/pbuZMkYYJ+OY5fDSghthMqVV2+CXk/JPyvPmUbFSXHZ
   TvabBQdkBy8hVRDvpEBp0AIvfB/NgE0JiV96UYYT2SYxivg9JhwVI/akq
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="285226391"
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="285226391"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 01:53:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="587105430"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 02 Apr 2022 01:53:54 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1naZW6-00026N-3G;
        Sat, 02 Apr 2022 08:53:54 +0000
Date:   Sat, 2 Apr 2022 16:53:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/clk/clk-fixed-mmio.c:26: undefined reference to `of_iomap'
Message-ID: <202204021621.QxSalFbt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   88e6c0207623874922712e162e25d9dafd39661e
commit: f9b3cd24578401e7a392974b3353277286e49cee Kconfig.debug: make DEBUG_INFO selectable from a choice
date:   9 days ago
config: s390-buildonly-randconfig-r001-20220402 (https://download.01.org/0day-ci/archive/20220402/202204021621.QxSalFbt-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f9b3cd24578401e7a392974b3353277286e49cee
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f9b3cd24578401e7a392974b3353277286e49cee
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/clk/clk-fixed-mmio.o: in function `fixed_mmio_clk_setup':
>> drivers/clk/clk-fixed-mmio.c:26: undefined reference to `of_iomap'
>> s390-linux-ld: drivers/clk/clk-fixed-mmio.c:33: undefined reference to `iounmap'
   s390-linux-ld: drivers/char/xillybus/xillybus_of.o: in function `xilly_drv_probe':
>> drivers/char/xillybus/xillybus_of.c:50: undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/crypto/ccree/cc_driver.o: in function `init_cc_resources':
>> drivers/crypto/ccree/cc_driver.c:355: undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/crypto/ccree/cc_debugfs.o: in function `cc_debugfs_init':
>> drivers/crypto/ccree/cc_debugfs.c:80: undefined reference to `debugfs_create_regset32'
>> s390-linux-ld: drivers/crypto/ccree/cc_debugfs.c:100: undefined reference to `debugfs_create_regset32'


vim +26 drivers/clk/clk-fixed-mmio.c

50cc4caf531abb Jan Kotas 2018-12-13  17  
50cc4caf531abb Jan Kotas 2018-12-13  18  static struct clk_hw *fixed_mmio_clk_setup(struct device_node *node)
50cc4caf531abb Jan Kotas 2018-12-13  19  {
50cc4caf531abb Jan Kotas 2018-12-13  20  	struct clk_hw *clk;
50cc4caf531abb Jan Kotas 2018-12-13  21  	const char *clk_name = node->name;
50cc4caf531abb Jan Kotas 2018-12-13  22  	void __iomem *base;
50cc4caf531abb Jan Kotas 2018-12-13  23  	u32 freq;
50cc4caf531abb Jan Kotas 2018-12-13  24  	int ret;
50cc4caf531abb Jan Kotas 2018-12-13  25  
50cc4caf531abb Jan Kotas 2018-12-13 @26  	base = of_iomap(node, 0);
50cc4caf531abb Jan Kotas 2018-12-13  27  	if (!base) {
50cc4caf531abb Jan Kotas 2018-12-13  28  		pr_err("%pOFn: failed to map address\n", node);
50cc4caf531abb Jan Kotas 2018-12-13  29  		return ERR_PTR(-EIO);
50cc4caf531abb Jan Kotas 2018-12-13  30  	}
50cc4caf531abb Jan Kotas 2018-12-13  31  
50cc4caf531abb Jan Kotas 2018-12-13  32  	freq = readl(base);
50cc4caf531abb Jan Kotas 2018-12-13 @33  	iounmap(base);
50cc4caf531abb Jan Kotas 2018-12-13  34  	of_property_read_string(node, "clock-output-names", &clk_name);
50cc4caf531abb Jan Kotas 2018-12-13  35  
50cc4caf531abb Jan Kotas 2018-12-13  36  	clk = clk_hw_register_fixed_rate(NULL, clk_name, NULL, 0, freq);
50cc4caf531abb Jan Kotas 2018-12-13  37  	if (IS_ERR(clk)) {
50cc4caf531abb Jan Kotas 2018-12-13  38  		pr_err("%pOFn: failed to register fixed rate clock\n", node);
50cc4caf531abb Jan Kotas 2018-12-13  39  		return clk;
50cc4caf531abb Jan Kotas 2018-12-13  40  	}
50cc4caf531abb Jan Kotas 2018-12-13  41  
50cc4caf531abb Jan Kotas 2018-12-13  42  	ret = of_clk_add_hw_provider(node, of_clk_hw_simple_get, clk);
50cc4caf531abb Jan Kotas 2018-12-13  43  	if (ret) {
50cc4caf531abb Jan Kotas 2018-12-13  44  		pr_err("%pOFn: failed to add clock provider\n", node);
50cc4caf531abb Jan Kotas 2018-12-13  45  		clk_hw_unregister(clk);
50cc4caf531abb Jan Kotas 2018-12-13  46  		clk = ERR_PTR(ret);
50cc4caf531abb Jan Kotas 2018-12-13  47  	}
50cc4caf531abb Jan Kotas 2018-12-13  48  
50cc4caf531abb Jan Kotas 2018-12-13  49  	return clk;
50cc4caf531abb Jan Kotas 2018-12-13  50  }
50cc4caf531abb Jan Kotas 2018-12-13  51  

:::::: The code at line 26 was first introduced by commit
:::::: 50cc4caf531abb2075c6973451fccdaba9f02715 clk: Add Fixed MMIO clock driver

:::::: TO: Jan Kotas <jank@cadence.com>
:::::: CC: Stephen Boyd <sboyd@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
