Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A387457A716
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbiGSTSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbiGSTSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:18:31 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9589254665;
        Tue, 19 Jul 2022 12:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658258310; x=1689794310;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hueuKSEXs+VQTfQVvnpjXB2DYGdmq574GA27A2Tm5zs=;
  b=EPJTiV359tbXklVoRTksGaolse+VDi39Akmm4Jbnt7W7cYkuWdcADzgq
   DRzKZtCSXhqDFcF192c9+dHpF0ZmTIyWbQiMO9++ln+vUiM29ZaioEI8A
   ayEDhLdM4/RAOGEDHa60n2s/amOhuRDxuJ9UJxgwFYrYi72ncb+mDUOCV
   tkv8641TdalOiEZRO3+ld1Wm41dHbWldHoyYZ8AwPCspB/wX/XSnM4ARh
   peohN1oo7QG0sf7EP0rJDVNDCrX4q0wjLw6MLRtdFEWFI5J89sjK6qNPQ
   Ay06cOTYKdd219K0UIXL0Rbi++EpPVCtlCdCTGpNJSFaTDTesS9AgH+BY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="273412258"
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="273412258"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 12:18:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="548030295"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 19 Jul 2022 12:18:26 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDsjh-0005wc-UP;
        Tue, 19 Jul 2022 19:18:25 +0000
Date:   Wed, 20 Jul 2022 03:17:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Judy Hsiao <judyhsiao@chromium.org>, Andy Gross <agross@kernel.org>
Cc:     kbuild-all@lists.01.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        dianders@chromium.org, mka@chromium.org, cychiang@google.com,
        judyhsiao@google.com, swboyd@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Judy Hsiao <judyhsiao@chromium.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sc7280: include
 sc7280-herobrine-audio-rt5682.dtsi in herobrine-r1
Message-ID: <202207200353.1Eary79U-lkp@intel.com>
References: <20220718080252.789585-4-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718080252.789585-4-judyhsiao@chromium.org>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Judy,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on arm/for-next arm64/for-next/core clk/clk-next kvmarm/next rockchip/for-next shawnguo/for-next soc/for-next linus/master v5.19-rc7 next-20220718]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Judy-Hsiao/Add-dtsi-for-sc7280-herobrine-boards-that-using/20220718-161009
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-buildonly-randconfig-r005-20220717 (https://download.01.org/0day-ci/archive/20220720/202207200353.1Eary79U-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/82e8a096331437f4e06ac3d344bdc9e9950e27b7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Judy-Hsiao/Add-dtsi-for-sc7280-herobrine-boards-that-using/20220718-161009
        git checkout 82e8a096331437f4e06ac3d344bdc9e9950e27b7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   Error: arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi:615.1-13 Label or path mi2s1_data0 not found
   Error: arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi:620.1-12 Label or path mi2s1_sclk not found
   Error: arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi:625.1-10 Label or path mi2s1_ws not found
>> Error: arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi:28.29-30 syntax error
   FATAL ERROR: Unable to parse input tree

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
