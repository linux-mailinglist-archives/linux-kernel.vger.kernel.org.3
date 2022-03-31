Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82B94ED851
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 13:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbiCaLUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 07:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235018AbiCaLUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:20:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC1427CD3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 04:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648725509; x=1680261509;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9lcg+VvO1YbDim/j38xjQPf7mJw8TeEX5TFuzW7zitE=;
  b=Te8aJ7o2IObKWTIWFEmL3yKLKQWIKinygHEqGW6FMiP8SXay3d1S9BSf
   O4h+m+Bd06+jR2sjrvzjkPkTnPZD22T4pFx6WyTGYqAz8nJ/zisWaGhFM
   8FtnE8rdo7p461WJHzSM/S48T2BeyqKUukku2f7P7ztFz2QSHmHmH1pOf
   CgiFv9LWZy5OrBYNibufcCGhPJyiJhZh173h2CzRBMQmWYC31urpikGSQ
   vBTJG78l1mTK129AwVdgIpEuCHBcqX/YAXDimCPmvT7F+fGgN7P4/wvzX
   S3VF0mTBbcdlKjdorF0QDoYD9cuL755dnrn9U+t3hA/kYNGg0L9r4diLW
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="322979088"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="322979088"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 04:17:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="547282366"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 31 Mar 2022 04:17:55 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZsoM-0000Cq-TF;
        Thu, 31 Mar 2022 11:17:54 +0000
Date:   Thu, 31 Mar 2022 19:17:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>,
        Xu YiPing <xuyiping@hisilicon.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-5.10-2022-01
 1118/9999] drivers/gpu/drm/hisilicon/kirin/kirin_drm_dsi.c:33:6: warning: no
 previous prototype for 'dsi_set_output_client'
Message-ID: <202203311955.w1yVgOkn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-5.10-2022-01
head:   1a4c05014bbef75d3878daa66540412c500f697b
commit: 34ebaf13befc0cd9274a190affbeae8e94f16ced [1118/9999] ANDROID: drm: kirin: Introduce kirin960
config: arm64-buildonly-randconfig-r005-20220331 (https://download.01.org/0day-ci/archive/20220331/202203311955.w1yVgOkn-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/34ebaf13befc0cd9274a190affbeae8e94f16ced
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-5.10-2022-01
        git checkout 34ebaf13befc0cd9274a190affbeae8e94f16ced
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/drm/hisilicon/kirin/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> cc1: warning: include/drm: No such file or directory [-Wmissing-include-dirs]
--
>> cc1: warning: include/drm: No such file or directory [-Wmissing-include-dirs]
>> drivers/gpu/drm/hisilicon/kirin/kirin_drm_dsi.c:33:6: warning: no previous prototype for 'dsi_set_output_client' [-Wmissing-prototypes]
      33 | void dsi_set_output_client(struct drm_device *dev)
         |      ^~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/hisilicon/kirin/kirin_drm_dsi.c:28:
   drivers/gpu/drm/hisilicon/kirin/kirin_drm_dsi.h:39:35: warning: 'dphy_range_info' defined but not used [-Wunused-const-variable=]
      39 | static const struct dsi_phy_range dphy_range_info[] = {
         |                                   ^~~~~~~~~~~~~~~


vim +/dsi_set_output_client +33 drivers/gpu/drm/hisilicon/kirin/kirin_drm_dsi.c

    32	
  > 33	void dsi_set_output_client(struct drm_device *dev)
    34	{
    35		enum dsi_output_client client;
    36		struct drm_connector *connector;
    37		struct drm_encoder *encoder;
    38		struct drm_connector_list_iter conn_iter;
    39		struct dw_dsi *dsi;
    40	
    41		mutex_lock(&dev->mode_config.mutex);
    42	
    43		/* find dsi encoder */
    44		drm_for_each_encoder(encoder, dev)
    45			if (encoder->encoder_type == DRM_MODE_ENCODER_DSI)
    46				break;
    47		dsi = encoder_to_dsi(encoder);
    48	
    49		/* find HDMI connector */
    50		drm_connector_list_iter_begin(dev, &conn_iter);
    51		drm_for_each_connector_iter(connector, &conn_iter)
    52			if (connector->connector_type == DRM_MODE_CONNECTOR_HDMIA)
    53				break;
    54		drm_connector_list_iter_end(&conn_iter);
    55	
    56		/*
    57		 * set the proper dsi output client
    58		 */
    59		client = connector->status == connector_status_connected ? OUT_HDMI :
    60									   OUT_PANEL;
    61		if (client != dsi->cur_client) {
    62			/*
    63			 * set the switch ic to select the HDMI or MIPI_DSI
    64			 */
    65			if (hisi_dsi_ops->version == KIRIN960_DSI)
    66				gpiod_set_value_cansleep(dsi->gpio_mux, client);
    67	
    68			dsi->cur_client = client;
    69			/* let the userspace know panel connector status has changed */
    70			drm_sysfs_hotplug_event(dev);
    71			DRM_INFO("client change to %s\n",
    72				 client == OUT_HDMI ? "HDMI" : "panel");
    73		}
    74	
    75		mutex_unlock(&dev->mode_config.mutex);
    76	}
    77	EXPORT_SYMBOL_GPL(dsi_set_output_client);
    78	/************************for the panel attach to dsi*****************************/
    79	static int dsi_connector_get_modes(struct drm_connector *connector)
    80	{
    81		struct dw_dsi *dsi = connector_to_dsi(connector);
    82	
    83		return drm_panel_get_modes(dsi->panel, connector);
    84	}
    85	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
