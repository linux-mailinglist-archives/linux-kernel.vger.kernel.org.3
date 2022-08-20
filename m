Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8B059AF04
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 18:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345729AbiHTQZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 12:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiHTQZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 12:25:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBCF3AE53
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 09:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661012701; x=1692548701;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BsMpgnApy6GLi8//tsFqFadINIE3KojzlkxnImRRviY=;
  b=WWEh5kvAVGfgmHUs80q7oEj9xXLWbEScXbh8puRJNi/+wh+8XbOcyRu0
   mLajDnc2mm6tMVNlWs1zKmQYJf4808ePOrgRHtGo2DFtO8fiuSTSgddi2
   jnVN50UYJvM6ZVbS2mgl0W+MfQuRMEIC64ERdlRRbRhZPvH3SP2sKWzJR
   5soKBNOkf75mox1dMJ3MlOKMOfq3DBJ3t3FHXRkO9ke8Q777u6zQ9C0Sp
   3Scv0ZzCIQbwpNXBM42DvIOK+ssKKlaDzu1fCi7kh2dFwXSRlBn68raDN
   WW8tBupqB7GuGPsKfC7YmETPST8Zs/tXSppBuUX4gAZLwmVhs/WFxhqfT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10445"; a="319215711"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="319215711"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 09:25:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="611628250"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 20 Aug 2022 09:25:00 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPRHP-0002sj-19;
        Sat, 20 Aug 2022 16:24:59 +0000
