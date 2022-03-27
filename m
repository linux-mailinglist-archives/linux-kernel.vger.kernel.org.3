Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31654E888B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 17:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbiC0P4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 11:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbiC0P4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 11:56:51 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF56286D7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 08:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648396512; x=1679932512;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=34u6t+Xwa62XzBUwZhcx0t0QMZcrh1CDyQwzr6GSNgo=;
  b=BQPGGO8ZfvNiGaMEhUybP7FA0aofjrzXeF4TCGD1utbkoTW6C7DMUH/h
   vzLidkDnS448aRggQ8ruyZGZmgzjGOExOUABiSK25neoUFZP4GtHXaavQ
   /xVDB9fCBYGQ0KDxtoxY6coPClcK+dFmosljDQ1d5nGzJY/T3o+Otdxfm
   BtJYhUzXHwIppKXahr58E4AmKYihL45YSojZsGApX9vK0RH+yaJc2KnUq
   JDpEL4Jwv8V9F28+5dfL/u5KLr8SM8CmMwr5sBelqVTTPhJCp5QxNU0/N
   oQ8xDVqIOLLYDPN3oZFcAOFGA0lmR7ldfHkuuEIp20R7vKdIZYW4kddy/
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="319561270"
X-IronPort-AV: E=Sophos;i="5.90,215,1643702400"; 
   d="scan'208";a="319561270"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 08:55:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,215,1643702400"; 
   d="scan'208";a="584939383"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 27 Mar 2022 08:55:11 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYVEU-0001Bj-DO; Sun, 27 Mar 2022 15:55:10 +0000
Date:   Sun, 27 Mar 2022 23:54:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/gma500/framebuffer.c:268:9: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202203272321.USs0Iv84-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f022814633e1c600507b3a99691b4d624c2813f0
commit: 28e77cc1c0686621a4d416f599cee5ab369daa0a fortify: Detect struct member overflows in memset() at compile-time
date:   6 weeks ago
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220327/202203272321.USs0Iv84-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=28e77cc1c0686621a4d416f599cee5ab369daa0a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 28e77cc1c0686621a4d416f599cee5ab369daa0a
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/gma500/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/gma500/framebuffer.c:268:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem * @@
   drivers/gpu/drm/gma500/framebuffer.c:268:9: sparse:     expected void const *
   drivers/gpu/drm/gma500/framebuffer.c:268:9: sparse:     got unsigned char [noderef] [usertype] __iomem *
>> drivers/gpu/drm/gma500/framebuffer.c:268:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem * @@
   drivers/gpu/drm/gma500/framebuffer.c:268:9: sparse:     expected void const *
   drivers/gpu/drm/gma500/framebuffer.c:268:9: sparse:     got unsigned char [noderef] [usertype] __iomem *
>> drivers/gpu/drm/gma500/framebuffer.c:268:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got unsigned char [noderef] [usertype] __iomem * @@
   drivers/gpu/drm/gma500/framebuffer.c:268:9: sparse:     expected void *
   drivers/gpu/drm/gma500/framebuffer.c:268:9: sparse:     got unsigned char [noderef] [usertype] __iomem *

vim +268 drivers/gpu/drm/gma500/framebuffer.c

