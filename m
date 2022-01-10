Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86E1489F5A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241468AbiAJSkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:40:14 -0500
Received: from mga07.intel.com ([134.134.136.100]:18445 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238734AbiAJSkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641840013; x=1673376013;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U+Glj/h5tYRthQXKeKVdr/rRhv+kw5dVVIG5/MTuWRQ=;
  b=BWzqYv+/Gx/9ySS1uKc7g105Qhg0GhGlDz8hOnH1FL56dMNsmA//bdRF
   f/XH7y4XcHBcAoRYZljiZ0yAviW1EHT39Q0VYX1rPmI7UiKYQeiPqt3U7
   Kq0oBMPn82oskIXq1rZJMWtiYmHw5MwSvH77BbETMNV2Ux61fd2mjQC3h
   6qFRMCKHZPh7CWbn+ny7B4Za/GyQ9YmScuv6BcCfehorTnYMVBJz0pnMv
   SoI3mombkGss6ruyBfPRvJweQwn3Ivd+XSW8UbiidokiZ/lvQt0Y9YR3J
   InchGmmkUVbofzEhJYVfH24zfsVwqtaL3AIhnUwhDfi2CZOuGH3QS3T3e
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="306649253"
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="306649253"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 10:40:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="690672972"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 10 Jan 2022 10:40:09 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6zaS-0003px-HT; Mon, 10 Jan 2022 18:40:08 +0000
Date:   Tue, 11 Jan 2022 02:39:17 +0800
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
Subject: Re: [v1 03/16] clk: mediatek: Add MT8186 mcusys clock support
Message-ID: <202201110231.DNu9pn4H-lkp@intel.com>
References: <20220110134416.5191-4-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110134416.5191-4-chun-jie.chen@mediatek.com>
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
config: nios2-allyesconfig (https://download.01.org/0day-ci/archive/20220111/202201110231.DNu9pn4H-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/d28b64e80990fd336192ccdd31676120bf4e2696
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Chun-Jie-Chen/dt-bindings-ARM-Mediatek-Add-new-document-bindings-of-MT8186-clock/20220110-224451
        git checkout d28b64e80990fd336192ccdd31676120bf4e2696
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/clk/mediatek/clk-mt8186-mcu.c: In function 'clk_mt8186_mcu_probe':
>> drivers/clk/mediatek/clk-mt8186-mcu.c:74:9: error: implicit declaration of function 'mtk_clk_unregister'; did you mean 'devm_clk_unregister'? [-Werror=implicit-function-declaration]
      74 |         mtk_clk_unregister(clk_data);
         |         ^~~~~~~~~~~~~~~~~~
         |         devm_clk_unregister
   cc1: some warnings being treated as errors


vim +74 drivers/clk/mediatek/clk-mt8186-mcu.c

    48	
    49	static int clk_mt8186_mcu_probe(struct platform_device *pdev)
    50	{
    51		struct clk_onecell_data *clk_data;
    52		struct device_node *node = pdev->dev.of_node;
    53		int r;
    54		void __iomem *base;
    55	
    56		base = devm_platform_ioremap_resource(pdev, 0);
    57		if (IS_ERR(base))
    58			return PTR_ERR(base);
    59	
    60		clk_data = mtk_alloc_clk_data(CLK_MCU_NR_CLK);
    61		if (!clk_data)
    62			return -ENOMEM;
    63	
    64		mtk_clk_register_composites(mcu_muxes, ARRAY_SIZE(mcu_muxes), base,
    65					    &mt8186_clk_lock, clk_data);
    66	
    67		r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
    68		if (r)
    69			goto unregister_clk;
    70	
    71		return r;
    72	
    73	unregister_clk:
  > 74		mtk_clk_unregister(clk_data);
    75		mtk_free_clk_data(clk_data);
    76		return r;
    77	}
    78	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
