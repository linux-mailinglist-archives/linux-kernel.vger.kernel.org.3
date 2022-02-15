Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1364B6EB9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238577AbiBOOTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:19:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbiBOOTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:19:06 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9B6B16D3;
        Tue, 15 Feb 2022 06:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644934736; x=1676470736;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=orXD2LKbgOOvkF5cZIbblDrtOCqS+mecgx/2vVgqzeg=;
  b=dQ221f7RBdHamEGjA4ZwlQzgVXMhh85r/wU7GIiJtSM59ZzbOnQijcf+
   SkwLpwkI2XDPwf4wUZwLjkO1yYUJKarA9deXXUInvZ28dLRNrJUFv1RoL
   omsYeVBdjJD2FKIA926ypYW2PfXulPWoSlLH515uWu4VzVXKT+dyLbwx0
   ONHIJQPzbHu3WVLeG8R7tsiaqbQfVSS1TyQwuxHmP9hjrtNTHGBoxjNqW
   NbTFd88KANa2siTC7B2A+Z/IUNC3KxqmsrHtRbsWwPIRTCOOImCSBaL+/
   UkOhnlHhVcM4dEObQvZ2sqb9bpFj4Kf9hCmLUfFYSwqWUrFtnr6TrrdH0
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="230987963"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="230987963"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 06:18:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="486195062"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 15 Feb 2022 06:18:51 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJyfL-0009k8-3w; Tue, 15 Feb 2022 14:18:51 +0000
Date:   Tue, 15 Feb 2022 22:18:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Satya Priya <quic_c_skakit@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     kbuild-all@lists.01.org, Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        quic_jprakash@quicinc.com, Satya Priya <quic_c_skakit@quicinc.com>
Subject: Re: [PATCH V6 3/6] mfd: pm8008: Add mfd cell struct to register LDOs
Message-ID: <202202152228.Mmfx9SWj-lkp@intel.com>
References: <1644915231-7308-4-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644915231-7308-4-git-send-email-quic_c_skakit@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

