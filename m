Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15237542186
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442859AbiFHCBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1839425AbiFHADK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 20:03:10 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B76B1F0FE0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 13:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654634588; x=1686170588;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uznAsvO6cd/Fbzz5a8GDA5cYX4iuDUW8CoL5qsE86g8=;
  b=TrKsk71zDrUTXesYZbvm09owtBsz/mDtrWhAMzg7Xg04bSJxANJRj3e/
   AuArFEYJ4gqqCu44573jd5eaj1rh+kptjtKmgUC56z7aAi0lJla1Rw73N
   uhnlgrOZu+tkdP5q2NSgdGeFBQt5LToX1KCMuCoKzA1dHenFMJc0vQ5Ib
   9zpHZ/gzVDehxCadL0VtZ2QWtAn+jnR4FhcphZKr9650P8v0B03biz/G0
   OfoYhh7k3mtmhUY3OIWMRTbH1zXk+67G+gPjDlhUwAZGjYd1CTLbdTIuD
   Ww6dAZahnCSmjfo8bCW0vZhlPQInL72uR7cFGo0e2T7QxSGj4XGEAgRRW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="338349902"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="338349902"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 13:07:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="584373102"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 07 Jun 2022 13:07:03 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyfTi-000Duf-Ta;
        Tue, 07 Jun 2022 20:07:02 +0000
Date:   Wed, 8 Jun 2022 04:06:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jocelyn Falempe <jfalempe@redhat.com>
Subject: [drm-misc:drm-misc-next 2/10]
 drivers/gpu/drm/mgag200/mgag200_g200.c:120:14: warning: assignment to
 'unsigned char *' from 'int' makes pointer from integer without a cast
Message-ID: <202206080411.JpdjEVh2-lkp@intel.com>
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
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20220608/202206080411.JpdjEVh2-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add drm-misc git://anongit.freedesktop.org/drm/drm-misc
        git fetch --no-tags drm-misc drm-misc-next
        git checkout 85397f6bc4ff13a6bc5259facb8ebebb1986d666
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/gpu/drm/mgag200/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/mgag200/mgag200_g200.c: In function 'mgag200_g200_init_refclk':
   drivers/gpu/drm/mgag200/mgag200_g200.c:120:16: error: implicit declaration of function 'vmalloc'; did you mean 'kvmalloc'? [-Werror=implicit-function-declaration]
     120 |         bios = vmalloc(size);
         |                ^~~~~~~
         |                kvmalloc
>> drivers/gpu/drm/mgag200/mgag200_g200.c:120:14: warning: assignment to 'unsigned char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     120 |         bios = vmalloc(size);
         |              ^
   drivers/gpu/drm/mgag200/mgag200_g200.c:131:9: error: implicit declaration of function 'vfree'; did you mean 'kvfree'? [-Werror=implicit-function-declaration]
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
   131		vfree(bios);
   132	out:
   133		pci_unmap_rom(pdev, rom);
   134	}
   135	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
