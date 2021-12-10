Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF1F46F989
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 04:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbhLJDSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 22:18:37 -0500
Received: from mga12.intel.com ([192.55.52.136]:59045 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231277AbhLJDSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 22:18:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639106102; x=1670642102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I+q/DqXldwHz9cyiUYWrfRwsQh9NHxK0ytftOvAtfmo=;
  b=X3VG1/Y6ROtR3QpQ9sEjOTOUidu/KzNnz1Cj8ano3JD23h6XiOJLeqMK
   SzECHWV2FBBPvynXiQLrsHvpxRlefv8K7r/Y5AK1Ees7ONJATLq4d6vN+
   OiubU+kkEc6rqoW6p/V1dtaBrjU79EqXRPDQgLTMoQPsIyZeO2npMjyhQ
   /9GQtAHEYDdx4arZVELvuhoNX3gOWmOX2c/G6nl1apTHUUlsnJdReA1Lw
   xje4vpfpCwBekaMHv23QVKazlZ7hcHxPMv3Hrdv7QzD0moJjg2+sL5ncK
   Upmhr4Bd1Jh7LEA4bvlYLXBHrLLKhQZFOxBAk8RL7/bM+BkSJshYwriy4
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="218285298"
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="218285298"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 19:14:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="543829948"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 09 Dec 2021 19:14:53 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvWN1-0002hQ-86; Fri, 10 Dec 2021 03:14:51 +0000
Date:   Fri, 10 Dec 2021 11:13:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/13] arm64: dts: qcom: Add base SM8450 QRD DTS
Message-ID: <202112101124.H3KNjjaf-lkp@intel.com>
References: <20211209103505.197453-6-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209103505.197453-6-vkoul@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

I love your patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v5.16-rc4]
[cannot apply to next-20211208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Vinod-Koul/arm64-dts-qcom-Add-support-for-SM8450-SoC-and-QRD-board/20211209-183713
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-randconfig-r022-20211207 (https://download.01.org/0day-ci/archive/20211210/202112101124.H3KNjjaf-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/636d2456715b3aba9cf1fa47931c6e381ca62e00
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Vinod-Koul/arm64-dts-qcom-Add-support-for-SM8450-SoC-and-QRD-board/20211209-183713
        git checkout 636d2456715b3aba9cf1fa47931c6e381ca62e00
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/qcom/sm8450-qrd.dts:8:
>> arch/arm64/boot/dts/qcom/sm8450.dtsi:7:10: fatal error: 'dt-bindings/clock/qcom,gcc-sm8450.h' file not found
   #include <dt-bindings/clock/qcom,gcc-sm8450.h>
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +7 arch/arm64/boot/dts/qcom/sm8450.dtsi

244741584ca1ceb Vinod Koul 2021-12-09  @7  #include <dt-bindings/clock/qcom,gcc-sm8450.h>
244741584ca1ceb Vinod Koul 2021-12-09   8  #include <dt-bindings/clock/qcom,rpmh.h>
244741584ca1ceb Vinod Koul 2021-12-09   9  #include <dt-bindings/gpio/gpio.h>
244741584ca1ceb Vinod Koul 2021-12-09  10  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
244741584ca1ceb Vinod Koul 2021-12-09  11  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
