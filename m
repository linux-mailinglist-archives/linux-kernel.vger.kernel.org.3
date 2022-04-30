Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB211515C50
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 12:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238885AbiD3KkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 06:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiD3KkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 06:40:15 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E720969707
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 03:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651315012; x=1682851012;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=d0ODFG+qWVJosjwuPYNcs5jsoE5HGe3GK5TcLmuvo+A=;
  b=HQ2FSGsq01eM4XGPrsD0j0auO3YhLxf4E303Babk4pPxm1PHtdbXATqL
   VSZJF06bF/3USPJtobYPStKOPKW7RuzEGAGckb/ryavxC11FbUVIF3w0f
   5ejfnqacZf48UlfxmgX7MHqBYhQUWOKIK2Pu/hPgUhF86ULV6sNjs0ZMb
   BU1QFQZ8+IgniQuflABZ6NcX2fAHoEar3AXK3VrK7R2QUJ1MFk9t2Fx1p
   b3884UlB7J4gZ8TZ83gCykEHFsP3a68NVDN1clCapMB5q4w0eJCCCdlTI
   OmtpUYIUy7dThJuY2S4NBashNGP7XEESrrvq8prC2C6YnqbXYJfReU/7a
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="265715070"
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="265715070"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 03:36:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="619087370"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 30 Apr 2022 03:36:51 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkkSz-00078h-C3;
        Sat, 30 Apr 2022 10:36:45 +0000
Date:   Sat, 30 Apr 2022 18:36:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: [drm-msm:msm-next-staging 7/32]
 drivers/gpu/drm/msm/msm_drv.c:236:17: error: implicit declaration of
 function 'drm_bridge_remove'; did you mean 'drm_bridge_detach'?
Message-ID: <202204301804.hJxOQfse-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/drm/msm.git msm-next-staging
head:   d2dc68276133362f021bc8d429433b5818826c81
commit: d28ea556267c4f2ec7264ab49f1b1296834321ec [7/32] drm/msm: properly add and remove internal bridges
config: parisc-randconfig-r023-20220428 (https://download.01.org/0day-ci/archive/20220430/202204301804.hJxOQfse-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add drm-msm https://gitlab.freedesktop.org/drm/msm.git
        git fetch --no-tags drm-msm msm-next-staging
        git checkout d28ea556267c4f2ec7264ab49f1b1296834321ec
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/gpu/drm/msm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/msm/msm_drv.c: In function 'msm_drm_uninit':
>> drivers/gpu/drm/msm/msm_drv.c:236:17: error: implicit declaration of function 'drm_bridge_remove'; did you mean 'drm_bridge_detach'? [-Werror=implicit-function-declaration]
     236 |                 drm_bridge_remove(priv->bridges[i]);
         |                 ^~~~~~~~~~~~~~~~~
         |                 drm_bridge_detach
   cc1: some warnings being treated as errors


vim +236 drivers/gpu/drm/msm/msm_drv.c

   230	
   231		msm_disp_snapshot_destroy(ddev);
   232	
   233		drm_mode_config_cleanup(ddev);
   234	
   235		for (i = 0; i < priv->num_bridges; i++)
 > 236			drm_bridge_remove(priv->bridges[i]);
   237	
   238		pm_runtime_get_sync(dev);
   239		msm_irq_uninstall(ddev);
   240		pm_runtime_put_sync(dev);
   241	
   242		if (kms && kms->funcs)
   243			kms->funcs->destroy(kms);
   244	
   245		if (priv->vram.paddr) {
   246			unsigned long attrs = DMA_ATTR_NO_KERNEL_MAPPING;
   247			drm_mm_takedown(&priv->vram.mm);
   248			dma_free_attrs(dev, priv->vram.size, NULL,
   249				       priv->vram.paddr, attrs);
   250		}
   251	
   252		component_unbind_all(dev, ddev);
   253	
   254		ddev->dev_private = NULL;
   255		drm_dev_put(ddev);
   256	
   257		destroy_workqueue(priv->wq);
   258	
   259		return 0;
   260	}
   261	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
