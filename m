Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7754EB60F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 00:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237594AbiC2WfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 18:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237593AbiC2WfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 18:35:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE1CD76C3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 15:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648593211; x=1680129211;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gJUVHXuYif343W5kwl53LsjF/P1U/FFSXed6oIWSZgo=;
  b=EvSjBq6BY6uf/+EKPMZLXOMU9qOPY4boMVV13nB76/lJcBwZdgzUnGGg
   kG+p+YXqvzp0a8ouoBZ61sSX7sB4xYIu/e+bv1ZMJ2gtK8r5L0zrjevuU
   vSowcjH/8J+re49u+keOM5f6kBGC1/U/VxDc5JC4v3DXM0Uk1kbCsBn8k
   sea5+6yPMMnExsSc7p1tDSpjGOSmWWdOJpQVjaAtN4L2iqt+Jec2WJ0kQ
   tM+AgkHK17sPEqwY/DTyNxzsV54Z1RgdaYc2ZP91SCrjbwOT6snzuHRhn
   5uSR36pJ32+l9XGhlqLeTgM4yuea70xCxGRk0rkrIo7YhQKYuegV6qY1Q
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="259361728"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="259361728"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 15:33:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="585767823"
Received: from lkp-server01.sh.intel.com (HELO 3965e2759b93) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 29 Mar 2022 15:33:30 -0700
Received: from kbuild by 3965e2759b93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZKP3-0000jm-I2; Tue, 29 Mar 2022 22:33:29 +0000
Date:   Wed, 30 Mar 2022 06:32:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [andersson:wip/sc8180x-next-20220301-take2 5/27]
 drivers/gpu/drm/msm/dp/dp_hpd.c:83: undefined reference to
 `typec_mux_unregister'
Message-ID: <202203300600.W7zSpGZl-lkp@intel.com>
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

tree:   https://github.com/andersson/kernel wip/sc8180x-next-20220301-take2
head:   4e9e94d03691fd0820dcff8d0877ddb280b01f88
commit: e4014b0e8a0a46349e91bfb9ef44a59d5a4a2771 [5/27] drm/msm/dp: Add typec_mux implementation
config: microblaze-randconfig-r006-20220327 (https://download.01.org/0day-ci/archive/20220330/202203300600.W7zSpGZl-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/andersson/kernel/commit/e4014b0e8a0a46349e91bfb9ef44a59d5a4a2771
        git remote add andersson https://github.com/andersson/kernel
        git fetch --no-tags andersson wip/sc8180x-next-20220301-take2
        git checkout e4014b0e8a0a46349e91bfb9ef44a59d5a4a2771
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   microblaze-linux-ld: drivers/gpu/drm/msm/dp/dp_hpd.o: in function `dp_hpd_unregister_typec_mux':
>> drivers/gpu/drm/msm/dp/dp_hpd.c:83: undefined reference to `typec_mux_unregister'
   microblaze-linux-ld: drivers/gpu/drm/msm/dp/dp_hpd.o: in function `dp_hpd_mux_set':
>> drivers/gpu/drm/msm/dp/dp_hpd.c:55: undefined reference to `typec_mux_get_drvdata'
   microblaze-linux-ld: drivers/gpu/drm/msm/dp/dp_hpd.o: in function `dp_hpd_get':
>> drivers/gpu/drm/msm/dp/dp_hpd.c:109: undefined reference to `typec_mux_register'
>> microblaze-linux-ld: drivers/gpu/drm/msm/dp/dp_hpd.c:83: undefined reference to `typec_mux_unregister'


vim +83 drivers/gpu/drm/msm/dp/dp_hpd.c

    52	
    53	static int dp_hpd_mux_set(struct typec_mux *mux, struct typec_mux_state *state)
    54	{
  > 55		struct dp_hpd_private *dp_hpd = typec_mux_get_drvdata(mux);
    56		struct dp_usbpd *usbpd = &dp_hpd->dp_usbpd;
    57		struct typec_displayport_data *dp_data = state->data;
    58		int pin_assign = 0;
    59	
    60		if (dp_data) {
    61			pin_assign = DP_CONF_GET_PIN_ASSIGN(dp_data->conf);
    62			usbpd->hpd_irq = !!(dp_data->status & DP_STATUS_IRQ_HPD);
    63			usbpd->multi_func = pin_assign == DP_PIN_ASSIGN_C || DP_PIN_ASSIGN_E;
    64		}
    65	
    66		if (!pin_assign) {
    67			if (dp_hpd->connected) {
    68				dp_hpd->connected = false;
    69				dp_hpd->dp_cb->disconnect(dp_hpd->dev);
    70			}
    71		} else if (!dp_hpd->connected) {
    72			dp_hpd->connected = true;
    73			dp_hpd->dp_cb->configure(dp_hpd->dev);
    74		} else {
    75			dp_hpd->dp_cb->attention(dp_hpd->dev);
    76		}
    77	
    78		return 0;
    79	}
    80	
    81	static void dp_hpd_unregister_typec_mux(void *data)
    82	{
  > 83		typec_mux_unregister(data);
    84	}
    85	
    86	struct dp_usbpd *dp_hpd_get(struct device *dev, struct dp_usbpd_cb *cb)
    87	{
    88		struct typec_mux_desc mux_desc = {};
    89		struct dp_hpd_private *dp_hpd;
    90		int rc;
    91	
    92		if (!cb) {
    93			pr_err("invalid cb data\n");
    94			return ERR_PTR(-EINVAL);
    95		}
    96	
    97		dp_hpd = devm_kzalloc(dev, sizeof(*dp_hpd), GFP_KERNEL);
    98		if (!dp_hpd)
    99			return ERR_PTR(-ENOMEM);
   100	
   101		dp_hpd->dev = dev;
   102		dp_hpd->dp_cb = cb;
   103	
   104		dp_hpd->dp_usbpd.connect = dp_hpd_connect;
   105	
   106		mux_desc.fwnode = dev->fwnode;
   107		mux_desc.set = dp_hpd_mux_set;
   108		mux_desc.drvdata = dp_hpd;
 > 109		dp_hpd->mux = typec_mux_register(dev, &mux_desc);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
