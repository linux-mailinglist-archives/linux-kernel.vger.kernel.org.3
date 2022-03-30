Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F4D4ECD24
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 21:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350631AbiC3TVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 15:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350734AbiC3TUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 15:20:39 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092BD6155;
        Wed, 30 Mar 2022 12:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648667917; x=1680203917;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EPfZR4tpHhDfDi4POeZPO4ixXNKSTXTaIqowE3v9tOc=;
  b=kJImin4yGV09651/vKLixpmnJPZS7mLRO/XYOAu/zEeCKypqb4CcHUzx
   NfZVeGsIguQ5+YmA/2sG9fARnz7/5HDqpjs1YjYkZ9LncTIUyfKFsyy+p
   IK0F8icoAQfkDQ88rhBpa/LPGxe6ts8qQMqsFI/ge0hpGCZl0XU+PPvkB
   P/UMNZHP81IxwQ2HWP155BSb1nqwrBQ9pMX7hgYm4DRO2pu0LR6obdl89
   zMsRjPjiNsoySwdPX5C0UtFgRDDkYirb9YKMumYCNpNlLduqUhXBY/IPi
   /OH6XvYcuVb/8H+LAudH8rY8GeIr0Oavj6X2NqisA+rKdwOalzd03AaIX
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="259339426"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="259339426"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 12:18:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="586115481"
Received: from lkp-server02.sh.intel.com (HELO 56431612eabd) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 30 Mar 2022 12:18:33 -0700
Received: from kbuild by 56431612eabd with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZdpw-0000Oa-MM;
        Wed, 30 Mar 2022 19:18:32 +0000
Date:   Thu, 31 Mar 2022 03:17:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>,
        agross@kernel.org
Cc:     kbuild-all@lists.01.org,
        Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CHROMIUM: arm64: dts: qcom: Add sc7180-gelarshie
Message-ID: <202203310354.EE0k3ev8-lkp@intel.com>
References: <20220330090947.9100-1-chenxiangrui@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330090947.9100-1-chenxiangrui@huaqin.corp-partner.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
config: arm64-randconfig-r012-20220330 (https://download.01.org/0day-ci/archive/20220331/202203310354.EE0k3ev8-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/18677c7abfdfc9a72daa7cfc3011314b098b361a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mars-Chen/CHROMIUM-arm64-dts-qcom-Add-sc7180-gelarshie/20220330-171139
        git checkout 18677c7abfdfc9a72daa7cfc3011314b098b361a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie-r0.dts:10:
>> arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie.dtsi:9:10: fatal error: sc7180-trogdor-mipi-camera.dtsi: No such file or directory
       9 | #include "sc7180-trogdor-mipi-camera.dtsi"
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +9 arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie.dtsi

   > 9	#include "sc7180-trogdor-mipi-camera.dtsi"
    10	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
