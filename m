Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726454A5589
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 04:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbiBADQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 22:16:23 -0500
Received: from mga03.intel.com ([134.134.136.65]:35755 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229666AbiBADQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 22:16:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643685377; x=1675221377;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+58W84POIAKDAtX67Wjd5ewA4HIW4GyJQ49bfc81Afg=;
  b=ko5/3Qj/MKAxFBEBMaD1RLsd2NVS+OPQMvevSslC/A1MmVLQ3LYa/52d
   TN4DeJC9kdinZnPjx70QUSmx43J2W01yj6PJ3v3EkAEzyWLjQgqDrjyqb
   kWKEQGyzQSdHvmebFt08gn0w60ZNrNDM7W1WPhcpQEMCB75hdtrQmYvPq
   LerTH4Oa7RdQlDzifkwg7lKTGlRK5BKiLMupjN9OQr8prRs/99iwj9rrg
   G8jsBkoVEzXS2e3gBkMq8LLNuXhndsQaevsTJMSVij3tt/gp3AeS1TKmn
   Q/cfwIwxuC/gjAHrtpKqSxdQpjaWpJ7CQuQldm2ZnPVNBZ4CF28UPDjLN
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="247564615"
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="247564615"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 19:16:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="522903186"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 31 Jan 2022 19:16:14 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEjeP-000ShE-J9; Tue, 01 Feb 2022 03:16:13 +0000
Date:   Tue, 1 Feb 2022 11:16:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Taniya Das <tdas@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: Add lpasscore & lpassaudio
 clock controllers
Message-ID: <202202011153.xR4ChtoP-lkp@intel.com>
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
config: arm64-randconfig-r003-20220130 (https://download.01.org/0day-ci/archive/20220201/202202011153.xR4ChtoP-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 2cdbaca3943a4d6259119f185656328bd3805b68)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/267104167c342dc01741424eaa26a44754a5c4e9
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Taniya-Das/arm64-dts-qcom-sc7280-Add-lpasscore-lpassaudio-clock-controllers/20220201-022909
        git checkout 267104167c342dc01741424eaa26a44754a5c4e9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/qcom/sc7280-herobrine.dts:8:
   In file included from arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi:18:
>> arch/arm64/boot/dts/qcom/sc7280.dtsi:11:10: fatal error: 'dt-bindings/clock/qcom,lpassaudiocc-sc7280.h' file not found
   #include <dt-bindings/clock/qcom,lpassaudiocc-sc7280.h>
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


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
