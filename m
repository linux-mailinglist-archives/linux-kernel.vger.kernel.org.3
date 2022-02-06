Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6E44AAE52
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 09:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiBFIRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 03:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiBFIRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 03:17:17 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B81C061355
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 00:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644135436; x=1675671436;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mn1XED8XlaIYsTY2D7jzK3yR3KsSDh6aZVBtlOCTdUc=;
  b=RcdtdUPACtG83a2nGciu4eFe41gM3lexw5Ky4Y3aUCr9EDsKlkyr1ygb
   AB93oNxZ46GRWsUqVcn3Lk25OTdPl41tWg2p7TmV/bef84dZMARf5Phv3
   LO9couqG9IVyGZlmUoTlbGEq+qBpRIOjcdKOLOdlAx4Mhh4olLFrxJ+hW
   B8Kk+nCGMKLAANFgSF2CcPijuwpVd4l5zhSQKyqLVaQKLAJ4zp44UwR6M
   YDdwxFtyxOEk7hNf0e9oqKMqWhTIXDA8RswAGnkdo2DpYwGqJjuichl02
   UB/xCF/MFU5Sw0pVpc3jBn3A2GcP2dhQPC0+NofN9RdKe1+9IbEhlLaIE
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10249"; a="228533156"
X-IronPort-AV: E=Sophos;i="5.88,347,1635231600"; 
   d="scan'208";a="228533156"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 00:17:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,347,1635231600"; 
   d="scan'208";a="567159791"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 06 Feb 2022 00:17:13 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nGcjQ-000a6N-Vs; Sun, 06 Feb 2022 08:17:12 +0000
Date:   Sun, 6 Feb 2022 16:16:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: drivers/video/fbdev/core/fbcon.c:1028:6: warning: variable 'cap' set
 but not used
Message-ID: <202202061640.zSayOYxO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   90c9e950c0def5c354b4a6154a2ddda3e5f214ac
commit: a3f781a9d6114c1d1e01defb7aa234dec45d2a5f fbcon: Add option to enable legacy hardware acceleration
date:   4 days ago
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220206/202202061640.zSayOYxO-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a3f781a9d6114c1d1e01defb7aa234dec45d2a5f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a3f781a9d6114c1d1e01defb7aa234dec45d2a5f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/video/fbdev/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/video/fbdev/core/fbcon.c: In function 'fbcon_init':
>> drivers/video/fbdev/core/fbcon.c:1028:6: warning: variable 'cap' set but not used [-Wunused-but-set-variable]
    1028 |  int cap, ret;
         |      ^~~


vim +/cap +1028 drivers/video/fbdev/core/fbcon.c

