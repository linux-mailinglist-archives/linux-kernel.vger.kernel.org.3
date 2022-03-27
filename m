Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B404E88D3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 18:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbiC0Q1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 12:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiC0Q1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 12:27:54 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F4E50076
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 09:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648398375; x=1679934375;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7i0z24uwur3pdk7vHbwoBPtRP4iokLyG04FKmo17cew=;
  b=ChPY7USdlosJseZCmsGWlKoxEIT4ZFU5mw9hkKpyC3OTICu0wDwmPMiA
   F1N131oK6i1tieIe7QyJ27zNgovIz3ZIfqTvx/05T8TIpxf7Rm3mSV8N7
   lRXnSbEX+1PeJP5ZcNqQoOVl45Islry5P/iODyKwY2CfA8yA1Y51VbLs4
   41DssaydeF1aHBH3oJb159oO78peAkTKuRuemTlY/RKXGVJTYzDrT9wlh
   FwQxHuluoMRHaJ8x4cAWDvrvju1tYHps119yXNcD+KWBwdiCsFg3WKQUz
   b2T1keQ9u9GeEIc0RFKerBWnKDI+LnUSJJahI0GNhj6GZXG3dKeawm7BJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="258830084"
X-IronPort-AV: E=Sophos;i="5.90,215,1643702400"; 
   d="scan'208";a="258830084"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 09:26:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,215,1643702400"; 
   d="scan'208";a="545671579"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 27 Mar 2022 09:26:13 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYViW-0001Eg-B1; Sun, 27 Mar 2022 16:26:12 +0000
