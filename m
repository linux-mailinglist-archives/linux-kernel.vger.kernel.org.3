Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51240515728
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238871AbiD2Vrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238760AbiD2Vrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:47:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E1AD890A;
        Fri, 29 Apr 2022 14:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651268665; x=1682804665;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P2UJ/TZ038lSA/cIVqZWSYw3gdJ/2sLQfrgZKGge4O4=;
  b=kfLJu83CCnSe67m4bsC2fROsc4pnT8tDL7cpphThVZ7rkvYhaV1/ah0I
   eZ02X3c5TTkIsMqjgntK0qQ7Mp/g1lL50RLZbbkGumf/Z60wOS/gL76/N
   HxD6TOknyPFYCFb/1wd+4dxtmzNYGfY7R9XiyDRT7oDWL/Tpe4dYXbz7u
   QabUX7Q8pKubXkhDoYx0qpMTgrV3YrhzkUR86DH1fARkHdbi06Wmc/06E
   SpR3oKdhBbY20WWNwJHnJdXRQw9PpBQ5YviQeOrU/CLOUIRbx3RjylnG6
   LBebyR5TlYUzpqgeYhe1tafGXIAeWIR3XhmQhnS/4XslKEprR0zeUsHJz
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="265625360"
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="265625360"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 14:44:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="881666036"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 29 Apr 2022 14:44:23 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkYPW-0006cz-DH;
        Fri, 29 Apr 2022 21:44:22 +0000
Date:   Sat, 30 Apr 2022 05:43:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        linux-media@vger.kernel.org, stanimir.varbanov@linaro.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_vgarodia@quicinc.com,
        frkoenig@chromium.org, quic_dikshita@quicinc.com
Subject: Re: [PATCH] media: venus: set ubwc configuration on specific video
 hardware
Message-ID: <202204300506.tuUok8FR-lkp@intel.com>
References: <1651131248-20313-1-git-send-email-quic_vgarodia@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651131248-20313-1-git-send-email-quic_vgarodia@quicinc.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vikash,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on media-tree/master]
[also build test ERROR on v5.18-rc4 next-20220429]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Vikash-Garodia/media-venus-set-ubwc-configuration-on-specific-video-hardware/20220428-153510
base:   git://linuxtv.org/media_tree.git master
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20220430/202204300506.tuUok8FR-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/22d299bea1f679d007cb71b3916bf39bb957ab66
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vikash-Garodia/media-venus-set-ubwc-configuration-on-specific-video-hardware/20220428-153510
        git checkout 22d299bea1f679d007cb71b3916bf39bb957ab66
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/media/platform/qcom/venus/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/media/platform/qcom/venus/hfi_venus.c: In function 'venus_sys_set_default_properties':
>> drivers/media/platform/qcom/venus/hfi_venus.c:997:23: error: too few arguments to function 'venus_sys_set_ubwc_config'
     997 |                 ret = venus_sys_set_ubwc_config();
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/qcom/venus/hfi_venus.c:907:12: note: declared here
     907 | static int venus_sys_set_ubwc_config(struct venus_hfi_device *hdev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/venus_sys_set_ubwc_config +997 drivers/media/platform/qcom/venus/hfi_venus.c

   967	
   968	static int venus_sys_set_default_properties(struct venus_hfi_device *hdev)
   969	{
   970		struct device *dev = hdev->core->dev;
   971		const struct venus_resources *res = hdev->core->res;
   972		int ret;
   973	
   974		ret = venus_sys_set_debug(hdev, venus_fw_debug);
   975		if (ret)
   976			dev_warn(dev, "setting fw debug msg ON failed (%d)\n", ret);
   977	
   978		/*
   979		 * Idle indicator is disabled by default on some 4xx firmware versions,
   980		 * enable it explicitly in order to make suspend functional by checking
   981		 * WFI (wait-for-interrupt) bit.
   982		 */
   983		if (IS_V4(hdev->core) || IS_V6(hdev->core))
   984			venus_sys_idle_indicator = true;
   985	
   986		ret = venus_sys_set_idle_message(hdev, venus_sys_idle_indicator);
   987		if (ret)
   988			dev_warn(dev, "setting idle response ON failed (%d)\n", ret);
   989	
   990		ret = venus_sys_set_power_control(hdev, venus_fw_low_power_mode);
   991		if (ret)
   992			dev_warn(dev, "setting hw power collapse ON failed (%d)\n",
   993				 ret);
   994	
   995		/* For specific venus core, it is mandatory to set the UBWC configuration */
   996		if (res->ubwc_conf) {
 > 997			ret = venus_sys_set_ubwc_config();
   998			if (ret)
   999				dev_warn(dev, "setting ubwc config failed (%d)\n", ret);
  1000		}
  1001	
  1002		return ret;
  1003	}
  1004	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
