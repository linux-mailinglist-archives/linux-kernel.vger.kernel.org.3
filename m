Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E76526021
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379439AbiEMKbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 06:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355585AbiEMKbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:31:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5B8590BC;
        Fri, 13 May 2022 03:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652437894; x=1683973894;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ficTo4G11TLusKxmT+h3TM35Qpeg9CrvwxCZMgmXqDI=;
  b=La10BoM/egYwtYX0cTojzvpjwJEyu988ZHp4WnnjDbOBDhKEkgNhieM1
   W4sBcxA8m5opCi641wDoGk8nwOLcRcbvDno7TJXKkyCs6OOWDczLLWpIv
   rGHWUobVL5rmTMGvtN8I/sqIv4anxkUdAVfs0btxyr39TPGM9lE/N2dhh
   gXEzIzkPpFp18Gg32WOotOxKprBvLHyAm/6o1Rxy7iYCKps9HyZYqeo6z
   ry/VJ4G6lJDSeUB3uDqFlmYyJkS9U+cL1USLLYTWvIhFvipp24Zz+7IQx
   Ejx7RikB3Q0iVB3GzPoSvN4zDsSvGMhN+MbW8jPzmSZgk8XRofwkqed78
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="252320748"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="252320748"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 03:31:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="595161151"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 13 May 2022 03:31:31 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npSa2-000Ld6-EH;
        Fri, 13 May 2022 10:31:30 +0000
Date:   Fri, 13 May 2022 18:30:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marvin Lin <milkfafa@gmail.com>, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, openbmc@lists.ozlabs.org,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        kwliu@nuvoton.com, kflin@nuvoton.com
Subject: Re: [PATCH v2 5/5] drivers: media: platform: Add NPCM Video
 Capture/Encode Engine driver
Message-ID: <202205131804.AMALhZXJ-lkp@intel.com>
References: <20220513033450.7038-6-kflin@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513033450.7038-6-kflin@nuvoton.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marvin,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linux/master linus/master v5.18-rc6]
[cannot apply to media-tree/master next-20220512]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Marvin-Lin/Support-Nuvoton-NPCM-Video-Capture-Encode-Engine/20220513-113806
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220513/202205131804.AMALhZXJ-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7fa1f7750e7317479ce2c2c043b44fa19c46b1a8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Marvin-Lin/Support-Nuvoton-NPCM-Video-Capture-Encode-Engine/20220513-113806
        git checkout 7fa1f7750e7317479ce2c2c043b44fa19c46b1a8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/media/platform/nuvoton/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/media/platform/nuvoton/npcm-video.c: In function 'nuvoton_video_buf_queue':
   drivers/media/platform/nuvoton/npcm-video.c:1776:13: warning: variable 'empty' set but not used [-Wunused-but-set-variable]
    1776 |         int empty;
         |             ^~~~~
   drivers/media/platform/nuvoton/npcm-video.c: At top level:
>> drivers/media/platform/nuvoton/npcm-video.c:2060:1: error: expected ',' or ';' before 'static'
    2060 | static struct platform_driver nuvoton_video_driver = {
         | ^~~~~~
   In file included from drivers/media/platform/nuvoton/npcm-video.c:24:
   drivers/media/platform/nuvoton/npcm-video.c: In function 'nuvoton_video_driver_init':
>> drivers/media/platform/nuvoton/npcm-video.c:2069:24: error: 'nuvoton_video_driver' undeclared (first use in this function); did you mean 'nuvoton_video_probe'?
    2069 | module_platform_driver(nuvoton_video_driver);
         |                        ^~~~~~~~~~~~~~~~~~~~
   include/linux/platform_device.h:222:36: note: in definition of macro 'platform_driver_register'
     222 |         __platform_driver_register(drv, THIS_MODULE)
         |                                    ^~~
   include/linux/platform_device.h:252:9: note: in expansion of macro 'module_driver'
     252 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^~~~~~~~~~~~~
   drivers/media/platform/nuvoton/npcm-video.c:2069:1: note: in expansion of macro 'module_platform_driver'
    2069 | module_platform_driver(nuvoton_video_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/nuvoton/npcm-video.c:2069:24: note: each undeclared identifier is reported only once for each function it appears in
    2069 | module_platform_driver(nuvoton_video_driver);
         |                        ^~~~~~~~~~~~~~~~~~~~
   include/linux/platform_device.h:222:36: note: in definition of macro 'platform_driver_register'
     222 |         __platform_driver_register(drv, THIS_MODULE)
         |                                    ^~~
   include/linux/platform_device.h:252:9: note: in expansion of macro 'module_driver'
     252 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^~~~~~~~~~~~~
   drivers/media/platform/nuvoton/npcm-video.c:2069:1: note: in expansion of macro 'module_platform_driver'
    2069 | module_platform_driver(nuvoton_video_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/device.h:32,
                    from drivers/media/platform/nuvoton/npcm-video.c:14:
   drivers/media/platform/nuvoton/npcm-video.c: In function 'nuvoton_video_driver_exit':
>> drivers/media/platform/nuvoton/npcm-video.c:2069:24: error: 'nuvoton_video_driver' undeclared (first use in this function); did you mean 'nuvoton_video_probe'?
    2069 | module_platform_driver(nuvoton_video_driver);
         |                        ^~~~~~~~~~~~~~~~~~~~
   include/linux/device/driver.h:267:24: note: in definition of macro 'module_driver'
     267 |         __unregister(&(__driver) , ##__VA_ARGS__); \
         |                        ^~~~~~~~
   drivers/media/platform/nuvoton/npcm-video.c:2069:1: note: in expansion of macro 'module_platform_driver'
    2069 | module_platform_driver(nuvoton_video_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/nuvoton/npcm-video.c: In function 'nuvoton_video_driver_init':
   include/linux/device/driver.h:263:1: error: control reaches end of non-void function [-Werror=return-type]
     263 | } \
         | ^
   include/linux/platform_device.h:252:9: note: in expansion of macro 'module_driver'
     252 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^~~~~~~~~~~~~
   drivers/media/platform/nuvoton/npcm-video.c:2069:1: note: in expansion of macro 'module_platform_driver'
    2069 | module_platform_driver(nuvoton_video_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   At top level:
   drivers/media/platform/nuvoton/npcm-video.c:2030:12: warning: 'nuvoton_video_remove' defined but not used [-Wunused-function]
    2030 | static int nuvoton_video_remove(struct platform_device *pdev)
         |            ^~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/nuvoton/npcm-video.c:1954:12: warning: 'nuvoton_video_probe' defined but not used [-Wunused-function]
    1954 | static int nuvoton_video_probe(struct platform_device *pdev)
         |            ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +2060 drivers/media/platform/nuvoton/npcm-video.c

  2059	
> 2060	static struct platform_driver nuvoton_video_driver = {
  2061		.driver = {
  2062			.name = DEVICE_NAME,
  2063			.of_match_table = nuvoton_video_match,
  2064		},
  2065		.probe = nuvoton_video_probe,
  2066		.remove = nuvoton_video_remove,
  2067	};
  2068	
> 2069	module_platform_driver(nuvoton_video_driver);
  2070	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
