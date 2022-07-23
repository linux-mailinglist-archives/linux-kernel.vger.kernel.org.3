Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7873757EBDA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 06:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiGWEQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 00:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGWEQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 00:16:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221BA74DE0;
        Fri, 22 Jul 2022 21:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658549766; x=1690085766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qi4Vo2BGFenUFFuQzdEqAlJ8D1th20Bp3/R/v6klphc=;
  b=JVEGsjNhCwmTCc7XdbJXrkNQj3y1vTbU1ZWr/nmB4G8NSOGcafMdDsfP
   Vqg2sLbZQ252+LwBrLOwN1s/7YaHe0tl8Z15qkupI7K5VRMQufP1pEj5k
   3o4ErH8bLBGVhYX7neiviEdgpn/QLvISm1qlxwDBW6pitJ+UM8hBdPWvB
   mmc45HOqqV1CSKdkJXmnDunRUoqGTkOXCM6oPGK0ChFmnHsCekpI03DJc
   n4IQug0QKCahWB/Sl3dH+PuLx74NjwscR2eTkWO1g/jZkjWfOB5FSSL+u
   paGV6nYWJe+j1IUM6QWEds4c2sX0Pz+odPm9rB6A8bW4jaP36mSspZM/3
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="351438807"
X-IronPort-AV: E=Sophos;i="5.93,187,1654585200"; 
   d="scan'208";a="351438807"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 21:16:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,187,1654585200"; 
   d="scan'208";a="775424893"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Jul 2022 21:16:02 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oF6Yb-0002Ff-33;
        Sat, 23 Jul 2022 04:16:01 +0000
Date:   Sat, 23 Jul 2022 12:15:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        devicetree@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v4 2/4] arm64: dts: qcom: msm8916-samsung-e2015: Add
 initial common dtsi
Message-ID: <202207231229.wqK1Zic2-lkp@intel.com>
References: <20220721235333.75282-1-linmengbo0689@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721235333.75282-1-linmengbo0689@protonmail.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Meng-Bo",

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v5.19-rc7]
[cannot apply to soc/for-next next-20220722]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lin-Meng-Bo/Add-Samsung-Galaxy-E5-E7-Grand-Max-device-trees/20220722-075631
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220723/202207231229.wqK1Zic2-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/00d1983861bc6f4389e307fe7758e3b0329b6222
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Lin-Meng-Bo/Add-Samsung-Galaxy-E5-E7-Grand-Max-device-trees/20220722-075631
        git checkout 00d1983861bc6f4389e307fe7758e3b0329b6222
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi:36.2-22 Properties must precede subnodes
   FATAL ERROR: Unable to parse input tree

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
