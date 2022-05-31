Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD91B538EB9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 12:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245428AbiEaKVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 06:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbiEaKVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 06:21:11 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA5C8DDFF;
        Tue, 31 May 2022 03:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653992470; x=1685528470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lxEFp44JsX/JOoOGTIBZIgRYdAkFBgaUx4lYxSNdtkU=;
  b=dIzb6zsQznD2vyLggpktwF7uTHbuR6u5GMLS/G3iVRSriJqm0s+k47PV
   Nf+G9750/koUDq0Il5BqF8rxpRXZU68NmI8Q7GeES26T+WJRhHuu/Zl/v
   H7sYEmIzoSRuQCygZe9V1UKQ00B6sRtAqEuSo1PcIY9SC+jxSCfGQfyjM
   iLOLPvWZoMFIUXbBDTND7QN4b4Ae1k3rQWxFeNjlhitv803JYW6OeQt/B
   f9lgv3mBpa7Y1g767lfP75o9dL64ep7Qakj2Bbws8xgWDhccFx6rPIL3J
   kAUkBJdmk4SM0QMSaW7VII0X/0SkL0OCEY851JwupJXg3Hcyt+DP8m4Yk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="272783031"
X-IronPort-AV: E=Sophos;i="5.91,264,1647327600"; 
   d="scan'208";a="272783031"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 03:21:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,264,1647327600"; 
   d="scan'208";a="632977245"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 31 May 2022 03:21:07 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvyzq-0002be-Gg;
        Tue, 31 May 2022 10:21:06 +0000
Date:   Tue, 31 May 2022 18:20:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Harsh Agarwal <quic_harshq@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, Harsh Agarwal <quic_harshq@quicinc.com>
Subject: Re: [PATCH 2/3] usb: phy: Add devm_of_usb_get_phy_by_phandle
Message-ID: <202205311838.eFoNSZzZ-lkp@intel.com>
References: <1653985217-20953-3-git-send-email-quic_harshq@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653985217-20953-3-git-send-email-quic_harshq@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harsh,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on robh/for-next v5.18 next-20220531]
[cannot apply to balbi-usb/testing/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Harsh-Agarwal/Add-support-for-multiport-controller/20220531-162337
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: csky-defconfig (https://download.01.org/0day-ci/archive/20220531/202205311838.eFoNSZzZ-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7af1d0e696ec2ddf574df10e3bf3799299b8061a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Harsh-Agarwal/Add-support-for-multiport-controller/20220531-162337
        git checkout 7af1d0e696ec2ddf574df10e3bf3799299b8061a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash drivers/usb/phy/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/usb/otg.h:14,
                    from include/linux/usb/of.h:12,
                    from drivers/usb/phy/of.c:9:
>> include/linux/usb/phy.h:257:16: warning: 'ERR_PTR' is static but used in inline function 'devm_of_usb_get_phy_by_phandle' which is not static
     257 |         return ERR_PTR(-ENXIO);
         |                ^~~~~~~


vim +257 include/linux/usb/phy.h

   253	
   254	extern inline struct usb_phy *devm_of_usb_get_phy_by_phandle(struct device *dev,
   255		const char *phandle, u8 index, struct device_node *lookup_node)
   256	{
 > 257		return ERR_PTR(-ENXIO);
   258	}
   259	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
