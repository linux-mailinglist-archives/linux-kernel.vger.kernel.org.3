Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FF55423C1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443158AbiFHCB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1588711AbiFGXy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:54:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331FF10D317
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 16:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654645152; x=1686181152;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=imhX1NYWGEsiCnnmaAbSWfZbszqDMMQOB9PHx0HzZoc=;
  b=Uml2Km8Iddfct789i+Dnbk+051Fhg5YeTMMUYXNCjA0q4mLx7oykOO5I
   u4nEgJ+L24rx5OcKmlBO+9ubF413xk9zuPvAe+rwksxmwrHVTL4mE9WD/
   W60U9LI/shHEZbniHS+ikulQ+4q0SySyuPui+nKRc7xRDUS74gfaNopM4
   rKKQ0UHFUoTBfIdJmRSsTYSPKMRNdc7PS/YoavM6z5JS9tIRwHJde7RWu
   4JZQ6wsr91fMZIU7AHJsunBlhnnUPfG8aypNIrG/9ZUcsDpP5fl8QKv+H
   3z2IK6BsSOJ1WRP0r9FvHVQft/zSeumjxhBNMMkSGz5j9VQbU4e6Mz9Rh
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="340759228"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="340759228"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 16:39:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="584473805"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 07 Jun 2022 16:39:09 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyimy-000E2T-VY;
        Tue, 07 Jun 2022 23:39:08 +0000
Date:   Wed, 8 Jun 2022 07:38:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jocelyn Falempe <jfalempe@redhat.com>
Subject: [drm-misc:drm-misc-next 2/10]
 drivers/gpu/drm/mgag200/mgag200_g200.c:120:16: error: implicit declaration
 of function 'vmalloc'; did you mean 'kvmalloc'?
Message-ID: <202206080734.ztAvDG7O-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
head:   dfa687bffc8a4a21ed929c7dececf01b8f1f52ee
commit: 85397f6bc4ff13a6bc5259facb8ebebb1986d666 [2/10] drm/mgag200: Initialize each model in separate function
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20220608/202206080734.ztAvDG7O-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add drm-misc git://anongit.freedesktop.org/drm/drm-misc
        git fetch --no-tags drm-misc drm-misc-next
        git checkout 85397f6bc4ff13a6bc5259facb8ebebb1986d666
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/mgag200/mgag200_g200.c: In function 'mgag200_g200_init_refclk':
>> drivers/gpu/drm/mgag200/mgag200_g200.c:120:16: error: implicit declaration of function 'vmalloc'; did you mean 'kvmalloc'? [-Werror=implicit-function-declaration]
     120 |         bios = vmalloc(size);
         |                ^~~~~~~
         |                kvmalloc
   drivers/gpu/drm/mgag200/mgag200_g200.c:120:14: warning: assignment to 'unsigned char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     120 |         bios = vmalloc(size);
         |              ^
>> drivers/gpu/drm/mgag200/mgag200_g200.c:131:9: error: implicit declaration of function 'vfree'; did you mean 'kvfree'? [-Werror=implicit-function-declaration]
     131 |         vfree(bios);
         |         ^~~~~
         |         kvfree
   cc1: some warnings being treated as errors


vim +120 drivers/gpu/drm/mgag200/mgag200_g200.c

   102	
   103	static void mgag200_g200_init_refclk(struct mgag200_g200_device *g200)
   104	{
   105		struct mga_device *mdev = &g200->base;
   106		struct drm_device *dev = &mdev->base;
   107		struct pci_dev *pdev = to_pci_dev(dev->dev);
   108		unsigned char __iomem *rom;
   109		unsigned char *bios;
   110		size_t size;
   111	
   112		g200->pclk_min = 50000;
   113		g200->pclk_max = 230000;
   114		g200->ref_clk = 27050;
   115	
   116		rom = pci_map_rom(pdev, &size);
   117		if (!rom)
   118			return;
   119	
 > 120		bios = vmalloc(size);
   121		if (!bios)
   122			goto out;
   123		memcpy_fromio(bios, rom, size);
   124	
   125		if (size != 0 && bios[0] == 0x55 && bios[1] == 0xaa)
   126			mgag200_g200_interpret_bios(g200, bios, size);
   127	
   128		drm_dbg_kms(dev, "pclk_min: %ld pclk_max: %ld ref_clk: %ld\n",
   129			    g200->pclk_min, g200->pclk_max, g200->ref_clk);
   130	
 > 131		vfree(bios);
   132	out:
   133		pci_unmap_rom(pdev, rom);
   134	}
   135	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
