Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9535319FD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245128AbiEWSRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343809AbiEWSIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 14:08:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9703956757;
        Mon, 23 May 2022 10:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653328307; x=1684864307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uZr5P/6fGVrb/f5Wy8Y9usW4kb9alNg7rTyBMTx9lZg=;
  b=QmzIs7y/McxjsHdj4Sx6bThXikeIis/i8LcrhE2Y5qKx+VYjp2ntv005
   TFy5Hj2i39SRFjvS01J49p2oQJkInGVKaBkZkvS4A0L5qcZasuC7mVzfo
   H6RfDneNP+njpT5Q2JPNLGaoG5qTQ0/Mghrruh9SNSYNciXDR49xRx6P0
   ZAsperglivIArlazk8lboqP60YIV6GD+7xldBLeab5UT4B8To/cib43k/
   smeh9XwrF+X+36BnOyoG/gIPLbGqvw3zib33DdQ8hZcbgVqbWWgHhbOVF
   c0nzF7ZOJ+5QLLvp07CrHk5Dr2BMdm3jVsRxc9+1ZriDpGefNQvEv7m9p
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="270876862"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="270876862"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 10:51:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="716816774"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 23 May 2022 10:51:13 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntCD3-0001KQ-9H;
        Mon, 23 May 2022 17:51:13 +0000
Date:   Tue, 24 May 2022 01:50:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Taniya Das <quic_tdas@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kbuild-all@lists.01.org, Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <quic_tdas@quicinc.com>
Subject: Re: [PATCH v5] arm64: dts: qcom: sc7280: Add lpasscore & lpassaudio
 clock controllers
Message-ID: <202205240130.JscI0RkD-lkp@intel.com>
References: <20220523100058.26241-1-quic_tdas@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523100058.26241-1-quic_tdas@quicinc.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Taniya,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v5.18]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Taniya-Das/arm64-dts-qcom-sc7280-Add-lpasscore-lpassaudio-clock-controllers/20220523-180437
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-randconfig-r026-20220522 (https://download.01.org/0day-ci/archive/20220524/202205240130.JscI0RkD-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6a56b4899f4e80f53613ce8e9569e2d1ca46f46a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Taniya-Das/arm64-dts-qcom-sc7280-Add-lpasscore-lpassaudio-clock-controllers/20220523-180437
        git checkout 6a56b4899f4e80f53613ce8e9569e2d1ca46f46a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts:17:
>> arch/arm64/boot/dts/qcom/sc7280.dtsi:11:10: fatal error: dt-bindings/clock/qcom,lpassaudiocc-sc7280.h: No such file or directory
      11 | #include <dt-bindings/clock/qcom,lpassaudiocc-sc7280.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +11 arch/arm64/boot/dts/qcom/sc7280.dtsi

  > 11	#include <dt-bindings/clock/qcom,lpassaudiocc-sc7280.h>
    12	#include <dt-bindings/clock/qcom,lpasscorecc-sc7280.h>
    13	#include <dt-bindings/clock/qcom,rpmh.h>
    14	#include <dt-bindings/clock/qcom,videocc-sc7280.h>
    15	#include <dt-bindings/gpio/gpio.h>
    16	#include <dt-bindings/interconnect/qcom,osm-l3.h>
    17	#include <dt-bindings/interconnect/qcom,sc7280.h>
    18	#include <dt-bindings/interrupt-controller/arm-gic.h>
    19	#include <dt-bindings/mailbox/qcom-ipcc.h>
    20	#include <dt-bindings/power/qcom-rpmpd.h>
    21	#include <dt-bindings/reset/qcom,sdm845-aoss.h>
    22	#include <dt-bindings/reset/qcom,sdm845-pdc.h>
    23	#include <dt-bindings/soc/qcom,rpmh-rsc.h>
    24	#include <dt-bindings/thermal/thermal.h>
    25	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
