Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6434854FE09
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 22:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbiFQT77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 15:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234782AbiFQT76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:59:58 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD935A083
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655495997; x=1687031997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I6O+tT1WKTABORDiTianGo1w70+VipMrQwG+yDREyqo=;
  b=mHghCJ6Ynil7k591Bn1lFNU0ioP1d7qW2+81wZSM3d52LOFeLhluqFoX
   Ms1TV+VB0cgXOh9btjBmngu7kOvsIBh1tonWf+le3xo3ce0mQp9KI5rM/
   CCCBwcmJ5wD/bFifIXToW9kNQwYVad9xbrkjPhYHR95JSMm+esTH9FfJj
   lma2GtZgLELA5tjaHmuAOuP7dLGv0a6CfRXHEB9OhKoosvAXr2ryhdKvm
   K9YcBj9J/w66ZGR7gRGRH10ig0DpUJ5zK+iNOaOZPDjGo37Z+9bOIUlDa
   1dwEMtYVoMsHMERzA3RKD0R6GOxL9JoiIRjAbhnv9srf5HIFPc1oTNt+o
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="341259408"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="341259408"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 12:59:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="688445106"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 17 Jun 2022 12:59:54 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2I8H-000Pij-Jp;
        Fri, 17 Jun 2022 19:59:53 +0000
Date:   Sat, 18 Jun 2022 03:59:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, mark.rutland@arm.com
Cc:     kbuild-all@lists.01.org, baolin.wang@linux.alibaba.com,
        yaohongbo@linux.alibaba.com, nengchen@linux.alibaba.com,
        zhuo.song@linux.alibaba.com
Subject: Re: [PATCH v1 2/3] drivers/perf: add DDR Sub-System Driveway PMU
 driver for Yitian 710 SoC
Message-ID: <202206180343.eGENefte-lkp@intel.com>
References: <20220617111825.92911-3-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617111825.92911-3-xueshuai@linux.alibaba.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuai,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on soc/for-next]
[also build test WARNING on linus/master v5.19-rc2 next-20220617]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Shuai-Xue/drivers-perf-add-DDR-Sub-System-Driveway-PMU-driver-for-Yitian-710-SoC/20220617-192123
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220618/202206180343.eGENefte-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/641441c43a62293dd0bae407fda7c229e8689617
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Shuai-Xue/drivers-perf-add-DDR-Sub-System-Driveway-PMU-driver-for-Yitian-710-SoC/20220617-192123
        git checkout 641441c43a62293dd0bae407fda7c229e8689617
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/perf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/perf/alibaba_uncore_drw_pmu.c:97:9: warning: no previous prototype for 'ali_drw_pmu_format_show' [-Wmissing-prototypes]
      97 | ssize_t ali_drw_pmu_format_show(struct device *dev,
         |         ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/perf/alibaba_uncore_drw_pmu.c:110:9: warning: no previous prototype for 'ali_drw_pmu_event_show' [-Wmissing-prototypes]
     110 | ssize_t ali_drw_pmu_event_show(struct device *dev,
         |         ^~~~~~~~~~~~~~~~~~~~~~


vim +/ali_drw_pmu_format_show +97 drivers/perf/alibaba_uncore_drw_pmu.c

    96	
  > 97	ssize_t ali_drw_pmu_format_show(struct device *dev,
    98					struct device_attribute *attr, char *buf)
    99	{
   100		struct dev_ext_attribute *eattr;
   101	
   102		eattr = container_of(attr, struct dev_ext_attribute, attr);
   103	
   104		return sprintf(buf, "%s\n", (char *)eattr->var);
   105	}
   106	
   107	/*
   108	 * PMU event attributes
   109	 */
 > 110	ssize_t ali_drw_pmu_event_show(struct device *dev,
   111					struct device_attribute *attr, char *page)
   112	{
   113		struct dev_ext_attribute *eattr;
   114	
   115		eattr = container_of(attr, struct dev_ext_attribute, attr);
   116	
   117		return sprintf(page, "config=0x%lx\n", (unsigned long)eattr->var);
   118	}
   119	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
