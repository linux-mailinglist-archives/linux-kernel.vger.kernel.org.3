Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06534E8927
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 19:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbiC0RtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 13:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiC0Rs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 13:48:58 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334C713DDC
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 10:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648403239; x=1679939239;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OUpNPueGOH4YaEWggnAceZWPfZs0gAnOejGtcmFM+RA=;
  b=ETFDJU40mkNV9kMHCPgVr+T7Ud89FNQg+o4u9ti8KitJrLbg22IpHrNW
   pG/hD72pTZ66Ld3lSLGcf1fQFg+qtsSlNYzONUk+26ocEZ6PO4aJrz/nt
   ii4Ffs10vx9k8kGuoSz1widdoPw8ILgDszhG0XxKcWt0NRDCip3lIrP4r
   ipjBach6uJ2s26DFJBtMjYlampjnKcvk2D1WQxh9DOG+857YQchRmLqMf
   TMBdfFLBjouqj87eOwOQiscvlRaZ+5WP4t+DGg3Mnvi5GN/wqTd+belQF
   7zD1bP9B6GJDn9l+XToz7yQICmfqmkNxN8uHAK7+axYOi9waynwcdoWdN
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="241019823"
X-IronPort-AV: E=Sophos;i="5.90,215,1643702400"; 
   d="scan'208";a="241019823"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 10:47:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,215,1643702400"; 
   d="scan'208";a="520740138"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 27 Mar 2022 10:47:16 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYWyx-0001HW-Tf; Sun, 27 Mar 2022 17:47:15 +0000
