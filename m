Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62738585EB9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 13:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbiGaL5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 07:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiGaL5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 07:57:12 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDEBBE1E
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 04:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659268631; x=1690804631;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4kG6dEiYKhvyL2iIJLg8PKK6cLIviKKJUX39G4/rpd4=;
  b=V5H10XMlO990lYuWBTzfUiBFNxhu6GZugPOSK648dS/4PDS+y9vFhaiY
   rvzZSnQkEDNy9G3aflOCiT7KToLWcWsqS/0WR9BEvLXFaOAbPJ6P+RTVd
   y07qNtNAr4pLpWb1rU7Q27TJPLK9IwgqQJyeN5segtDKDNgshobHZ4cku
   y+8Rh3+hRd0wnRWESsPDDufiyuA311uvt1KMTLS3f4r+EZxN2gwbpFTUq
   B2rajK4x3H5kRtkULJVGFPl0y/7UPS28vZfd5kKW11px/Lo5cfDanY1I4
   yv87C/mvXljsdkiyZx45qv9USYTKPRGguzTUQt0VJpUwWT/YPJ/7pOnGe
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="289003132"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="289003132"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 04:57:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="929248697"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 31 Jul 2022 04:57:09 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oI7ZE-000E69-2i;
        Sun, 31 Jul 2022 11:57:08 +0000
Date:   Sun, 31 Jul 2022 19:56:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Steev Klimaszewski <steev@kali.org>
Subject: [steev:linux-v5.19.0-rc8-tests 146/182]
 drivers/gpu/drm/msm/dsi/dsi_host.c:1997:14: warning: variable 'device_node'
 is uninitialized when used here
