Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F358B4C356B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbiBXTLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbiBXTLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:11:04 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7F120DB2E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645729834; x=1677265834;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HaQfjHlK/TOUx0USrUGLMW9tdvbyzyyT+DQI7d9FpSY=;
  b=Vg2evt6Y9vSpiMGJ8MEbFkWstXvX2AyC+d1o7icHWZW1UGqSUgjbduYz
   awl6lGLraUzKMhcZbjTjEypQ1+/b7NjOIMPE5oe2IPdTAnVW2YKa16NjB
   mgt28UnUJz/JTZ7JO7WaCI3c18Sw5zYB/6biQomiTAUCc44q4dLACTqlD
   3G4pgZ3EBndPwBwiC9nro3vcTrFDaNawoslfEg4w+giqoWcCyeFzn18qv
   qsy1iz3vpq0mol/NyY4RntFEnLqBf+J1XVTt4fEiXX6TQucmZqBqo2TNG
   VUQUyU/rwyT70JaRdSPEZSHY1lgJ32pfubAnnLDTrCow/RnrHez4iYhl7
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="232299778"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="232299778"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 11:10:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="777164724"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 24 Feb 2022 11:10:32 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNJVX-0003Oh-NB; Thu, 24 Feb 2022 19:10:31 +0000
Date:   Fri, 25 Feb 2022 03:10:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: s390-linux-ld: clk-lan966x.c:undefined reference to
 `devm_ioremap_resource'
Message-ID: <202202250246.PWe7AMU9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Horatiu,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   23d04328444a8fa0ca060c5e532220dac8e8bc26
commit: 5ad5915dea0047a6376d8f809ea3470ef68b1f92 clk: lan966x: Extend lan966x clock driver for clock gating support
date:   3 months ago
config: s390-randconfig-r004-20220223 (https://download.01.org/0day-ci/archive/20220225/202202250246.PWe7AMU9-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5ad5915dea0047a6376d8f809ea3470ef68b1f92
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5ad5915dea0047a6376d8f809ea3470ef68b1f92
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/clk/clk-lan966x.o: in function `lan966x_clk_probe':
   clk-lan966x.c:(.text+0x392): undefined reference to `devm_platform_ioremap_resource'
>> s390-linux-ld: clk-lan966x.c:(.text+0x498): undefined reference to `devm_ioremap_resource'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
