Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65C257F2AF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 04:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbiGXCgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 22:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiGXCgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 22:36:23 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6D713DE2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 19:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658630183; x=1690166183;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KPXnMjwUWbhG1S05SL+/0f8BnL00yR9HZFn5WbmLJGY=;
  b=CQPH78iI5dDlXQXt9N9j267PeqnEXfifmEyOHmBblJzoRT0pdnuFpY6L
   qVpvPoF7wXRbc0kIxingxVNSkk3WpLBHjIx2BUrlk7Y7Vztdvze+aMVuU
   N1Grk9YgZn4gn5QaM8mkWIpaJL6IinRap9Z+bRQoSXwNlXj0U6HbMm0Yh
   188HoJC932qKjYNYrtJjH13GUPNXz7LzJV4m6wZ3JXCqiZoe2RjB7rbY7
   D5Iln/OHx0eqWl5oRAAgPhecRGShBPQlVnMO+LnVPsavGwcRlVhGGNVNN
   4GdFiUWmQUGgyojTqizqCJOx6zRbo1Yve746fgpztnMps76WrLPrquXML
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="288266471"
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="288266471"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 19:36:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="688675685"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jul 2022 19:36:20 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFRTf-0003Pt-1k;
        Sun, 24 Jul 2022 02:36:19 +0000
Date:   Sun, 24 Jul 2022 10:35:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Evan Green <evgreen@chromium.org>
Subject: [jsarha:topic/cros-sof-v4.19 923/6555]
 drivers/soc/qcom/qcom_gsbi.c:125:34: warning: 'tcsr_dt_match' defined but
 not used
Message-ID: <202207241059.TJ6DBg9u-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.19
head:   d7a3e91d8d16d1ef8653deec5a1fffc4de034a0c
commit: cb830e93e29574f6eae7ecd6f709905e15c245cb [923/6555] UPSTREAM: soc: qcom: Allow COMPILE_TEST of qcom SoC Kconfigs
config: i386-buildonly-randconfig-r004-20220718 (https://download.01.org/0day-ci/archive/20220724/202207241059.TJ6DBg9u-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/jsarha/linux/commit/cb830e93e29574f6eae7ecd6f709905e15c245cb
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/cros-sof-v4.19
        git checkout cb830e93e29574f6eae7ecd6f709905e15c245cb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/mailbox/ drivers/soc/qcom/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/soc/qcom/qcom_gsbi.c:125:34: warning: 'tcsr_dt_match' defined but not used [-Wunused-const-variable=]
     125 | static const struct of_device_id tcsr_dt_match[] = {
         |                                  ^~~~~~~~~~~~~


vim +/tcsr_dt_match +125 drivers/soc/qcom/qcom_gsbi.c

e5fdad68d47ed3 Andy Gross          2015-02-09  124  
e5fdad68d47ed3 Andy Gross          2015-02-09 @125  static const struct of_device_id tcsr_dt_match[] = {
e5fdad68d47ed3 Andy Gross          2015-02-09  126  	{ .compatible = "qcom,tcsr-ipq8064", .data = &config_ipq8064},
e5fdad68d47ed3 Andy Gross          2015-02-09  127  	{ .compatible = "qcom,tcsr-apq8064", .data = &config_apq8064},
e5fdad68d47ed3 Andy Gross          2015-02-09  128  	{ .compatible = "qcom,tcsr-msm8960", .data = &config_msm8960},
e5fdad68d47ed3 Andy Gross          2015-02-09  129  	{ .compatible = "qcom,tcsr-msm8660", .data = &config_msm8660},
e5fdad68d47ed3 Andy Gross          2015-02-09  130  	{ },
fa9eb3241895d2 Srinivas Kandagatla 2014-09-23  131  };
fa9eb3241895d2 Srinivas Kandagatla 2014-09-23  132  

:::::: The code at line 125 was first introduced by commit
:::::: e5fdad68d47ed344832b7ca4e18b2e9708d8141e soc: qcom: gsbi: Add support for ADM CRCI muxing

:::::: TO: Andy Gross <agross@codeaurora.org>
:::::: CC: Kumar Gala <galak@codeaurora.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
