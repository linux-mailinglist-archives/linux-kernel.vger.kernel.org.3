Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3464D2739
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiCIDgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 22:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiCIDgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 22:36:50 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EA6A0BFA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 19:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646796951; x=1678332951;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YoSvj5HoeHQvE8waVX37sXxIAybhr/FWMyV087iEYCc=;
  b=TTTt/DF4HHC3+z8BuklCkQGlIMh2QM+jYtvYDGxYoHoLROdFl8D5T/Wv
   oojgReKbzL2a043LYzqLcqNZnA9elDv0OXqC1D18lH84joC9ydacV8xIZ
   BDco0KUZjr2ijJRU1OP0wLQLoiU1aij1V0EJM5z+Hcwm22xnpI/f3Z1Qy
   CoMQr3AZvm59uR6Ei27FpvXZksrHH6TEUKBrAT6eDmuFgtF0fajHU8eJd
   fM/IrhlkKtan+VA6Z3qeXm7Q1R7Jd3nQc2oY/puVqeWdb8/Yf1GMnqIRg
   Yg04KSB+WM53VZYMwUc+gMZbjyHMaI4nuaPTMGPzVFJpzD5pLB7MYeF8D
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="318104367"
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="318104367"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 19:35:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="495696030"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 08 Mar 2022 19:35:49 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRn76-0002Vl-Vx; Wed, 09 Mar 2022 03:35:49 +0000
Date:   Wed, 9 Mar 2022 11:35:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: drivers/video/fbdev/kyro/fbdev.c:725:9: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202203091150.upB6zd1n-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   92f90cc9fe0e7a984ea3d4bf3d120e30ba8a2118
commit: a18b14d8886614b3c7d290c4cfc33389822b0535 riscv: Disable STACKPROTECTOR_PER_TASK if GCC_PLUGIN_RANDSTRUCT is enabled
date:   7 months ago
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20220309/202203091150.upB6zd1n-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a18b14d8886614b3c7d290c4cfc33389822b0535
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a18b14d8886614b3c7d290c4cfc33389822b0535
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/ drivers/video/fbdev/kyro/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/video/fbdev/kyro/fbdev.c:725:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/kyro/fbdev.c:725:9: sparse:     expected void *
   drivers/video/fbdev/kyro/fbdev.c:725:9: sparse:     got char [noderef] __iomem *screen_base

vim +725 drivers/video/fbdev/kyro/fbdev.c

