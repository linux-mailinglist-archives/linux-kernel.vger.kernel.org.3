Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975F752420A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 03:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiELBaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 21:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiELBaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 21:30:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C89154B3F;
        Wed, 11 May 2022 18:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652319006; x=1683855006;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FmzxLobn0K8eUJokt43bdYb1Kp6hZ00M7lRWrjyhUwY=;
  b=SKeOnlZmmXRXW1DKAasjKtvf6ApCGk+x3DLPODK8l0L+JabxLMnFJfzp
   m7UVKz3uculOAPYDdc64yIkSIEj3KpWJR9tKlmnn5h5qZrvWsoUgrfDVl
   SLhrv4GOGlWmIZj+HEvqItztlQypeWYlMk534fxnCb61TeSqkKXnI9BbR
   x5zgwbY4B6CZGGBKL9dZTagQvSb14XMVDA/GXpWMgVv0W2MWFUuVRfIYF
   57sM0W2rw+IqipldUXxK2G5dChfh3rSH+aPd2tP5Csj/IvSbtlPMBPBQi
   LL2cHJK6GRX1ZnLwMc7oo5GwUDtuuIghxvpVa8wnTEXLDxga2TOvaT0Qw
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="330460649"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="330460649"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 18:30:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="542554715"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 11 May 2022 18:29:58 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noxeQ-000Jmk-2Z;
        Thu, 12 May 2022 01:29:58 +0000
Date:   Thu, 12 May 2022 09:29:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: Re: [v4 2/3] phy: qcom-snps: Add support for overriding phy tuning
 parameters
Message-ID: <202205120931.JrA2orb3-lkp@intel.com>
References: <1652282793-5580-3-git-send-email-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652282793-5580-3-git-send-email-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krishna,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on krzk/for-next linus/master v5.18-rc6 next-20220511]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-Kurapati/Add-QCOM-SNPS-PHY-overriding-params-support/20220511-232858
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: riscv-randconfig-r033-20220509 (https://download.01.org/0day-ci/archive/20220512/202205120931.JrA2orb3-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 18dd123c56754edf62c7042dcf23185c3727610f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/48c46f24873c92d3e16904af9e654962d0b923f1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Krishna-Kurapati/Add-QCOM-SNPS-PHY-overriding-params-support/20220511-232858
        git checkout 48c46f24873c92d3e16904af9e654962d0b923f1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c:541:29: error: initializing 'struct override_param_map *' with an expression of type 'const void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           struct override_param_map *cfg = of_device_get_match_data(dev);
                                      ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +541 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c

   534	
   535	static void qcom_snps_hsphy_read_override_param_seq(struct device *dev)
   536	{
   537		struct device_node *node = dev->of_node;
   538		s32 val;
   539		int ret, i;
   540		struct qcom_snps_hsphy *hsphy;
 > 541		struct override_param_map *cfg = of_device_get_match_data(dev);
   542	
   543		hsphy = dev_get_drvdata(dev);
   544	
   545		for (i = 0; i < ARRAY_SIZE(phy_seq_props); i++) {
   546			ret = of_property_read_s32(node, phy_seq_props[i], &val);
   547			if (!ret) {
   548				dev_dbg(&hsphy->phy->dev, "Read param: %s val: %d\n",
   549							phy_seq_props[i], val);
   550				qcom_snps_hsphy_override_param_update_val(cfg[i], val,
   551							&hsphy->update_seq_cfg[i]);
   552			}
   553		}
   554	}
   555	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
