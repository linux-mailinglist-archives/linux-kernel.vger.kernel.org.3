Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4384C4A546D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 02:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbiBABEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 20:04:09 -0500
Received: from mga02.intel.com ([134.134.136.20]:12886 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231382AbiBABEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 20:04:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643677447; x=1675213447;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DXtKer8mna4UgD1qVP9Kb07cnZkz86WOAt0lED8SSyE=;
  b=fzZJcQ/aLatjeiZMd8y2thLrmBPnr/snQLp4GFk/ggw7uywn9B92NCq7
   mNJNn+/vp5FQqyFtmuCGwaX2FWMFdAKz1YSYKuYcZIFnEE+f43ULL5LeJ
   cUWPUlPXXVB+cDh2FrmKw+kuKqi2I4CrzKwbwVTitlLLW3Bzw9YhaV2R7
   oUmeN8/6M3BQGam6kVyqrHCpS4qB5JDFQ2KMjjTNxRJBawfqDbVXrrgVz
   gSBCsMQwjy/6lePgQhFdZ6KEblTe1m62g4u4sO+zQhCvwPJLL1HMgpHhH
   Oe4H2yMxW51k9LGo2WWBHgnyvYb2XxIUoiWh4wlT/JsM91JEaY0qdKi4+
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="234989533"
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="234989533"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 17:04:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="599044194"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 31 Jan 2022 17:04:04 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEhaW-000SXb-88; Tue, 01 Feb 2022 01:04:04 +0000
Date:   Tue, 1 Feb 2022 09:03:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Taniya Das <tdas@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kbuild-all@lists.01.org, Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: Add lpasscore & lpassaudio
 clock controllers
Message-ID: <202202010945.Gqhv3bfz-lkp@intel.com>
References: <20220131182629.9235-1-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131182629.9235-1-tdas@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Taniya,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v5.17-rc2 next-20220131]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Taniya-Das/arm64-dts-qcom-sc7280-Add-lpasscore-lpassaudio-clock-controllers/20220201-022909
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-randconfig-m031-20220131 (https://download.01.org/0day-ci/archive/20220201/202202010945.Gqhv3bfz-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/267104167c342dc01741424eaa26a44754a5c4e9
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Taniya-Das/arm64-dts-qcom-sc7280-Add-lpasscore-lpassaudio-clock-controllers/20220201-022909
        git checkout 267104167c342dc01741424eaa26a44754a5c4e9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi:18,
                    from arch/arm64/boot/dts/qcom/sc7280-herobrine.dts:8:
>> arch/arm64/boot/dts/qcom/sc7280.dtsi:11:10: fatal error: dt-bindings/clock/qcom,lpassaudiocc-sc7280.h: No such file or directory
      11 | #include <dt-bindings/clock/qcom,lpassaudiocc-sc7280.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +11 arch/arm64/boot/dts/qcom/sc7280.dtsi

  > 11	#include <dt-bindings/clock/qcom,lpassaudiocc-sc7280.h>
    12	#include <dt-bindings/clock/qcom,lpasscorecc-sc7280.h>
    13	#include <dt-bindings/clock/qcom,rpmh.h>
    14	#include <dt-bindings/clock/qcom,videocc-sc7280.h>
    15	#include <dt-bindings/interconnect/qcom,sc7280.h>
    16	#include <dt-bindings/interrupt-controller/arm-gic.h>
    17	#include <dt-bindings/mailbox/qcom-ipcc.h>
    18	#include <dt-bindings/power/qcom-rpmpd.h>
    19	#include <dt-bindings/reset/qcom,sdm845-aoss.h>
    20	#include <dt-bindings/reset/qcom,sdm845-pdc.h>
    21	#include <dt-bindings/soc/qcom,rpmh-rsc.h>
    22	#include <dt-bindings/thermal/thermal.h>
    23	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
