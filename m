Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3DF57B43C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 11:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbiGTJ7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 05:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiGTJ7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 05:59:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B92412A84;
        Wed, 20 Jul 2022 02:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658311169; x=1689847169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SOFujLqVQ8IM/zPTiPh1M18yqXiEmqEQFOTKQq34x6g=;
  b=WQQWZDgNC/FEb4yK0CwPjjx2V6w2cokOp1YOqvrLdGuLKTln9FP1uuw9
   qs1DYQVrLTQvjyph+HVVGVAoxwF0t1c/pRib27gH5d/64YxabZV2Snb3D
   74ZAeG1UWpwBQzwyI5TmehwsQIm81kyuvPWEkNG0wW/rUfRztgyJHt7NK
   RA/V2BsuQoFoF31RgWJ/R6bGLhzJIA7ThP8Rz7ToK/zcOu6Hdqxpt37Eh
   L5cv7TOImxXlerO+tePFEHDPdQCVVbXwDSQY+MyfxnyvVxLEb763f8yR1
   pdCLzjxpdd2FlziY0owTgav6h/jtFdLtGMKKhdK9fkMcJtVQ+tJ3O6zqr
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="285498281"
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="285498281"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 02:59:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="740228895"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jul 2022 02:59:24 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oE6UF-0000MV-Nz;
        Wed, 20 Jul 2022 09:59:23 +0000
Date:   Wed, 20 Jul 2022 17:58:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     kbuild-all@lists.01.org, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, laurent.pinchart@ideasonboard.com,
        marex@denx.de, paul.elder@ideasonboard.com, aford173@gmail.com,
        Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 5/7] soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl
