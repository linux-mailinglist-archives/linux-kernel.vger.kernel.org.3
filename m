Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4B851DE63
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 19:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444219AbiEFRgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 13:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444142AbiEFRgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 13:36:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FE05047B;
        Fri,  6 May 2022 10:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651858347; x=1683394347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RJIpyH4aTtIDi9aTnRTxdWTTpZ/zrmSOQtRCRTJZbRw=;
  b=iTnFYc4gmZeuC0UJYgs0IHP/gXEyWLz5sU5Aae/3yIdSAGaEhjYehT2P
   jtR7dnX5e3opm0UFej3f3BerB90zB1Ty0Xfg+TUpOIl1q+1qfD31Ou/jx
   8ZEc0HOp1TUQLfSrgytNjrMNCJU1p+WReTiehU+7RY8hueiTb86hMv1rE
   rIL3TDSCj6caMQXFsq3rW9ownSDu7LYDeMzPROrcZ1ZvbK+PCyjLN5XfC
   wGyPDspl9U6bQ6KjeyKPdzCEV8MWe++tG0+cePTP7J58uq53hm3pmmObN
   qcmBguNYF/C4yQC22M7u1kTZcWlZYGH/kKII92lVG/Bku3bOYaLLxg1vs
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="268425255"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="268425255"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 10:32:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="812475599"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 06 May 2022 10:32:23 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nn1oV-000DiS-2G;
        Fri, 06 May 2022 17:32:23 +0000
Date:   Sat, 7 May 2022 01:31:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     kbuild-all@lists.01.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom: msm8974-FP2: Add notification LED
Message-ID: <202205070100.8DCDwfSb-lkp@intel.com>
References: <20220505163029.6541-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505163029.6541-1-luca@z3ntu.xyz>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20220505]
[cannot apply to robh/for-next v5.18-rc5 v5.18-rc4 v5.18-rc3 v5.18-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Luca-Weiss/ARM-dts-qcom-msm8974-FP2-Add-notification-LED/20220506-003524
base:    632a8c88e339fe86ae6e420a24dfc641d4dd0ab5
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220507/202205070100.8DCDwfSb-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/45445147f88f2416d7bc32c8a72c714818fe466c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Luca-Weiss/ARM-dts-qcom-msm8974-FP2-Add-notification-LED/20220506-003524
        git checkout 45445147f88f2416d7bc32c8a72c714818fe466c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts:123.1-12 Label or path pm8941_lpg not found
   FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
