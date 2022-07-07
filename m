Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29A156A9BA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbiGGRgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbiGGRgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:36:12 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65333337C;
        Thu,  7 Jul 2022 10:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657215371; x=1688751371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zRlmYVn9zHQI1IKGlhE4MO06PH0yP+9P4EPGr4unR1E=;
  b=a3tBzOjgoupnmiJo+uEcv8a5j7AXt5bUt4nS0yKA6WpWqhqRFMUmhyRi
   DvxVoOjB62OnI6MvbieW28XCSdMT2/UzgPExOI712TlOacOfKkrB8VjC+
   SjCUB6zeIXMJ7ujC/snX5QwckVB+LTjld/0YiKi+xuRwU0XgQ7Ickuz22
   VE3w0CJhkG9SgN8Sc394cFLe0S0PEI1e5q7REN/W4sxCw41Clay9isnm8
   rRYYgQ1Uc/5ZsTlHfdK+yC0HNpnYAjFuAcuqY59s7LRtl0/Aw/tDz7Y1e
   CUkucHdwwWfk2dmquHCvWSxshmSobkxyEoiMWa1e9vPfyFrBbeEWqwnxR
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="267112800"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="267112800"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 10:35:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="683384996"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Jul 2022 10:35:54 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9VPu-000MGg-51;
        Thu, 07 Jul 2022 17:35:54 +0000
Date:   Fri, 8 Jul 2022 01:35:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH v4 3/3] clk: qcom: lcc-ipq806x: convert to parent data
Message-ID: <202207080145.UiRhIFg5-lkp@intel.com>
References: <20220707101326.30880-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707101326.30880-3-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on linus/master v5.19-rc5 next-20220707]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/dt-bindings-clock-add-pcm-reset-for-ipq806x-lcc/20220707-181546
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: nios2-randconfig-r003-20220707 (https://download.01.org/0day-ci/archive/20220708/202207080145.UiRhIFg5-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/81953f04f08f730affa53b4637cc05f97da50a1d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Christian-Marangi/dt-bindings-clock-add-pcm-reset-for-ipq806x-lcc/20220707-181546
        git checkout 81953f04f08f730affa53b4637cc05f97da50a1d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=nios2 SHELL=/bin/bash drivers/clk/qcom/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/clk/qcom/lcc-ipq806x.c:38:25: warning: braces around scalar initializer
      38 |                         { .fw_name = "pxo", .name = "pxo_board" },
         |                         ^
   drivers/clk/qcom/lcc-ipq806x.c:38:25: note: (near initialization for '(anonymous)[0]')
   drivers/clk/qcom/lcc-ipq806x.c:38:27: error: field name not in record or union initializer
      38 |                         { .fw_name = "pxo", .name = "pxo_board" },
         |                           ^
   drivers/clk/qcom/lcc-ipq806x.c:38:27: note: (near initialization for '(anonymous)[0]')
   drivers/clk/qcom/lcc-ipq806x.c:38:38: error: initialization of 'const struct clk_parent_data *' from incompatible pointer type 'char *' [-Werror=incompatible-pointer-types]
      38 |                         { .fw_name = "pxo", .name = "pxo_board" },
         |                                      ^~~~~
   drivers/clk/qcom/lcc-ipq806x.c:38:38: note: (near initialization for '(anonymous)[0]')
   drivers/clk/qcom/lcc-ipq806x.c:38:45: error: field name not in record or union initializer
      38 |                         { .fw_name = "pxo", .name = "pxo_board" },
         |                                             ^
   drivers/clk/qcom/lcc-ipq806x.c:38:45: note: (near initialization for '(anonymous)[0]')
   drivers/clk/qcom/lcc-ipq806x.c:38:53: warning: excess elements in scalar initializer
      38 |                         { .fw_name = "pxo", .name = "pxo_board" },
         |                                                     ^~~~~~~~~~~
   drivers/clk/qcom/lcc-ipq806x.c:38:53: note: (near initialization for '(anonymous)[0]')
>> drivers/clk/qcom/lcc-ipq806x.c:37:32: error: initialization of 'const struct clk_parent_data *' from incompatible pointer type 'const struct clk_parent_data **' [-Werror=incompatible-pointer-types]
      37 |                 .parent_data = (const struct clk_parent_data*[]){
         |                                ^
   drivers/clk/qcom/lcc-ipq806x.c:37:32: note: (near initialization for '(anonymous).parent_data')
   cc1: some warnings being treated as errors


vim +37 drivers/clk/qcom/lcc-ipq806x.c

    26	
    27	static struct clk_pll pll4 = {
    28		.l_reg = 0x4,
    29		.m_reg = 0x8,
    30		.n_reg = 0xc,
    31		.config_reg = 0x14,
    32		.mode_reg = 0x0,
    33		.status_reg = 0x18,
    34		.status_bit = 16,
    35		.clkr.hw.init = &(struct clk_init_data){
    36			.name = "pll4",
  > 37			.parent_data = (const struct clk_parent_data*[]){
  > 38				{ .fw_name = "pxo", .name = "pxo_board" },
    39			},
    40			.num_parents = 1,
    41			.ops = &clk_pll_ops,
    42		},
    43	};
    44	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
