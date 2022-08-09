Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503EF58DAB2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 17:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244735AbiHIPEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 11:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241540AbiHIPDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:03:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6C11A382
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 08:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660057410; x=1691593410;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JTC3IpuAIriy8fVfGALi52hLIe//Sn9i43111djg3FQ=;
  b=C65WRH4nOHW1TooOccbC5HZ9UnS0SczZotck7xXGXWLXY6G6PbNpAgt+
   J2c4p/e2xoIR3Zqo1EvO5kJJWNWS33vtrPZum/7d6ZzwOHAxboF+5UjHh
   w9wZaiNNmpkhiybdn/2lCAmSIkivLZ49CNhaJnqSHunQ9pdiELAam6A0g
   ez8eTjlwrr6HIP+2G56XpsVOcu3cGV4HOY4EvnV1SX0BAGiYS6GXrNYp3
   qR6BS65ycDJbX5/hbLFv+0inTRsVcIZqCl3805qQKaccmV/obWW5RqQPr
   /a2LuRxQ+qohjOTljpJmM0JvDS+4QmustJq52IdsJk65e5J3lBT5LO20S
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="290856951"
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="290856951"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 08:02:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="694168703"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Aug 2022 08:02:50 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLQkr-000N0n-1Y;
        Tue, 09 Aug 2022 15:02:49 +0000
Date:   Tue, 9 Aug 2022 23:02:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>
Subject: [steev:sc8280xp-next-20220808-nonworking-gpu 136/153]
 drivers/soc/qcom/pmic_glink_altmode.c:355:27: error: too many arguments to
 function 'devm_pmic_glink_register_client'
Message-ID: <202208092235.yBxIFZdc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/steev/linux sc8280xp-next-20220808-nonworking-gpu
head:   3784291a8ef0733c6dd3b3a45e0ac2b3548e80d9
commit: 6962dd929e7833423c7533885705d1ac203d54e5 [136/153] soc: qcom: pmic_glink: Introduce altmode support
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220809/202208092235.yBxIFZdc-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/steev/linux/commit/6962dd929e7833423c7533885705d1ac203d54e5
        git remote add steev https://github.com/steev/linux
        git fetch --no-tags steev sc8280xp-next-20220808-nonworking-gpu
        git checkout 6962dd929e7833423c7533885705d1ac203d54e5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/soc/qcom/pmic_glink_altmode.c: In function 'pmic_glink_altmode_probe':
>> drivers/soc/qcom/pmic_glink_altmode.c:355:27: error: too many arguments to function 'devm_pmic_glink_register_client'
     355 |         altmode->client = devm_pmic_glink_register_client(dev,
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/soc/qcom/pmic_glink_altmode.c:19:
   include/linux/soc/qcom/pmic_glink.h:23:27: note: declared here
      23 | struct pmic_glink_client *devm_pmic_glink_register_client(struct device *dev,
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/devm_pmic_glink_register_client +355 drivers/soc/qcom/pmic_glink_altmode.c

   273	
   274	static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
   275					    const struct auxiliary_device_id *id)
   276	{
   277		struct pmic_glink_altmode_port *alt_port;
   278		struct pmic_glink_altmode *altmode;
   279		struct typec_altmode_desc mux_desc = {};
   280		struct fwnode_handle *fwnode;
   281		struct device *dev = &adev->dev;
   282		u32 port;
   283		int ret;
   284	
   285		altmode = devm_kzalloc(dev, sizeof(*altmode), GFP_KERNEL);
   286		if (!altmode)
   287			return -ENOMEM;
   288	
   289		altmode->dev = dev;
   290	
   291		init_completion(&altmode->pan_ack);
   292		mutex_init(&altmode->lock);
   293	
   294		device_for_each_child_node(dev, fwnode) {
   295			ret = fwnode_property_read_u32(fwnode, "reg", &port);
   296			if (ret < 0) {
   297				dev_err(dev, "missing reg property of %pOFn\n", fwnode);
   298				return ret;
   299			}
   300	
   301			if (port >= ARRAY_SIZE(altmode->ports)) {
   302				dev_warn(dev, "invalid connector number, ignoring\n");
   303				continue;
   304			}
   305	
   306			if (altmode->ports[port].altmode) {
   307				dev_err(dev, "multiple connector definition for port %u\n", port);
   308				return -EINVAL;
   309			}
   310	
   311			alt_port = &altmode->ports[port];
   312			alt_port->altmode = altmode;
   313			alt_port->index = port;
   314			INIT_WORK(&alt_port->work, pmic_glink_altmode_worker);
   315	
   316			alt_port->bridge.funcs = &pmic_glink_altmode_bridge_funcs;
   317			alt_port->bridge.of_node = to_of_node(fwnode);
   318			alt_port->bridge.ops = DRM_BRIDGE_OP_HPD;
   319			alt_port->bridge.type = DRM_MODE_CONNECTOR_USB;
   320	
   321			ret = devm_drm_bridge_add(dev, &alt_port->bridge);
   322			if (ret)
   323				return ret;
   324			dev_err(dev, "registered bridge for port%d: %pOF\n", port, alt_port->bridge.of_node);
   325	
   326			alt_port->dp_alt.svid = USB_TYPEC_DP_SID;
   327			alt_port->dp_alt.mode = USB_TYPEC_DP_MODE;
   328			alt_port->dp_alt.active = 1;
   329	
   330			mux_desc.svid = USB_TYPEC_DP_SID;
   331			mux_desc.mode = USB_TYPEC_DP_MODE;
   332			alt_port->typec_mux = fwnode_typec_mux_get(fwnode, &mux_desc);
   333			if (IS_ERR(alt_port->typec_mux))
   334				return dev_err_probe(dev, PTR_ERR(alt_port->typec_mux),
   335						     "failed to acquire mode-switch for port: %d\n",
   336						     port);
   337	
   338			ret = devm_add_action_or_reset(dev, pmic_glink_altmode_put_mux,
   339						       alt_port->typec_mux);
   340			if (ret)
   341				return ret;
   342	
   343			alt_port->typec_switch = fwnode_typec_switch_get(fwnode);
   344			if (IS_ERR(alt_port->typec_switch))
   345				return dev_err_probe(dev, PTR_ERR(alt_port->typec_switch),
   346						     "failed to acquire orientation-switch for port: %d\n",
   347						     port);
   348	
   349			ret = devm_add_action_or_reset(dev, pmic_glink_altmode_put_switch,
   350						       alt_port->typec_switch);
   351			if (ret)
   352				return ret;
   353		}
   354	
 > 355		altmode->client = devm_pmic_glink_register_client(dev,
   356								 PMIC_GLINK_OWNER_USBC_PAN,
   357								 pmic_glink_altmode_callback,
   358								 pmic_glink_altmode_pdr_notify,
   359								 altmode);
   360		if (IS_ERR(altmode->client))
   361			return PTR_ERR(altmode->client);
   362	
   363		dev_set_drvdata(dev, altmode);
   364	
   365		dev_err(dev, "SUCCESS!\n");
   366	
   367		return 0;
   368	}
   369	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
