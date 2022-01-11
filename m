Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9266348A42A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 01:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345818AbiAKAGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 19:06:20 -0500
Received: from mga06.intel.com ([134.134.136.31]:42271 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242685AbiAKAGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 19:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641859579; x=1673395579;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p7nsmEccBKpPlOWZFEkdVoJGgRfuwq0AFf2KH3+X540=;
  b=JfCOoP2l8DEA0Yj1lUVZ4y2U2UJq2hC98UBWjGQKJ3WkjNPPD4cuOTbl
   89RoCbI0rNCJzFW2KeiMZohBDyESWFsuPtRzoWJXyKbL5II4LeRis2dNL
   rDww2YguDKxHa9OR02aRtdZpDrQ3nrLV1vCJlgh2dO7dR6+K1fPOUeBLU
   ROvBVoW8Dst4yojLZ4fgPWM7er5wFOXQUrVFRold8a5JhjzB3MjEvheBa
   PLclmgDWh5TbTqGxWbA4XAuPljTh/wPXq8tJG7sBv8fkrfNzjoS06qPAO
   KtFnw2gnzA246QXLgirBtoL6eo3T9SLJ/PN0u8COBsara56SiHUwR/5Y1
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="304103492"
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="304103492"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 16:06:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="622863838"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 10 Jan 2022 16:06:16 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n74g3-00045s-Jr; Tue, 11 Jan 2022 00:06:15 +0000
Date:   Tue, 11 Jan 2022 08:06:03 +0800
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
Subject: Re: [v1 06/16] clk: mediatek: Add MT8186 apmixedsys clock support
Message-ID: <202201110701.jdDbg8yY-lkp@intel.com>
References: <20220110134416.5191-7-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110134416.5191-7-chun-jie.chen@mediatek.com>
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
config: nios2-allyesconfig (https://download.01.org/0day-ci/archive/20220111/202201110701.jdDbg8yY-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/2b9fcab7333544a52a4e5fd9e42764e1f1e7a7b1
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Chun-Jie-Chen/dt-bindings-ARM-Mediatek-Add-new-document-bindings-of-MT8186-clock/20220110-224451
        git checkout 2b9fcab7333544a52a4e5fd9e42764e1f1e7a7b1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/clk/mediatek/clk-mt8186-apmixedsys.c: In function 'clk_mt8186_apmixed_probe':
>> drivers/clk/mediatek/clk-mt8186-apmixedsys.c:102:9: error: implicit declaration of function 'mtk_clk_unregister'; did you mean 'devm_clk_unregister'? [-Werror=implicit-function-declaration]
     102 |         mtk_clk_unregister(clk_data);
         |         ^~~~~~~~~~~~~~~~~~
         |         devm_clk_unregister
   cc1: some warnings being treated as errors


vim +102 drivers/clk/mediatek/clk-mt8186-apmixedsys.c

    82	
    83	static int clk_mt8186_apmixed_probe(struct platform_device *pdev)
    84	{
    85		struct clk_onecell_data *clk_data;
    86		struct device_node *node = pdev->dev.of_node;
    87		int r;
    88	
    89		clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
    90		if (!clk_data)
    91			return -ENOMEM;
    92	
    93		mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
    94	
    95		r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
    96		if (r)
    97			goto unregister_clk;
    98	
    99		return r;
   100	
   101	unregister_clk:
 > 102		mtk_clk_unregister(clk_data);
   103		mtk_free_clk_data(clk_data);
   104		return r;
   105	}
   106	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
