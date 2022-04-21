Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285955097B8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384966AbiDUGgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384896AbiDUGfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:35:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F4B13F40
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650522770; x=1682058770;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LJkqSCxMZhRTCmXAmX8KGvpLRUWshnwi8beUnGU/DUk=;
  b=kyTW/sKsD3JLgyPwmBuPf5ihZsKlXnvv1zYY8UhntVPecA2sStSTci4d
   sr1a+X26fk85lxZC5C7CXHJQ51LQ9jdG/2hYSXEYseXKoxl6dPfpHHppK
   51fV4Df8OhRcgnGVfOl6C4rGJkGpJgM4sEnKKWO2gUKGGIEQ66CMRJDpu
   hvbTg8Ov1uRS1XUclX4c5RHpfFoXPNEZVnPl1c4C3XAyLkrEilW4CmhNB
   Xww0k4gPmhXmASMuXQ2XV7AAcyyOtYvPZhrB3LdewK8ddwuFsKVOwZqe0
   pVGgkjeqUHwolPShoILSEvg/+XULmsxnQ5grSRby+bgmS30BR1P6uOk2J
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="244188238"
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="244188238"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:32:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="614754424"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 20 Apr 2022 23:32:48 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQMy-0007wf-Ce;
        Thu, 21 Apr 2022 06:32:48 +0000
Date:   Thu, 21 Apr 2022 14:31:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thierry Reding <treding@nvidia.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: drivers/memory/tegra/mc.c:320:7: warning: Local variable 'value'
 shadows outer variable [shadowVariable]
Message-ID: <202204201809.s6rWhuwc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   559089e0a93d44280ec3ab478830af319c56dbe3
commit: 56ebc9b0d77e0406aba2d900c82e79204cc7dc32 memory: tegra: Enable compile testing for all drivers
date:   11 months ago
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (cppcheck warning):
        # apt-get install cppcheck
        git checkout 56ebc9b0d77e0406aba2d900c82e79204cc7dc32
        cppcheck --quiet --enable=style,performance,portability --template=gcc FILE

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)
>> drivers/memory/tegra/mc.c:320:7: warning: Local variable 'value' shadows outer variable [shadowVariable]
     u32 value;
         ^
   drivers/memory/tegra/mc.c:306:6: note: Shadowed declaration
    u32 value;
        ^
   drivers/memory/tegra/mc.c:320:7: note: Shadow variable
     u32 value;
         ^

vim +/value +320 drivers/memory/tegra/mc.c

20e92462cdfb27 Dmitry Osipenko 2018-04-13  301  
89184651631713 Thierry Reding  2014-04-16  302  static int tegra_mc_setup_latency_allowance(struct tegra_mc *mc)
89184651631713 Thierry Reding  2014-04-16  303  {
89184651631713 Thierry Reding  2014-04-16  304  	unsigned long long tick;
89184651631713 Thierry Reding  2014-04-16  305  	unsigned int i;
89184651631713 Thierry Reding  2014-04-16  306  	u32 value;
89184651631713 Thierry Reding  2014-04-16  307  
89184651631713 Thierry Reding  2014-04-16  308  	/* compute the number of MC clock cycles per tick */
b906c056b6023c Dmitry Osipenko 2019-04-12  309  	tick = (unsigned long long)mc->tick * clk_get_rate(mc->clk);
89184651631713 Thierry Reding  2014-04-16  310  	do_div(tick, NSEC_PER_SEC);
89184651631713 Thierry Reding  2014-04-16  311  
48791f97223430 Dmitry Osipenko 2019-04-12  312  	value = mc_readl(mc, MC_EMEM_ARB_CFG);
89184651631713 Thierry Reding  2014-04-16  313  	value &= ~MC_EMEM_ARB_CFG_CYCLES_PER_UPDATE_MASK;
89184651631713 Thierry Reding  2014-04-16  314  	value |= MC_EMEM_ARB_CFG_CYCLES_PER_UPDATE(tick);
48791f97223430 Dmitry Osipenko 2019-04-12  315  	mc_writel(mc, value, MC_EMEM_ARB_CFG);
89184651631713 Thierry Reding  2014-04-16  316  
89184651631713 Thierry Reding  2014-04-16  317  	/* write latency allowance defaults */
89184651631713 Thierry Reding  2014-04-16  318  	for (i = 0; i < mc->soc->num_clients; i++) {
89184651631713 Thierry Reding  2014-04-16  319  		const struct tegra_mc_la *la = &mc->soc->clients[i].la;
89184651631713 Thierry Reding  2014-04-16 @320  		u32 value;
89184651631713 Thierry Reding  2014-04-16  321  
48791f97223430 Dmitry Osipenko 2019-04-12  322  		value = mc_readl(mc, la->reg);
89184651631713 Thierry Reding  2014-04-16  323  		value &= ~(la->mask << la->shift);
89184651631713 Thierry Reding  2014-04-16  324  		value |= (la->def & la->mask) << la->shift;
48791f97223430 Dmitry Osipenko 2019-04-12  325  		mc_writel(mc, value, la->reg);
89184651631713 Thierry Reding  2014-04-16  326  	}
89184651631713 Thierry Reding  2014-04-16  327  
76b959a44c0b9c Dmitry Osipenko 2019-04-12  328  	/* latch new values */
48791f97223430 Dmitry Osipenko 2019-04-12  329  	mc_writel(mc, MC_TIMING_UPDATE, MC_TIMING_CONTROL);
76b959a44c0b9c Dmitry Osipenko 2019-04-12  330  
89184651631713 Thierry Reding  2014-04-16  331  	return 0;
89184651631713 Thierry Reding  2014-04-16  332  }
89184651631713 Thierry Reding  2014-04-16  333  

:::::: The code at line 320 was first introduced by commit
:::::: 8918465163171322c77a19d5258a95f56d89d2e4 memory: Add NVIDIA Tegra memory controller support

:::::: TO: Thierry Reding <treding@nvidia.com>
:::::: CC: Thierry Reding <treding@nvidia.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
