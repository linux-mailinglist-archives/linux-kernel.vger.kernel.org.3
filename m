Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A56B543B3F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 20:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbiFHSRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 14:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbiFHSOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 14:14:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2865F66
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 11:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654712085; x=1686248085;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=q0UKg2td1OeH75UdMMAKk817pN6Kfw8ugHHAYDiXytQ=;
  b=Jcq4QghJmuwsO7BxsvVXB6ZDA3EezPPIelQ0UH6huecfJ7Nuaoa6Apki
   OT2fsR8H4yBRb3DnAcYZSXheicPh4XlD0b8yR/Hy7yzkOiQsjFIlvHUmz
   DyhfLW3kRR2brzuvGzZSbKtle6dz0sMDeAYs+pD9IeZ9SzjTky4iQO5Jz
   FxDAZT8a8WtSHaGORcsIytP2/K6a1JvYgYuPrbwiUs69t7m/gr/9O0ftG
   ZVdfAySGA0ZpiAdVkbFKe8qSmIkIM+12eFOrg4AmrC5+qknOxoQQEbXCa
   T6WRQyugjOpIVzVaaTzJysBswWpPOqTiWwxpqaVLzzQo8aAYiGteDrv2G
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="274518721"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="274518721"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 11:14:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="615499926"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 08 Jun 2022 11:14:43 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nz0CY-000Esv-Ms;
        Wed, 08 Jun 2022 18:14:42 +0000
Date:   Thu, 9 Jun 2022 02:14:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/m68k/coldfire/m523x.c:31:19: sparse: sparse: symbol
 'm523x_clk_lookup' was not declared. Should it be static?
Message-ID: <202206090157.h0Kd7mjN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   34f4335c16a5f4bb7da6c8d2d5e780b6a163846a
commit: 63aadb77669a6856b26d73da85b4f788731524a3 m68k: coldfire: use clkdev_lookup on most coldfire
date:   1 year ago
config: m68k-randconfig-s031-20220607 (https://download.01.org/0day-ci/archive/20220609/202206090157.h0Kd7mjN-lkp@intel.com/config)
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
