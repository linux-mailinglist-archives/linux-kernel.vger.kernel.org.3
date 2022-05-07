Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C5551E816
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 17:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446607AbiEGPRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 11:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382110AbiEGPRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 11:17:39 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1942D1FE;
        Sat,  7 May 2022 08:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651936432; x=1683472432;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SFrfLygWwaKz2niUDCJteyOlvqg0e03MT+XUWT0AuUQ=;
  b=DL/j5qcK8uvQVXsqw5lD87pV1QXWrlQPP9AGWqBiGoVtDNbtZvgiE5ZG
   a+rv2WaqX1TYnwl8buzKHNg5e/k7csztqq9/A4iQB2tc/7+E8qjgpOpGa
   8bDX2ZmQPOtnmOe/GT+mtAEJ3w6s5Qt2D2AW3EfZyDmd1BWA/2e+9/PM4
   i6JUGT5DEUNCrg+OGVEazyo3/EZxaMaeD5bRye2SBbXNHBg/dEW5e4989
   kofJ6ay7eqyphvGlfy3xlI7evpgq3n5MdC1Tef/+diuSRVkisUVguE0Bj
   Pq4IjFC1uCfN5UlHdkEq6EjycOoeQX0e0bvq4RaFkJQcI9CvgzbyEEC2G
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10340"; a="329271612"
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="scan'208";a="329271612"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 08:13:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="scan'208";a="709892109"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 07 May 2022 08:13:48 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnM7w-000Eg3-7k;
        Sat, 07 May 2022 15:13:48 +0000
Date:   Sat, 7 May 2022 23:13:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Satya Priya <quic_c_skakit@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     kbuild-all@lists.01.org, Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com,
        Satya Priya <quic_c_skakit@quicinc.com>
Subject: Re: [PATCH V11 7/9] regulator: Add a regulator driver for the PM8008
 PMIC
Message-ID: <202205072349.clMXCCaw-lkp@intel.com>
References: <1651742739-12338-8-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651742739-12338-8-git-send-email-quic_c_skakit@quicinc.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Satya,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on lee-mfd/for-mfd-next]
[also build test ERROR on robh/for-next broonie-regulator/for-next v5.18-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Satya-Priya/Add-Qualcomm-Technologies-Inc-PM8008-regulator-driver/20220505-173045
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20220507/202205072349.clMXCCaw-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/66f37a37cac5f149b7f08cc53508ca6363ea575a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Satya-Priya/Add-Qualcomm-Technologies-Inc-PM8008-regulator-driver/20220505-173045
        git checkout 66f37a37cac5f149b7f08cc53508ca6363ea575a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "pm8008_get_regmap" [drivers/regulator/qcom-pm8008-regulator.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
