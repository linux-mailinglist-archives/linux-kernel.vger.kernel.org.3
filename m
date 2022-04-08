Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B9F4F8FB2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiDHHlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiDHHld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:41:33 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237BD1A8C35
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 00:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649403571; x=1680939571;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nevn+9bPY11rikKB/F9X0TbFXNtoxEjhyh33BAUbosk=;
  b=F2Zv0MapOdUxJL9cp6XomuZk8LACFxxYvPUEdYQyKfCHYgTr/W3e68io
   iyY0uPw/C4RG4p9vLVKmLxCW6/WyMQYePs3oNc3v9ggiCVaZtfhk3bJ6O
   LXh5S41j/eSz6NLwBq9PtaRLjoQ2K6kUXvXQTETZR1WFk4boCuCMpVrDa
   KuZDuWlrnP6nWc+ZV5PLwuqzRNJvdM4b6YmF+AvaO7AEVXxg6FxYon0qH
   qKQwQFT6gs9IRbAbG9F9EiBqqLRjytVlaLRsESS2zRD+OgNvdOJ5UhZMg
   Zz5MlxmF8g3BoNBgTuHFZPOoumIhnrsy3xwbZXCKNIXB4s77xXW6+AB3w
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="322224614"
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="322224614"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 00:39:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="506471019"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 08 Apr 2022 00:39:28 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncjDL-0006At-U1;
        Fri, 08 Apr 2022 07:39:27 +0000
Date:   Fri, 8 Apr 2022 15:38:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Phil Elwell <pelwell@users.noreply.github.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dom Cobley <popcornmix@gmail.com>
Subject: [l1k:smsc95xx_5.17 76/887] drivers/video/fbdev/rpisense-fb.c:203:34:
 error: implicit declaration of function 'vzalloc'; did you mean 'kvzalloc'?
Message-ID: <202204081542.rzWZZRnZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   05d68ced287b30f62f18f95b5476135ef669804a
commit: b722bea6165a6e42fff47ede05186cb53542689e [76/887] mfd: Add Raspberry Pi Sense HAT core driver
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220408/202204081542.rzWZZRnZ-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/l1k/linux/commit/b722bea6165a6e42fff47ede05186cb53542689e
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k smsc95xx_5.17
        git checkout b722bea6165a6e42fff47ede05186cb53542689e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash drivers/video/fbdev/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/video/fbdev/rpisense-fb.c: In function 'rpisense_fb_probe':
>> drivers/video/fbdev/rpisense-fb.c:203:34: error: implicit declaration of function 'vzalloc'; did you mean 'kvzalloc'? [-Werror=implicit-function-declaration]
     203 |         rpisense_fb_param.vmem = vzalloc(rpisense_fb_param.vmemsize);
         |                                  ^~~~~~~
         |                                  kvzalloc
>> drivers/video/fbdev/rpisense-fb.c:203:32: warning: assignment to 'char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     203 |         rpisense_fb_param.vmem = vzalloc(rpisense_fb_param.vmemsize);
         |                                ^
>> drivers/video/fbdev/rpisense-fb.c:246:9: error: implicit declaration of function 'vfree'; did you mean 'kfree'? [-Werror=implicit-function-declaration]
     246 |         vfree(rpisense_fb_param.vmem);
         |         ^~~~~
         |         kfree
   cc1: some warnings being treated as errors


vim +203 drivers/video/fbdev/rpisense-fb.c

   193	
   194	static int rpisense_fb_probe(struct platform_device *pdev)
   195	{
   196		struct fb_info *info;
   197		int ret = -ENOMEM;
   198		struct rpisense_fb *rpisense_fb;
   199	
   200		rpisense = rpisense_get_dev();
   201		rpisense_fb = &rpisense->framebuffer;
   202	
 > 203		rpisense_fb_param.vmem = vzalloc(rpisense_fb_param.vmemsize);
   204		if (!rpisense_fb_param.vmem)
   205			return ret;
   206	
   207		rpisense_fb_param.vmem_work = devm_kmalloc(&pdev->dev, 193, GFP_KERNEL);
   208		if (!rpisense_fb_param.vmem_work)
   209			goto err_malloc;
   210	
   211		info = framebuffer_alloc(0, &pdev->dev);
   212		if (!info) {
   213			dev_err(&pdev->dev, "Could not allocate framebuffer.\n");
   214			goto err_malloc;
   215		}
   216		rpisense_fb->info = info;
   217	
   218		rpisense_fb_fix.smem_start = (unsigned long)rpisense_fb_param.vmem;
   219		rpisense_fb_fix.smem_len = rpisense_fb_param.vmemsize;
   220	
   221		info->fbops = &rpisense_fb_ops;
   222		info->fix = rpisense_fb_fix;
   223		info->var = rpisense_fb_var;
   224		info->fbdefio = &rpisense_fb_defio;
   225		info->flags = FBINFO_FLAG_DEFAULT | FBINFO_VIRTFB;
   226		info->screen_base = rpisense_fb_param.vmem;
   227		info->screen_size = rpisense_fb_param.vmemsize;
   228	
   229		if (lowlight)
   230			rpisense_fb_param.gamma = gamma_low;
   231	
   232		fb_deferred_io_init(info);
   233	
   234		ret = register_framebuffer(info);
   235		if (ret < 0) {
   236			dev_err(&pdev->dev, "Could not register framebuffer.\n");
   237			goto err_fballoc;
   238		}
   239	
   240		fb_info(info, "%s frame buffer device\n", info->fix.id);
   241		schedule_delayed_work(&info->deferred_work, rpisense_fb_defio.delay);
   242		return 0;
   243	err_fballoc:
   244		framebuffer_release(info);
   245	err_malloc:
 > 246		vfree(rpisense_fb_param.vmem);
   247		return ret;
   248	}
   249	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
