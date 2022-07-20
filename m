Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E79357B2E4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 10:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240417AbiGTI2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 04:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbiGTI2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 04:28:35 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04BE66B8B;
        Wed, 20 Jul 2022 01:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658305715; x=1689841715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vKdl45w44DVZ4009KJx1RD6WsdZNx3GYoGN39PPTpvM=;
  b=BvyhgCEM8QB1wHEoU0Vrb6rIorfDDZJagiefEIFMsbEI6tyEGYe0ekLD
   UOBLnuvmAL62unjTltp6FBWZOu1LJsc5Ph2iXvIPFJH0RMqhrX0NasIBB
   5drlfmJiiuWCaphW6MVfI8oqnl+49J/FlWE7v7d6idfMwPcnvmL3gqzyT
   gTsUlroEmZgAsKwZcaol3v84Fm2gMpXoYyvzl2/aC00Fqil+T7sdghkaJ
   3xA0mhP22wBYRWIj17Ot/OubQlkqwhgarrY6YACIWHe2bY+BjlWJYxf4b
   tNz0oamsnluf6F2s3jKYt58YnWpsuBX+5ayRNz/5jfo/YIZBcpmi1DTRa
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="267115783"
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="267115783"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 01:28:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="687435509"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jul 2022 01:28:24 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oE546-0000Hp-MB;
        Wed, 20 Jul 2022 08:28:18 +0000
