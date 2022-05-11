Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13196523F31
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 23:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347961AbiEKVF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 17:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiEKVF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 17:05:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283D322922E;
        Wed, 11 May 2022 14:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652303126; x=1683839126;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fcAVKuqd6YZHzN7purgtSBIoD9bELDVNb4vgy0qU8LA=;
  b=HxQdqGVMPhXplL8hRLoax5LfcGjF7bU7vpk/oRtT5w8gZFRHHuJ+WPB9
   SDWmy53D4hLzjUwB6xXB4ERcz3r/+x637r3R5Ax8vdrsQCDCdEOpNFozq
   tFfMySXrI9Q0hD+dfw2yefWAnumoAr44OYXcA90bbLYq3cgvWHGDIkGno
   md+dkJs6b2itgzfHS7L8XUVn7lnDJ2Z5LJjVgnFuTXxzZla5CNSLMGOnN
   iHXwB5uBkiIpmVQ7jS1WfTn3CVrNRJilKs1Rqm+bbXiFEcGHqqp0/YEr1
   J7EDNVgI7Hp/Wki0tN0e2n3GopNwFJUObsUaOaTLVqaS6QY+WPXfhBcXp
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="251865948"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="251865948"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 14:05:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="553491065"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 11 May 2022 14:05:21 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1notWK-000JaW-It;
        Wed, 11 May 2022 21:05:20 +0000
Date:   Thu, 12 May 2022 05:04:19 +0800
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
Cc:     kbuild-all@lists.01.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_vpulyala@quicinc.com,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: Re: [v4 2/3] phy: qcom-snps: Add support for overriding phy tuning
 parameters
Message-ID: <202205120425.gScyEI7N-lkp@intel.com>
References: <1652282793-5580-3-git-send-email-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652282793-5580-3-git-send-email-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krishna,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on krzk/for-next linus/master v5.18-rc6 next-20220511]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-Kurapati/Add-QCOM-SNPS-PHY-overriding-params-support/20220511-232858
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220512/202205120425.gScyEI7N-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/48c46f24873c92d3e16904af9e654962d0b923f1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Krishna-Kurapati/Add-QCOM-SNPS-PHY-overriding-params-support/20220511-232858
        git checkout 48c46f24873c92d3e16904af9e654962d0b923f1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/phy/qualcomm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c: In function 'qcom_snps_hsphy_read_override_param_seq':
>> drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c:541:42: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     541 |         struct override_param_map *cfg = of_device_get_match_data(dev);
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/const +541 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c

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
