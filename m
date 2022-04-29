Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE235150A4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379005AbiD2QXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbiD2QXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:23:39 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0F218B03;
        Fri, 29 Apr 2022 09:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651249219; x=1682785219;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NeeAYHCb2w8hfb2CqYSw0VXn0vgeaiNaoDLMfEcGd6U=;
  b=aRelUJHAOq5NynNFsOMgxpTUUmwyD7sqd+ssbUpr7TAdnbSWbbgoRF+e
   jjybxaW1I/hkW+UJyaEenrpnZ/ulReHuvuDra9KfakQb3JixCSV3YJFdg
   rPuVqJq3zu1AwWjwzlNB+Opm56Kh389PtrrMhoQDT365dKURzZBGq+k8i
   pyRIDWbjBvgGjwn7t2ToiePiAHsrCCLDUS2m8v0HuAP85If0RCvkhjya6
   bpdTJVxUwx4ZO+yF20xUUJKcrHHczqMNC7qNevpP7hQugtFSMMPOeE29g
   gTL63FFWf37Wav2LvlttZ4pWeUY7wYQQlCBCEsBY8QN0VPrzZr00Ons2E
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="248617880"
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="248617880"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 09:20:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="542671702"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 29 Apr 2022 09:20:16 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkTLs-0006Tj-2q;
        Fri, 29 Apr 2022 16:20:16 +0000
Date:   Sat, 30 Apr 2022 00:19:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        linux-media@vger.kernel.org, stanimir.varbanov@linaro.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_vgarodia@quicinc.com, frkoenig@chromium.org,
        quic_dikshita@quicinc.com
Subject: Re: [PATCH] media: venus: set ubwc configuration on specific video
 hardware
Message-ID: <202204300037.EcG1kDyl-lkp@intel.com>
References: <1651131248-20313-1-git-send-email-quic_vgarodia@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651131248-20313-1-git-send-email-quic_vgarodia@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220430/202204300037.EcG1kDyl-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c59473aacce38cd7dd77eebceaf3c98c5707ab3b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/22d299bea1f679d007cb71b3916bf39bb957ab66
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vikash-Garodia/media-venus-set-ubwc-configuration-on-specific-video-hardware/20220428-153510
        git checkout 22d299bea1f679d007cb71b3916bf39bb957ab66
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/crypto/ arch/arm64/kernel/ drivers/media/platform/qcom/venus/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/media/platform/qcom/venus/hfi_venus.c:997:35: error: too few arguments to function call, single argument 'hdev' was not specified
                   ret = venus_sys_set_ubwc_config();
                         ~~~~~~~~~~~~~~~~~~~~~~~~~ ^
   drivers/media/platform/qcom/venus/hfi_venus.c:907:12: note: 'venus_sys_set_ubwc_config' declared here
   static int venus_sys_set_ubwc_config(struct venus_hfi_device *hdev)
              ^
   1 error generated.


vim +/hdev +997 drivers/media/platform/qcom/venus/hfi_venus.c

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