[auto build test ERROR on next-20220214]
[also build test ERROR on v5.17-rc4]
[cannot apply to robh/for-next broonie-regulator/for-next lee-mfd/for-mfd-next v5.17-rc4 v5.17-rc3 v5.17-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Satya-Priya/Add-Qualcomm-Technologies-Inc-PM8008-regulator-driver/20220215-165525
base:    259cbfc98c55ba3b6ef6e61fb7cfc3751dfded1e
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220215/202202152228.Mmfx9SWj-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/12b686033a10eae2956b1c8436bfaa8c411baa92
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Satya-Priya/Add-Qualcomm-Technologies-Inc-PM8008-regulator-driver/20220215-165525
        git checkout 12b686033a10eae2956b1c8436bfaa8c411baa92
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash drivers/mfd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/mfd/qcom-pm8008.c:272:1: error: expected ',' or ';' before 'static'
     272 | static struct i2c_driver pm8008_mfd_driver = {
         | ^~~~~~
   In file included from drivers/mfd/qcom-pm8008.c:7:
   drivers/mfd/qcom-pm8008.c: In function 'pm8008_mfd_driver_init':
>> drivers/mfd/qcom-pm8008.c:279:19: error: 'pm8008_mfd_driver' undeclared (first use in this function); did you mean 'pm8008_mfd_driver_init'?
     279 | module_i2c_driver(pm8008_mfd_driver);
         |                   ^~~~~~~~~~~~~~~~~
   include/linux/i2c.h:886:42: note: in definition of macro 'i2c_add_driver'
     886 |         i2c_register_driver(THIS_MODULE, driver)
         |                                          ^~~~~~
   include/linux/i2c.h:954:9: note: in expansion of macro 'module_driver'
     954 |         module_driver(__i2c_driver, i2c_add_driver, \
         |         ^~~~~~~~~~~~~
   drivers/mfd/qcom-pm8008.c:279:1: note: in expansion of macro 'module_i2c_driver'
     279 | module_i2c_driver(pm8008_mfd_driver);
         | ^~~~~~~~~~~~~~~~~
   drivers/mfd/qcom-pm8008.c:279:19: note: each undeclared identifier is reported only once for each function it appears in
     279 | module_i2c_driver(pm8008_mfd_driver);
         |                   ^~~~~~~~~~~~~~~~~
   include/linux/i2c.h:886:42: note: in definition of macro 'i2c_add_driver'
     886 |         i2c_register_driver(THIS_MODULE, driver)
         |                                          ^~~~~~
   include/linux/i2c.h:954:9: note: in expansion of macro 'module_driver'
     954 |         module_driver(__i2c_driver, i2c_add_driver, \
         |         ^~~~~~~~~~~~~
   drivers/mfd/qcom-pm8008.c:279:1: note: in expansion of macro 'module_i2c_driver'
     279 | module_i2c_driver(pm8008_mfd_driver);
         | ^~~~~~~~~~~~~~~~~
   In file included from include/linux/device.h:32,
                    from include/linux/acpi.h:15,
                    from include/linux/i2c.h:13,
                    from drivers/mfd/qcom-pm8008.c:7:
   drivers/mfd/qcom-pm8008.c: In function 'pm8008_mfd_driver_exit':
   drivers/mfd/qcom-pm8008.c:279:19: error: 'pm8008_mfd_driver' undeclared (first use in this function); did you mean 'pm8008_mfd_driver_exit'?
     279 | module_i2c_driver(pm8008_mfd_driver);
         |                   ^~~~~~~~~~~~~~~~~
   include/linux/device/driver.h:267:24: note: in definition of macro 'module_driver'
     267 |         __unregister(&(__driver) , ##__VA_ARGS__); \
         |                        ^~~~~~~~
   drivers/mfd/qcom-pm8008.c:279:1: note: in expansion of macro 'module_i2c_driver'
     279 | module_i2c_driver(pm8008_mfd_driver);
         | ^~~~~~~~~~~~~~~~~
   drivers/mfd/qcom-pm8008.c: In function 'pm8008_mfd_driver_init':
   include/linux/device/driver.h:263:1: error: control reaches end of non-void function [-Werror=return-type]
     263 | } \
         | ^
   include/linux/i2c.h:954:9: note: in expansion of macro 'module_driver'
     954 |         module_driver(__i2c_driver, i2c_add_driver, \
         |         ^~~~~~~~~~~~~
   drivers/mfd/qcom-pm8008.c:279:1: note: in expansion of macro 'module_i2c_driver'
     279 | module_i2c_driver(pm8008_mfd_driver);
         | ^~~~~~~~~~~~~~~~~
   At top level:
   drivers/mfd/qcom-pm8008.c:230:12: warning: 'pm8008_probe' defined but not used [-Wunused-function]
     230 | static int pm8008_probe(struct i2c_client *client)
         |            ^~~~~~~~~~~~
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for SND_SOC_LPASS_RX_MACRO
   Depends on SOUND && !UML && SND && SND_SOC && COMMON_CLK
   Selected by
   - SND_SOC_SC7280 && SOUND && !UML && SND && SND_SOC && SND_SOC_QCOM && (I2C && SOUNDWIRE || COMPILE_TEST
   WARNING: unmet direct dependencies detected for SND_SOC_LPASS_TX_MACRO
   Depends on SOUND && !UML && SND && SND_SOC && COMMON_CLK
   Selected by
   - SND_SOC_SC7280 && SOUND && !UML && SND && SND_SOC && SND_SOC_QCOM && (I2C && SOUNDWIRE || COMPILE_TEST


vim +272 drivers/mfd/qcom-pm8008.c

6b149f3310a466 Guru Das Srinagesh 2021-05-25  271  
6b149f3310a466 Guru Das Srinagesh 2021-05-25 @272  static struct i2c_driver pm8008_mfd_driver = {
6b149f3310a466 Guru Das Srinagesh 2021-05-25  273  	.driver = {
6b149f3310a466 Guru Das Srinagesh 2021-05-25  274  		.name = "pm8008",
6b149f3310a466 Guru Das Srinagesh 2021-05-25  275  		.of_match_table = pm8008_match,
6b149f3310a466 Guru Das Srinagesh 2021-05-25  276  	},
6b149f3310a466 Guru Das Srinagesh 2021-05-25  277  	.probe_new = pm8008_probe,
6b149f3310a466 Guru Das Srinagesh 2021-05-25  278  };
6b149f3310a466 Guru Das Srinagesh 2021-05-25 @279  module_i2c_driver(pm8008_mfd_driver);
6b149f3310a466 Guru Das Srinagesh 2021-05-25  280  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