Message-ID: <202207201734.DwWC33xs-lkp@intel.com>
References: <20220719055054.3855979-6-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719055054.3855979-6-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Peng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on shawnguo/for-next]
[also build test WARNING on linus/master v5.19-rc7 next-20220719]
[cannot apply to robh/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Fan-OSS/imx-add-i-MX8MP-hdmi-blk-ctrl-hdcp-hrv-and-vpu-blk-ctrl/20220719-135352
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
config: microblaze-allmodconfig (https://download.01.org/0day-ci/archive/20220720/202207201734.DwWC33xs-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/73728b6c4380e24d833b690b7ead261e1fcdcbc2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Peng-Fan-OSS/imx-add-i-MX8MP-hdmi-blk-ctrl-hdcp-hrv-and-vpu-blk-ctrl/20220719-135352
        git checkout 73728b6c4380e24d833b690b7ead261e1fcdcbc2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/soc/imx/ sound/soc/sof/imx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/soc/imx/imx8m-blk-ctrl.c:466:18: error: 'const struct imx8m_blk_ctrl_domain_data' has no member named 'path_names'
     466 |                 .path_names = (const char *[]){"g1"},
         |                  ^~~~~~~~~~
>> drivers/soc/imx/imx8m-blk-ctrl.c:466:31: warning: initialization of 'unsigned int' from 'const char **' makes integer from pointer without a cast [-Wint-conversion]
     466 |                 .path_names = (const char *[]){"g1"},
         |                               ^
   drivers/soc/imx/imx8m-blk-ctrl.c:466:31: note: (near initialization for 'imx8mp_vpu_blk_ctl_domain_data[0].mipi_phy_rst_mask')
   drivers/soc/imx/imx8m-blk-ctrl.c:467:18: error: 'const struct imx8m_blk_ctrl_domain_data' has no member named 'num_paths'
     467 |                 .num_paths = 1,
         |                  ^~~~~~~~~
>> drivers/soc/imx/imx8m-blk-ctrl.c:467:30: warning: excess elements in struct initializer
     467 |                 .num_paths = 1,
         |                              ^
   drivers/soc/imx/imx8m-blk-ctrl.c:467:30: note: (near initialization for 'imx8mp_vpu_blk_ctl_domain_data[0]')
   drivers/soc/imx/imx8m-blk-ctrl.c:476:18: error: 'const struct imx8m_blk_ctrl_domain_data' has no member named 'path_names'
     476 |                 .path_names = (const char *[]){"g2"},
         |                  ^~~~~~~~~~
   drivers/soc/imx/imx8m-blk-ctrl.c:476:31: warning: initialization of 'unsigned int' from 'const char **' makes integer from pointer without a cast [-Wint-conversion]
     476 |                 .path_names = (const char *[]){"g2"},
         |                               ^
   drivers/soc/imx/imx8m-blk-ctrl.c:476:31: note: (near initialization for 'imx8mp_vpu_blk_ctl_domain_data[1].mipi_phy_rst_mask')
   drivers/soc/imx/imx8m-blk-ctrl.c:477:18: error: 'const struct imx8m_blk_ctrl_domain_data' has no member named 'num_paths'
     477 |                 .num_paths = 1,
         |                  ^~~~~~~~~
   drivers/soc/imx/imx8m-blk-ctrl.c:477:30: warning: excess elements in struct initializer
     477 |                 .num_paths = 1,
         |                              ^
   drivers/soc/imx/imx8m-blk-ctrl.c:477:30: note: (near initialization for 'imx8mp_vpu_blk_ctl_domain_data[1]')
   drivers/soc/imx/imx8m-blk-ctrl.c:486:18: error: 'const struct imx8m_blk_ctrl_domain_data' has no member named 'path_names'
     486 |                 .path_names = (const char *[]){"vc8000e"},
         |                  ^~~~~~~~~~
   drivers/soc/imx/imx8m-blk-ctrl.c:486:31: warning: initialization of 'unsigned int' from 'const char **' makes integer from pointer without a cast [-Wint-conversion]
     486 |                 .path_names = (const char *[]){"vc8000e"},
         |                               ^
   drivers/soc/imx/imx8m-blk-ctrl.c:486:31: note: (near initialization for 'imx8mp_vpu_blk_ctl_domain_data[2].mipi_phy_rst_mask')
   drivers/soc/imx/imx8m-blk-ctrl.c:487:18: error: 'const struct imx8m_blk_ctrl_domain_data' has no member named 'num_paths'
     487 |                 .num_paths = 1,
         |                  ^~~~~~~~~
   drivers/soc/imx/imx8m-blk-ctrl.c:487:30: warning: excess elements in struct initializer
     487 |                 .num_paths = 1,
         |                              ^
   drivers/soc/imx/imx8m-blk-ctrl.c:487:30: note: (near initialization for 'imx8mp_vpu_blk_ctl_domain_data[2]')


vim +466 drivers/soc/imx/imx8m-blk-ctrl.c

   457	
   458	static const struct imx8m_blk_ctrl_domain_data imx8mp_vpu_blk_ctl_domain_data[] = {
   459		[IMX8MP_VPUBLK_PD_G1] = {
   460			.name = "vpublk-g1",
   461			.clk_names = (const char *[]){ "g1", },
   462			.num_clks = 1,
   463			.gpc_name = "g1",
   464			.rst_mask = BIT(1),
   465			.clk_mask = BIT(1),
 > 466			.path_names = (const char *[]){"g1"},
 > 467			.num_paths = 1,
   468		},
   469		[IMX8MP_VPUBLK_PD_G2] = {
   470			.name = "vpublk-g2",
   471			.clk_names = (const char *[]){ "g2", },
   472			.num_clks = 1,
   473			.gpc_name = "g2",
   474			.rst_mask = BIT(0),
   475			.clk_mask = BIT(0),
   476			.path_names = (const char *[]){"g2"},
   477			.num_paths = 1,
   478		},
   479		[IMX8MP_VPUBLK_PD_VC8000E] = {
   480			.name = "vpublk-vc8000e",
   481			.clk_names = (const char *[]){ "vc8000e", },
   482			.num_clks = 1,
   483			.gpc_name = "vc8000e",
   484			.rst_mask = BIT(2),
   485			.clk_mask = BIT(2),
   486			.path_names = (const char *[]){"vc8000e"},
   487			.num_paths = 1,
   488		},
   489	};
   490	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