Message-ID: <202207311957.wVEYCh2c-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/steev/linux linux-v5.19.0-rc8-tests
head:   171125613e081f0d0d9aeb710dc7469ce2c6a219
commit: d99732349a84f6046d58df883c6c68fd7351faa9 [146/182] drm/msm/dsi: switch to DRM_PANEL_BRIDGE
config: arm64-buildonly-randconfig-r005-20220731 (https://download.01.org/0day-ci/archive/20220731/202207311957.wVEYCh2c-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/steev/linux/commit/d99732349a84f6046d58df883c6c68fd7351faa9
        git remote add steev https://github.com/steev/linux
        git fetch --no-tags steev linux-v5.19.0-rc8-tests
        git checkout d99732349a84f6046d58df883c6c68fd7351faa9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/drm/msm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/msm/dsi/dsi_host.c:1997:14: warning: variable 'device_node' is uninitialized when used here [-Wuninitialized]
           of_node_put(device_node);
                       ^~~~~~~~~~~
   drivers/gpu/drm/msm/dsi/dsi_host.c:1964:44: note: initialize the variable 'device_node' to silence this warning
           struct device_node *endpoint, *device_node;
                                                     ^
                                                      = NULL
   1 warning generated.
--
>> drivers/gpu/drm/msm/dsi/dsi_manager.c:533:7: warning: variable 'connector' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   if (ret < 0)
                       ^~~~~~~
   drivers/gpu/drm/msm/dsi/dsi_manager.c:551:9: note: uninitialized use occurs here
           return connector;
                  ^~~~~~~~~
   drivers/gpu/drm/msm/dsi/dsi_manager.c:533:3: note: remove the 'if' if its condition is always true
                   if (ret < 0)
                   ^~~~~~~~~~~~
   drivers/gpu/drm/msm/dsi/dsi_manager.c:509:33: note: initialize the variable 'connector' to silence this warning
           struct drm_connector *connector;
                                          ^
                                           = NULL
   1 warning generated.


vim +/device_node +1997 drivers/gpu/drm/msm/dsi/dsi_host.c

b9080324d6ca24 Vinod Koul    2022-04-06  1959  
f7009d266d8b2f Archit Taneja 2015-06-25  1960  static int dsi_host_parse_dt(struct msm_dsi_host *msm_host)
f7009d266d8b2f Archit Taneja 2015-06-25  1961  {
f7009d266d8b2f Archit Taneja 2015-06-25  1962  	struct device *dev = &msm_host->pdev->dev;
f7009d266d8b2f Archit Taneja 2015-06-25  1963  	struct device_node *np = dev->of_node;
a9ddac9c576571 Archit Taneja 2015-08-03  1964  	struct device_node *endpoint, *device_node;
a1b1a4f7e4c3cf Archit Taneja 2017-01-04  1965  	int ret = 0;
f7009d266d8b2f Archit Taneja 2015-06-25  1966  
f7009d266d8b2f Archit Taneja 2015-06-25  1967  	/*
b9ac76f6ac9841 Archit Taneja 2016-04-27  1968  	 * Get the endpoint of the output port of the DSI host. In our case,
b9ac76f6ac9841 Archit Taneja 2016-04-27  1969  	 * this is mapped to port number with reg = 1. Don't return an error if
b9ac76f6ac9841 Archit Taneja 2016-04-27  1970  	 * the remote endpoint isn't defined. It's possible that there is
b9ac76f6ac9841 Archit Taneja 2016-04-27  1971  	 * nothing connected to the dsi output.
f7009d266d8b2f Archit Taneja 2015-06-25  1972  	 */
b9ac76f6ac9841 Archit Taneja 2016-04-27  1973  	endpoint = of_graph_get_endpoint_by_regs(np, 1, -1);
f7009d266d8b2f Archit Taneja 2015-06-25  1974  	if (!endpoint) {
6a41da17e87dee Mamta Shukla  2018-10-20  1975  		DRM_DEV_DEBUG(dev, "%s: no endpoint\n", __func__);
f7009d266d8b2f Archit Taneja 2015-06-25  1976  		return 0;
f7009d266d8b2f Archit Taneja 2015-06-25  1977  	}
f7009d266d8b2f Archit Taneja 2015-06-25  1978  
26f7d1f4d9ab10 Archit Taneja 2016-02-25  1979  	ret = dsi_host_parse_lane_data(msm_host, endpoint);
26f7d1f4d9ab10 Archit Taneja 2016-02-25  1980  	if (ret) {
6a41da17e87dee Mamta Shukla  2018-10-20  1981  		DRM_DEV_ERROR(dev, "%s: invalid lane configuration %d\n",
26f7d1f4d9ab10 Archit Taneja 2016-02-25  1982  			__func__, ret);
feb085ec8a3dc1 Sean Paul     2018-07-30  1983  		ret = -EINVAL;
26f7d1f4d9ab10 Archit Taneja 2016-02-25  1984  		goto err;
26f7d1f4d9ab10 Archit Taneja 2016-02-25  1985  	}
26f7d1f4d9ab10 Archit Taneja 2016-02-25  1986  
0c7df47f6a4c5d Archit Taneja 2015-10-14  1987  	if (of_property_read_bool(np, "syscon-sfpb")) {
0c7df47f6a4c5d Archit Taneja 2015-10-14  1988  		msm_host->sfpb = syscon_regmap_lookup_by_phandle(np,
0c7df47f6a4c5d Archit Taneja 2015-10-14  1989  					"syscon-sfpb");
0c7df47f6a4c5d Archit Taneja 2015-10-14  1990  		if (IS_ERR(msm_host->sfpb)) {
6a41da17e87dee Mamta Shukla  2018-10-20  1991  			DRM_DEV_ERROR(dev, "%s: failed to get sfpb regmap\n",
0c7df47f6a4c5d Archit Taneja 2015-10-14  1992  				__func__);
26f7d1f4d9ab10 Archit Taneja 2016-02-25  1993  			ret = PTR_ERR(msm_host->sfpb);
0c7df47f6a4c5d Archit Taneja 2015-10-14  1994  		}
0c7df47f6a4c5d Archit Taneja 2015-10-14  1995  	}
0c7df47f6a4c5d Archit Taneja 2015-10-14  1996  
26f7d1f4d9ab10 Archit Taneja 2016-02-25 @1997  	of_node_put(device_node);
26f7d1f4d9ab10 Archit Taneja 2016-02-25  1998  
26f7d1f4d9ab10 Archit Taneja 2016-02-25  1999  err:
26f7d1f4d9ab10 Archit Taneja 2016-02-25  2000  	of_node_put(endpoint);
26f7d1f4d9ab10 Archit Taneja 2016-02-25  2001  
26f7d1f4d9ab10 Archit Taneja 2016-02-25  2002  	return ret;
f7009d266d8b2f Archit Taneja 2015-06-25  2003  }
f7009d266d8b2f Archit Taneja 2015-06-25  2004  

:::::: The code at line 1997 was first introduced by commit
:::::: 26f7d1f4d9ab108b28b8d0f340b98941073c6f4d drm/msm/dsi: Parse DSI lanes via DT

:::::: TO: Archit Taneja <architt@codeaurora.org>
:::::: CC: Rob Clark <robdclark@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
