Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F25257D924
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 06:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbiGVEGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 00:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiGVEGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 00:06:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94F7114
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 21:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658462776; x=1689998776;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zE6KJgZUX+0VMPVrPnAX03mn0xq0LtMVZQJay9I+iZQ=;
  b=O1K6d6uwRwot1w6jAUQGIfKVfR0xARB2gB2M4UAkNs4qOoLbmKGduSby
   yphVThzBOMy+j0ijTyZHQXbwY5EY0pm5vlahRF0ak6tNbTXtKXpYOEwAc
   QbX4fyWWxiquxnHcBRfI3WjnjFs/dFwTjdV8a8K1r8qocOLnBCsd06sNm
   UGODUk6lyT+pfpaa2X4rucZmpOlco0uoL9sAji1CqK9+Z2NkHWZT5wtBX
   qzdVPJUNhnY0Wn4XsypC/UzsqKv4us77da83aDlJTBEf0pQvuptvBOf61
   Ds8z1L7gXeWGPO+E9fuCp99p+GFxUZjcTkkHOSatjHyzIrVmwoWOTFBVt
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="287236938"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="287236938"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 21:06:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="701527383"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jul 2022 21:06:14 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oEjvZ-0000wU-2B;
        Fri, 22 Jul 2022 04:06:13 +0000
Date:   Fri, 22 Jul 2022 12:05:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [kraxel:drm-misc-next 5/11] drivers/video/fbdev/hyperv_fb.c:1080:26:
 warning: expression which evaluates to zero treated as a null pointer
 constant of type 'const char *'
Message-ID: <202207221220.l3OexDU3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kraxel.org/linux drm-misc-next
head:   15fced5b051e6e22c228a521a5894b12c2ba0892
commit: 8d69d008f44cb96050c35e64fe940a22dd6b0113 [5/11] fbdev: Convert drivers to aperture helpers
config: x86_64-randconfig-a003 (https://download.01.org/0day-ci/archive/20220722/202207221220.l3OexDU3-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 72686d68c137551cce816416190a18d45b4d4e2a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add kraxel git://git.kraxel.org/linux
        git fetch --no-tags kraxel drm-misc-next
        git checkout 8d69d008f44cb96050c35e64fe940a22dd6b0113
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/video/fbdev/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/video/fbdev/hyperv_fb.c:1080:26: warning: expression which evaluates to zero treated as a null pointer constant of type 'const char *' [-Wnon-literal-null-conversion]
                                               KBUILD_MODNAME, false);
                                                               ^~~~~
   1 warning generated.


vim +1080 drivers/video/fbdev/hyperv_fb.c

