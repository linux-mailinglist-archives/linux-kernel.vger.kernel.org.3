Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A646448A19E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 22:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343842AbiAJVOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 16:14:17 -0500
Received: from mga03.intel.com ([134.134.136.65]:9708 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240545AbiAJVOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 16:14:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641849256; x=1673385256;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=07J0kEnUclvM6FnzQLBdbihjujxj/fW7+ovEwmxMxl4=;
  b=TAHPi+xfL0NzNJvcQqmQ4ds/fyy2pHpb9oHP6UQInI/tTxru3zoLKu8Q
   5JRLXqmHS02rIAxGgWV1TnsK5l360kT4vJimwwEARcElPEvmtiydI1Tqh
   MeGu0Dg+7MwWxLgei7LDLG6naF8OwouhWknxik9icV06s8pzVIJKJbOey
   sohGtatTvg3I35lM1Yx0i7MMQwR32tS1hUR9rB2YRdVMUw5DP1iomKYFv
   gCvTFtbh3dj/BjyQ8QzlkqL2VR4+xXyKj4rfSkhr2+5alcQ6FOapJvnGA
   tIP4FX6yKZor/ic1n37jj4qgpH/oIpcO+jj1EfWbZDBDOtbxt5ICXpnEO
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="243276703"
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="243276703"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 13:14:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="490133756"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 10 Jan 2022 13:14:12 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n71zY-0003yB-7m; Mon, 10 Jan 2022 21:14:12 +0000
Date:   Tue, 11 Jan 2022 05:13:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        srv_heupstream@mediatek.com
Subject: Re: [v1 04/16] clk: mediatek: Add MT8186 topckgen clock support
Message-ID: <202201110556.oB2sYNXm-lkp@intel.com>
References: <20220110134416.5191-5-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110134416.5191-5-chun-jie.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Jie,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on robh/for-next v5.16 next-20220110]
[cannot apply to mbgg-mediatek/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Chun-Jie-Chen/dt-bindings-ARM-Mediatek-Add-new-document-bindings-of-MT8186-clock/20220110-224451
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: nios2-allyesconfig (https://download.01.org/0day-ci/archive/20220111/202201110556.oB2sYNXm-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/265a72ef3e3b41a62f280049219cf4efe1d79171
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Chun-Jie-Chen/dt-bindings-ARM-Mediatek-Add-new-document-bindings-of-MT8186-clock/20220110-224451
        git checkout 265a72ef3e3b41a62f280049219cf4efe1d79171
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/clk/mediatek/clk-mt8186-topckgen.c: In function 'clk_mt8186_topck_probe':
>> drivers/clk/mediatek/clk-mt8186-topckgen.c:725:9: error: implicit declaration of function 'mtk_clk_unregister'; did you mean 'devm_clk_unregister'? [-Werror=implicit-function-declaration]
     725 |         mtk_clk_unregister(clk_data);
         |         ^~~~~~~~~~~~~~~~~~
         |         devm_clk_unregister
   cc1: some warnings being treated as errors


vim +725 drivers/clk/mediatek/clk-mt8186-topckgen.c

   691	
   692	static int clk_mt8186_topck_probe(struct platform_device *pdev)
   693	{
   694		struct clk_onecell_data *clk_data;
   695		struct device_node *node = pdev->dev.of_node;
   696		int r;
   697		void __iomem *base;
   698	
   699		base = devm_platform_ioremap_resource(pdev, 0);
   700		if (IS_ERR(base))
   701			return PTR_ERR(base);
   702	
   703		clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
   704		if (!clk_data)
   705			return -ENOMEM;
   706	
   707		mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
   708					    clk_data);
   709		mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
   710		mtk_clk_register_muxes(top_mtk_muxes, ARRAY_SIZE(top_mtk_muxes), node,
   711				       &mt8186_clk_lock, clk_data);
   712	
   713		mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
   714					    &mt8186_clk_lock, clk_data);
   715		mtk_clk_register_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), base,
   716					    &mt8186_clk_lock, clk_data);
   717	
   718		r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
   719		if (r)
   720			goto unregister_clk;
   721	
   722		return r;
   723	
   724	unregister_clk:
 > 725		mtk_clk_unregister(clk_data);
   726		mtk_free_clk_data(clk_data);
   727		return r;
   728	}
   729	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
