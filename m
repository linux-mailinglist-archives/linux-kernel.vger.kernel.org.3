Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C46C52F55D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 23:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353794AbiETVyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 17:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353768AbiETVyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 17:54:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4F919CEDB;
        Fri, 20 May 2022 14:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653083659; x=1684619659;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W3Hw8dGbu5yL/Jnvwt4oT6Phov9xhNAt7GZa8rlyCjs=;
  b=FJdTudj/VAYwfNKXjf3r6Ka+DWqFJL+BSxUACNfaB6zic1c0QSV65NzP
   TAwwCWj7jcyvJrUQSSJ8EqXBmQ2k7IuF0STtFSRCh0CsxbTRqpByHtF0L
   uW8D0qetg1O2f9GVnDmvbRrRf+5l7xwy1kYvJ5qbqM3vtK3S+DB/XbZad
   0TwpV2tXRwmH9SJN/5QmS46Vp2UHQEhch0jyehUSpjOu+pwmxaPotRBNH
   cH9RbKGpu0QX6HKlZwZr8qwciZPsXOME6Z8xCbeF7Sp8yWZtnUd/cJEDt
   a1Rq0P7y4MWFXNlAfK+Yv6HgDnuV7sEIh0LaK2lK3WFU3vb+AZkAtNFkQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="272875920"
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="272875920"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 14:54:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="662471042"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 20 May 2022 14:54:17 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsAZc-0005XO-Ee;
        Fri, 20 May 2022 21:54:16 +0000
Date:   Sat, 21 May 2022 05:54:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marvin Lin <milkfafa@gmail.com>, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, openbmc@lists.ozlabs.org,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        kwliu@nuvoton.com, kflin@nuvoton.com,
        Marvin Lin <milkfafa@gmail.com>
Subject: Re: [PATCH v3 5/5] drivers: media: platform: Add NPCM Video
 Capture/Encode Engine driver
Message-ID: <202205210506.qGHSKHPp-lkp@intel.com>
References: <20220520024744.25655-6-milkfafa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520024744.25655-6-milkfafa@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marvin,

I love your patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linux/master linus/master v5.18-rc7]
[cannot apply to media-tree/master next-20220520]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Marvin-Lin/Support-Nuvoton-NPCM-Video-Capture-Encode-Engine/20220520-104901
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: ia64-allmodconfig (https://download.01.org/0day-ci/archive/20220521/202205210506.qGHSKHPp-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/56e41b3b4b1a54f2096e810eda12259da495c686
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Marvin-Lin/Support-Nuvoton-NPCM-Video-Capture-Encode-Engine/20220520-104901
        git checkout 56e41b3b4b1a54f2096e810eda12259da495c686
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/media/platform/nuvoton/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/media/platform/nuvoton/npcm-video.c:2050:1: error: expected ',' or ';' before 'static'
    2050 | static struct platform_driver nuvoton_video_driver = {
         | ^~~~~~
   In file included from drivers/media/platform/nuvoton/npcm-video.c:24:
   drivers/media/platform/nuvoton/npcm-video.c: In function 'nuvoton_video_driver_init':
>> drivers/media/platform/nuvoton/npcm-video.c:2059:24: error: 'nuvoton_video_driver' undeclared (first use in this function); did you mean 'nuvoton_video_probe'?
    2059 | module_platform_driver(nuvoton_video_driver);
         |                        ^~~~~~~~~~~~~~~~~~~~
   include/linux/platform_device.h:222:36: note: in definition of macro 'platform_driver_register'
     222 |         __platform_driver_register(drv, THIS_MODULE)
         |                                    ^~~
   include/linux/platform_device.h:252:9: note: in expansion of macro 'module_driver'
     252 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^~~~~~~~~~~~~
   drivers/media/platform/nuvoton/npcm-video.c:2059:1: note: in expansion of macro 'module_platform_driver'
    2059 | module_platform_driver(nuvoton_video_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/nuvoton/npcm-video.c:2059:24: note: each undeclared identifier is reported only once for each function it appears in
    2059 | module_platform_driver(nuvoton_video_driver);
         |                        ^~~~~~~~~~~~~~~~~~~~
   include/linux/platform_device.h:222:36: note: in definition of macro 'platform_driver_register'
     222 |         __platform_driver_register(drv, THIS_MODULE)
         |                                    ^~~
   include/linux/platform_device.h:252:9: note: in expansion of macro 'module_driver'
     252 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^~~~~~~~~~~~~
   drivers/media/platform/nuvoton/npcm-video.c:2059:1: note: in expansion of macro 'module_platform_driver'
    2059 | module_platform_driver(nuvoton_video_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/device.h:32,
                    from drivers/media/platform/nuvoton/npcm-video.c:14:
   drivers/media/platform/nuvoton/npcm-video.c: In function 'nuvoton_video_driver_exit':
>> drivers/media/platform/nuvoton/npcm-video.c:2059:24: error: 'nuvoton_video_driver' undeclared (first use in this function); did you mean 'nuvoton_video_probe'?
    2059 | module_platform_driver(nuvoton_video_driver);
         |                        ^~~~~~~~~~~~~~~~~~~~
   include/linux/device/driver.h:267:24: note: in definition of macro 'module_driver'
     267 |         __unregister(&(__driver) , ##__VA_ARGS__); \
         |                        ^~~~~~~~
   drivers/media/platform/nuvoton/npcm-video.c:2059:1: note: in expansion of macro 'module_platform_driver'
    2059 | module_platform_driver(nuvoton_video_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/nuvoton/npcm-video.c: In function 'nuvoton_video_driver_init':
   include/linux/device/driver.h:263:1: error: control reaches end of non-void function [-Werror=return-type]
     263 | } \
         | ^
   include/linux/platform_device.h:252:9: note: in expansion of macro 'module_driver'
     252 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^~~~~~~~~~~~~
   drivers/media/platform/nuvoton/npcm-video.c:2059:1: note: in expansion of macro 'module_platform_driver'
    2059 | module_platform_driver(nuvoton_video_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   At top level:
   drivers/media/platform/nuvoton/npcm-video.c:2020:12: warning: 'nuvoton_video_remove' defined but not used [-Wunused-function]
    2020 | static int nuvoton_video_remove(struct platform_device *pdev)
         |            ^~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/nuvoton/npcm-video.c:1944:12: warning: 'nuvoton_video_probe' defined but not used [-Wunused-function]
    1944 | static int nuvoton_video_probe(struct platform_device *pdev)
         |            ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +2050 drivers/media/platform/nuvoton/npcm-video.c

  2049	
> 2050	static struct platform_driver nuvoton_video_driver = {
  2051		.driver = {
  2052			.name = DEVICE_NAME,
  2053			.of_match_table = nuvoton_video_match,
  2054		},
  2055		.probe = nuvoton_video_probe,
  2056		.remove = nuvoton_video_remove,
  2057	};
  2058	
> 2059	module_platform_driver(nuvoton_video_driver);
  2060	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
