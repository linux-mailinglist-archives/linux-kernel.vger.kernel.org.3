Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2201C544175
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 04:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236785AbiFICZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 22:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236825AbiFICZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 22:25:21 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1F2237C9D;
        Wed,  8 Jun 2022 19:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654741515; x=1686277515;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YSRDc8vSy0bDnzktx1c5rLBH1FRcIlBQFLnV7u8Exyc=;
  b=W0+mVdsB7FKBp6YD/mbXCMpDdkVYlkzLsnS6xDswU7/fA4UAqwlszjLP
   SItvCuPqvazCqFqhdnF8n33DIyfJ958rfQ9+C9ysf1wWQUodeqggMoFNx
   RvOiC0AhlF/01e5iP3/4oAwHqIwhEVoaswK/ExT61cWvT7zuG+keFSQs5
   eci/CPxOzBD+pu2zuQzkzX0brpjv8kh1TSr4sMccw0pjubrQns9z76TXK
   WhbsQ5+L1Yad6InxomcnAcekiZ+Bpq1U9iWmSFsSjn9yHD07YK0GObhKx
   PgUYo9EbQlqsc62zOxiyryC4hOx2sj5BCSvlAsLytTv6wbbWAJMR3cqS1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="278278487"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="278278487"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 19:25:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="908021175"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 08 Jun 2022 19:25:11 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nz7rC-000FLl-TQ;
        Thu, 09 Jun 2022 02:25:10 +0000
Date:   Thu, 9 Jun 2022 10:24:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shreeya Patel <shreeya.patel@collabora.com>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, Zhigang.Shi@liteon.com,
        krisman@collabora.com
Cc:     kbuild-all@lists.01.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, alvaro.soliverez@collabora.com,
        andy.shevchenko@gmail.com, digetx@gmail.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: Re: [PATCH v5 2/2] iio: light: Add support for ltrf216a sensor
Message-ID: <202206091041.MeYKMR6P-lkp@intel.com>
References: <20220608113553.32083-3-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608113553.32083-3-shreeya.patel@collabora.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shreeya,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on v5.19-rc1 next-20220608]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Shreeya-Patel/Add-LTRF216A-Driver/20220608-194016
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220609/202206091041.MeYKMR6P-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4809a7f42af19c3da77457e1aaf37ddd171fa779
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Shreeya-Patel/Add-LTRF216A-Driver/20220608-194016
        git checkout 4809a7f42af19c3da77457e1aaf37ddd171fa779
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/iio/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/iio/light/ltrf216a.c:193:5: warning: no previous prototype for 'ltrf216a_check_for_data' [-Wmissing-prototypes]
     193 | int ltrf216a_check_for_data(struct i2c_client *client)
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/device.h:25,
                    from include/linux/acpi.h:15,
                    from include/linux/i2c.h:13,
                    from drivers/iio/light/ltrf216a.c:14:
>> drivers/iio/light/ltrf216a.c:409:28: error: 'ltrf216a_runtime_suspend' undeclared here (not in a function); did you mean 'pm_runtime_suspend'?
     409 |         SET_RUNTIME_PM_OPS(ltrf216a_runtime_suspend,
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pm.h:329:28: note: in definition of macro 'RUNTIME_PM_OPS'
     329 |         .runtime_suspend = suspend_fn, \
         |                            ^~~~~~~~~~
   drivers/iio/light/ltrf216a.c:409:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
     409 |         SET_RUNTIME_PM_OPS(ltrf216a_runtime_suspend,
         |         ^~~~~~~~~~~~~~~~~~
>> drivers/iio/light/ltrf216a.c:410:28: error: 'ltrf216a_runtime_resume' undeclared here (not in a function); did you mean 'ltrf216a_int_time_reg'?
     410 |                            ltrf216a_runtime_resume, NULL)
         |                            ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pm.h:330:27: note: in definition of macro 'RUNTIME_PM_OPS'
     330 |         .runtime_resume = resume_fn, \
         |                           ^~~~~~~~~
   drivers/iio/light/ltrf216a.c:409:9: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
     409 |         SET_RUNTIME_PM_OPS(ltrf216a_runtime_suspend,
         |         ^~~~~~~~~~~~~~~~~~


vim +409 drivers/iio/light/ltrf216a.c

   405	
   406	static const struct dev_pm_ops ltrf216a_pm_ops = {
   407		SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
   408					pm_runtime_force_resume)
 > 409		SET_RUNTIME_PM_OPS(ltrf216a_runtime_suspend,
 > 410				   ltrf216a_runtime_resume, NULL)
   411	};
   412	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
