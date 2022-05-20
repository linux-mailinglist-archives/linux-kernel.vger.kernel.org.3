Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417B952E14E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 02:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344100AbiETAnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 20:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243558AbiETAm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 20:42:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25CF3EF07;
        Thu, 19 May 2022 17:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653007374; x=1684543374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BajxnFhDjeYK6OJdvg1bDjwAI7zO7CVIHlt3kCTR+TE=;
  b=PPEG40atiujKCRKozYbQOqOhrSj+1HMfjebFc32DeN4cRM+CR2nwQLkE
   HgbMSrbhOWVPB0+cCzroSqNLALPY5Y6ZzgcWLbEQ+6VFqF22bkdknaOqT
   eHmkXZG0iaMSp9SrlUJuBokTa2Xt9a8OIyoaLHkmde/3LRViXe0r9KWmk
   V5xC9RSt9viJFdMtEAYfJE1IJ1qC6rQU6NXcvnnVKXKfXbdQdtO9Low1p
   GFtpf/1Vwior8vLdR0g49mTA9pRcC7pPpVXLlDz4RCEo5bFFzHoMFSCUV
   88V58VTws7YYqp+AEaHBN69CQy0elpnlibAUQu+atuFUzh7LiLddd+2AX
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="358840108"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="358840108"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 17:42:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="598905012"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 19 May 2022 17:42:50 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrqjB-00045d-VE;
        Fri, 20 May 2022 00:42:49 +0000
Date:   Fri, 20 May 2022 08:41:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Uri Arev <me@wantyapps.xyz>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Uri Arev <me@wantyapps.xyz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Len Baker <len.baker@gmx.com>, Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Srivathsa Dara <srivathsa729.8@gmail.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix checkpatch.pl struct should normally
 be const
