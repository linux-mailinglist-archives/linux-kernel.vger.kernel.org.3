Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B689B581CD2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 02:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240092AbiG0Aol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 20:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiG0Aog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 20:44:36 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAF3286C7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 17:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658882674; x=1690418674;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YX10oloxAvyKxW08wf2eEZMGJSafvzOo6ATwL/KJXd4=;
  b=jshSWNSX2oEAnpf43Y1gEnUJZOA1Qun50ZXSglBFbYXNsQ2wXLd+I7Lh
   VCAHVlyq7OmcSdNxchiuL+lYppeWqNydw1srxdKqty90+FhGbmzHCGWn/
   esdXxIV9+ipvnn5vYC5NmFVZjP/U0fupzbosTSut4QyW3FqhMvYazyiUD
   0OlnZg0sbJ2l21Q+mTej45wzRs48Tvyq3/etaYcfK9yT3GuTBnWuWfTz8
   /z5z4/AJU4srASH68zZovlhYXTdQf/ZuEEVhvhAu9eWUPJJOVLjGYzLO2
   Mnkvd5k/zR6mZjubHw3/cnC4+ZrZdM867yfS7yiykpT23Ktdv/+KpHe5J
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="352105189"
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="352105189"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 17:44:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="575745469"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Jul 2022 17:44:31 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGVA7-00086g-0o;
        Wed, 27 Jul 2022 00:44:31 +0000
Date:   Wed, 27 Jul 2022 08:44:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [deller-fbdev:for-next 22/22] drivers/video/fbdev/simplefb.c:426:6:
 error: use of undeclared identifier 'num_registered_fb'; did you mean
 'WB_registered'?
