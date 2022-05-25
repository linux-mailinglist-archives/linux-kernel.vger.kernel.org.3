Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8996533F3E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244658AbiEYOdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbiEYOdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:33:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F4DA76E9;
        Wed, 25 May 2022 07:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653489179; x=1685025179;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bCGZ5ZNajctbooEYiyVVpK96NPvsv5UbHP7Lrx6diLE=;
  b=TKqLUyTW1IM+va4DsYaRg0rC8M57RQD3ZI/ssodu+BC2KiasB/U1BDw7
   b+2iNSj45i7YyW5VwVHvoOXjOBaU50/SqNolKonrmvSgCoc8lhInbQVsx
   0/Vx51pVCSZu2wMulm6BpiCExAqHX6PVSU8ilxgVb2fGDWQxbxVhX1hHG
   QK1Q2VScz24OcY6XKdRudTqldVT0UdHP//bV3x1J5qe+Y+YFg8eD69p7b
   HZcOZJrPH6PFm+d9kBD6BKo9JyvHce2KBeZgnFXgZGGbvIA8sgyMUwbZy
   88jIkf9SlINnCrifSaQtidGYhEwIkHNB5uZ3kt+XdIGsb7pq2blnb1aG6
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="255891764"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="255891764"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 07:32:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="549045443"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 25 May 2022 07:32:56 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nts4F-00034G-U0;
        Wed, 25 May 2022 14:32:55 +0000
Date:   Wed, 25 May 2022 22:32:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Quentin Schulz <foss+kernel@0leil.net>
Cc:     kbuild-all@lists.01.org, shawnx.tu@intel.com, mchehab@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, foss+kernel@0leil.net,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH v4 2/4] media: ov5675: add device-tree support and
 support runtime PM
Message-ID: <202205252218.mhWZtfwJ-lkp@intel.com>
References: <20220525121240.1094792-2-foss+kernel@0leil.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525121240.1094792-2-foss+kernel@0leil.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on media-tree/master]
[also build test WARNING on robh/for-next v5.18 next-20220525]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Quentin-Schulz/media-dt-bindings-ov5675-document-YAML-binding/20220525-201607
base:   git://linuxtv.org/media_tree.git master
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220525/202205252218.mhWZtfwJ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/66ceb2ca2f2882f78a14838931faace1ac74d812
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Quentin-Schulz/media-dt-bindings-ov5675-document-YAML-binding/20220525-201607
        git checkout 66ceb2ca2f2882f78a14838931faace1ac74d812
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/media/i2c/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/media/i2c/ov5675.c: In function 'ov5675_power_on':
>> drivers/media/i2c/ov5675.c:1007:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    1007 |         u32 delay_us = DIV_ROUND_UP(8192, OV5675_XVCLK_19_2 / 1000 / 1000);
         |         ^~~


vim +1007 drivers/media/i2c/ov5675.c

   978	
   979	static int ov5675_power_on(struct device *dev)
   980	{
   981		struct v4l2_subdev *sd = dev_get_drvdata(dev);
   982		struct ov5675 *ov5675 = to_ov5675(sd);
   983		int ret;
   984	
   985		ret = clk_prepare_enable(ov5675->xvclk);
   986		if (ret < 0) {
   987			dev_err(dev, "failed to enable xvclk: %d\n", ret);
   988			return ret;
   989		}
   990	
   991		gpiod_set_value_cansleep(ov5675->reset_gpio, 1);
   992	
   993		ret = regulator_bulk_enable(OV5675_NUM_SUPPLIES, ov5675->supplies);
   994		if (ret) {
   995			clk_disable_unprepare(ov5675->xvclk);
   996			return ret;
   997		}
   998	
   999		/* Reset pulse should be at least 2ms and reset gpio released only once
  1000		 * regulators are stable.
  1001		 */
  1002		usleep_range(2000, 2200);
  1003	
  1004		gpiod_set_value_cansleep(ov5675->reset_gpio, 0);
  1005	
  1006		/* 8192 xvclk cycles prior to the first SCCB transation */
> 1007		u32 delay_us = DIV_ROUND_UP(8192, OV5675_XVCLK_19_2 / 1000 / 1000);
  1008	
  1009		usleep_range(delay_us, delay_us * 2);
  1010	
  1011		return 0;
  1012	}
  1013	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
