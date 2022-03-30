Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F62A4EC667
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346755AbiC3OYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346104AbiC3OX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:23:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983A91C550E;
        Wed, 30 Mar 2022 07:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648650133; x=1680186133;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=41EM4l2nimufuzVlqLONXL8Be3SNWhsMlZum9H47py8=;
  b=U3GSz2QYKYlDOvBqIe88on3rJ9gR/W64n4LECvHN1iGop41I1tZy6115
   a7xS0lhfdoQ/vbj2enW4+7AU73NgiEJBiAmeYjFJ0Dc8vatBgQYs0bex/
   zVy2xYY+hbcmKnOpGtq+tH4FGfcbU72VntmxSMNhtecSL6XeFftF+HPwB
   BCDZtBydvUt3R66PD3/wdduwp+i6ikGb4YMpSZQWBZWecJ4a2ouPAL7tE
   eh3oUkmKbgVukwt4HBqwk2l3Qip7osELOyDUAzScD8/PsTDZ9hVtapA0b
   KknarKcq4s6n28awdhX6Mmlcw9SV67JjxeETNAmnKUo8D9Y2vfNULu8Of
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="259739578"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="259739578"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 07:22:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="719992331"
Received: from lkp-server02.sh.intel.com (HELO 56431612eabd) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 30 Mar 2022 07:22:08 -0700
Received: from kbuild by 56431612eabd with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZZD5-00004C-Ed;
        Wed, 30 Mar 2022 14:22:07 +0000
Date:   Wed, 30 Mar 2022 22:21:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>,
        agross@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CHROMIUM: arm64: dts: qcom: Add sc7180-gelarshie
Message-ID: <202203302254.6kSD2Eo4-lkp@intel.com>
References: <20220330090947.9100-1-chenxiangrui@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330090947.9100-1-chenxiangrui@huaqin.corp-partner.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mars,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v5.17 next-20220330]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Mars-Chen/CHROMIUM-arm64-dts-qcom-Add-sc7180-gelarshie/20220330-171139
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-randconfig-r032-20220330 (https://download.01.org/0day-ci/archive/20220330/202203302254.6kSD2Eo4-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/18677c7abfdfc9a72daa7cfc3011314b098b361a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mars-Chen/CHROMIUM-arm64-dts-qcom-Add-sc7180-gelarshie/20220330-171139
        git checkout 18677c7abfdfc9a72daa7cfc3011314b098b361a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie-r0.dts:10:
>> arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie.dtsi:9:10: fatal error: 'sc7180-trogdor-mipi-camera.dtsi' file not found
   #include "sc7180-trogdor-mipi-camera.dtsi"
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +9 arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie.dtsi

   > 9	#include "sc7180-trogdor-mipi-camera.dtsi"
    10	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
