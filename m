Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEB758E75F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 08:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiHJGkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 02:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiHJGkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 02:40:15 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57384E8B
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 23:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660113614; x=1691649614;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HunvRlGf+2CuaRYYHsgwV5dcV4ElyszccBtdpaa23Eo=;
  b=g4nT9hBQVTWlxajVsBz1XhNn3l/jmL+j53l7pzu8dvazvkWgeM59Wn6N
   BlZMtCCT+ahEWrk5NthoWE0r86Ysz37wngtvelJ3BbxBoOyJQwawuUvNc
   I9mWmhDeQD3VeQUH4TVtNuz4bV8/zgfuF6Mb/w48O3JKLgrdHG/+nGtaH
   2LfsId0zI/RyIYXdldbtYhkWCcVn0OTijsH9rCI3BLXX1qFtYj79hTVDB
   7pj61lCmysCzaSKdMPGauN10qJtXi1PWQqUXIQG/O32Kwph8zE0TKSKBd
   uRw6OzyCFG24McwIU6ajW1qxC3eZr1d7vKz76zax2iOX6GkL67GZtDXZf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="288578307"
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="288578307"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 23:40:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="932774425"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 09 Aug 2022 23:40:12 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLfO0-000Nbh-0i;
        Wed, 10 Aug 2022 06:40:12 +0000
