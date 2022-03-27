Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6B64E8539
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 05:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbiC0DPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 23:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiC0DPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 23:15:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AC617AB0;
        Sat, 26 Mar 2022 20:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648350832; x=1679886832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/A6DpEcffmvgLm6q+sVR/U01n76qk67tk+U7N8uWM2I=;
  b=kNDb3eb+O9T5C2014Cl+fqTwwlgFyO2RrMtS6E5bjBiEkOe/Kw9wAAcY
   CtAP4cb20ry+K3W4+jaZoyPyI69wSsjpLFul4BxPxok3c4klDVO0hU/uF
   NcG9dX1cPwX3p5QbRl9fBmxOv99sE3NgjEztHryNrTxYBwXDYMH9JLimu
   DPR9HrW10Rp0B9tQwcrEZaw59mA6t4ICW/tVfH4FAZ+DSd/20EJx/TwaF
   1zQUD3p+Y2rLM5Hzvz6wMBnXOifd6icxyixCWglHV4RT5kj6T3YrLEc9e
   0oYc1LXd8yvsDQHuDZamizPEAzbdJVWacnMHcq+zUMFO99BV339ps5ERX
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10298"; a="259008006"
X-IronPort-AV: E=Sophos;i="5.90,214,1643702400"; 
   d="scan'208";a="259008006"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 20:13:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,214,1643702400"; 
   d="scan'208";a="562289030"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 26 Mar 2022 20:13:48 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYJLg-0000gH-1W; Sun, 27 Mar 2022 03:13:48 +0000
Date:   Sun, 27 Mar 2022 11:13:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Walle <michael@walle.cc>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v1 4/4] hwmon: add driver for the Microchip LAN966x SoC
Message-ID: <202203271141.S44Wx3yF-lkp@intel.com>
References: <20220326192347.2940747-5-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220326192347.2940747-5-michael@walle.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

I love your patch! Perhaps something to improve:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on robh/for-next linus/master v5.17 next-20220325]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-Walle/hwmon-add-lan9668-driver/20220327-032606
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
config: sparc64-randconfig-s031-20220327 (https://download.01.org/0day-ci/archive/20220327/202203271141.S44Wx3yF-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/cfef456b1f1b1ab545a03f098e209aff8ae507b7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Michael-Walle/hwmon-add-lan9668-driver/20220327-032606
        git checkout cfef456b1f1b1ab545a03f098e209aff8ae507b7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc64 SHELL=/bin/bash drivers/hwmon/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/hwmon/lan966x-hwmon.c:302:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected struct regmap * @@     got void [noderef] __iomem *[assigned] base @@
   drivers/hwmon/lan966x-hwmon.c:302:24: sparse:     expected struct regmap *
   drivers/hwmon/lan966x-hwmon.c:302:24: sparse:     got void [noderef] __iomem *[assigned] base

vim +302 drivers/hwmon/lan966x-hwmon.c

   289	
   290	static struct regmap *lan966x_init_regmap(struct platform_device *pdev,
   291						  const char *name)
   292	{
   293		struct regmap_config regmap_config = {
   294			.reg_bits = 32,
   295			.reg_stride = 4,
   296			.val_bits = 32,
   297		};
   298		void __iomem *base;
   299	
   300		base = devm_platform_ioremap_resource_byname(pdev, name);
   301		if (IS_ERR(base))
 > 302			return base;
   303	
   304		regmap_config.name = name;
   305	
   306		return devm_regmap_init_mmio(&pdev->dev, base, &regmap_config);
   307	}
   308	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
