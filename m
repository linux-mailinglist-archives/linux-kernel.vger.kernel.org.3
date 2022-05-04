Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419A4519DA4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 13:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348554AbiEDLL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 07:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348558AbiEDLLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 07:11:23 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4B928E20
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 04:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651662467; x=1683198467;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uiLbHLxiGXNW6OESnecCcNJLWQSiF+MKfCJxeylLQB4=;
  b=YHvNfTfM8yE8G7fWnDg91g1QWQJwKMsAhUDpcwOP9bRoTaZ6BchzL8xV
   nYLF0MDz5FGTefT8BUg/pvxfYe3s+oLB6WbG0uVknJHRc4XtV+hmImPcL
   BP/48gBu+O1LeVvdPMQC/4TRaDFlTfmPDQdFLadK0nEQyPXjGSXFv2AoJ
   cpyktW49vv+6K8w9s/CO5G3+z2HbIZz5wVmdOwDJOkUi9MUVYELUrEMY8
   bdjDjyqfK/+J5LmsuJNlXtR/AJ+eT9YWSpN/p9r7I0nVqRuKkAhi8o8xB
   jnz3bGMKq78JWt9Wqr/meBdy3FrzOblXE4t3AuSAsv8PonKgMx+E6wdX+
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="265321245"
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="265321245"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 04:07:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="548624233"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 04 May 2022 04:07:45 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmCrA-000BKr-VX;
        Wed, 04 May 2022 11:07:44 +0000
Date:   Wed, 4 May 2022 19:06:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [andersson:wip/sc8180x-next-20220502 6/29]
 drivers/gpu/drm/msm/dp/dp_hpd.c:63:53: warning: converting the enum constant
 to a boolean
Message-ID: <202205041920.TXQhAxL4-lkp@intel.com>
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

tree:   https://github.com/andersson/kernel wip/sc8180x-next-20220502
head:   6199153320a3b7d1dce23ad1ea4d894a86793cb6
commit: be6e31f126bed33f684250905b79d76f7664d985 [6/29] drm/msm/dp: Add typec_mux implementation
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20220504/202205041920.TXQhAxL4-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 363b3a645a1e30011cc8da624f13dac5fd915628)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/andersson/kernel/commit/be6e31f126bed33f684250905b79d76f7664d985
        git remote add andersson https://github.com/andersson/kernel
        git fetch --no-tags andersson wip/sc8180x-next-20220502
        git checkout be6e31f126bed33f684250905b79d76f7664d985
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/gpu/drm/msm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/msm/dp/dp_hpd.c:63:53: warning: converting the enum constant to a boolean [-Wint-in-bool-context]
                   usbpd->multi_func = pin_assign == DP_PIN_ASSIGN_C || DP_PIN_ASSIGN_E;
                                                                     ^
   1 warning generated.


vim +63 drivers/gpu/drm/msm/dp/dp_hpd.c

    52	
    53	static int dp_hpd_mux_set(struct typec_mux_dev *mux, struct typec_mux_state *state)
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
