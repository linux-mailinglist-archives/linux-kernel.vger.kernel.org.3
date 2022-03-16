Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D824DA6E4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 01:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352810AbiCPAcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 20:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbiCPAci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 20:32:38 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1A054F9C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 17:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647390685; x=1678926685;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=O2vtuUMGcpiw4aKuwBGN35a37smyYdBy+cKgxeAFTHw=;
  b=U/saCzSK1UIsQYKkrqPpKFis+oabU+8uUoHynQTy7sAoM9yfGYjwLyfa
   lcdlnQpb259yBi0dFHMisgUNu8ilJnBfsJ21+PG1zCy7RIracNQQOOjfg
   xzd1tudgTB6uoQtpHiM3Usvh3OLx8RUQ9Darbk82jPTWpyeDIkfM6T07y
   mGYQHcUB4vjNOcWEXitdn6p2qEji6Dwkiw+bVeDC+et/8h1ILiuHsS49f
   FtKFlCqa730mwgTu2TGCrgUl+2bWI8riIiS/nN4ZjO795LA91nvkn7p8L
   tQe2ac73UaPE09aRo8VNLvjxFmp9PIbobjnzt/LptaBbbgV9mndCMfk09
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="238620694"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="238620694"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 17:31:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="598512479"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 15 Mar 2022 17:31:23 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUHZT-000Bhd-5M; Wed, 16 Mar 2022 00:31:23 +0000
Date:   Wed, 16 Mar 2022 08:30:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [chenxing:msc313_mainlining 79/95] Error:
 arch/arm/boot/dts/mstar-infinity2m-ssd201-wirelesstag-ido-som2d01.dtsi:18.1-9
 Label or path pm_uart not found
Message-ID: <202203160838.GLh9IxnA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/linux-chenxing/linux.git msc313_mainlining
head:   6f0911d3048b5a3144b147137ba10a636dd23292
commit: d231501ff439bc2ea62d86220cb5fe5e49c42da7 [79/95] ARM: dts: mstar: Add top level dts for ssd201-som2d01
config: arm-randconfig-r003-20220313 (https://download.01.org/0day-ci/archive/20220316/202203160838.GLh9IxnA-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/linux-chenxing/linux/commit/d231501ff439bc2ea62d86220cb5fe5e49c42da7
        git remote add chenxing git://github.com/linux-chenxing/linux.git
        git fetch --no-tags chenxing msc313_mainlining
        git checkout d231501ff439bc2ea62d86220cb5fe5e49c42da7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/mstar-infinity2m-ssd201-wirelesstag-ido-som2d01.dtsi:18.1-9 Label or path pm_uart not found
   FATAL ERROR: Syntax error parsing input tree

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
