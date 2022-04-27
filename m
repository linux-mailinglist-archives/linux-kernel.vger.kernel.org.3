Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB1E511CDA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243994AbiD0Ra4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiD0Ray (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:30:54 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD5D73789
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651080462; x=1682616462;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZCqRL2nULn+c4atR1gdffjMJlGxdVmYqnHfTcJl0rik=;
  b=Bij0y43y8qL80Ss1vnFy4WWbG9pNfIPkzUFADIshmcRuyT6d7ALxPQ6T
   aWaUTJn5zXtIrMtEPXkNVwipZXJonQjbyWnprqMQEXvgHdplzQbSBRag4
   e408uv6+/0z0WFSIRZYIv6aeVXnY60pfXnY+PNrTyc6EtlBLPZY+vSuYp
   1ZDdYJC2sY1HsQq4MXEhbbttT2LfpA73QjQf0EM3h1Al+mVBjVus0kxNf
   YKsYvEXfKgCtHFjK2nvr/NaqDEUQG87lEq1bgB1s1zD78NcbPMf381Umi
   Wp8+g3XtzTu4hH8X1Vi8bQFsRAsySoa3ZLF2CQKuIidfMjGxrhe/lfkZU
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="266171895"
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="266171895"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 10:27:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="876757424"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 27 Apr 2022 10:27:40 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njlRz-0004oo-Dk;
        Wed, 27 Apr 2022 17:27:39 +0000
Date:   Thu, 28 Apr 2022 01:27:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Miles Chen <miles.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: drivers/clk/mediatek/clk-pll.c:418:23: warning: variable 'base' set
 but not used
Message-ID: <202204280114.eJS2jGX1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   46cf2c613f4b10eb12f749207b0fd2c1bfae3088
commit: 6dd199064dd86127030b5bc59d4058370b6c8310 clk: mediatek: pll: Implement unregister API
date:   10 weeks ago
config: sh-randconfig-r016-20220427 (https://download.01.org/0day-ci/archive/20220428/202204280114.eJS2jGX1-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6dd199064dd86127030b5bc59d4058370b6c8310
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6dd199064dd86127030b5bc59d4058370b6c8310
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/clk/mediatek/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/clk/mediatek/clk-pll.c: In function 'mtk_clk_unregister_plls':
>> drivers/clk/mediatek/clk-pll.c:418:23: warning: variable 'base' set but not used [-Wunused-but-set-variable]
     418 |         __iomem void *base = NULL;
         |                       ^~~~


vim +/base +418 drivers/clk/mediatek/clk-pll.c

   414	
   415	void mtk_clk_unregister_plls(const struct mtk_pll_data *plls, int num_plls,
   416				     struct clk_onecell_data *clk_data)
   417	{
 > 418		__iomem void *base = NULL;
   419		int i;
   420	
   421		if (!clk_data)
   422			return;
   423	
   424		for (i = num_plls; i > 0; i--) {
   425			const struct mtk_pll_data *pll = &plls[i - 1];
   426	
   427			if (IS_ERR_OR_NULL(clk_data->clks[pll->id]))
   428				continue;
   429	
   430			/*
   431			 * This is quite ugly but unfortunately the clks don't have
   432			 * any device tied to them, so there's no place to store the
   433			 * pointer to the I/O region base address. We have to fetch
   434			 * it from one of the registered clks.
   435			 */
   436			base = mtk_clk_pll_get_base(clk_data->clks[pll->id], pll);
   437	
   438			mtk_clk_unregister_pll(clk_data->clks[pll->id]);
   439			clk_data->clks[pll->id] = ERR_PTR(-ENOENT);
   440		}
   441	
   442		iounmap(base);
   443	}
   444	EXPORT_SYMBOL_GPL(mtk_clk_unregister_plls);
   445	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