Date:   Mon, 28 Mar 2022 01:47:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/i740fb.c:743:9: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202203280145.msqrXeT4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f022814633e1c600507b3a99691b4d624c2813f0
commit: 28e77cc1c0686621a4d416f599cee5ab369daa0a fortify: Detect struct member overflows in memset() at compile-time
date:   6 weeks ago
config: i386-randconfig-s001 (https://download.01.org/0day-ci/archive/20220328/202203280145.msqrXeT4-lkp@intel.com/config)
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
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/video/fbdev/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/video/fbdev/i740fb.c:743:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/i740fb.c:743:9: sparse:     expected void const *
   drivers/video/fbdev/i740fb.c:743:9: sparse:     got char [noderef] __iomem *screen_base
>> drivers/video/fbdev/i740fb.c:743:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/i740fb.c:743:9: sparse:     expected void const *
   drivers/video/fbdev/i740fb.c:743:9: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/i740fb.c:743:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/i740fb.c:743:9: sparse:     expected void *
   drivers/video/fbdev/i740fb.c:743:9: sparse:     got char [noderef] __iomem *screen_base

vim +743 drivers/video/fbdev/i740fb.c

5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  732  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  733  static int i740fb_set_par(struct fb_info *info)
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  734  {
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  735  	struct i740fb_par *par = info->par;
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  736  	u32 itemp;
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  737  	int i;
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  738  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  739  	i = i740fb_decode_var(&info->var, par, info);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  740  	if (i)
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  741  		return i;
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  742  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10 @743  	memset(info->screen_base, 0, info->screen_size);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  744  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  745  	vga_protect(par);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  746  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  747  	i740outreg(par, XRX, DRAM_EXT_CNTL, DRAM_REFRESH_DISABLE);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  748  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  749  	mdelay(1);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  750  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  751  	i740outreg(par, XRX, VCLK2_VCO_M, par->video_clk2_m);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  752  	i740outreg(par, XRX, VCLK2_VCO_N, par->video_clk2_n);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  753  	i740outreg(par, XRX, VCLK2_VCO_MN_MSBS, par->video_clk2_mn_msbs);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  754  	i740outreg(par, XRX, VCLK2_VCO_DIV_SEL, par->video_clk2_div_sel);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  755  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  756  	i740outreg_mask(par, XRX, PIXPIPE_CONFIG_0,
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  757  			par->pixelpipe_cfg0 & DAC_8_BIT, 0x80);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  758  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  759  	i740inb(par, 0x3DA);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  760  	i740outb(par, 0x3C0, 0x00);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  761  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  762  	/* update misc output register */
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  763  	i740outb(par, VGA_MIS_W, par->misc | 0x01);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  764  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  765  	/* synchronous reset on */
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  766  	i740outreg(par, VGA_SEQ_I, VGA_SEQ_RESET, 0x01);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  767  	/* write sequencer registers */
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  768  	i740outreg(par, VGA_SEQ_I, VGA_SEQ_CLOCK_MODE,
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  769  			par->seq[VGA_SEQ_CLOCK_MODE] | 0x20);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  770  	for (i = 2; i < VGA_SEQ_C; i++)
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  771  		i740outreg(par, VGA_SEQ_I, i, par->seq[i]);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  772  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  773  	/* synchronous reset off */
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  774  	i740outreg(par, VGA_SEQ_I, VGA_SEQ_RESET, 0x03);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  775  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  776  	/* deprotect CRT registers 0-7 */
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  777  	i740outreg(par, VGA_CRT_IC, VGA_CRTC_V_SYNC_END,
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  778  			par->crtc[VGA_CRTC_V_SYNC_END]);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  779  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  780  	/* write CRT registers */
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  781  	for (i = 0; i < VGA_CRT_C; i++)
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  782  		i740outreg(par, VGA_CRT_IC, i, par->crtc[i]);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  783  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  784  	/* write graphics controller registers */
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  785  	for (i = 0; i < VGA_GFX_C; i++)
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  786  		i740outreg(par, VGA_GFX_I, i, par->gdc[i]);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  787  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  788  	/* write attribute controller registers */
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  789  	for (i = 0; i < VGA_ATT_C; i++) {
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  790  		i740inb(par, VGA_IS1_RC);		/* reset flip-flop */
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  791  		i740outb(par, VGA_ATT_IW, i);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  792  		i740outb(par, VGA_ATT_IW, par->atc[i]);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  793  	}
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  794  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  795  	i740inb(par, VGA_IS1_RC);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  796  	i740outb(par, VGA_ATT_IW, 0x20);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  797  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  798  	i740outreg(par, VGA_CRT_IC, EXT_VERT_TOTAL, par->ext_vert_total);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  799  	i740outreg(par, VGA_CRT_IC, EXT_VERT_DISPLAY, par->ext_vert_disp_end);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  800  	i740outreg(par, VGA_CRT_IC, EXT_VERT_SYNC_START,
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  801  			par->ext_vert_sync_start);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  802  	i740outreg(par, VGA_CRT_IC, EXT_VERT_BLANK_START,
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  803  			par->ext_vert_blank_start);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  804  	i740outreg(par, VGA_CRT_IC, EXT_HORIZ_TOTAL, par->ext_horiz_total);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  805  	i740outreg(par, VGA_CRT_IC, EXT_HORIZ_BLANK, par->ext_horiz_blank);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  806  	i740outreg(par, VGA_CRT_IC, EXT_OFFSET, par->ext_offset);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  807  	i740outreg(par, VGA_CRT_IC, EXT_START_ADDR_HI, par->ext_start_addr_hi);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  808  	i740outreg(par, VGA_CRT_IC, EXT_START_ADDR, par->ext_start_addr);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  809  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  810  	i740outreg_mask(par, VGA_CRT_IC, INTERLACE_CNTL,
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  811  			par->interlace_cntl, INTERLACE_ENABLE);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  812  	i740outreg_mask(par, XRX, ADDRESS_MAPPING, par->address_mapping, 0x1F);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  813  	i740outreg_mask(par, XRX, BITBLT_CNTL, par->bitblt_cntl, COLEXP_MODE);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  814  	i740outreg_mask(par, XRX, DISPLAY_CNTL,
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  815  			par->display_cntl, VGA_WRAP_MODE | GUI_MODE);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  816  	i740outreg_mask(par, XRX, PIXPIPE_CONFIG_0, par->pixelpipe_cfg0, 0x9B);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  817  	i740outreg_mask(par, XRX, PIXPIPE_CONFIG_2, par->pixelpipe_cfg2, 0x0C);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  818  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  819  	i740outreg(par, XRX, PLL_CNTL, par->pll_cntl);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  820  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  821  	i740outreg_mask(par, XRX, PIXPIPE_CONFIG_1,
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  822  			par->pixelpipe_cfg1, DISPLAY_COLOR_MODE);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  823  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  824  	itemp = readl(par->regs + FWATER_BLC);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  825  	itemp &= ~(LMI_BURST_LENGTH | LMI_FIFO_WATERMARK);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  826  	itemp |= par->lmi_fifo_watermark;
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  827  	writel(itemp, par->regs + FWATER_BLC);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  828  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  829  	i740outreg(par, XRX, DRAM_EXT_CNTL, DRAM_REFRESH_60HZ);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  830  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  831  	i740outreg_mask(par, MRX, COL_KEY_CNTL_1, 0, BLANK_DISP_OVERLAY);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  832  	i740outreg_mask(par, XRX, IO_CTNL,
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  833  			par->io_cntl, EXTENDED_ATTR_CNTL | EXTENDED_CRTC_CNTL);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  834  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  835  	if (par->pixelpipe_cfg1 != DISPLAY_8BPP_MODE) {
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  836  		i740outb(par, VGA_PEL_MSK, 0xFF);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  837  		i740outb(par, VGA_PEL_IW, 0x00);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  838  		for (i = 0; i < 256; i++) {
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  839  			itemp = (par->pixelpipe_cfg0 & DAC_8_BIT) ? i : i >> 2;
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  840  			i740outb(par, VGA_PEL_D, itemp);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  841  			i740outb(par, VGA_PEL_D, itemp);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  842  			i740outb(par, VGA_PEL_D, itemp);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  843  		}
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  844  	}
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  845  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  846  	/* Wait for screen to stabilize. */
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  847  	mdelay(50);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  848  	vga_unprotect(par);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  849  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  850  	info->fix.line_length =
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  851  			info->var.xres_virtual * info->var.bits_per_pixel / 8;
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  852  	if (info->var.bits_per_pixel == 8)
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  853  		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  854  	else
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  855  		info->fix.visual = FB_VISUAL_TRUECOLOR;
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  856  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  857  	return 0;
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  858  }
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  859  

:::::: The code at line 743 was first introduced by commit
:::::: 5350c65f4f15bbc111ffa629130d3f32cdd4ccf6 Resurrect Intel740 driver: i740fb

:::::: TO: Ondrej Zary <linux@rainbow-software.org>
:::::: CC: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