Date:   Wed, 10 Aug 2022 14:39:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/tdfxfb.c:1118:17: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202208101431.245QhuXv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d4252071b97d2027d246f6a82cbee4d52f618b47
commit: 28e77cc1c0686621a4d416f599cee5ab369daa0a fortify: Detect struct member overflows in memset() at compile-time
date:   6 months ago
config: mips-randconfig-s041-20220810 (https://download.01.org/0day-ci/archive/20220810/202208101431.245QhuXv-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=28e77cc1c0686621a4d416f599cee5ab369daa0a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 28e77cc1c0686621a4d416f599cee5ab369daa0a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash drivers/video/fbdev/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/video/fbdev/tdfxfb.c:1118:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *cursorbase @@
   drivers/video/fbdev/tdfxfb.c:1118:17: sparse:     expected void const *
   drivers/video/fbdev/tdfxfb.c:1118:17: sparse:     got unsigned char [noderef] [usertype] __iomem *cursorbase
>> drivers/video/fbdev/tdfxfb.c:1118:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *cursorbase @@
   drivers/video/fbdev/tdfxfb.c:1118:17: sparse:     expected void const *
   drivers/video/fbdev/tdfxfb.c:1118:17: sparse:     got unsigned char [noderef] [usertype] __iomem *cursorbase
   drivers/video/fbdev/tdfxfb.c:1118:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got unsigned char [noderef] [usertype] __iomem *cursorbase @@
   drivers/video/fbdev/tdfxfb.c:1118:17: sparse:     expected void *
   drivers/video/fbdev/tdfxfb.c:1118:17: sparse:     got unsigned char [noderef] [usertype] __iomem *cursorbase
   drivers/video/fbdev/tdfxfb.c:1129:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tdfxfb.c:1132:33: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/video/fbdev/sstfb.c:337:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/sstfb.c:337:9: sparse:     expected void const *
   drivers/video/fbdev/sstfb.c:337:9: sparse:     got char [noderef] __iomem *screen_base
>> drivers/video/fbdev/sstfb.c:337:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/sstfb.c:337:9: sparse:     expected void const *
   drivers/video/fbdev/sstfb.c:337:9: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/sstfb.c:337:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/sstfb.c:337:9: sparse:     expected void *
   drivers/video/fbdev/sstfb.c:337:9: sparse:     got char [noderef] __iomem *screen_base
--
>> drivers/video/fbdev/aty/mach64_cursor.c:156:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *dst @@
   drivers/video/fbdev/aty/mach64_cursor.c:156:13: sparse:     expected void const *
   drivers/video/fbdev/aty/mach64_cursor.c:156:13: sparse:     got unsigned char [noderef] [usertype] __iomem *dst
>> drivers/video/fbdev/aty/mach64_cursor.c:156:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *dst @@
   drivers/video/fbdev/aty/mach64_cursor.c:156:13: sparse:     expected void const *
   drivers/video/fbdev/aty/mach64_cursor.c:156:13: sparse:     got unsigned char [noderef] [usertype] __iomem *dst
   drivers/video/fbdev/aty/mach64_cursor.c:156:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got unsigned char [noderef] [usertype] __iomem *dst @@
   drivers/video/fbdev/aty/mach64_cursor.c:156:13: sparse:     expected void *
   drivers/video/fbdev/aty/mach64_cursor.c:156:13: sparse:     got unsigned char [noderef] [usertype] __iomem *dst
   drivers/video/fbdev/aty/mach64_cursor.c:187:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/aty/mach64_cursor.c:188:25: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/video/fbdev/kyro/fbdev.c:733:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/kyro/fbdev.c:733:9: sparse:     expected void const *
   drivers/video/fbdev/kyro/fbdev.c:733:9: sparse:     got char [noderef] __iomem *screen_base
>> drivers/video/fbdev/kyro/fbdev.c:733:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/kyro/fbdev.c:733:9: sparse:     expected void const *
   drivers/video/fbdev/kyro/fbdev.c:733:9: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/kyro/fbdev.c:733:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/kyro/fbdev.c:733:9: sparse:     expected void *
   drivers/video/fbdev/kyro/fbdev.c:733:9: sparse:     got char [noderef] __iomem *screen_base

vim +1118 drivers/video/fbdev/tdfxfb.c

^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1038  
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1039  static int tdfxfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1040  {
a807f618b62594 drivers/video/tdfxfb.c Antonino A. Daplas 2006-01-09  1041  	struct tdfx_par *par = info->par;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1042  	u32 vidcfg;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1043  
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1044  	if (!hwcursor)
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1045  		return -EINVAL;	/* just to force soft_cursor() call */
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1046  
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1047  	/* Too large of a cursor or wrong bpp :-( */
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1048  	if (cursor->image.width > 64 ||
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1049  	    cursor->image.height > 64 ||
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1050  	    cursor->image.depth > 1)
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1051  		return -EINVAL;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1052  
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1053  	vidcfg = tdfx_inl(par, VIDPROCCFG);
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1054  	if (cursor->enable)
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1055  		tdfx_outl(par, VIDPROCCFG, vidcfg | VIDCFG_HWCURSOR_ENABLE);
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1056  	else
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1057  		tdfx_outl(par, VIDPROCCFG, vidcfg & ~VIDCFG_HWCURSOR_ENABLE);
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1058  
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1059  	/*
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1060  	 * If the cursor is not be changed this means either we want the
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1061  	 * current cursor state (if enable is set) or we want to query what
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1062  	 * we can do with the cursor (if enable is not set)
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1063  	 */
8af1d50f7f6793 drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1064  	if (!cursor->set)
8af1d50f7f6793 drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1065  		return 0;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1066  
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1067  	/* fix cursor color - XFree86 forgets to restore it properly */
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1068  	if (cursor->set & FB_CUR_SETCMAP) {
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1069  		struct fb_cmap cmap = info->cmap;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1070  		u32 bg_idx = cursor->image.bg_color;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1071  		u32 fg_idx = cursor->image.fg_color;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1072  		unsigned long bg_color, fg_color;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1073  
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1074  		fg_color = (((u32)cmap.red[fg_idx]   & 0xff00) << 8) |
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1075  			   (((u32)cmap.green[fg_idx] & 0xff00) << 0) |
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1076  			   (((u32)cmap.blue[fg_idx]  & 0xff00) >> 8);
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1077  		bg_color = (((u32)cmap.red[bg_idx]   & 0xff00) << 8) |
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1078  			   (((u32)cmap.green[bg_idx] & 0xff00) << 0) |
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1079  			   (((u32)cmap.blue[bg_idx]  & 0xff00) >> 8);
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1080  		banshee_make_room(par, 2);
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1081  		tdfx_outl(par, HWCURC0, bg_color);
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1082  		tdfx_outl(par, HWCURC1, fg_color);
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1083  	}
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1084  
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1085  	if (cursor->set & FB_CUR_SETPOS) {
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1086  		int x = cursor->image.dx;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1087  		int y = cursor->image.dy - info->var.yoffset;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1088  
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1089  		x += 63;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1090  		y += 63;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1091  		banshee_make_room(par, 1);
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1092  		tdfx_outl(par, HWCURLOC, (y << 16) + x);
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1093  	}
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1094  	if (cursor->set & (FB_CUR_SETIMAGE | FB_CUR_SETSHAPE)) {
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1095  		/*
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1096  		 * Voodoo 3 and above cards use 2 monochrome cursor patterns.
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1097  		 *    The reason is so the card can fetch 8 words at a time
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1098  		 * and are stored on chip for use for the next 8 scanlines.
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1099  		 * This reduces the number of times for access to draw the
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1100  		 * cursor for each screen refresh.
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1101  		 *    Each pattern is a bitmap of 64 bit wide and 64 bit high
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1102  		 * (total of 8192 bits or 1024 bytes). The two patterns are
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1103  		 * stored in such a way that pattern 0 always resides in the
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1104  		 * lower half (least significant 64 bits) of a 128 bit word
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1105  		 * and pattern 1 the upper half. If you examine the data of
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1106  		 * the cursor image the graphics card uses then from the
25985edcedea63 drivers/video/tdfxfb.c Lucas De Marchi    2011-03-30  1107  		 * beginning you see line one of pattern 0, line one of
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1108  		 * pattern 1, line two of pattern 0, line two of pattern 1,
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1109  		 * etc etc. The linear stride for the cursor is always 16 bytes
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1110  		 * (128 bits) which is the maximum cursor width times two for
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1111  		 * the two monochrome patterns.
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1112  		 */
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1113  		u8 __iomem *cursorbase = info->screen_base + info->fix.smem_len;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1114  		u8 *bitmap = (u8 *)cursor->image.data;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1115  		u8 *mask = (u8 *)cursor->mask;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1116  		int i;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1117  
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16 @1118  		fb_memset(cursorbase, 0, 1024);
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1119  
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1120  		for (i = 0; i < cursor->image.height; i++) {
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1121  			int h = 0;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1122  			int j = (cursor->image.width + 7) >> 3;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1123  
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1124  			for (; j > 0; j--) {
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1125  				u8 data = *mask ^ *bitmap;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1126  				if (cursor->rop == ROP_COPY)
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1127  					data = *mask & *bitmap;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1128  				/* Pattern 0. Copy the cursor mask to it */
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1129  				fb_writeb(*mask, cursorbase + h);
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1130  				mask++;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1131  				/* Pattern 1. Copy the cursor bitmap to it */
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1132  				fb_writeb(data, cursorbase + h + 8);
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1133  				bitmap++;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1134  				h++;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1135  			}
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1136  			cursorbase += 16;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1137  		}
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1138  	}
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1139  	return 0;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1140  }
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1141  

:::::: The code at line 1118 was first introduced by commit
:::::: 90b0f08536531abbbe7b5d4944792da08cadde01 tdfxfb: hardware cursor

:::::: TO: Krzysztof Helt <krzysztof.h1@wp.pl>
:::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
