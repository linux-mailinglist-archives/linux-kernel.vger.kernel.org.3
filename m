Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B0F4C1CB2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244555AbiBWT6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244562AbiBWT6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:58:16 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C960C3153B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645646267; x=1677182267;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rZ3ZnZW5S6mbLFIAzboD0o9V0WHiGiUpp7BNZHLCMno=;
  b=gaM3oHYhWJCkYnyaIy8Fu1qGJulYVt2KOOBnL5V6hpO6KPdvek+nb+YW
   HyMhITryThCzFHAnWAxA7H4SCKiQyozuVK05ZjMNbxceFFH694aLDAMdM
   CfYEhgtU0u4RTFmntbYNKV1ReGfnAUxZYDKwPELKjCYydk67Zp6jcWaQ9
   sUnjVjKqj2fS56g/Lsb5dO0AnLJfSjYUKQkArctB2lmFygLxqZt2RSdU8
   +3Xkk0PYP1QUnRifpyEOW+kZdxEEvdN7y+3aAk4xAkPcGz7QFou3kKP0d
   eFaTdW+HVo1HV5NE/mFy7AT3S8xCY2iOTIjb9HbZNcJFSHvA2Wrjap9+a
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="312784648"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="312784648"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 11:57:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="573955976"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 23 Feb 2022 11:57:46 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMxlh-0001lu-HA; Wed, 23 Feb 2022 19:57:45 +0000
Date:   Thu, 24 Feb 2022 03:56:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [chenxing:msc313_mainlining 77/93] Error:
 arch/arm/boot/dts/mstar-infinity2m-ssd201-wirelesstag-ido-som2d01.dtsi:18.1-9
 Label or path pm_uart not found
Message-ID: <202202240309.fSFamJiu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/linux-chenxing/linux.git msc313_mainlining
head:   99a396728dcff78ca3eddcbd2085f11eeb8a01b8
commit: 89e6d5a9a03b2a20d94fd0c2027fbe89ccb84c83 [77/93] ARM: dts: mstar: Add top level dts for ssd201-som2d01
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220224/202202240309.fSFamJiu-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/linux-chenxing/linux/commit/89e6d5a9a03b2a20d94fd0c2027fbe89ccb84c83
        git remote add chenxing git://github.com/linux-chenxing/linux.git
        git fetch --no-tags chenxing msc313_mainlining
        git checkout 89e6d5a9a03b2a20d94fd0c2027fbe89ccb84c83
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/mstar-infinity2m-ssd201-wirelesstag-ido-som2d01.dtsi:18.1-9 Label or path pm_uart not found
   FATAL ERROR: Syntax error parsing input tree

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
