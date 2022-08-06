Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF2258B30B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 02:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241450AbiHFA0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 20:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241414AbiHFA0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 20:26:41 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D59186DA;
        Fri,  5 Aug 2022 17:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659745600; x=1691281600;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V7WkwMRtvzgnOUB9B91sjg30DJM30XVkzNMiGpG+Zm0=;
  b=ULgoFTKVmGhyhdZx8POJGHTYZ7kiJVgoQV2Ob8+bb5o6DpRZV+eYEFr7
   9Tmu9ciY9+9k+gDgpQ8ANZV2SZiXXdjIFkF0bfeUm4YygxtrFBMxJNdeS
   FTWHKijPJsuzf/B2dSxB1fw8ycIPfNmnSUXb6pf8qMPmg8zVfaUlTQbLV
   u792zqwihyLto6GbnLoVDRwEgJ6GgqKX4uHe+UPsUWw+HfPYtXkBeeCe0
   xVIenC5fGb4r+i8hoXSfCrmjQA0WqAa8pqsCQHs0Vvsx0/QLoX2GGkF9G
   JRytBVrAr8bWL5t2PUkupjbWlX9UYUqdUDAC4RGpCP6h26rkeq07Xy5JW
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="273368296"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="273368296"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 17:26:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="636673589"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 05 Aug 2022 17:26:36 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oK7eG-000Jqf-0r;
        Sat, 06 Aug 2022 00:26:36 +0000
Date:   Sat, 6 Aug 2022 08:26:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Dooks <ben.dooks@sifive.com>, linux-pwm@vger.kernel.org
Cc:     kbuild-all@lists.01.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha --subject-prefix=PATCH v3 
        <jude.onyenegecha@sifive.com>, Ben Dooks <ben.dooks@sifive.com>
Subject: Re: [PATCH 4/8] pwm: dwc: add of/platform support
Message-ID: <202208060853.DyMRfoge-lkp@intel.com>
References: <20220805165033.140958-5-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805165033.140958-5-ben.dooks@sifive.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

I love your patch! Perhaps something to improve:

[auto build test WARNING on thierry-reding-pwm/for-next]
[also build test WARNING on linus/master v5.19 next-20220805]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ben-Dooks/dt-bindings-pwm-Document-Synopsys-DesignWare-snps-pwm-dw-apb-timers-pwm2/20220806-015142
base:   https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git for-next
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220806/202208060853.DyMRfoge-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3bd100d711908b7d16a2c4793b4f5b597acb8d7f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ben-Dooks/dt-bindings-pwm-Document-Synopsys-DesignWare-snps-pwm-dw-apb-timers-pwm2/20220806-015142
        git checkout 3bd100d711908b7d16a2c4793b4f5b597acb8d7f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/pwm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/pwm/pwm-dwc.c:321:1: warning: data definition has no type or storage class
     321 | module_pci_driver(dwc_pwm_driver);
         | ^~~~~~~~~~~~~~~~~
   drivers/pwm/pwm-dwc.c:321:1: error: type defaults to 'int' in declaration of 'module_pci_driver' [-Werror=implicit-int]
>> drivers/pwm/pwm-dwc.c:321:1: warning: parameter names (without types) in function declaration
   drivers/pwm/pwm-dwc.c:311:26: warning: 'dwc_pwm_driver' defined but not used [-Wunused-variable]
     311 | static struct pci_driver dwc_pwm_driver = {
         |                          ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +321 drivers/pwm/pwm-dwc.c

1ed2b3fca64516 Jarkko Nikula 2020-10-02  320  
1ed2b3fca64516 Jarkko Nikula 2020-10-02 @321  module_pci_driver(dwc_pwm_driver);
1ed2b3fca64516 Jarkko Nikula 2020-10-02  322  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
