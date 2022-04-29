Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E5951406C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 03:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354098AbiD2CAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 22:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbiD2CAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 22:00:08 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BE08723F;
        Thu, 28 Apr 2022 18:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651197411; x=1682733411;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CPEvDJ3ytBpYATJRkPLi382z+ezVo1awVW8z44TiQNE=;
  b=SlqPVfjXvnihFrxSnATIn6wus84NmFGNq3FDJRtBjZI1GD60kSfY/sWE
   ju5iuj2wvFQssqh8mG8y2NQU958Gq2gOkfPDooz4jusXe4cVNPLWdT29m
   qcz7N78qJv6dxrO3H2LK9CBfTYPNVO7o2nAOVPDqjdlJgU6dwl9gCX7zb
   h7h7MF0iDtsmfkowlMXSgJCHfrvr6mtVnb0yVnszcBW8aNmO45M/towgj
   CeHU8SpkMPWFpccZ7SpWsGem1ETVVTgUi7hzPwZ48MsXxYQkVC22Dr3yv
   brFANqYtbmFuDflmFuCNoqk5+40KW23IaF/z56o9zZO0d4fC6wZHBYwgU
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="266652286"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="266652286"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 18:56:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="565900073"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 28 Apr 2022 18:56:46 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkFsD-0005rp-RA;
        Fri, 29 Apr 2022 01:56:45 +0000
Date:   Fri, 29 Apr 2022 09:56:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     kbuild-all@lists.01.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        Elaine Zhang <zhangqing@rock-chips.com>, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCHv1 03/19] clk: rockchip: add pll type for RK3588
Message-ID: <202204290947.GtdwE4Zq-lkp@intel.com>
References: <20220422170920.401914-4-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422170920.401914-4-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linusw-pinctrl/devel linus/master v5.18-rc4 next-20220428]
[cannot apply to rockchip/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Sebastian-Reichel/Basic-RK3588-Support/20220423-013425
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20220429/202204290947.GtdwE4Zq-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/28c7fd4a10867094894809b60b86688817f70744
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sebastian-Reichel/Basic-RK3588-Support/20220423-013425
        git checkout 28c7fd4a10867094894809b60b86688817f70744
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/clk/rockchip/ drivers/media/platform/qcom/venus/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/clk/rockchip/clk-pll.c:916: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * PLL used in RK3588


vim +916 drivers/clk/rockchip/clk-pll.c

   914	
   915	/**
 > 916	 * PLL used in RK3588
   917	 */
   918	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
