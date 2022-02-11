Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E7D4B1EA0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 07:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345823AbiBKGgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 01:36:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243174AbiBKGgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:36:37 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86D726DA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 22:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644561396; x=1676097396;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ie/i3Qvp4DuzO1nw6b7nkiCe6qMgPLbvuZfIsTPFAY8=;
  b=ZNBH5+RGPaQmfb0hDdqoi65xUSkB1K7Lpgv4VEAYRHf+7fPY4bwlF6HO
   XdNeU3JNzaIYvrHb1fqW4zLjA5yhIeVGofgmbmp4K/dAcfgvFepf46oU9
   oii3XhkpLYkyTBl0O9cCxcgQMC7gxBrREhVEzDC8v4IFz7gJSoMwJW8cV
   BXoLgaiUVR738qDNiJUZT2mD5aUNF5W/yFDLZ+8IPcNXuqi4U0ij/iVeN
   fW5n16kK2pFNK6fGq8hULkVAD0D/FjF9OKBtbTFG6QvWdQ+9wwlXuX44c
   6aw5b8ripm0RyvjoF6wAl8qxYUlxVF85L90pzf9oylJAwpQm+Ja3K9To0
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="249423537"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="249423537"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 22:36:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="623123666"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Feb 2022 22:36:32 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIPXk-0004Ek-4p; Fri, 11 Feb 2022 06:36:32 +0000
Date:   Fri, 11 Feb 2022 14:35:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/m68k/coldfire/m523x.c:31:19: sparse: sparse: symbol
 'm523x_clk_lookup' was not declared. Should it be static?
Message-ID: <202202111434.ezwGbZ9a-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f1baf68e1383f6ed93eb9cff2866d46562607a43
commit: 63aadb77669a6856b26d73da85b4f788731524a3 m68k: coldfire: use clkdev_lookup on most coldfire
date:   8 months ago
config: m68k-randconfig-s032-20220211 (https://download.01.org/0day-ci/archive/20220211/202202111434.ezwGbZ9a-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=63aadb77669a6856b26d73da85b4f788731524a3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 63aadb77669a6856b26d73da85b4f788731524a3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=m68k SHELL=/bin/bash arch/m68k/coldfire/ drivers/net/ethernet/cirrus/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/m68k/coldfire/m523x.c:31:19: sparse: sparse: symbol 'm523x_clk_lookup' was not declared. Should it be static?

vim +/m523x_clk_lookup +31 arch/m68k/coldfire/m523x.c

    30	
  > 31	struct clk_lookup m523x_clk_lookup[] = {
    32		CLKDEV_INIT(NULL, "pll.0", &clk_pll),
    33		CLKDEV_INIT(NULL, "sys.0", &clk_sys),
    34		CLKDEV_INIT("mcfpit.0", NULL, &clk_pll),
    35		CLKDEV_INIT("mcfpit.1", NULL, &clk_pll),
    36		CLKDEV_INIT("mcfpit.2", NULL, &clk_pll),
    37		CLKDEV_INIT("mcfpit.3", NULL, &clk_pll),
    38		CLKDEV_INIT("mcfuart.0", NULL, &clk_sys),
    39		CLKDEV_INIT("mcfuart.1", NULL, &clk_sys),
    40		CLKDEV_INIT("mcfuart.2", NULL, &clk_sys),
    41		CLKDEV_INIT("mcfqspi.0", NULL, &clk_sys),
    42		CLKDEV_INIT("fec.0", NULL, &clk_sys),
    43		CLKDEV_INIT("imx1-i2c.0", NULL, &clk_sys),
    44	};
    45	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
