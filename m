Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1F74F13F1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 13:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376379AbiDDLod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 07:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238787AbiDDLob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 07:44:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69492616B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 04:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649072555; x=1680608555;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qZ249cS9BHhypOiO6l0ngEL97rK/THlJmqIZmeCvttM=;
  b=MrJykNzQM0CO9g+tKo0HqIvtSVSXdxKbVBS0YZhF8JmKlRpAXpVZ9Zi2
   lBiwClj+nFB6u6SFwPVUSO1zaZmlDapUeeJlcWPIMjVhNh02aUkL1qxli
   DIPBsoO/0RX3UOau7AGf9OF9GA9Zo2ayVwhx02rLosbrcTx+x2SNSIju0
   PtqEWjC6hWcs9bj++B3V7riKymUu7OAmokDxwO+B3ASRv6G39Nbj/ZAqC
   RiLWXD7+ckqPPkIFWOxD+0YpN0oWIMaFTlHWSDlGLC/UqhBoVXuMV7uhi
   z41umwUnpiULPrcm+4GnacwtrNNjUboDMaXwMzYNhxq1i9voUnPnpGCfZ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="240431096"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="240431096"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 04:42:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="548620396"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 04 Apr 2022 04:42:12 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbL64-00020j-3U;
        Mon, 04 Apr 2022 11:42:12 +0000
Date:   Mon, 4 Apr 2022 19:41:17 +0800
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
Message-ID: <202204041904.XbBQEwTe-lkp@intel.com>
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

Hi Chen-Yu,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3123109284176b1532874591f7c81f3837bbdc17
commit: 6dd199064dd86127030b5bc59d4058370b6c8310 clk: mediatek: pll: Implement unregister API
date:   7 weeks ago
config: sh-buildonly-randconfig-r002-20220404 (https://download.01.org/0day-ci/archive/20220404/202204041904.XbBQEwTe-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6dd199064dd86127030b5bc59d4058370b6c8310
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6dd199064dd86127030b5bc59d4058370b6c8310
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash drivers/clk/mediatek/

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
