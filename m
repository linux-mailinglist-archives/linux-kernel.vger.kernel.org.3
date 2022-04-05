Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9944F4911
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390043AbiDEWDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455041AbiDEP7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:59:33 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0AE1DF879;
        Tue,  5 Apr 2022 08:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649171321; x=1680707321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AeNd77QICNkAN7eq+CSDcjKHvEE427NmCwyTIIhpM+I=;
  b=YEaENLh7oWkCsnQpJGMx3sg55wdzwfV9SETKMHuGmqZonJWboqoJdiHL
   D/DLncZ4DRfLrbApLxuefSRu1kpWiKEaWJsuG2J84cp+MZNC/QXQrSd61
   kpSF0aN1V/VxrkmxHXudLvBRlyrkAZ8RVWUWTG1doDcrmnt1af260tNiM
   ikXkgdP1tk2myivyplvTlJfxCnQV2BItC5YMn36L0eDCFEly7mpMSBiId
   6vTHUzsUL10YviPuBOpo2F2OFcTAjvStEw1wvUYnbHYHB0lwhpGCv6W3I
   MHm5cYsch0LlPlQEs9t8YVJpJWtR7xtFWM/P5kC2Cw6HtW32FYozAcuWh
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="260947639"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="260947639"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 08:08:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="587959371"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 05 Apr 2022 08:08:12 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbkmx-0003SB-JR;
        Tue, 05 Apr 2022 15:08:11 +0000
Date:   Tue, 5 Apr 2022 23:07:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matteo Lisi <matteo.lisi@engicam.com>
Cc:     kbuild-all@lists.01.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
        Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Subject: Re: [PATCH 3/3] arm64: dts: imx8mp: Add Engicam i.Core MX8M Plus
 EDIMM2.2 Starter Kit
Message-ID: <202204052339.ieCONM1Z-lkp@intel.com>
References: <20220330191437.614065-4-abbaraju.manojsai@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330191437.614065-4-abbaraju.manojsai@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manoj,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on shawnguo/for-next krzk/for-next v5.18-rc1 next-20220405]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Manoj-Sai/add-support-for-engicam-icore-mx8m-plus-and-edimm2-2-starter-kit/20220331-031909
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-randconfig-r003-20220405 (https://download.01.org/0day-ci/archive/20220405/202204052339.ieCONM1Z-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/31bd60a72a241149df3e4fcb8f1055d2d0269335
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Manoj-Sai/add-support-for-engicam-icore-mx8m-plus-and-edimm2-2-starter-kit/20220331-031909
        git checkout 31bd60a72a241149df3e4fcb8f1055d2d0269335
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   also defined at arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dts:169.9-176.3
>> ERROR: Input tree has errors, aborting (use -f to force output)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