Date:   Sun, 21 Aug 2022 00:24:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/aty/mach64_cursor.c:156:23: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202208210041.l5KjvUX7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   50cd95ac46548429e5bba7ca75cc97d11a697947
commit: ded2ee36313c941f1a12b6f85cde295b575264ae openrisc: Add pci bus support
date:   3 weeks ago
config: openrisc-randconfig-s031-20220820 (https://download.01.org/0day-ci/archive/20220821/202208210041.l5KjvUX7-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ded2ee36313c941f1a12b6f85cde295b575264ae
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ded2ee36313c941f1a12b6f85cde295b575264ae
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/video/fbdev/aty/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/video/fbdev/aty/mach64_cursor.c:156:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *s @@     got unsigned char [noderef] [usertype] __iomem *dst @@
   drivers/video/fbdev/aty/mach64_cursor.c:156:23: sparse:     expected void *s
   drivers/video/fbdev/aty/mach64_cursor.c:156:23: sparse:     got unsigned char [noderef] [usertype] __iomem *dst
   drivers/video/fbdev/aty/mach64_cursor.c:187:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/aty/mach64_cursor.c:188:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/aty/mach64_cursor.c:209:30: sparse: sparse: cast removes address space '__iomem' of expression

vim +156 drivers/video/fbdev/aty/mach64_cursor.c

^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   67  
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   68  static int atyfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   69  {
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   70  	struct atyfb_par *par = (struct atyfb_par *) info->par;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   71  	u16 xoff, yoff;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   72  	int x, y, h;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   73  
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   74  #ifdef __sparc__
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   75  	if (par->mmaped)
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   76  		return -EPERM;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   77  #endif
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   78  	if (par->asleep)
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   79  		return -EPERM;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   80  
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   81  	wait_for_fifo(1, par);
2f682fae611df6 drivers/video/aty/mach64_cursor.c Krzysztof Helt     2009-03-31   82  	if (cursor->enable)
2f682fae611df6 drivers/video/aty/mach64_cursor.c Krzysztof Helt     2009-03-31   83  		aty_st_le32(GEN_TEST_CNTL, aty_ld_le32(GEN_TEST_CNTL, par)
2f682fae611df6 drivers/video/aty/mach64_cursor.c Krzysztof Helt     2009-03-31   84  			    | HWCURSOR_ENABLE, par);
2f682fae611df6 drivers/video/aty/mach64_cursor.c Krzysztof Helt     2009-03-31   85  	else
2f682fae611df6 drivers/video/aty/mach64_cursor.c Krzysztof Helt     2009-03-31   86  		aty_st_le32(GEN_TEST_CNTL, aty_ld_le32(GEN_TEST_CNTL, par)
2f682fae611df6 drivers/video/aty/mach64_cursor.c Krzysztof Helt     2009-03-31   87  				& ~HWCURSOR_ENABLE, par);
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   88  
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   89  	/* set position */
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   90  	if (cursor->set & FB_CUR_SETPOS) {
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   91  		x = cursor->image.dx - cursor->hot.x - info->var.xoffset;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   92  		if (x < 0) {
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   93  			xoff = -x;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   94  			x = 0;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   95  		} else {
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   96  			xoff = 0;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   97  		}
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   98  
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   99  		y = cursor->image.dy - cursor->hot.y - info->var.yoffset;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  100  		if (y < 0) {
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  101  			yoff = -y;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  102  			y = 0;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  103  		} else {
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  104  			yoff = 0;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  105  		}
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  106  
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  107  		h = cursor->image.height;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  108  
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  109  		/*
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  110  		 * In doublescan mode, the cursor location
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  111  		 * and heigh also needs to be doubled.
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  112  		 */
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  113                  if (par->crtc.gen_cntl & CRTC_DBL_SCAN_EN) {
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  114  			y<<=1;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  115  			h<<=1;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  116  		}
2f682fae611df6 drivers/video/aty/mach64_cursor.c Krzysztof Helt     2009-03-31  117  		wait_for_fifo(3, par);
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  118  		aty_st_le32(CUR_OFFSET, (info->fix.smem_len >> 3) + (yoff << 1), par);
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  119  		aty_st_le32(CUR_HORZ_VERT_OFF,
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  120  			    ((u32) (64 - h + yoff) << 16) | xoff, par);
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  121  		aty_st_le32(CUR_HORZ_VERT_POSN, ((u32) y << 16) | x, par);
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  122  	}
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  123  
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  124  	/* Set color map */
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  125  	if (cursor->set & FB_CUR_SETCMAP) {
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  126  		u32 fg_idx, bg_idx, fg, bg;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  127  
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  128  		fg_idx = cursor->image.fg_color;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  129  		bg_idx = cursor->image.bg_color;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  130  
72c24cc51aef31 drivers/video/aty/mach64_cursor.c Antonino A. Daplas 2006-06-26  131  		fg = ((info->cmap.red[fg_idx] & 0xff) << 24) |
72c24cc51aef31 drivers/video/aty/mach64_cursor.c Antonino A. Daplas 2006-06-26  132  		     ((info->cmap.green[fg_idx] & 0xff) << 16) |
72c24cc51aef31 drivers/video/aty/mach64_cursor.c Antonino A. Daplas 2006-06-26  133  		     ((info->cmap.blue[fg_idx] & 0xff) << 8) | 0xff;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  134  
72c24cc51aef31 drivers/video/aty/mach64_cursor.c Antonino A. Daplas 2006-06-26  135  		bg = ((info->cmap.red[bg_idx] & 0xff) << 24) |
72c24cc51aef31 drivers/video/aty/mach64_cursor.c Antonino A. Daplas 2006-06-26  136  		     ((info->cmap.green[bg_idx] & 0xff) << 16) |
72c24cc51aef31 drivers/video/aty/mach64_cursor.c Antonino A. Daplas 2006-06-26  137  		     ((info->cmap.blue[bg_idx] & 0xff) << 8);
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  138  
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  139  		wait_for_fifo(2, par);
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  140  		aty_st_le32(CUR_CLR0, bg, par);
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  141  		aty_st_le32(CUR_CLR1, fg, par);
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  142  	}
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  143  
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  144  	if (cursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETIMAGE)) {
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  145  	    u8 *src = (u8 *)cursor->image.data;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  146  	    u8 *msk = (u8 *)cursor->mask;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  147  	    u8 __iomem *dst = (u8 __iomem *)info->sprite.addr;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  148  	    unsigned int width = (cursor->image.width + 7) >> 3;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  149  	    unsigned int height = cursor->image.height;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  150  	    unsigned int align = info->sprite.scan_align;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  151  
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  152  	    unsigned int i, j, offset;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  153  	    u8 m, b;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  154  
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  155  	    // Clear cursor image with 1010101010...
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16 @156  	    fb_memset(dst, 0xaa, 1024);
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  157  
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  158  	    offset = align - width*2;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  159  
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  160  	    for (i = 0; i < height; i++) {
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  161  		for (j = 0; j < width; j++) {
43751a1b8ee2e7 drivers/video/aty/mach64_cursor.c Mikulas Patocka    2014-01-23  162  			u16 l = 0xaaaa;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  163  			b = *src++;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  164  			m = *msk++;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  165  			switch (cursor->rop) {
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  166  			case ROP_XOR:
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  167  			    // Upper 4 bits of mask data
43751a1b8ee2e7 drivers/video/aty/mach64_cursor.c Mikulas Patocka    2014-01-23  168  			    l = cursor_bits_lookup[(b ^ m) >> 4] |
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  169  			    // Lower 4 bits of mask
43751a1b8ee2e7 drivers/video/aty/mach64_cursor.c Mikulas Patocka    2014-01-23  170  				    (cursor_bits_lookup[(b ^ m) & 0x0f] << 8);
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  171  			    break;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  172  			case ROP_COPY:
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  173  			    // Upper 4 bits of mask data
43751a1b8ee2e7 drivers/video/aty/mach64_cursor.c Mikulas Patocka    2014-01-23  174  			    l = cursor_bits_lookup[(b & m) >> 4] |
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  175  			    // Lower 4 bits of mask
43751a1b8ee2e7 drivers/video/aty/mach64_cursor.c Mikulas Patocka    2014-01-23  176  				    (cursor_bits_lookup[(b & m) & 0x0f] << 8);
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  177  			    break;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  178  			}
43751a1b8ee2e7 drivers/video/aty/mach64_cursor.c Mikulas Patocka    2014-01-23  179  			/*
43751a1b8ee2e7 drivers/video/aty/mach64_cursor.c Mikulas Patocka    2014-01-23  180  			 * If cursor size is not a multiple of 8 characters
43751a1b8ee2e7 drivers/video/aty/mach64_cursor.c Mikulas Patocka    2014-01-23  181  			 * we must pad it with transparent pattern (0xaaaa).
43751a1b8ee2e7 drivers/video/aty/mach64_cursor.c Mikulas Patocka    2014-01-23  182  			 */
43751a1b8ee2e7 drivers/video/aty/mach64_cursor.c Mikulas Patocka    2014-01-23  183  			if ((j + 1) * 8 > cursor->image.width) {
43751a1b8ee2e7 drivers/video/aty/mach64_cursor.c Mikulas Patocka    2014-01-23  184  				l = comp(l, 0xaaaa,
43751a1b8ee2e7 drivers/video/aty/mach64_cursor.c Mikulas Patocka    2014-01-23  185  				    (1 << ((cursor->image.width & 7) * 2)) - 1);
43751a1b8ee2e7 drivers/video/aty/mach64_cursor.c Mikulas Patocka    2014-01-23  186  			}
43751a1b8ee2e7 drivers/video/aty/mach64_cursor.c Mikulas Patocka    2014-01-23  187  			fb_writeb(l & 0xff, dst++);
43751a1b8ee2e7 drivers/video/aty/mach64_cursor.c Mikulas Patocka    2014-01-23  188  			fb_writeb(l >> 8, dst++);
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  189  		}
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  190  		dst += offset;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  191  	    }
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  192  	}
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  193  
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  194  	return 0;
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  195  }
^1da177e4c3f41 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  196  

:::::: The code at line 156 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