3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09   987  
68a2d20b79b105f drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29   988  
68a2d20b79b105f drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29   989  /* Get framebuffer memory from Hyper-V video pci space */
3546448338e76a5 drivers/video/fbdev/hyperv_fb.c Jake Oshins       2015-08-05   990  static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
68a2d20b79b105f drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29   991  {
9069fd54960304a drivers/video/hyperv_fb.c       Gerd Hoffmann     2014-02-26   992  	struct hvfb_par *par = info->par;
9069fd54960304a drivers/video/hyperv_fb.c       Gerd Hoffmann     2014-02-26   993  	struct pci_dev *pdev  = NULL;
68a2d20b79b105f drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29   994  	void __iomem *fb_virt;
9069fd54960304a drivers/video/hyperv_fb.c       Gerd Hoffmann     2014-02-26   995  	int gen2vm = efi_enabled(EFI_BOOT);
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09   996  	phys_addr_t paddr;
9069fd54960304a drivers/video/hyperv_fb.c       Gerd Hoffmann     2014-02-26   997  	int ret;
68a2d20b79b105f drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29   998  
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09   999  	info->apertures = alloc_apertures(1);
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1000  	if (!info->apertures)
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1001  		return -ENOMEM;
d21987d709e807b drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-09-18  1002  
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1003  	if (!gen2vm) {
68a2d20b79b105f drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1004  		pdev = pci_get_device(PCI_VENDOR_ID_MICROSOFT,
68a2d20b79b105f drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1005  			PCI_DEVICE_ID_HYPERV_VIDEO, NULL);
68a2d20b79b105f drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1006  		if (!pdev) {
68a2d20b79b105f drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1007  			pr_err("Unable to find PCI Hyper-V video\n");
68a2d20b79b105f drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1008  			return -ENODEV;
68a2d20b79b105f drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1009  		}
68a2d20b79b105f drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1010  
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1011  		info->apertures->ranges[0].base = pci_resource_start(pdev, 0);
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1012  		info->apertures->ranges[0].size = pci_resource_len(pdev, 0);
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1013  
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1014  		/*
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1015  		 * For Gen 1 VM, we can directly use the contiguous memory
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1016  		 * from VM. If we succeed, deferred IO happens directly
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1017  		 * on this allocated framebuffer memory, avoiding extra
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1018  		 * memory copy.
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1019  		 */
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1020  		paddr = hvfb_get_phymem(hdev, screen_fb_size);
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1021  		if (paddr != (phys_addr_t) -1) {
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1022  			par->mmio_pp = paddr;
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1023  			par->mmio_vp = par->dio_vp = __va(paddr);
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1024  
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1025  			info->fix.smem_start = paddr;
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1026  			info->fix.smem_len = screen_fb_size;
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1027  			info->screen_base = par->mmio_vp;
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1028  			info->screen_size = screen_fb_size;
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1029  
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1030  			par->need_docopy = false;
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1031  			goto getmem_done;
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1032  		}
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1033  		pr_info("Unable to allocate enough contiguous physical memory on Gen 1 VM. Using MMIO instead.\n");
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1034  	} else {
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1035  		info->apertures->ranges[0].base = screen_info.lfb_base;
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1036  		info->apertures->ranges[0].size = screen_info.lfb_size;
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1037  	}
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1038  
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1039  	/*
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1040  	 * Cannot use the contiguous physical memory.
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1041  	 * Allocate mmio space for framebuffer.
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1042  	 */
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1043  	dio_fb_size =
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1044  		screen_width * screen_height * screen_depth / 8;
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1045  
c4b4d7047f16a8d drivers/video/fbdev/hyperv_fb.c Saurabh Sengar    2022-04-27  1046  	ret = vmbus_allocate_mmio(&par->mem, hdev, 0, -1,
3546448338e76a5 drivers/video/fbdev/hyperv_fb.c Jake Oshins       2015-08-05  1047  				  screen_fb_size, 0x100000, true);
9069fd54960304a drivers/video/hyperv_fb.c       Gerd Hoffmann     2014-02-26  1048  	if (ret != 0) {
3546448338e76a5 drivers/video/fbdev/hyperv_fb.c Jake Oshins       2015-08-05  1049  		pr_err("Unable to allocate framebuffer memory\n");
68a2d20b79b105f drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1050  		goto err1;
9069fd54960304a drivers/video/hyperv_fb.c       Gerd Hoffmann     2014-02-26  1051  	}
68a2d20b79b105f drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1052  
5f1251a48c17b54 drivers/video/fbdev/hyperv_fb.c Dexuan Cui        2020-11-17  1053  	/*
5f1251a48c17b54 drivers/video/fbdev/hyperv_fb.c Dexuan Cui        2020-11-17  1054  	 * Map the VRAM cacheable for performance. This is also required for
5f1251a48c17b54 drivers/video/fbdev/hyperv_fb.c Dexuan Cui        2020-11-17  1055  	 * VM Connect to display properly for ARM64 Linux VM, as the host also
5f1251a48c17b54 drivers/video/fbdev/hyperv_fb.c Dexuan Cui        2020-11-17  1056  	 * maps the VRAM cacheable.
5f1251a48c17b54 drivers/video/fbdev/hyperv_fb.c Dexuan Cui        2020-11-17  1057  	 */
5f1251a48c17b54 drivers/video/fbdev/hyperv_fb.c Dexuan Cui        2020-11-17  1058  	fb_virt = ioremap_cache(par->mem->start, screen_fb_size);
68a2d20b79b105f drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1059  	if (!fb_virt)
68a2d20b79b105f drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1060  		goto err2;
68a2d20b79b105f drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1061  
d21987d709e807b drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-09-18  1062  	/* Allocate memory for deferred IO */
d21987d709e807b drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-09-18  1063  	par->dio_vp = vzalloc(round_up(dio_fb_size, PAGE_SIZE));
d21987d709e807b drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-09-18  1064  	if (par->dio_vp == NULL)
d21987d709e807b drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-09-18  1065  		goto err3;
d21987d709e807b drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-09-18  1066  
d21987d709e807b drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-09-18  1067  	/* Physical address of FB device */
d21987d709e807b drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-09-18  1068  	par->mmio_pp = par->mem->start;
d21987d709e807b drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-09-18  1069  	/* Virtual address of FB device */
d21987d709e807b drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-09-18  1070  	par->mmio_vp = (unsigned char *) fb_virt;
d21987d709e807b drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-09-18  1071  
3546448338e76a5 drivers/video/fbdev/hyperv_fb.c Jake Oshins       2015-08-05  1072  	info->fix.smem_start = par->mem->start;
d21987d709e807b drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-09-18  1073  	info->fix.smem_len = dio_fb_size;
d21987d709e807b drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-09-18  1074  	info->screen_base = par->dio_vp;
d21987d709e807b drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-09-18  1075  	info->screen_size = dio_fb_size;
68a2d20b79b105f drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1076  
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1077  getmem_done:
8d69d008f44cb96 drivers/video/fbdev/hyperv_fb.c Thomas Zimmermann 2022-07-18  1078  	aperture_remove_conflicting_devices(info->apertures->ranges[0].base,
8d69d008f44cb96 drivers/video/fbdev/hyperv_fb.c Thomas Zimmermann 2022-07-18  1079  					    info->apertures->ranges[0].size,
3a6fb6c4255c389 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09 @1080  					    KBUILD_MODNAME, false);
3cb73bc3fa2a3cb drivers/video/fbdev/hyperv_fb.c Kairui Song       2020-10-14  1081  
3cb73bc3fa2a3cb drivers/video/fbdev/hyperv_fb.c Kairui Song       2020-10-14  1082  	if (gen2vm) {
3cb73bc3fa2a3cb drivers/video/fbdev/hyperv_fb.c Kairui Song       2020-10-14  1083  		/* framebuffer is reallocated, clear screen_info to avoid misuse from kexec */
3cb73bc3fa2a3cb drivers/video/fbdev/hyperv_fb.c Kairui Song       2020-10-14  1084  		screen_info.lfb_size = 0;
3cb73bc3fa2a3cb drivers/video/fbdev/hyperv_fb.c Kairui Song       2020-10-14  1085  		screen_info.lfb_base = 0;
3cb73bc3fa2a3cb drivers/video/fbdev/hyperv_fb.c Kairui Song       2020-10-14  1086  		screen_info.orig_video_isVGA = 0;
3cb73bc3fa2a3cb drivers/video/fbdev/hyperv_fb.c Kairui Song       2020-10-14  1087  	} else {
68a2d20b79b105f drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1088  		pci_dev_put(pdev);
3cb73bc3fa2a3cb drivers/video/fbdev/hyperv_fb.c Kairui Song       2020-10-14  1089  	}
9069fd54960304a drivers/video/hyperv_fb.c       Gerd Hoffmann     2014-02-26  1090  
68a2d20b79b105f drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1091  	return 0;
68a2d20b79b105f drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1092  
68a2d20b79b105f drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1093  err3:
68a2d20b79b105f drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1094  	iounmap(fb_virt);
68a2d20b79b105f drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1095  err2:
696ca5e82c057a2 drivers/video/fbdev/hyperv_fb.c Jake Oshins       2016-04-05  1096  	vmbus_free_mmio(par->mem->start, screen_fb_size);
3546448338e76a5 drivers/video/fbdev/hyperv_fb.c Jake Oshins       2015-08-05  1097  	par->mem = NULL;
68a2d20b79b105f drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1098  err1:
9069fd54960304a drivers/video/hyperv_fb.c       Gerd Hoffmann     2014-02-26  1099  	if (!gen2vm)
68a2d20b79b105f drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1100  		pci_dev_put(pdev);
9069fd54960304a drivers/video/hyperv_fb.c       Gerd Hoffmann     2014-02-26  1101  
68a2d20b79b105f drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1102  	return -ENOMEM;
68a2d20b79b105f drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1103  }
68a2d20b79b105f drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1104  

:::::: The code at line 1080 was first introduced by commit
:::::: 3a6fb6c4255c3893ab61e2bd4e9ae01ca6bbcd94 video: hyperv: hyperv_fb: Use physical memory for fb on HyperV Gen 1 VMs.

:::::: TO: Wei Hu <weh@microsoft.com>
:::::: CC: Sasha Levin <sashal@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
