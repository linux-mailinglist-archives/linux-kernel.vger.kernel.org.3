Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A794E808A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 12:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbiCZKzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 06:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbiCZKzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 06:55:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC27848888
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 03:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648292054; x=1679828054;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+DULYsQyN33SjUke7wC+KDnyKxuorPFQhsSjFOU7jBY=;
  b=GHa+hhQhXkiZ5ZQ6JNG/7uZ3gV9ShiXlMredp/jrxkCAkInaA389F9yY
   9bvwbxML5t7TySMbwSGy7MqLiyXYhUG/zJPLbHtrfgcsUa0WksUGIeTKj
   4APv6EUihFYww71mDJ8X2kfpCXUDhA9C2/9aq9EuUlvuKF+t13unNtuir
   gMf8rM5npXzGpVm3LpL+G03ir5XT4q4Cd22WNovrTFKNezvrnEEm32n5b
   oAd1Cy2wWHUfcOlrClBIXpZyCmXyEl4MSI8fxDGtOqIk6QwdYCemvyTQO
   7RH9cG5Hl/upMrudb8eFh8UHhC96PrzwG1JEa3yRi2V18kqheOwcyckH5
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="258742678"
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="258742678"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 03:54:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="520474136"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 26 Mar 2022 03:54:13 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nY43g-000NIZ-8a; Sat, 26 Mar 2022 10:54:12 +0000
Date:   Sat, 26 Mar 2022 18:53:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [andersson:wip/sc8180x-next-20220301 5/27]
 drivers/gpu/drm/msm/dp/dp_hpd.c:63:53: warning: converting the enum constant
 to a boolean
Message-ID: <202203261858.pcxuQp9z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/andersson/kernel wip/sc8180x-next-20220301
head:   0289eb1e5447f549241a40b2a0742a796467ecd8
commit: e4014b0e8a0a46349e91bfb9ef44a59d5a4a2771 [5/27] drm/msm/dp: Add typec_mux implementation
config: arm64-randconfig-r014-20220324 (https://download.01.org/0day-ci/archive/20220326/202203261858.pcxuQp9z-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/andersson/kernel/commit/e4014b0e8a0a46349e91bfb9ef44a59d5a4a2771
        git remote add andersson https://github.com/andersson/kernel
        git fetch --no-tags andersson wip/sc8180x-next-20220301
        git checkout e4014b0e8a0a46349e91bfb9ef44a59d5a4a2771
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/drm/msm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/msm/dp/dp_hpd.c:63:53: warning: converting the enum constant to a boolean [-Wint-in-bool-context]
                   usbpd->multi_func = pin_assign == DP_PIN_ASSIGN_C || DP_PIN_ASSIGN_E;
                                                                     ^
   1 warning generated.


vim +63 drivers/gpu/drm/msm/dp/dp_hpd.c

    52	
    53	static int dp_hpd_mux_set(struct typec_mux *mux, struct typec_mux_state *state)
    54	{
    55		struct dp_hpd_private *dp_hpd = typec_mux_get_drvdata(mux);
    56		struct dp_usbpd *usbpd = &dp_hpd->dp_usbpd;
    57		struct typec_displayport_data *dp_data = state->data;
    58		int pin_assign = 0;
    59	
    60		if (dp_data) {
    61			pin_assign = DP_CONF_GET_PIN_ASSIGN(dp_data->conf);
    62			usbpd->hpd_irq = !!(dp_data->status & DP_STATUS_IRQ_HPD);
  > 63			usbpd->multi_func = pin_assign == DP_PIN_ASSIGN_C || DP_PIN_ASSIGN_E;
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