^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1019  
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1020  static void fbcon_init(struct vc_data *vc, int init)
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1021  {
1f4ed2fb01f80f drivers/video/fbdev/core/fbcon.c Daniel Vetter             2019-05-28  1022  	struct fb_info *info;
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1023  	struct fbcon_ops *ops;
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1024  	struct vc_data **default_mode = vc->vc_display_fg;
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1025  	struct vc_data *svc = *default_mode;
50233393f0cf9b drivers/video/fbdev/core/fbcon.c Daniel Vetter             2019-05-28  1026  	struct fbcon_display *t, *p = &fb_display[vc->vc_num];
a1ac250a82a5e9 drivers/video/fbdev/core/fbcon.c Peilin Ye                 2020-11-12  1027  	int logo = 1, new_rows, new_cols, rows, cols;
87ab9f6b741734 drivers/video/fbdev/core/fbcon.c Helge Deller              2022-02-02 @1028  	int cap, ret;
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1029  
1f4ed2fb01f80f drivers/video/fbdev/core/fbcon.c Daniel Vetter             2019-05-28  1030  	if (WARN_ON(info_idx == -1))
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1031  	    return;
306958e8e8d150 drivers/video/console/fbcon.c    Adrian Bunk               2005-05-01  1032  
1f4ed2fb01f80f drivers/video/fbdev/core/fbcon.c Daniel Vetter             2019-05-28  1033  	if (con2fb_map[vc->vc_num] == -1)
1f4ed2fb01f80f drivers/video/fbdev/core/fbcon.c Daniel Vetter             2019-05-28  1034  		con2fb_map[vc->vc_num] = info_idx;
1f4ed2fb01f80f drivers/video/fbdev/core/fbcon.c Daniel Vetter             2019-05-28  1035  
1f4ed2fb01f80f drivers/video/fbdev/core/fbcon.c Daniel Vetter             2019-05-28  1036  	info = registered_fb[con2fb_map[vc->vc_num]];
87ab9f6b741734 drivers/video/fbdev/core/fbcon.c Helge Deller              2022-02-02  1037  	cap = info->flags;
306958e8e8d150 drivers/video/console/fbcon.c    Adrian Bunk               2005-05-01  1038  
3c5a1b111373e6 drivers/video/fbdev/core/fbcon.c Andreas Schwab            2019-05-06  1039  	if (logo_shown < 0 && console_loglevel <= CONSOLE_LOGLEVEL_QUIET)
10993504d64735 drivers/video/fbdev/core/fbcon.c Prarit Bhargava           2019-02-08  1040  		logo_shown = FBCON_LOGO_DONTSHOW;
10993504d64735 drivers/video/fbdev/core/fbcon.c Prarit Bhargava           2019-02-08  1041  
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1042  	if (vc != svc || logo_shown == FBCON_LOGO_DONTSHOW ||
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1043  	    (info->fix.type == FB_TYPE_TEXT))
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1044  		logo = 0;
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1045  
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1046  	if (var_to_display(p, &info->var, info))
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1047  		return;
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1048  
d1baa4ffa677bf drivers/video/console/fbcon.c    Antonino A. Daplas        2007-07-17  1049  	if (!info->fbcon_par)
d1baa4ffa677bf drivers/video/console/fbcon.c    Antonino A. Daplas        2007-07-17  1050  		con2fb_acquire_newinfo(vc, info, vc->vc_num, -1);
d1baa4ffa677bf drivers/video/console/fbcon.c    Antonino A. Daplas        2007-07-17  1051  
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1052  	/* If we are not the first console on this
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1053  	   fb, copy the font from that console */
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1054  	t = &fb_display[fg_console];
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1055  	if (!p->fontdata) {
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1056  		if (t->fontdata) {
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1057  			struct vc_data *fvc = vc_cons[fg_console].d;
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1058  
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1059  			vc->vc_font.data = (void *)(p->fontdata =
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1060  						    fvc->vc_font.data);
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1061  			vc->vc_font.width = fvc->vc_font.width;
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1062  			vc->vc_font.height = fvc->vc_font.height;
a1ac250a82a5e9 drivers/video/fbdev/core/fbcon.c Peilin Ye                 2020-11-12  1063  			vc->vc_font.charcount = fvc->vc_font.charcount;
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1064  			p->userfont = t->userfont;
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1065  
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1066  			if (p->userfont)
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1067  				REFCOUNT(p->fontdata)++;
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1068  		} else {
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1069  			const struct font_desc *font = NULL;
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1070  
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1071  			if (!fontname[0] || !(font = find_font(fontname)))
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1072  				font = get_default_font(info->var.xres,
2d2699d9849248 drivers/video/console/fbcon.c    Antonino A. Daplas        2007-05-08  1073  							info->var.yres,
2d2699d9849248 drivers/video/console/fbcon.c    Antonino A. Daplas        2007-05-08  1074  							info->pixmap.blit_x,
2d2699d9849248 drivers/video/console/fbcon.c    Antonino A. Daplas        2007-05-08  1075  							info->pixmap.blit_y);
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1076  			vc->vc_font.width = font->width;
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1077  			vc->vc_font.height = font->height;
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1078  			vc->vc_font.data = (void *)(p->fontdata = font->data);
a1ac250a82a5e9 drivers/video/fbdev/core/fbcon.c Peilin Ye                 2020-11-12  1079  			vc->vc_font.charcount = font->charcount;
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1080  		}
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1081  	}
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1082  
b8c909454f046b drivers/video/console/fbcon.c    Antonino A. Daplas        2005-09-09  1083  	vc->vc_can_do_color = (fb_get_color_depth(&info->var, &info->fix)!=1);
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1084  	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
a1ac250a82a5e9 drivers/video/fbdev/core/fbcon.c Peilin Ye                 2020-11-12  1085  	if (vc->vc_font.charcount == 256) {
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1086  		vc->vc_hi_font_mask = 0;
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1087  	} else {
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1088  		vc->vc_hi_font_mask = 0x100;
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1089  		if (vc->vc_can_do_color)
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1090  			vc->vc_complement_mask <<= 1;
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1091  	}
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1092  
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1093  	if (!*svc->vc_uni_pagedir_loc)
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1094  		con_set_default_unimap(svc);
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1095  	if (!*vc->vc_uni_pagedir_loc)
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1096  		con_copy_unimap(vc, svc);
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1097  
e4fc27618b7523 drivers/video/console/fbcon.c    Antonino A. Daplas        2005-11-08  1098  	ops = info->fbcon_par;
f235f664a8afab drivers/video/console/fbcon.c    Scot Doyle                2015-10-09  1099  	ops->cur_blink_jiffies = msecs_to_jiffies(vc->vc_cur_blink_ms);
c9e6a36492504e drivers/video/fbdev/core/fbcon.c Hans de Goede             2017-11-25  1100  
2428e59b530928 drivers/video/console/fbcon.c    Marcin Slusarz            2008-02-06  1101  	p->con_rotate = initial_rotation;
c9e6a36492504e drivers/video/fbdev/core/fbcon.c Hans de Goede             2017-11-25  1102  	if (p->con_rotate == -1)
c9e6a36492504e drivers/video/fbdev/core/fbcon.c Hans de Goede             2017-11-25  1103  		p->con_rotate = info->fbcon_rotate_hint;
c9e6a36492504e drivers/video/fbdev/core/fbcon.c Hans de Goede             2017-11-25  1104  	if (p->con_rotate == -1)
f2f4946b0adfd6 drivers/video/fbdev/core/fbcon.c Hans de Goede             2017-11-25  1105  		p->con_rotate = FB_ROTATE_UR;
c9e6a36492504e drivers/video/fbdev/core/fbcon.c Hans de Goede             2017-11-25  1106  
b73deed32d0874 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-01-09  1107  	set_blitting_type(vc, info);
e4fc27618b7523 drivers/video/console/fbcon.c    Antonino A. Daplas        2005-11-08  1108  
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1109  	cols = vc->vc_cols;
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1110  	rows = vc->vc_rows;
e4fc27618b7523 drivers/video/console/fbcon.c    Antonino A. Daplas        2005-11-08  1111  	new_cols = FBCON_SWAP(ops->rotate, info->var.xres, info->var.yres);
e4fc27618b7523 drivers/video/console/fbcon.c    Antonino A. Daplas        2005-11-08  1112  	new_rows = FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
e4fc27618b7523 drivers/video/console/fbcon.c    Antonino A. Daplas        2005-11-08  1113  	new_cols /= vc->vc_font.width;
e4fc27618b7523 drivers/video/console/fbcon.c    Antonino A. Daplas        2005-11-08  1114  	new_rows /= vc->vc_font.height;
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1115  
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1116  	/*
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1117  	 * We must always set the mode. The mode of the previous console
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1118  	 * driver could be in the same resolution but we are using different
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1119  	 * hardware so we have to initialize the hardware.
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1120  	 *
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1121  	 * We need to do it in fbcon_init() to prevent screen corruption.
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1122  	 */
6ca8dfd78187d8 drivers/video/console/fbcon.c    Jiri Slaby                2016-06-23  1123  	if (con_is_visible(vc) && vc->vc_mode == KD_TEXT) {
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1124  		if (info->fbops->fb_set_par &&
0fcf6ada2b8eb4 drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  1125  		    !(ops->flags & FBCON_FLAGS_INIT)) {
0fcf6ada2b8eb4 drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  1126  			ret = info->fbops->fb_set_par(info);
0fcf6ada2b8eb4 drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  1127  
0fcf6ada2b8eb4 drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  1128  			if (ret)
0fcf6ada2b8eb4 drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  1129  				printk(KERN_ERR "fbcon_init: detected "
0fcf6ada2b8eb4 drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  1130  					"unhandled fb_set_par error, "
0fcf6ada2b8eb4 drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  1131  					"error code %d\n", ret);
0fcf6ada2b8eb4 drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  1132  		}
0fcf6ada2b8eb4 drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  1133  
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1134  		ops->flags |= FBCON_FLAGS_INIT;
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1135  	}
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1136  
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1137  	ops->graphics = 0;
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1138  

:::::: The code at line 1028 was first introduced by commit
:::::: 87ab9f6b7417349aa197a6c7098d4fdd4beebb74 Revert "fbcon: Disable accelerated scrolling"

:::::: TO: Helge Deller <deller@gmx.de>
:::::: CC: Daniel Vetter <daniel.vetter@ffwll.ch>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