4d8d096e9ae866 Alan Cox           2011-11-03  225  
4d8d096e9ae866 Alan Cox           2011-11-03  226  /**
4d8d096e9ae866 Alan Cox           2011-11-03  227   *	psbfb_create		-	create a framebuffer
358794a29a5fe3 Lee Jones          2021-01-15  228   *	@fb_helper: the framebuffer helper
4d8d096e9ae866 Alan Cox           2011-11-03  229   *	@sizes: specification of the layout
4d8d096e9ae866 Alan Cox           2011-11-03  230   *
4d8d096e9ae866 Alan Cox           2011-11-03  231   *	Create a framebuffer to the specifications provided
4d8d096e9ae866 Alan Cox           2011-11-03  232   */
6b7ce2c4161a00 Thomas Zimmermann  2019-11-22  233  static int psbfb_create(struct drm_fb_helper *fb_helper,
4d8d096e9ae866 Alan Cox           2011-11-03  234  				struct drm_fb_helper_surface_size *sizes)
4d8d096e9ae866 Alan Cox           2011-11-03  235  {
6b7ce2c4161a00 Thomas Zimmermann  2019-11-22  236  	struct drm_device *dev = fb_helper->dev;
f71635e893c383 Thomas Zimmermann  2021-09-20  237  	struct drm_psb_private *dev_priv = to_drm_psb_private(dev);
a2c68495b57986 Thomas Zimmermann  2020-12-01  238  	struct pci_dev *pdev = to_pci_dev(dev->dev);
4d8d096e9ae866 Alan Cox           2011-11-03  239  	struct fb_info *info;
0a8ec2ed0783eb Thomas Zimmermann  2019-11-22  240  	struct drm_framebuffer *fb;
a9a644ac9e8d6c Dave Airlie        2011-11-28  241  	struct drm_mode_fb_cmd2 mode_cmd;
4d8d096e9ae866 Alan Cox           2011-11-03  242  	int size;
4d8d096e9ae866 Alan Cox           2011-11-03  243  	int ret;
f2d061ed01b3f0 Thomas Zimmermann  2021-10-15  244  	struct psb_gem_object *backing;
957a2d0e7ea38d Thomas Zimmermann  2021-10-15  245  	struct drm_gem_object *obj;
a9a644ac9e8d6c Dave Airlie        2011-11-28  246  	u32 bpp, depth;
4d8d096e9ae866 Alan Cox           2011-11-03  247  
4d8d096e9ae866 Alan Cox           2011-11-03  248  	mode_cmd.width = sizes->surface_width;
4d8d096e9ae866 Alan Cox           2011-11-03  249  	mode_cmd.height = sizes->surface_height;
a9a644ac9e8d6c Dave Airlie        2011-11-28  250  	bpp = sizes->surface_bpp;
6aa1ead1b85581 Kirill A. Shutemov 2012-03-08  251  	depth = sizes->surface_depth;
4d8d096e9ae866 Alan Cox           2011-11-03  252  
4d8d096e9ae866 Alan Cox           2011-11-03  253  	/* No 24bit packed */
a9a644ac9e8d6c Dave Airlie        2011-11-28  254  	if (bpp == 24)
a9a644ac9e8d6c Dave Airlie        2011-11-28  255  		bpp = 32;
4d8d096e9ae866 Alan Cox           2011-11-03  256  
ebc7d6470ac4b5 Patrik Jakobsson   2020-10-28  257  	mode_cmd.pitches[0] = ALIGN(mode_cmd.width * DIV_ROUND_UP(bpp, 8), 64);
a6ba582d264f67 Alan Cox           2011-11-29  258  
a6ba582d264f67 Alan Cox           2011-11-29  259  	size = mode_cmd.pitches[0] * mode_cmd.height;
a6ba582d264f67 Alan Cox           2011-11-29  260  	size = ALIGN(size, PAGE_SIZE);
a6ba582d264f67 Alan Cox           2011-11-29  261  
4d8d096e9ae866 Alan Cox           2011-11-03  262  	/* Allocate the framebuffer in the GTT with stolen page backing */
957a2d0e7ea38d Thomas Zimmermann  2021-10-15  263  	backing = psb_gem_create(dev, size, "fb", true, PAGE_SIZE);
957a2d0e7ea38d Thomas Zimmermann  2021-10-15  264  	if (IS_ERR(backing))
957a2d0e7ea38d Thomas Zimmermann  2021-10-15  265  		return PTR_ERR(backing);
f2d061ed01b3f0 Thomas Zimmermann  2021-10-15  266  	obj = &backing->base;
4d8d096e9ae866 Alan Cox           2011-11-03  267  
bb84977941ad85 Alan Cox           2012-05-03 @268  	memset(dev_priv->vram_addr + backing->offset, 0, size);
bb84977941ad85 Alan Cox           2012-05-03  269  
6b7ce2c4161a00 Thomas Zimmermann  2019-11-22  270  	info = drm_fb_helper_alloc_fbi(fb_helper);
546187c85d4d4e Archit Taneja      2015-07-22  271  	if (IS_ERR(info)) {
546187c85d4d4e Archit Taneja      2015-07-22  272  		ret = PTR_ERR(info);
957a2d0e7ea38d Thomas Zimmermann  2021-10-15  273  		goto err_drm_gem_object_put;
4d8d096e9ae866 Alan Cox           2011-11-03  274  	}
4d8d096e9ae866 Alan Cox           2011-11-03  275  
a9a644ac9e8d6c Dave Airlie        2011-11-28  276  	mode_cmd.pixel_format = drm_mode_legacy_fb_format(bpp, depth);
a9a644ac9e8d6c Dave Airlie        2011-11-28  277  
957a2d0e7ea38d Thomas Zimmermann  2021-10-15  278  	fb = psb_framebuffer_create(dev, &mode_cmd, obj);
0a8ec2ed0783eb Thomas Zimmermann  2019-11-22  279  	if (IS_ERR(fb)) {
0a8ec2ed0783eb Thomas Zimmermann  2019-11-22  280  		ret = PTR_ERR(fb);
957a2d0e7ea38d Thomas Zimmermann  2021-10-15  281  		goto err_drm_gem_object_put;
0a8ec2ed0783eb Thomas Zimmermann  2019-11-22  282  	}
4d8d096e9ae866 Alan Cox           2011-11-03  283  
6b7ce2c4161a00 Thomas Zimmermann  2019-11-22  284  	fb_helper->fb = fb;
4d8d096e9ae866 Alan Cox           2011-11-03  285  
a6ba582d264f67 Alan Cox           2011-11-29  286  	info->fbops = &psbfb_unaccel_ops;
4d8d096e9ae866 Alan Cox           2011-11-03  287  
4d8d096e9ae866 Alan Cox           2011-11-03  288  	info->fix.smem_start = dev->mode_config.fb_base;
4d8d096e9ae866 Alan Cox           2011-11-03  289  	info->fix.smem_len = size;
ebc7d6470ac4b5 Patrik Jakobsson   2020-10-28  290  	info->fix.ywrapstep = 0;
a6ba582d264f67 Alan Cox           2011-11-29  291  	info->fix.ypanstep = 0;
4d8d096e9ae866 Alan Cox           2011-11-03  292  
4d8d096e9ae866 Alan Cox           2011-11-03  293  	/* Accessed stolen memory directly */
37214ca00e6474 Kirill A. Shutemov 2012-05-03  294  	info->screen_base = dev_priv->vram_addr + backing->offset;
4d8d096e9ae866 Alan Cox           2011-11-03  295  	info->screen_size = size;
4d8d096e9ae866 Alan Cox           2011-11-03  296  
4d8d096e9ae866 Alan Cox           2011-11-03  297  	if (dev_priv->gtt.stolen_size) {
4d8d096e9ae866 Alan Cox           2011-11-03  298  		info->apertures->ranges[0].base = dev->mode_config.fb_base;
4d8d096e9ae866 Alan Cox           2011-11-03  299  		info->apertures->ranges[0].size = dev_priv->gtt.stolen_size;
4d8d096e9ae866 Alan Cox           2011-11-03  300  	}
4d8d096e9ae866 Alan Cox           2011-11-03  301  
6b7ce2c4161a00 Thomas Zimmermann  2019-11-22  302  	drm_fb_helper_fill_info(info, fb_helper, sizes);
4d8d096e9ae866 Alan Cox           2011-11-03  303  
a2c68495b57986 Thomas Zimmermann  2020-12-01  304  	info->fix.mmio_start = pci_resource_start(pdev, 0);
a2c68495b57986 Thomas Zimmermann  2020-12-01  305  	info->fix.mmio_len = pci_resource_len(pdev, 0);
4d8d096e9ae866 Alan Cox           2011-11-03  306  
fb2a99e15ff0d3 Sascha Hauer       2012-02-06  307  	/* Use default scratch pixmap (info->pixmap.flags = FB_PIXMAP_SYSTEM) */
4d8d096e9ae866 Alan Cox           2011-11-03  308  
e18da8ce7d730b Thomas Zimmermann  2019-11-22  309  	dev_dbg(dev->dev, "allocated %dx%d fb\n", fb->width, fb->height);
4d8d096e9ae866 Alan Cox           2011-11-03  310  
4d8d096e9ae866 Alan Cox           2011-11-03  311  	return 0;
957a2d0e7ea38d Thomas Zimmermann  2021-10-15  312  
957a2d0e7ea38d Thomas Zimmermann  2021-10-15  313  err_drm_gem_object_put:
957a2d0e7ea38d Thomas Zimmermann  2021-10-15  314  	drm_gem_object_put(obj);
4d8d096e9ae866 Alan Cox           2011-11-03  315  	return ret;
4d8d096e9ae866 Alan Cox           2011-11-03  316  }
4d8d096e9ae866 Alan Cox           2011-11-03  317  

:::::: The code at line 268 was first introduced by commit
:::::: bb84977941ad85a5c0b9ff4fd5331913e31107c4 gma500: wide framebuffer memory

:::::: TO: Alan Cox <alan@linux.intel.com>
:::::: CC: Dave Airlie <airlied@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