Date:   Mon, 28 Mar 2022 00:25:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/cirrusfb.c:1852:17: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202203280028.6JmzLLX5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f022814633e1c600507b3a99691b4d624c2813f0
commit: f68f2ff91512c199ec24883001245912afc17873 fortify: Detect struct member overflows in memcpy() at compile-time
date:   6 weeks ago
config: i386-randconfig-s001 (https://download.01.org/0day-ci/archive/20220328/202203280028.6JmzLLX5-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f68f2ff91512c199ec24883001245912afc17873
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f68f2ff91512c199ec24883001245912afc17873
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/video/fbdev/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/video/fbdev/cirrusfb.c:1852:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/cirrusfb.c:1852:17: sparse:     expected void const *
   drivers/video/fbdev/cirrusfb.c:1852:17: sparse:     got char [noderef] __iomem *screen_base
>> drivers/video/fbdev/cirrusfb.c:1852:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/cirrusfb.c:1852:17: sparse:     expected void const *
   drivers/video/fbdev/cirrusfb.c:1852:17: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/cirrusfb.c:1852:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/cirrusfb.c:1852:17: sparse:     expected void *
   drivers/video/fbdev/cirrusfb.c:1852:17: sparse:     got char [noderef] __iomem *screen_base
--
>> drivers/video/fbdev/geode/suspend_gx.c:30:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *gp_regs @@
   drivers/video/fbdev/geode/suspend_gx.c:30:9: sparse:     expected void const *
   drivers/video/fbdev/geode/suspend_gx.c:30:9: sparse:     got void [noderef] __iomem *gp_regs
>> drivers/video/fbdev/geode/suspend_gx.c:30:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *gp_regs @@
   drivers/video/fbdev/geode/suspend_gx.c:30:9: sparse:     expected void const *
   drivers/video/fbdev/geode/suspend_gx.c:30:9: sparse:     got void [noderef] __iomem *gp_regs
   drivers/video/fbdev/geode/suspend_gx.c:30:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *gp_regs @@
   drivers/video/fbdev/geode/suspend_gx.c:30:9: sparse:     expected void const *
   drivers/video/fbdev/geode/suspend_gx.c:30:9: sparse:     got void [noderef] __iomem *gp_regs
>> drivers/video/fbdev/geode/suspend_gx.c:31:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *dc_regs @@
   drivers/video/fbdev/geode/suspend_gx.c:31:9: sparse:     expected void const *
   drivers/video/fbdev/geode/suspend_gx.c:31:9: sparse:     got void [noderef] __iomem *dc_regs
>> drivers/video/fbdev/geode/suspend_gx.c:31:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *dc_regs @@
   drivers/video/fbdev/geode/suspend_gx.c:31:9: sparse:     expected void const *
   drivers/video/fbdev/geode/suspend_gx.c:31:9: sparse:     got void [noderef] __iomem *dc_regs
   drivers/video/fbdev/geode/suspend_gx.c:31:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *dc_regs @@
   drivers/video/fbdev/geode/suspend_gx.c:31:9: sparse:     expected void const *
   drivers/video/fbdev/geode/suspend_gx.c:31:9: sparse:     got void [noderef] __iomem *dc_regs
>> drivers/video/fbdev/geode/suspend_gx.c:32:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *vid_regs @@
   drivers/video/fbdev/geode/suspend_gx.c:32:9: sparse:     expected void const *
   drivers/video/fbdev/geode/suspend_gx.c:32:9: sparse:     got void [noderef] __iomem *vid_regs
>> drivers/video/fbdev/geode/suspend_gx.c:32:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *vid_regs @@
   drivers/video/fbdev/geode/suspend_gx.c:32:9: sparse:     expected void const *
   drivers/video/fbdev/geode/suspend_gx.c:32:9: sparse:     got void [noderef] __iomem *vid_regs
   drivers/video/fbdev/geode/suspend_gx.c:32:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *vid_regs @@
   drivers/video/fbdev/geode/suspend_gx.c:32:9: sparse:     expected void const *
   drivers/video/fbdev/geode/suspend_gx.c:32:9: sparse:     got void [noderef] __iomem *vid_regs
>> drivers/video/fbdev/geode/suspend_gx.c:33:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/video/fbdev/geode/suspend_gx.c:33:9: sparse:     expected void const *
   drivers/video/fbdev/geode/suspend_gx.c:33:9: sparse:     got void [noderef] __iomem *
>> drivers/video/fbdev/geode/suspend_gx.c:33:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/video/fbdev/geode/suspend_gx.c:33:9: sparse:     expected void const *
   drivers/video/fbdev/geode/suspend_gx.c:33:9: sparse:     got void [noderef] __iomem *
   drivers/video/fbdev/geode/suspend_gx.c:33:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/video/fbdev/geode/suspend_gx.c:33:9: sparse:     expected void const *
   drivers/video/fbdev/geode/suspend_gx.c:33:9: sparse:     got void [noderef] __iomem *
--
>> drivers/video/fbdev/geode/lxfb_ops.c:602:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *gp_regs @@
   drivers/video/fbdev/geode/lxfb_ops.c:602:9: sparse:     expected void const *
   drivers/video/fbdev/geode/lxfb_ops.c:602:9: sparse:     got void [noderef] __iomem *gp_regs
>> drivers/video/fbdev/geode/lxfb_ops.c:602:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *gp_regs @@
   drivers/video/fbdev/geode/lxfb_ops.c:602:9: sparse:     expected void const *
   drivers/video/fbdev/geode/lxfb_ops.c:602:9: sparse:     got void [noderef] __iomem *gp_regs
   drivers/video/fbdev/geode/lxfb_ops.c:602:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *gp_regs @@
   drivers/video/fbdev/geode/lxfb_ops.c:602:9: sparse:     expected void const *
   drivers/video/fbdev/geode/lxfb_ops.c:602:9: sparse:     got void [noderef] __iomem *gp_regs
>> drivers/video/fbdev/geode/lxfb_ops.c:603:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *dc_regs @@
   drivers/video/fbdev/geode/lxfb_ops.c:603:9: sparse:     expected void const *
   drivers/video/fbdev/geode/lxfb_ops.c:603:9: sparse:     got void [noderef] __iomem *dc_regs
>> drivers/video/fbdev/geode/lxfb_ops.c:603:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *dc_regs @@
   drivers/video/fbdev/geode/lxfb_ops.c:603:9: sparse:     expected void const *
   drivers/video/fbdev/geode/lxfb_ops.c:603:9: sparse:     got void [noderef] __iomem *dc_regs
   drivers/video/fbdev/geode/lxfb_ops.c:603:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *dc_regs @@
   drivers/video/fbdev/geode/lxfb_ops.c:603:9: sparse:     expected void const *
   drivers/video/fbdev/geode/lxfb_ops.c:603:9: sparse:     got void [noderef] __iomem *dc_regs
>> drivers/video/fbdev/geode/lxfb_ops.c:604:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *vp_regs @@
   drivers/video/fbdev/geode/lxfb_ops.c:604:9: sparse:     expected void const *
   drivers/video/fbdev/geode/lxfb_ops.c:604:9: sparse:     got void [noderef] __iomem *vp_regs
>> drivers/video/fbdev/geode/lxfb_ops.c:604:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *vp_regs @@
   drivers/video/fbdev/geode/lxfb_ops.c:604:9: sparse:     expected void const *
   drivers/video/fbdev/geode/lxfb_ops.c:604:9: sparse:     got void [noderef] __iomem *vp_regs
   drivers/video/fbdev/geode/lxfb_ops.c:604:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *vp_regs @@
   drivers/video/fbdev/geode/lxfb_ops.c:604:9: sparse:     expected void const *
   drivers/video/fbdev/geode/lxfb_ops.c:604:9: sparse:     got void [noderef] __iomem *vp_regs
>> drivers/video/fbdev/geode/lxfb_ops.c:605:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/video/fbdev/geode/lxfb_ops.c:605:9: sparse:     expected void const *
   drivers/video/fbdev/geode/lxfb_ops.c:605:9: sparse:     got void [noderef] __iomem *
>> drivers/video/fbdev/geode/lxfb_ops.c:605:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/video/fbdev/geode/lxfb_ops.c:605:9: sparse:     expected void const *
   drivers/video/fbdev/geode/lxfb_ops.c:605:9: sparse:     got void [noderef] __iomem *
   drivers/video/fbdev/geode/lxfb_ops.c:605:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/video/fbdev/geode/lxfb_ops.c:605:9: sparse:     expected void const *
   drivers/video/fbdev/geode/lxfb_ops.c:605:9: sparse:     got void [noderef] __iomem *
   drivers/video/fbdev/geode/lxfb_ops.c:633:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/video/fbdev/geode/lxfb_ops.c:633:9: sparse:     expected void const *
   drivers/video/fbdev/geode/lxfb_ops.c:633:9: sparse:     got void [noderef] __iomem *
   drivers/video/fbdev/geode/lxfb_ops.c:633:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/video/fbdev/geode/lxfb_ops.c:633:9: sparse:     expected void const *
   drivers/video/fbdev/geode/lxfb_ops.c:633:9: sparse:     got void [noderef] __iomem *
   drivers/video/fbdev/geode/lxfb_ops.c:633:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/video/fbdev/geode/lxfb_ops.c:633:9: sparse:     expected void const *
   drivers/video/fbdev/geode/lxfb_ops.c:633:9: sparse:     got void [noderef] __iomem *
   drivers/video/fbdev/geode/lxfb_ops.c:760:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/video/fbdev/geode/lxfb_ops.c:760:9: sparse:     expected void const *
   drivers/video/fbdev/geode/lxfb_ops.c:760:9: sparse:     got void [noderef] __iomem *
   drivers/video/fbdev/geode/lxfb_ops.c:760:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   drivers/video/fbdev/geode/lxfb_ops.c:760:9: sparse:     expected void const *
   drivers/video/fbdev/geode/lxfb_ops.c:760:9: sparse:     got void [noderef] __iomem *
>> drivers/video/fbdev/geode/lxfb_ops.c:760:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   drivers/video/fbdev/geode/lxfb_ops.c:760:9: sparse:     expected void *
   drivers/video/fbdev/geode/lxfb_ops.c:760:9: sparse:     got void [noderef] __iomem *

vim +1852 drivers/video/fbdev/cirrusfb.c

^1da177e4c3f415 drivers/video/cirrusfb.c Linus Torvalds 2005-04-16  1809  
8503df65976d0f8 drivers/video/cirrusfb.c Krzysztof Helt 2007-10-16  1810  static void cirrusfb_imageblit(struct fb_info *info,
8503df65976d0f8 drivers/video/cirrusfb.c Krzysztof Helt 2007-10-16  1811  			       const struct fb_image *image)
^1da177e4c3f415 drivers/video/cirrusfb.c Linus Torvalds 2005-04-16  1812  {
^1da177e4c3f415 drivers/video/cirrusfb.c Linus Torvalds 2005-04-16  1813  	struct cirrusfb_info *cinfo = info->par;
7cade31cabec33c drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1814  	unsigned char op = (info->var.bits_per_pixel == 24) ? 0xc : 0x4;
^1da177e4c3f415 drivers/video/cirrusfb.c Linus Torvalds 2005-04-16  1815  
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1816  	if (info->state != FBINFO_STATE_RUNNING)
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1817  		return;
df3aafd57d590d6 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1818  	/* Alpine/SD64 does not work at 24bpp ??? */
df3aafd57d590d6 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1819  	if (info->flags & FBINFO_HWACCEL_DISABLED || image->depth != 1)
df3aafd57d590d6 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1820  		cfb_imageblit(info, image);
df3aafd57d590d6 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1821  	else if ((cinfo->btype == BT_ALPINE || cinfo->btype == BT_SD64) &&
df3aafd57d590d6 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1822  		  op == 0xc)
^1da177e4c3f415 drivers/video/cirrusfb.c Linus Torvalds 2005-04-16  1823  		cfb_imageblit(info, image);
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1824  	else {
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1825  		unsigned size = ((image->width + 7) >> 3) * image->height;
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1826  		int m = info->var.bits_per_pixel;
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1827  		u32 fg, bg;
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1828  
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1829  		if (info->var.bits_per_pixel == 8) {
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1830  			fg = image->fg_color;
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1831  			bg = image->bg_color;
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1832  		} else {
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1833  			fg = ((u32 *)(info->pseudo_palette))[image->fg_color];
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1834  			bg = ((u32 *)(info->pseudo_palette))[image->bg_color];
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1835  		}
7cade31cabec33c drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1836  		if (info->var.bits_per_pixel == 24) {
7cade31cabec33c drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1837  			/* clear background first */
7cade31cabec33c drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1838  			cirrusfb_RectFill(cinfo->regbase,
7cade31cabec33c drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1839  					  info->var.bits_per_pixel,
7cade31cabec33c drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1840  					  (image->dx * m) / 8, image->dy,
7cade31cabec33c drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1841  					  (image->width * m) / 8,
7cade31cabec33c drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1842  					  image->height,
7cade31cabec33c drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1843  					  bg, bg,
7cade31cabec33c drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1844  					  info->fix.line_length, 0x40);
7cade31cabec33c drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1845  		}
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1846  		cirrusfb_RectFill(cinfo->regbase,
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1847  				  info->var.bits_per_pixel,
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1848  				  (image->dx * m) / 8, image->dy,
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1849  				  (image->width * m) / 8, image->height,
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1850  				  fg, bg,
7cade31cabec33c drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1851  				  info->fix.line_length, op);
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31 @1852  		memcpy(info->screen_base, image->data, size);
9e8480625332071 drivers/video/cirrusfb.c Krzysztof Helt 2009-03-31  1853  	}
^1da177e4c3f415 drivers/video/cirrusfb.c Linus Torvalds 2005-04-16  1854  }
^1da177e4c3f415 drivers/video/cirrusfb.c Linus Torvalds 2005-04-16  1855  

:::::: The code at line 1852 was first introduced by commit
:::::: 9e848062533207130667f6eaa748549367ccbedf cirrusfb: add imageblit function

:::::: TO: Krzysztof Helt <krzysztof.h1@wp.pl>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
