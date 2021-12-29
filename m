Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F93481304
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 14:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239023AbhL2NFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 08:05:06 -0500
Received: from mga11.intel.com ([192.55.52.93]:39960 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238590AbhL2NFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 08:05:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640783104; x=1672319104;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OPekGE0BysIj2ePhh+K0lb5fBtjc9oFbufOduayBaso=;
  b=hbav0veG9xqjrCyuSS6gSHoUJZ6RLBvWbCTU6WwyITqq5oj7o2QN/cQ2
   zy3rk99xPKlD0gWq8vwbw6uJ8MSv8FJDktTfH2QNF3BafxSBrG3Db7AdV
   zSY3Pu23DWDdVQDw72ISuXU12Q5VgZELyJ4QkgUpdz6wK2Zy7kVhispff
   EszCj0KAHNQDcXQdHmxTWR0OgAy2tTIYDZFz5QhXrWOo371vbtfAfmnBY
   YIb0CD3Ynh+M+kUzupbN4ZoQTnn6e/SPzUgIv3Q8+CDdqLq64vhHAwc87
   bAJt/QMTqpbTy+CrMTxbrScCQtHHAcFFSx1jdM9YWYXLbSkGu7x3yfAS0
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="239059690"
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="239059690"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 05:05:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="572600689"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 29 Dec 2021 05:05:01 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2YdZ-0008vc-20; Wed, 29 Dec 2021 13:05:01 +0000
Date:   Wed, 29 Dec 2021 21:04:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li-hao Kuo <lhjeff911@gmail.com>, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, wells.lu@sunplus.com,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: Re: [PATCH v2 1/2] THERMAL: Add THERMAL driver for Sunplus SP7021
Message-ID: <202112292049.x3u9VQgr-lkp@intel.com>
References: <a5b37169978e9b82c33718289066287dfd1b9c00.1640235724.git.lhjeff911@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5b37169978e9b82c33718289066287dfd1b9c00.1640235724.git.lhjeff911@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li-hao,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/thermal]
[also build test WARNING on linus/master v5.16-rc7 next-20211224]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Li-hao-Kuo/Add-THERMAL-control-driver-for-Sunplus-SP7021-SoC/20211223-130720
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
config: h8300-allyesconfig (https://download.01.org/0day-ci/archive/20211229/202112292049.x3u9VQgr-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/99e97d44b9115aad59fc953c2945c7cbda1d57bb
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Li-hao-Kuo/Add-THERMAL-control-driver-for-Sunplus-SP7021-SoC/20211223-130720
        git checkout 99e97d44b9115aad59fc953c2945c7cbda1d57bb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=h8300 SHELL=/bin/bash drivers/thermal/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/thermal/sunplus_thermal.c:44:7: warning: no previous prototype for 'sp7021_otp_coef_read' [-Wmissing-prototypes]
      44 | char *sp7021_otp_coef_read(struct device *dev, ssize_t *len)
         |       ^~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/printk.h:559,
                    from include/linux/kernel.h:20,
                    from include/linux/clk.h:13,
                    from drivers/thermal/sunplus_thermal.c:8:
   drivers/thermal/sunplus_thermal.c: In function 'sp7021_otp_coef_read':
>> drivers/thermal/sunplus_thermal.c:55:22: warning: format '%d' expects argument of type 'int', but argument 4 has type 'ssize_t' {aka 'long int'} [-Wformat=]
      55 |         dev_dbg(dev, "%d bytes read from OTP", *len);
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:30: note: in expansion of macro 'dev_fmt'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/thermal/sunplus_thermal.c:55:9: note: in expansion of macro 'dev_dbg'
      55 |         dev_dbg(dev, "%d bytes read from OTP", *len);
         |         ^~~~~~~
   drivers/thermal/sunplus_thermal.c:55:24: note: format string is defined here
      55 |         dev_dbg(dev, "%d bytes read from OTP", *len);
         |                       ~^
         |                        |
         |                        int
         |                       %ld


vim +55 drivers/thermal/sunplus_thermal.c

    43	
  > 44	char *sp7021_otp_coef_read(struct device *dev, ssize_t *len)
    45	{
    46		char *ret = NULL;
    47		struct nvmem_cell *c = nvmem_cell_get(dev, "therm_calib");
    48	
    49		if (IS_ERR_OR_NULL(c)) {
    50			dev_err(dev, "OTP read failure:%ld", PTR_ERR(c));
    51			return NULL;
    52		}
    53		ret = nvmem_cell_read(c, len);
    54		nvmem_cell_put(c);
  > 55		dev_dbg(dev, "%d bytes read from OTP", *len);
    56		return ret;
    57	}
    58	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