Message-ID: <202205200821.nJQ0IfFt-lkp@intel.com>
References: <20220519172503.10821-1-me@wantyapps.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519172503.10821-1-me@wantyapps.xyz>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uri,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Uri-Arev/staging-fbtft-fix-checkpatch-pl-struct-should-normally-be-const/20220520-012948
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git 4d0cc9e0e53e9946d7b8dc58279c62dfa7a2191b
config: arm64-randconfig-r011-20220519 (https://download.01.org/0day-ci/archive/20220520/202205200821.nJQ0IfFt-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project e00cbbec06c08dc616a0d52a20f678b8fbd4e304)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/d26e139bfc29011b0a147df71f0b91485189c66e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Uri-Arev/staging-fbtft-fix-checkpatch-pl-struct-should-normally-be-const/20220520-012948
        git checkout d26e139bfc29011b0a147df71f0b91485189c66e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/staging/fbtft/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/staging/fbtft/fbtft-core.c:332:6: warning: variable 'count' set but not used [-Wunused-but-set-variable]
           int count = 0;
               ^
>> drivers/staging/fbtft/fbtft-core.c:617:8: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
           const fbops = devm_kzalloc(dev, sizeof(struct fb_ops), GFP_KERNEL);
           ~~~~~ ^
           int
>> drivers/staging/fbtft/fbtft-core.c:617:8: error: redefinition of 'fbops' with a different type: 'const int' vs 'const struct fb_ops *'
   drivers/staging/fbtft/fbtft-core.c:542:23: note: previous definition is here
           const struct fb_ops *fbops = NULL;
                                ^
>> drivers/staging/fbtft/fbtft-core.c:647:22: error: cannot assign to variable 'fbops' with const-qualified type 'const struct fb_ops *'
           fbops->owner        =      dev->driver->owner;
           ~~~~~~~~~~~~        ^
   drivers/staging/fbtft/fbtft-core.c:542:23: note: variable 'fbops' declared const here
           const struct fb_ops *fbops = NULL;
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
   drivers/staging/fbtft/fbtft-core.c:648:22: error: cannot assign to variable 'fbops' with const-qualified type 'const struct fb_ops *'
           fbops->fb_read      =      fb_sys_read;
           ~~~~~~~~~~~~~~      ^
   drivers/staging/fbtft/fbtft-core.c:542:23: note: variable 'fbops' declared const here
           const struct fb_ops *fbops = NULL;
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
   drivers/staging/fbtft/fbtft-core.c:649:22: error: cannot assign to variable 'fbops' with const-qualified type 'const struct fb_ops *'
           fbops->fb_write     =      fbtft_fb_write;
           ~~~~~~~~~~~~~~~     ^
   drivers/staging/fbtft/fbtft-core.c:542:23: note: variable 'fbops' declared const here
           const struct fb_ops *fbops = NULL;
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
   drivers/staging/fbtft/fbtft-core.c:650:22: error: cannot assign to variable 'fbops' with const-qualified type 'const struct fb_ops *'
           fbops->fb_fillrect  =      fbtft_fb_fillrect;
           ~~~~~~~~~~~~~~~~~~  ^
   drivers/staging/fbtft/fbtft-core.c:542:23: note: variable 'fbops' declared const here
           const struct fb_ops *fbops = NULL;
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
   drivers/staging/fbtft/fbtft-core.c:651:22: error: cannot assign to variable 'fbops' with const-qualified type 'const struct fb_ops *'
           fbops->fb_copyarea  =      fbtft_fb_copyarea;
           ~~~~~~~~~~~~~~~~~~  ^
   drivers/staging/fbtft/fbtft-core.c:542:23: note: variable 'fbops' declared const here
           const struct fb_ops *fbops = NULL;
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
   drivers/staging/fbtft/fbtft-core.c:652:22: error: cannot assign to variable 'fbops' with const-qualified type 'const struct fb_ops *'
           fbops->fb_imageblit =      fbtft_fb_imageblit;
           ~~~~~~~~~~~~~~~~~~~ ^
   drivers/staging/fbtft/fbtft-core.c:542:23: note: variable 'fbops' declared const here
           const struct fb_ops *fbops = NULL;
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
   drivers/staging/fbtft/fbtft-core.c:653:22: error: cannot assign to variable 'fbops' with const-qualified type 'const struct fb_ops *'
           fbops->fb_setcolreg =      fbtft_fb_setcolreg;
           ~~~~~~~~~~~~~~~~~~~ ^
   drivers/staging/fbtft/fbtft-core.c:542:23: note: variable 'fbops' declared const here
           const struct fb_ops *fbops = NULL;
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
   drivers/staging/fbtft/fbtft-core.c:654:22: error: cannot assign to variable 'fbops' with const-qualified type 'const struct fb_ops *'
           fbops->fb_blank     =      fbtft_fb_blank;
           ~~~~~~~~~~~~~~~     ^
   drivers/staging/fbtft/fbtft-core.c:542:23: note: variable 'fbops' declared const here
           const struct fb_ops *fbops = NULL;
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
>> drivers/staging/fbtft/fbtft-core.c:617:8: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
           const fbops = devm_kzalloc(dev, sizeof(struct fb_ops), GFP_KERNEL);
                 ^
   2 warnings and 10 errors generated.


vim +/int +617 drivers/staging/fbtft/fbtft-core.c

   516	
   517	/**
   518	 * fbtft_framebuffer_alloc - creates a new frame buffer info structure
   519	 *
   520	 * @display: pointer to structure describing the display
   521	 * @dev: pointer to the device for this fb, this can be NULL
   522	 * @pdata: platform data for the display in use
   523	 *
   524	 * Creates a new frame buffer info structure.
   525	 *
   526	 * Also creates and populates the following structures:
   527	 *   info->fbops
   528	 *   info->fbdefio
   529	 *   info->pseudo_palette
   530	 *   par->fbtftops
   531	 *   par->txbuf
   532	 *
   533	 * Returns the new structure, or NULL if an error occurred.
   534	 *
   535	 */
   536	struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
   537						struct device *dev,
   538						struct fbtft_platform_data *pdata)
   539	{
   540		struct fb_info *info;
   541		struct fbtft_par *par;
   542		const struct fb_ops *fbops = NULL;
   543		struct fb_deferred_io *fbdefio = NULL;
   544		u8 *vmem = NULL;
   545		void *txbuf = NULL;
   546		void *buf = NULL;
   547		unsigned int width;
   548		unsigned int height;
   549		int txbuflen = display->txbuflen;
   550		unsigned int bpp = display->bpp;
   551		unsigned int fps = display->fps;
   552		int vmem_size;
   553		const s16 *init_sequence = display->init_sequence;
   554		char *gamma = display->gamma;
   555		u32 *gamma_curves = NULL;
   556	
   557		/* sanity check */
   558		if (display->gamma_num * display->gamma_len >
   559				FBTFT_GAMMA_MAX_VALUES_TOTAL) {
   560			dev_err(dev, "FBTFT_GAMMA_MAX_VALUES_TOTAL=%d is exceeded\n",
   561				FBTFT_GAMMA_MAX_VALUES_TOTAL);
   562			return NULL;
   563		}
   564	
   565		/* defaults */
   566		if (!fps)
   567			fps = 20;
   568		if (!bpp)
   569			bpp = 16;
   570	
   571		if (!pdata) {
   572			dev_err(dev, "platform data is missing\n");
   573			return NULL;
   574		}
   575	
   576		/* override driver values? */
   577		if (pdata->fps)
   578			fps = pdata->fps;
   579		if (pdata->txbuflen)
   580			txbuflen = pdata->txbuflen;
   581		if (pdata->display.init_sequence)
   582			init_sequence = pdata->display.init_sequence;
   583		if (pdata->gamma)
   584			gamma = pdata->gamma;
   585		if (pdata->display.debug)
   586			display->debug = pdata->display.debug;
   587		if (pdata->display.backlight)
   588			display->backlight = pdata->display.backlight;
   589		if (pdata->display.width)
   590			display->width = pdata->display.width;
   591		if (pdata->display.height)
   592			display->height = pdata->display.height;
   593		if (pdata->display.buswidth)
   594			display->buswidth = pdata->display.buswidth;
   595		if (pdata->display.regwidth)
   596			display->regwidth = pdata->display.regwidth;
   597	
   598		display->debug |= debug;
   599		fbtft_expand_debug_value(&display->debug);
   600	
   601		switch (pdata->rotate) {
   602		case 90:
   603		case 270:
   604			width =  display->height;
   605			height = display->width;
   606			break;
   607		default:
   608			width =  display->width;
   609			height = display->height;
   610		}
   611	
   612		vmem_size = display->width * display->height * bpp / 8;
   613		vmem = vzalloc(vmem_size);
   614		if (!vmem)
   615			goto alloc_fail;
   616	
 > 617		const fbops = devm_kzalloc(dev, sizeof(struct fb_ops), GFP_KERNEL);
   618		if (!fbops)
   619			goto alloc_fail;
   620	
   621		fbdefio = devm_kzalloc(dev, sizeof(struct fb_deferred_io), GFP_KERNEL);
   622		if (!fbdefio)
   623			goto alloc_fail;
   624	
   625		buf = devm_kzalloc(dev, 128, GFP_KERNEL);
   626		if (!buf)
   627			goto alloc_fail;
   628	
   629		if (display->gamma_num && display->gamma_len) {
   630			gamma_curves = devm_kcalloc(dev,
   631						    display->gamma_num *
   632						    display->gamma_len,
   633						    sizeof(gamma_curves[0]),
   634						    GFP_KERNEL);
   635			if (!gamma_curves)
   636				goto alloc_fail;
   637		}
   638	
   639		info = framebuffer_alloc(sizeof(struct fbtft_par), dev);
   640		if (!info)
   641			goto alloc_fail;
   642	
   643		info->screen_buffer = vmem;
   644		info->fbops = fbops;
   645		info->fbdefio = fbdefio;
   646	
 > 647		fbops->owner        =      dev->driver->owner;
   648		fbops->fb_read      =      fb_sys_read;
   649		fbops->fb_write     =      fbtft_fb_write;
   650		fbops->fb_fillrect  =      fbtft_fb_fillrect;
   651		fbops->fb_copyarea  =      fbtft_fb_copyarea;
   652		fbops->fb_imageblit =      fbtft_fb_imageblit;
   653		fbops->fb_setcolreg =      fbtft_fb_setcolreg;
   654		fbops->fb_blank     =      fbtft_fb_blank;
   655	
   656		fbdefio->delay =           HZ / fps;
   657		fbdefio->sort_pagelist =   true;
   658		fbdefio->deferred_io =     fbtft_deferred_io;
   659		fb_deferred_io_init(info);
   660	
   661		snprintf(info->fix.id, sizeof(info->fix.id), "%s", dev->driver->name);
   662		info->fix.type =           FB_TYPE_PACKED_PIXELS;
   663		info->fix.visual =         FB_VISUAL_TRUECOLOR;
   664		info->fix.xpanstep =	   0;
   665		info->fix.ypanstep =	   0;
   666		info->fix.ywrapstep =	   0;
   667		info->fix.line_length =    width * bpp / 8;
   668		info->fix.accel =          FB_ACCEL_NONE;
   669		info->fix.smem_len =       vmem_size;
   670	
   671		info->var.rotate =         pdata->rotate;
   672		info->var.xres =           width;
   673		info->var.yres =           height;
   674		info->var.xres_virtual =   info->var.xres;
   675		info->var.yres_virtual =   info->var.yres;
   676		info->var.bits_per_pixel = bpp;
   677		info->var.nonstd =         1;
   678	
   679		/* RGB565 */
   680		info->var.red.offset =     11;
   681		info->var.red.length =     5;
   682		info->var.green.offset =   5;
   683		info->var.green.length =   6;
   684		info->var.blue.offset =    0;
   685		info->var.blue.length =    5;
   686		info->var.transp.offset =  0;
   687		info->var.transp.length =  0;
   688	
   689		info->flags =              FBINFO_FLAG_DEFAULT | FBINFO_VIRTFB;
   690	
   691		par = info->par;
   692		par->info = info;
   693		par->pdata = pdata;
   694		par->debug = display->debug;
   695		par->buf = buf;
   696		spin_lock_init(&par->dirty_lock);
   697		par->bgr = pdata->bgr;
   698		par->startbyte = pdata->startbyte;
   699		par->init_sequence = init_sequence;
   700		par->gamma.curves = gamma_curves;
   701		par->gamma.num_curves = display->gamma_num;
   702		par->gamma.num_values = display->gamma_len;
   703		mutex_init(&par->gamma.lock);
   704		info->pseudo_palette = par->pseudo_palette;
   705	
   706		if (par->gamma.curves && gamma) {
   707			if (fbtft_gamma_parse_str(par, par->gamma.curves, gamma,
   708						  strlen(gamma)))
   709				goto release_framebuf;
   710		}
   711	
   712		/* Transmit buffer */
   713		if (txbuflen == -1)
   714			txbuflen = vmem_size + 2; /* add in case startbyte is used */
   715		if (txbuflen >= vmem_size + 2)
   716			txbuflen = 0;
   717	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
