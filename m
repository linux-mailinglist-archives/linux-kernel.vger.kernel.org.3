Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83F64E2072
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 07:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244571AbiCUGHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 02:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbiCUGHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 02:07:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADAF60A96
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 23:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647842775; x=1679378775;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bFyqALhA7OfJnFO9sDllFgshtGguc8ifM6aNskKwB5o=;
  b=n5ullq+JEJny7WtQcXnnTWyiMfygBTs7xe4GaPl6r4oMdH7oQbT5w0nb
   mVwZdcxffM3meybX0Jg5P+xc79MxjplMpiM31K77POmNyZjtG49m4E5dl
   twnYgR+9DzC2omwKyr9TMFeQcQljhwXHrvFDpxLmerxRFZvtkI/DqiJAR
   BX/kjHORNnCd+/exlGVGeh9Z99ARN/GQR+XLv6mC+XAFKRN9C5kafv1eJ
   63qlkGpIQzvbbydWdW1D7Tap4+vQDPAadfumI6iRkNl/MfLy7S/hH9d05
   i+cNjZoPrBriELaWnoxypgtK4WBfDcREQwxDQIOAxK/iqqllq7fKGlzuN
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="343905811"
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; 
   d="scan'208";a="343905811"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 23:06:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; 
   d="scan'208";a="518300240"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 20 Mar 2022 23:06:13 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWBBE-000HXR-QC; Mon, 21 Mar 2022 06:06:12 +0000
Date:   Mon, 21 Mar 2022 14:05:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/m68k/coldfire/m523x.c:31:19: sparse: sparse: symbol
 'm523x_clk_lookup' was not declared. Should it be static?
Message-ID: <202203211320.DInkQfSM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f443e374ae131c168a065ea1748feac6b2e76613
commit: 63aadb77669a6856b26d73da85b4f788731524a3 m68k: coldfire: use clkdev_lookup on most coldfire
date:   10 months ago
config: m68k-randconfig-s031-20220321 (https://download.01.org/0day-ci/archive/20220321/202203211320.DInkQfSM-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=m68k SHELL=/bin/bash arch/m68k/coldfire/

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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