Message-ID: <202207270857.mo9oRcRE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git for-next
head:   96eed011e2413fc83f14632e8782f60b76b34a50
commit: 96eed011e2413fc83f14632e8782f60b76b34a50 [22/22] video: fbdev: Make registered_fb[] private to fbmem.c
config: arm64-randconfig-r003-20220724 (https://download.01.org/0day-ci/archive/20220727/202207270857.mo9oRcRE-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 83882606dbd7ffb0bdd3460356202d97705809c8)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git/commit/?id=96eed011e2413fc83f14632e8782f60b76b34a50
        git remote add deller-fbdev git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git
        git fetch --no-tags deller-fbdev for-next
        git checkout 96eed011e2413fc83f14632e8782f60b76b34a50
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/video/fbdev/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/video/fbdev/simplefb.c:426:6: error: use of undeclared identifier 'num_registered_fb'; did you mean 'WB_registered'?
           if (num_registered_fb > 0) {
               ^~~~~~~~~~~~~~~~~
               WB_registered
   include/linux/backing-dev-defs.h:25:2: note: 'WB_registered' declared here
           WB_registered,          /* bdi_register() was done */
           ^
   1 error generated.


vim +426 drivers/video/fbdev/simplefb.c

814740e759afe9 drivers/video/fbdev/simplefb.c Chen-Yu Tsai             2015-11-17  412  
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  413  static int simplefb_probe(struct platform_device *pdev)
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  414  {
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  415  	int ret;
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  416  	struct simplefb_params params;
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  417  	struct fb_info *info;
1270be4a4fb852 drivers/video/fbdev/simplefb.c Luc Verhaegen            2014-11-14  418  	struct simplefb_par *par;
748bd5873d1a6f drivers/video/fbdev/simplefb.c Thomas Zimmermann        2022-01-25  419  	struct resource *res, *mem;
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  420  
fb561bf9abde49 drivers/video/fbdev/simplefb.c Javier Martinez Canillas 2021-11-11  421  	/*
fb561bf9abde49 drivers/video/fbdev/simplefb.c Javier Martinez Canillas 2021-11-11  422  	 * Generic drivers must not be registered if a framebuffer exists.
fb561bf9abde49 drivers/video/fbdev/simplefb.c Javier Martinez Canillas 2021-11-11  423  	 * If a native driver was probed, the display hardware was already
fb561bf9abde49 drivers/video/fbdev/simplefb.c Javier Martinez Canillas 2021-11-11  424  	 * taken and attempting to use the system framebuffer is dangerous.
fb561bf9abde49 drivers/video/fbdev/simplefb.c Javier Martinez Canillas 2021-11-11  425  	 */
fb561bf9abde49 drivers/video/fbdev/simplefb.c Javier Martinez Canillas 2021-11-11 @426  	if (num_registered_fb > 0) {
fb561bf9abde49 drivers/video/fbdev/simplefb.c Javier Martinez Canillas 2021-11-11  427  		dev_err(&pdev->dev,
fb561bf9abde49 drivers/video/fbdev/simplefb.c Javier Martinez Canillas 2021-11-11  428  			"simplefb: a framebuffer is already registered\n");
fb561bf9abde49 drivers/video/fbdev/simplefb.c Javier Martinez Canillas 2021-11-11  429  		return -EINVAL;
fb561bf9abde49 drivers/video/fbdev/simplefb.c Javier Martinez Canillas 2021-11-11  430  	}
fb561bf9abde49 drivers/video/fbdev/simplefb.c Javier Martinez Canillas 2021-11-11  431  
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  432  	if (fb_get_options("simplefb", NULL))
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  433  		return -ENODEV;
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  434  
5ef76da644bf34 drivers/video/simplefb.c       David Herrmann           2013-08-02  435  	ret = -ENODEV;
129f1be4b9357a drivers/video/simplefb.c       Jingoo Han               2013-09-17  436  	if (dev_get_platdata(&pdev->dev))
5ef76da644bf34 drivers/video/simplefb.c       David Herrmann           2013-08-02  437  		ret = simplefb_parse_pd(pdev, &params);
5ef76da644bf34 drivers/video/simplefb.c       David Herrmann           2013-08-02  438  	else if (pdev->dev.of_node)
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  439  		ret = simplefb_parse_dt(pdev, &params);
5ef76da644bf34 drivers/video/simplefb.c       David Herrmann           2013-08-02  440  
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  441  	if (ret)
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  442  		return ret;
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  443  
748bd5873d1a6f drivers/video/fbdev/simplefb.c Thomas Zimmermann        2022-01-25  444  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
748bd5873d1a6f drivers/video/fbdev/simplefb.c Thomas Zimmermann        2022-01-25  445  	if (!res) {
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  446  		dev_err(&pdev->dev, "No memory resource\n");
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  447  		return -EINVAL;
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  448  	}
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  449  
748bd5873d1a6f drivers/video/fbdev/simplefb.c Thomas Zimmermann        2022-01-25  450  	mem = request_mem_region(res->start, resource_size(res), "simplefb");
748bd5873d1a6f drivers/video/fbdev/simplefb.c Thomas Zimmermann        2022-01-25  451  	if (!mem) {
748bd5873d1a6f drivers/video/fbdev/simplefb.c Thomas Zimmermann        2022-01-25  452  		/*
748bd5873d1a6f drivers/video/fbdev/simplefb.c Thomas Zimmermann        2022-01-25  453  		 * We cannot make this fatal. Sometimes this comes from magic
748bd5873d1a6f drivers/video/fbdev/simplefb.c Thomas Zimmermann        2022-01-25  454  		 * spaces our resource handlers simply don't know about. Use
748bd5873d1a6f drivers/video/fbdev/simplefb.c Thomas Zimmermann        2022-01-25  455  		 * the I/O-memory resource as-is and try to map that instead.
748bd5873d1a6f drivers/video/fbdev/simplefb.c Thomas Zimmermann        2022-01-25  456  		 */
748bd5873d1a6f drivers/video/fbdev/simplefb.c Thomas Zimmermann        2022-01-25  457  		dev_warn(&pdev->dev, "simplefb: cannot reserve video memory at %pR\n", res);
748bd5873d1a6f drivers/video/fbdev/simplefb.c Thomas Zimmermann        2022-01-25  458  		mem = res;
748bd5873d1a6f drivers/video/fbdev/simplefb.c Thomas Zimmermann        2022-01-25  459  	}
748bd5873d1a6f drivers/video/fbdev/simplefb.c Thomas Zimmermann        2022-01-25  460  
1270be4a4fb852 drivers/video/fbdev/simplefb.c Luc Verhaegen            2014-11-14  461  	info = framebuffer_alloc(sizeof(struct simplefb_par), &pdev->dev);
748bd5873d1a6f drivers/video/fbdev/simplefb.c Thomas Zimmermann        2022-01-25  462  	if (!info) {
748bd5873d1a6f drivers/video/fbdev/simplefb.c Thomas Zimmermann        2022-01-25  463  		ret = -ENOMEM;
748bd5873d1a6f drivers/video/fbdev/simplefb.c Thomas Zimmermann        2022-01-25  464  		goto error_release_mem_region;
748bd5873d1a6f drivers/video/fbdev/simplefb.c Thomas Zimmermann        2022-01-25  465  	}
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  466  	platform_set_drvdata(pdev, info);
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  467  
1270be4a4fb852 drivers/video/fbdev/simplefb.c Luc Verhaegen            2014-11-14  468  	par = info->par;
1270be4a4fb852 drivers/video/fbdev/simplefb.c Luc Verhaegen            2014-11-14  469  
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  470  	info->fix = simplefb_fix;
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  471  	info->fix.smem_start = mem->start;
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  472  	info->fix.smem_len = resource_size(mem);
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  473  	info->fix.line_length = params.stride;
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  474  
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  475  	info->var = simplefb_var;
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  476  	info->var.xres = params.width;
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  477  	info->var.yres = params.height;
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  478  	info->var.xres_virtual = params.width;
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  479  	info->var.yres_virtual = params.height;
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  480  	info->var.bits_per_pixel = params.format->bits_per_pixel;
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  481  	info->var.red = params.format->red;
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  482  	info->var.green = params.format->green;
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  483  	info->var.blue = params.format->blue;
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  484  	info->var.transp = params.format->transp;
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  485  
df0960ab2d9554 drivers/video/simplefb.c       David Herrmann           2013-08-02  486  	info->apertures = alloc_apertures(1);
df0960ab2d9554 drivers/video/simplefb.c       David Herrmann           2013-08-02  487  	if (!info->apertures) {
bf2fda157a9ab5 drivers/video/fbdev/simplefb.c Luc Verhaegen            2014-11-14  488  		ret = -ENOMEM;
bf2fda157a9ab5 drivers/video/fbdev/simplefb.c Luc Verhaegen            2014-11-14  489  		goto error_fb_release;
df0960ab2d9554 drivers/video/simplefb.c       David Herrmann           2013-08-02  490  	}
df0960ab2d9554 drivers/video/simplefb.c       David Herrmann           2013-08-02  491  	info->apertures->ranges[0].base = info->fix.smem_start;
df0960ab2d9554 drivers/video/simplefb.c       David Herrmann           2013-08-02  492  	info->apertures->ranges[0].size = info->fix.smem_len;
df0960ab2d9554 drivers/video/simplefb.c       David Herrmann           2013-08-02  493  
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  494  	info->fbops = &simplefb_ops;
df0960ab2d9554 drivers/video/simplefb.c       David Herrmann           2013-08-02  495  	info->flags = FBINFO_DEFAULT | FBINFO_MISC_FIRMWARE;
9e210be68a396d drivers/video/simplefb.c       David Herrmann           2013-10-02  496  	info->screen_base = ioremap_wc(info->fix.smem_start,
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  497  				       info->fix.smem_len);
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  498  	if (!info->screen_base) {
bf2fda157a9ab5 drivers/video/fbdev/simplefb.c Luc Verhaegen            2014-11-14  499  		ret = -ENOMEM;
bf2fda157a9ab5 drivers/video/fbdev/simplefb.c Luc Verhaegen            2014-11-14  500  		goto error_fb_release;
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  501  	}
1270be4a4fb852 drivers/video/fbdev/simplefb.c Luc Verhaegen            2014-11-14  502  	info->pseudo_palette = par->palette;
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  503  
a3accfd70e166a drivers/video/fbdev/simplefb.c Hans de Goede            2017-01-11  504  	ret = simplefb_clocks_get(par, pdev);
fc219bfd5b2e48 drivers/video/fbdev/simplefb.c Luc Verhaegen            2014-11-14  505  	if (ret < 0)
fc219bfd5b2e48 drivers/video/fbdev/simplefb.c Luc Verhaegen            2014-11-14  506  		goto error_unmap;
fc219bfd5b2e48 drivers/video/fbdev/simplefb.c Luc Verhaegen            2014-11-14  507  
a3accfd70e166a drivers/video/fbdev/simplefb.c Hans de Goede            2017-01-11  508  	ret = simplefb_regulators_get(par, pdev);
814740e759afe9 drivers/video/fbdev/simplefb.c Chen-Yu Tsai             2015-11-17  509  	if (ret < 0)
814740e759afe9 drivers/video/fbdev/simplefb.c Chen-Yu Tsai             2015-11-17  510  		goto error_clocks;
814740e759afe9 drivers/video/fbdev/simplefb.c Chen-Yu Tsai             2015-11-17  511  
a3accfd70e166a drivers/video/fbdev/simplefb.c Hans de Goede            2017-01-11  512  	simplefb_clocks_enable(par, pdev);
a3accfd70e166a drivers/video/fbdev/simplefb.c Hans de Goede            2017-01-11  513  	simplefb_regulators_enable(par, pdev);
a3accfd70e166a drivers/video/fbdev/simplefb.c Hans de Goede            2017-01-11  514  
5269a618eec7f8 drivers/video/fbdev/simplefb.c Peter Robinson           2020-12-28  515  	dev_info(&pdev->dev, "framebuffer at 0x%lx, 0x%x bytes\n",
5269a618eec7f8 drivers/video/fbdev/simplefb.c Peter Robinson           2020-12-28  516  			     info->fix.smem_start, info->fix.smem_len);
9f192a92286c41 drivers/video/simplefb.c       Tom Gundersen            2013-09-07  517  	dev_info(&pdev->dev, "format=%s, mode=%dx%dx%d, linelength=%d\n",
9f192a92286c41 drivers/video/simplefb.c       Tom Gundersen            2013-09-07  518  			     params.format->name,
9f192a92286c41 drivers/video/simplefb.c       Tom Gundersen            2013-09-07  519  			     info->var.xres, info->var.yres,
9f192a92286c41 drivers/video/simplefb.c       Tom Gundersen            2013-09-07  520  			     info->var.bits_per_pixel, info->fix.line_length);
9f192a92286c41 drivers/video/simplefb.c       Tom Gundersen            2013-09-07  521  
748bd5873d1a6f drivers/video/fbdev/simplefb.c Thomas Zimmermann        2022-01-25  522  	if (mem != res)
748bd5873d1a6f drivers/video/fbdev/simplefb.c Thomas Zimmermann        2022-01-25  523  		par->mem = mem; /* release in clean-up handler */
748bd5873d1a6f drivers/video/fbdev/simplefb.c Thomas Zimmermann        2022-01-25  524  
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  525  	ret = register_framebuffer(info);
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  526  	if (ret < 0) {
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  527  		dev_err(&pdev->dev, "Unable to register simplefb: %d\n", ret);
814740e759afe9 drivers/video/fbdev/simplefb.c Chen-Yu Tsai             2015-11-17  528  		goto error_regulators;
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  529  	}
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  530  
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  531  	dev_info(&pdev->dev, "fb%d: simplefb registered!\n", info->node);
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  532  
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  533  	return 0;
bf2fda157a9ab5 drivers/video/fbdev/simplefb.c Luc Verhaegen            2014-11-14  534  
814740e759afe9 drivers/video/fbdev/simplefb.c Chen-Yu Tsai             2015-11-17  535  error_regulators:
814740e759afe9 drivers/video/fbdev/simplefb.c Chen-Yu Tsai             2015-11-17  536  	simplefb_regulators_destroy(par);
fc219bfd5b2e48 drivers/video/fbdev/simplefb.c Luc Verhaegen            2014-11-14  537  error_clocks:
fc219bfd5b2e48 drivers/video/fbdev/simplefb.c Luc Verhaegen            2014-11-14  538  	simplefb_clocks_destroy(par);
bf2fda157a9ab5 drivers/video/fbdev/simplefb.c Luc Verhaegen            2014-11-14  539  error_unmap:
bf2fda157a9ab5 drivers/video/fbdev/simplefb.c Luc Verhaegen            2014-11-14  540  	iounmap(info->screen_base);
bf2fda157a9ab5 drivers/video/fbdev/simplefb.c Luc Verhaegen            2014-11-14  541  error_fb_release:
bf2fda157a9ab5 drivers/video/fbdev/simplefb.c Luc Verhaegen            2014-11-14  542  	framebuffer_release(info);
748bd5873d1a6f drivers/video/fbdev/simplefb.c Thomas Zimmermann        2022-01-25  543  error_release_mem_region:
748bd5873d1a6f drivers/video/fbdev/simplefb.c Thomas Zimmermann        2022-01-25  544  	if (mem != res)
748bd5873d1a6f drivers/video/fbdev/simplefb.c Thomas Zimmermann        2022-01-25  545  		release_mem_region(mem->start, resource_size(mem));
bf2fda157a9ab5 drivers/video/fbdev/simplefb.c Luc Verhaegen            2014-11-14  546  	return ret;
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  547  }
26549c8d36a64d drivers/video/simplefb.c       Stephen Warren           2013-05-24  548  

:::::: The code at line 426 was first introduced by commit
:::::: fb561bf9abde49f7e00fdbf9ed2ccf2d86cac8ee fbdev: Prevent probing generic drivers if a FB is already registered

:::::: TO: Javier Martinez Canillas <javierm@redhat.com>
:::::: CC: Javier Martinez Canillas <javierm@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
