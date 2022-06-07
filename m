Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CE75421DA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389480AbiFHBqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381367AbiFGWmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 18:42:49 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684791A8E38
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654630464; x=1686166464;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nMwIYlHjiSDXJfavSznI1rVa27YLpTBuPQ+gIwdpgew=;
  b=fNF3q5BS0Jfy/plPnCCOEywQ3oF5CXTMWGYRPj/W6QMU98NdkeqqytA8
   UIpXRZXWyDbdAwaPsGGQlsyoglHeUFpuk8+ZkuPwvqDMxUdv06rqNS3fW
   9nE6ZRCPDhnEjKic/njDBPzsGTns02UXDWqWqL5f6LVaxjHeKJNGqSDlt
   SFCvkDM2p/B9a4E4ONjI9FK2oNk6PfyCVjIIbWg8dPno/t9PMwyt29JEB
   Z6cO9oSPfhr8Jy5JCL8UFx7T8i7GitJjuosW2/WF7kdw2EC4PNNU/AJHU
   8GkSrc6qwe9zhnlhz/rYDVu0RlF4q2Eh//gGfjDvl4yyCD2DWLYgSjOqE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="275515315"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="275515315"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 12:34:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="532755934"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Jun 2022 12:34:02 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyexm-000DtB-1D;
        Tue, 07 Jun 2022 19:34:02 +0000
Date:   Wed, 8 Jun 2022 03:33:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/m68k/coldfire/m523x.c:31:19: sparse: sparse: symbol
 'm523x_clk_lookup' was not declared. Should it be static?
Message-ID: <202206080316.wGYMA1Sk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e71e60cd74df9386c3f684c54888f2367050b831
commit: 63aadb77669a6856b26d73da85b4f788731524a3 m68k: coldfire: use clkdev_lookup on most coldfire
date:   12 months ago
config: m68k-randconfig-s031-20220607 (https://download.01.org/0day-ci/archive/20220608/202206080316.wGYMA1Sk-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-26-gb3cf30ba-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=63aadb77669a6856b26d73da85b4f788731524a3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 63aadb77669a6856b26d73da85b4f788731524a3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=m68k SHELL=/bin/bash arch/m68k/coldfire/ fs/

If you fix the issue, kindly add following tag where applicable
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