Date:   Wed, 20 Jul 2022 16:27:35 +0800
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
Subject: Re: [PATCH V3 4/7] soc: imx: add i.MX8MP HDMI blk ctrl HDCP/HRV
Message-ID: <202207201616.Ek404VMJ-lkp@intel.com>
References: <20220719055054.3855979-5-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719055054.3855979-5-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Peng,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on shawnguo/for-next]
[also build test ERROR on linus/master v5.19-rc7 next-20220719]
[cannot apply to robh/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Fan-OSS/imx-add-i-MX8MP-hdmi-blk-ctrl-hdcp-hrv-and-vpu-blk-ctrl/20220719-135352
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
config: microblaze-allmodconfig (https://download.01.org/0day-ci/archive/20220720/202207201616.Ek404VMJ-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/328924f29e2ab1b6667c1be9578a9e17a7824c71
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Peng-Fan-OSS/imx-add-i-MX8MP-hdmi-blk-ctrl-hdcp-hrv-and-vpu-blk-ctrl/20220719-135352
        git checkout 328924f29e2ab1b6667c1be9578a9e17a7824c71
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/soc/ sound/soc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/soc/imx/imx8mp-blk-ctrl.c:375:18: error: 'const struct imx8mp_blk_ctrl_domain_data' has no member named 'path_names'
     375 |                 .path_names = (const char *[]){"hrv"},
         |                  ^~~~~~~~~~
   drivers/soc/imx/imx8mp-blk-ctrl.c:375:31: warning: excess elements in struct initializer
     375 |                 .path_names = (const char *[]){"hrv"},
         |                               ^
   drivers/soc/imx/imx8mp-blk-ctrl.c:375:31: note: (near initialization for 'imx8mp_hdmi_domain_data[8]')
>> drivers/soc/imx/imx8mp-blk-ctrl.c:376:18: error: 'const struct imx8mp_blk_ctrl_domain_data' has no member named 'num_paths'
     376 |                 .num_paths = 1,
         |                  ^~~~~~~~~
   drivers/soc/imx/imx8mp-blk-ctrl.c:376:30: warning: excess elements in struct initializer
     376 |                 .num_paths = 1,
         |                              ^
   drivers/soc/imx/imx8mp-blk-ctrl.c:376:30: note: (near initialization for 'imx8mp_hdmi_domain_data[8]')
   drivers/soc/imx/imx8mp-blk-ctrl.c:383:18: error: 'const struct imx8mp_blk_ctrl_domain_data' has no member named 'path_names'
     383 |                 .path_names = (const char *[]){"hdcp"},
         |                  ^~~~~~~~~~
   drivers/soc/imx/imx8mp-blk-ctrl.c:383:31: warning: excess elements in struct initializer
     383 |                 .path_names = (const char *[]){"hdcp"},
         |                               ^
   drivers/soc/imx/imx8mp-blk-ctrl.c:383:31: note: (near initialization for 'imx8mp_hdmi_domain_data[7]')
   drivers/soc/imx/imx8mp-blk-ctrl.c:384:18: error: 'const struct imx8mp_blk_ctrl_domain_data' has no member named 'num_paths'
     384 |                 .num_paths = 1,
         |                  ^~~~~~~~~
   drivers/soc/imx/imx8mp-blk-ctrl.c:384:30: warning: excess elements in struct initializer
     384 |                 .num_paths = 1,
         |                              ^
   drivers/soc/imx/imx8mp-blk-ctrl.c:384:30: note: (near initialization for 'imx8mp_hdmi_domain_data[7]')


vim +375 drivers/soc/imx/imx8mp-blk-ctrl.c

   326	
   327	static const struct imx8mp_blk_ctrl_domain_data imx8mp_hdmi_domain_data[] = {
   328		[IMX8MP_HDMIBLK_PD_IRQSTEER] = {
   329			.name = "hdmiblk-irqsteer",
   330			.clk_names = (const char *[]){ "apb" },
   331			.num_clks = 1,
   332			.gpc_name = "irqsteer",
   333		},
   334		[IMX8MP_HDMIBLK_PD_LCDIF] = {
   335			.name = "hdmiblk-lcdif",
   336			.clk_names = (const char *[]){ "axi", "apb" },
   337			.num_clks = 2,
   338			.gpc_name = "lcdif",
   339		},
   340		[IMX8MP_HDMIBLK_PD_PAI] = {
   341			.name = "hdmiblk-pai",
   342			.clk_names = (const char *[]){ "apb" },
   343			.num_clks = 1,
   344			.gpc_name = "pai",
   345		},
   346		[IMX8MP_HDMIBLK_PD_PVI] = {
   347			.name = "hdmiblk-pvi",
   348			.clk_names = (const char *[]){ "apb" },
   349			.num_clks = 1,
   350			.gpc_name = "pvi",
   351		},
   352		[IMX8MP_HDMIBLK_PD_TRNG] = {
   353			.name = "hdmiblk-trng",
   354			.clk_names = (const char *[]){ "apb" },
   355			.num_clks = 1,
   356			.gpc_name = "trng",
   357		},
   358		[IMX8MP_HDMIBLK_PD_HDMI_TX] = {
   359			.name = "hdmiblk-hdmi-tx",
   360			.clk_names = (const char *[]){ "apb", "ref_266m" },
   361			.num_clks = 2,
   362			.gpc_name = "hdmi-tx",
   363		},
   364		[IMX8MP_HDMIBLK_PD_HDMI_TX_PHY] = {
   365			.name = "hdmiblk-hdmi-tx-phy",
   366			.clk_names = (const char *[]){ "apb", "ref_24m" },
   367			.num_clks = 2,
   368			.gpc_name = "hdmi-tx-phy",
   369		},
   370		[IMX8MP_HDMIBLK_PD_HRV] = {
   371			.name = "hdmiblk-hrv",
   372			.clk_names = (const char *[]){ "axi", "apb" },
   373			.num_clks = 2,
   374			.gpc_name = "hrv",
 > 375			.path_names = (const char *[]){"hrv"},
 > 376			.num_paths = 1,
   377		},
   378		[IMX8MP_HDMIBLK_PD_HDCP] = {
   379			.name = "hdmiblk-hdcp",
   380			.clk_names = (const char *[]){ "axi", "apb" },
   381			.num_clks = 2,
   382			.gpc_name = "hdcp",
   383			.path_names = (const char *[]){"hdcp"},
   384			.num_paths = 1,
   385		},
   386	};
   387	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
