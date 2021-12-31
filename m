Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFCC48261B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 00:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhLaXPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 18:15:19 -0500
Received: from mga03.intel.com ([134.134.136.65]:61946 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230094AbhLaXPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 18:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640992519; x=1672528519;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ss1AmmwAamG5zaDC3MSix1KO5b50rmc1BE1GSp6jhXA=;
  b=GdGiQLgaInqeaBBneVNTYQtz1b7IQg9tlecdc9iNnGr1ya6+GBnIjZkv
   wKE4dW3ceqCQAHv3oFFHO92PmCx1QcNLhcmNNjEqHFkLbIXF/4MRqy3WA
   QwK9VUFWtiHe5W4QNdZtFtGPh+2AK8+NPe4D+Txcf6MzviPK9tmqufveN
   gMory/xjpqXguYAw2JluDbjuwbOGtMh8pO+W76nV6HeirYjNvoUoba5Qj
   Yz2VgEZjZFqgqWUkURHdzU83XAhaRV1oBLTEmVmIc8DahnnyUgH0HUSqm
   YuUV/rHFSc82Dw1lzlu7vutU/NJ1W99osRRRj6969nNivhXHO5DYMA4df
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10214"; a="241806064"
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="241806064"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 15:15:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="687591931"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 31 Dec 2021 15:15:16 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3R7D-000BmS-Gf; Fri, 31 Dec 2021 23:15:15 +0000
Date:   Sat, 1 Jan 2022 07:14:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: Re: [PATCH v6 2/2] Driver for ON Semi AR0521 camera sensor
Message-ID: <202201010737.V5A5o9x5-lkp@intel.com>
References: <m35yrfhkaf.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m35yrfhkaf.fsf@t19.piap.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Krzysztof,

I love your patch! Yet something to improve:

[auto build test ERROR on media-tree/master]
[also build test ERROR on linus/master v5.16-rc7 next-20211224]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Krzysztof-Ha-asa/On-Semi-AR0521-sensor-driver/20211223-150758
base:   git://linuxtv.org/media_tree.git master
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220101/202201010737.V5A5o9x5-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/664482ab74a2331a7a7ead9256b0455cfc3334c7
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Krzysztof-Ha-asa/On-Semi-AR0521-sensor-driver/20211223-150758
        git checkout 664482ab74a2331a7a7ead9256b0455cfc3334c7
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/device.h:25,
                    from include/linux/pm_runtime.h:11,
                    from drivers/media/i2c/ar0521.c:10:
>> drivers/media/i2c/ar0521.c:1029:21: error: initialization of 'int (*)(struct device *)' from incompatible pointer type 'void (*)(struct device *)' [-Werror=incompatible-pointer-types]
    1029 |  SET_RUNTIME_PM_OPS(ar0521_power_off, ar0521_power_on, NULL)
         |                     ^~~~~~~~~~~~~~~~
   include/linux/pm.h:341:21: note: in definition of macro 'SET_RUNTIME_PM_OPS'
     341 |  .runtime_suspend = suspend_fn, \
         |                     ^~~~~~~~~~
   drivers/media/i2c/ar0521.c:1029:21: note: (near initialization for 'ar0521_pm_ops.runtime_suspend')
    1029 |  SET_RUNTIME_PM_OPS(ar0521_power_off, ar0521_power_on, NULL)
         |                     ^~~~~~~~~~~~~~~~
   include/linux/pm.h:341:21: note: in definition of macro 'SET_RUNTIME_PM_OPS'
     341 |  .runtime_suspend = suspend_fn, \
         |                     ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +1029 drivers/media/i2c/ar0521.c

  1026	
  1027	static const struct dev_pm_ops ar0521_pm_ops = {
  1028		SET_SYSTEM_SLEEP_PM_OPS(ar0521_suspend, ar0521_resume)
> 1029		SET_RUNTIME_PM_OPS(ar0521_power_off, ar0521_power_on, NULL)
  1030	};
  1031	static const struct of_device_id ar0521_dt_ids[] = {
  1032		{.compatible = "onnn,ar0521"},
  1033		{}
  1034	};
  1035	MODULE_DEVICE_TABLE(of, ar0521_dt_ids);
  1036	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
