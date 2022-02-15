Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6294A4B6E00
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 14:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238430AbiBONsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 08:48:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238424AbiBONsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 08:48:04 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624BFE026;
        Tue, 15 Feb 2022 05:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644932874; x=1676468874;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sOvWmHCfNTGwnxKIrR6Zs268ld65whSnGZFHC7shh/M=;
  b=JbYuFLgc9zNl3mM981Vsp85HF4nKzrk+uP/lzs5Aqff1gO8rtrcpEQAN
   SrIXiIelVUbpHje6D2LHsoZc/2c9vNwIekeYiqjqZ/zfu3lfePbJZwMNu
   JdIE/OKaJ/EAOY3QBXlsPoYZ8m0tzbobBFxJrOMLA+mi2jkU+BTa7sUKi
   Y3/WXubh5qkbUcYX0todPqrJpNjhw2YdP52zbEfnhKHhhMIYwpOL8w8AZ
   EruFZ/yuSflL1E6yqWjH3h7D9d64lJmHGie3KhgXExrvEJzOcJtbH1Mp+
   bX5WjRbD+qQw38MluFGxVKRhJA9yjyzG9XqAMx/OLDMFprvX0jKvXKQZx
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="247949062"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="247949062"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 05:47:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="681038721"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 15 Feb 2022 05:47:50 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJyBK-0009hq-7O; Tue, 15 Feb 2022 13:47:50 +0000
Date:   Tue, 15 Feb 2022 21:46:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Satya Priya <quic_c_skakit@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        quic_jprakash@quicinc.com, Satya Priya <quic_c_skakit@quicinc.com>
Subject: Re: [PATCH V6 3/6] mfd: pm8008: Add mfd cell struct to register LDOs
Message-ID: <202202152150.MRo3NhGR-lkp@intel.com>
References: <1644915231-7308-4-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644915231-7308-4-git-send-email-quic_c_skakit@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Satya,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20220214]
[also build test ERROR on v5.17-rc4]
[cannot apply to robh/for-next broonie-regulator/for-next lee-mfd/for-mfd-next v5.17-rc4 v5.17-rc3 v5.17-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Satya-Priya/Add-Qualcomm-Technologies-Inc-PM8008-regulator-driver/20220215-165525
base:    259cbfc98c55ba3b6ef6e61fb7cfc3751dfded1e
config: i386-randconfig-a005-20220214 (https://download.01.org/0day-ci/archive/20220215/202202152150.MRo3NhGR-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 37f422f4ac31c8b8041c6b62065263314282dab6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/12b686033a10eae2956b1c8436bfaa8c411baa92
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Satya-Priya/Add-Qualcomm-Technologies-Inc-PM8008-regulator-driver/20220215-165525
        git checkout 12b686033a10eae2956b1c8436bfaa8c411baa92
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/mfd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/mfd/qcom-pm8008.c:270:38: error: expected ';' after top level declarator
   MODULE_DEVICE_TABLE(of, pm8008_match)
                                        ^
                                        ;
   1 error generated.


vim +270 drivers/mfd/qcom-pm8008.c

   265	
   266	static const struct of_device_id pm8008_match[] = {
   267		{ .compatible = "qcom,pm8008", .data = (void *)PM8008_INFRA},
   268		{ .compatible = "qcom,pm8008-regulators", .data = (void *)PM8008_REGULATORS},
   269	};
 > 270	MODULE_DEVICE_TABLE(of, pm8008_match)
   271	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