^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  661  
48c68c4f1b5424 drivers/video/kyro/fbdev.c       Greg Kroah-Hartman 2012-12-21  662  static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  663  {
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  664  	struct fb_info *info;
a26968df0110bc drivers/video/kyro/fbdev.c       Antonino A. Daplas 2006-01-09  665  	struct kyrofb_info *currentpar;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  666  	unsigned long size;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  667  	int err;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  668  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  669  	if ((err = pci_enable_device(pdev))) {
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  670  		printk(KERN_WARNING "kyrofb: Can't enable pdev: %d\n", err);
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  671  		return err;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  672  	}
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  673  
a26968df0110bc drivers/video/kyro/fbdev.c       Antonino A. Daplas 2006-01-09  674  	info = framebuffer_alloc(sizeof(struct kyrofb_info), &pdev->dev);
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  675  	if (!info)
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  676  		return -ENOMEM;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  677  
a26968df0110bc drivers/video/kyro/fbdev.c       Antonino A. Daplas 2006-01-09  678  	currentpar = info->par;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  679  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  680  	kyro_fix.smem_start = pci_resource_start(pdev, 0);
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  681  	kyro_fix.smem_len   = pci_resource_len(pdev, 0);
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  682  	kyro_fix.mmio_start = pci_resource_start(pdev, 1);
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  683  	kyro_fix.mmio_len   = pci_resource_len(pdev, 1);
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  684  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  685  	currentpar->regbase = deviceInfo.pSTGReg =
4bdc0d676a6431 drivers/video/fbdev/kyro/fbdev.c Christoph Hellwig  2020-01-06  686  		ioremap(kyro_fix.mmio_start, kyro_fix.mmio_len);
9e517ac88b2443 drivers/video/fbdev/kyro/fbdev.c Luis R. Rodriguez  2015-08-24  687  	if (!currentpar->regbase)
9e517ac88b2443 drivers/video/fbdev/kyro/fbdev.c Luis R. Rodriguez  2015-08-24  688  		goto out_free_fb;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  689  
9e517ac88b2443 drivers/video/fbdev/kyro/fbdev.c Luis R. Rodriguez  2015-08-24  690  	info->screen_base = pci_ioremap_wc_bar(pdev, 0);
9e517ac88b2443 drivers/video/fbdev/kyro/fbdev.c Luis R. Rodriguez  2015-08-24  691  	if (!info->screen_base)
9e517ac88b2443 drivers/video/fbdev/kyro/fbdev.c Luis R. Rodriguez  2015-08-24  692  		goto out_unmap_regs;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  693  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  694  	if (!nomtrr)
9e517ac88b2443 drivers/video/fbdev/kyro/fbdev.c Luis R. Rodriguez  2015-08-24  695  		currentpar->wc_cookie = arch_phys_wc_add(kyro_fix.smem_start,
9e517ac88b2443 drivers/video/fbdev/kyro/fbdev.c Luis R. Rodriguez  2015-08-24  696  							 kyro_fix.smem_len);
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  697  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  698  	kyro_fix.ypanstep	= nopan ? 0 : 1;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  699  	kyro_fix.ywrapstep	= nowrap ? 0 : 1;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  700  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  701  	info->fbops		= &kyrofb_ops;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  702  	info->fix		= kyro_fix;
a26968df0110bc drivers/video/kyro/fbdev.c       Antonino A. Daplas 2006-01-09  703  	info->pseudo_palette	= currentpar->palette;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  704  	info->flags		= FBINFO_DEFAULT;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  705  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  706  	SetCoreClockPLL(deviceInfo.pSTGReg, pdev);
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  707  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  708  	deviceInfo.ulNextFreeVidMem = 0;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  709  	deviceInfo.ulOverlayOffset = 0;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  710  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  711  	/* This should give a reasonable default video mode */
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  712  	if (!fb_find_mode(&info->var, info, mode_option, kyro_modedb,
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  713  			  NUM_TOTAL_MODES, &kyro_modedb[VMODE_1024_768_75], 32))
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  714  		info->var = kyro_var;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  715  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  716  	fb_alloc_cmap(&info->cmap, 256, 0);
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  717  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  718  	kyrofb_set_par(info);
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  719  	kyrofb_check_var(&info->var, info);
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  720  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  721  	size = get_line_length(info->var.xres_virtual,
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  722  			       info->var.bits_per_pixel);
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  723  	size *= info->var.yres_virtual;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  724  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16 @725  	fb_memset(info->screen_base, 0, size);
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  726  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  727  	if (register_framebuffer(info) < 0)
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  728  		goto out_unmap;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  729  
31b6780c15a4e3 drivers/video/kyro/fbdev.c       Joe Perches        2013-09-19  730  	fb_info(info, "%s frame buffer device, at %dx%d@%d using %ldk/%ldk of VRAM\n",
31b6780c15a4e3 drivers/video/kyro/fbdev.c       Joe Perches        2013-09-19  731  		info->fix.id,
31b6780c15a4e3 drivers/video/kyro/fbdev.c       Joe Perches        2013-09-19  732  		info->var.xres, info->var.yres, info->var.bits_per_pixel,
31b6780c15a4e3 drivers/video/kyro/fbdev.c       Joe Perches        2013-09-19  733  		size >> 10, (unsigned long)info->fix.smem_len >> 10);
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  734  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  735  	pci_set_drvdata(pdev, info);
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  736  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  737  	return 0;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  738  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  739  out_unmap:
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  740  	iounmap(info->screen_base);
9e517ac88b2443 drivers/video/fbdev/kyro/fbdev.c Luis R. Rodriguez  2015-08-24  741  out_unmap_regs:
9e517ac88b2443 drivers/video/fbdev/kyro/fbdev.c Luis R. Rodriguez  2015-08-24  742  	iounmap(currentpar->regbase);
9e517ac88b2443 drivers/video/fbdev/kyro/fbdev.c Luis R. Rodriguez  2015-08-24  743  out_free_fb:
a26968df0110bc drivers/video/kyro/fbdev.c       Antonino A. Daplas 2006-01-09  744  	framebuffer_release(info);
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  745  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  746  	return -EINVAL;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  747  }
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  748  

:::::: The code at line 725 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
