Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE22950EECF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 04:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242470AbiDZChT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 22:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiDZChQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 22:37:16 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F1912635C;
        Mon, 25 Apr 2022 19:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650940450; x=1682476450;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5JFNg6jFJJro93J2ti17S2dZknlyG6NInv6FUGPwQR0=;
  b=bMlNKxUs1/St7A7UNlpByPEdZgWrgoC2yjrj1d2QNDwqPHuVaaTqUime
   m1uMEXdhL6X0NHnZim1Uq3hfwY8X29egi2Q2HVJa9xAW6iDudT4IS7GIw
   lr/H7XZ1oB9QcmQCChiF3sXTUOQT8OvLnGR4z2VNQi9BA49kkINf7RMkc
   ynuJTH2/jZDHiMZtt7N7L1S2hg+UiBUTguEkdP/PFHCw7HOgDX9KrDmtC
   P9dh/DxUKlsywNPYp+Diqs6MAaR8QqBul8JWuASBIy6TkT6VRe93MYjvQ
   /a/WHXbn3uS463kCLsxsKVSakC+5hUWwNfYbH2m9dS7KPJNplDI1q3mG9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="247355058"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="247355058"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 19:34:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="595523919"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 Apr 2022 19:34:05 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njB1h-00039e-8g;
        Tue, 26 Apr 2022 02:34:05 +0000
Date:   Tue, 26 Apr 2022 10:33:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kbuild-all@lists.01.org, Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Clark <robdclark@chromium.org>, quic_kalyant@quicinc.com,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: eDP for herobrine boards
Message-ID: <202204261039.8xYr3fIO-lkp@intel.com>
References: <20220425153650.1.Iedd71976a78d53c301ce0134832de95a989c9195@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425153650.1.Iedd71976a78d53c301ce0134832de95a989c9195@changeid>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Douglas,

I love your patch! Yet something to improve:

[auto build test ERROR on next-20220422]
[cannot apply to robh/for-next v5.18-rc4 v5.18-rc3 v5.18-rc2 v5.18-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Douglas-Anderson/arm64-dts-qcom-sc7280-eDP-for-herobrine-boards/20220426-064439
base:    e7d6987e09a328d4a949701db40ef63fbb970670
config: arm64-randconfig-r014-20220425 (https://download.01.org/0day-ci/archive/20220426/202204261039.8xYr3fIO-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e620a809a54d1f68056bfee27b7902f96dfa8cf3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Douglas-Anderson/arm64-dts-qcom-sc7280-eDP-for-herobrine-boards/20220426-064439
        git checkout e620a809a54d1f68056bfee27b7902f96dfa8cf3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi:345.1-13 Label or path pm8350c_pwm not found
>> Error: arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi:448.1-13 Label or path pm8350c_pwm not found
>> FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
