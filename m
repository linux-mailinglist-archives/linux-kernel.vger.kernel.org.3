Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E4A49C02C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 01:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbiAZAef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 19:34:35 -0500
Received: from mga02.intel.com ([134.134.136.20]:45261 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235306AbiAZAea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 19:34:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643157270; x=1674693270;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B9RtbbrpWYiUijglXq+ExlP6zjJVlx3Gp4w4pmG8csY=;
  b=QcpXM2ILtdn1U+h1vWhmfS42h7Z6WnFfSzLo+Y/xdvJlnZORDUxiKctX
   N/u1dVBAWEEYNJabhbHT0S0D03QE3gq3jS+5oc0UUVC7wElVj6d8SH/eU
   2LpCs+3N6HDS/Z3uIC/Ks74+4UdGJ0ISt9I4J+O1LbcmfUzBxwgPvmOXu
   sq51uT+fJQ0bWSiI3+zN6nUnCxA0kQYOpMSK5q9oAsccLThnQ/BqtUKwJ
   Oi2qndGjq+tzHBaGrByQS4rV7F3GzqlA2K2CQle9oUqm05FgjXTRHbUd7
   0mQd2Dw9O+lyUTKX9pFLNZ+GhnegWAUJLcE6ocs9JKB13YN3+pam2rUCW
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="233822293"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="233822293"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 16:34:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="479707717"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 25 Jan 2022 16:34:28 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCWGZ-000KbB-8z; Wed, 26 Jan 2022 00:34:27 +0000
Date:   Wed, 26 Jan 2022 08:33:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [deller-fbdev:fbcon-accel 3/3]
 drivers/video/fbdev/core/fbcon.c:1028:6: warning: variable 'cap' set but not
 used
Message-ID: <202201260838.fucWW54g-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git fbcon-accel
head:   555c308a1337c14841f4ff8f8d75613fb5701cef
commit: 555c308a1337c14841f4ff8f8d75613fb5701cef [3/3] fbcon: Add option to enable legacy hardware acceleration
config: i386-randconfig-m021-20220124 (https://download.01.org/0day-ci/archive/20220126/202201260838.fucWW54g-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git/commit/?id=555c308a1337c14841f4ff8f8d75613fb5701cef
        git remote add deller-fbdev git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git
        git fetch --no-tags deller-fbdev fbcon-accel
        git checkout 555c308a1337c14841f4ff8f8d75613fb5701cef
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

^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1019  
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1020  static void fbcon_init(struct vc_data *vc, int init)
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1021  {
1f4ed2fb01f80fa drivers/video/fbdev/core/fbcon.c Daniel Vetter             2019-05-28  1022  	struct fb_info *info;
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1023  	struct fbcon_ops *ops;
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1024  	struct vc_data **default_mode = vc->vc_display_fg;
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1025  	struct vc_data *svc = *default_mode;
50233393f0cf9ba drivers/video/fbdev/core/fbcon.c Daniel Vetter             2019-05-28  1026  	struct fbcon_display *t, *p = &fb_display[vc->vc_num];
a1ac250a82a5e97 drivers/video/fbdev/core/fbcon.c Peilin Ye                 2020-11-12  1027  	int logo = 1, new_rows, new_cols, rows, cols;
0f5e5bb1b0e22e8 drivers/video/fbdev/core/fbcon.c Helge Deller              2022-01-18 @1028  	int cap, ret;
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1029  
1f4ed2fb01f80fa drivers/video/fbdev/core/fbcon.c Daniel Vetter             2019-05-28  1030  	if (WARN_ON(info_idx == -1))
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1031  	    return;
306958e8e8d150b drivers/video/console/fbcon.c    Adrian Bunk               2005-05-01  1032  
1f4ed2fb01f80fa drivers/video/fbdev/core/fbcon.c Daniel Vetter             2019-05-28  1033  	if (con2fb_map[vc->vc_num] == -1)
1f4ed2fb01f80fa drivers/video/fbdev/core/fbcon.c Daniel Vetter             2019-05-28  1034  		con2fb_map[vc->vc_num] = info_idx;
1f4ed2fb01f80fa drivers/video/fbdev/core/fbcon.c Daniel Vetter             2019-05-28  1035  
1f4ed2fb01f80fa drivers/video/fbdev/core/fbcon.c Daniel Vetter             2019-05-28  1036  	info = registered_fb[con2fb_map[vc->vc_num]];
0f5e5bb1b0e22e8 drivers/video/fbdev/core/fbcon.c Helge Deller              2022-01-18  1037  	cap = info->flags;
306958e8e8d150b drivers/video/console/fbcon.c    Adrian Bunk               2005-05-01  1038  
3c5a1b111373e66 drivers/video/fbdev/core/fbcon.c Andreas Schwab            2019-05-06  1039  	if (logo_shown < 0 && console_loglevel <= CONSOLE_LOGLEVEL_QUIET)
10993504d647356 drivers/video/fbdev/core/fbcon.c Prarit Bhargava           2019-02-08  1040  		logo_shown = FBCON_LOGO_DONTSHOW;
10993504d647356 drivers/video/fbdev/core/fbcon.c Prarit Bhargava           2019-02-08  1041  
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1042  	if (vc != svc || logo_shown == FBCON_LOGO_DONTSHOW ||
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1043  	    (info->fix.type == FB_TYPE_TEXT))
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1044  		logo = 0;
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1045  
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1046  	if (var_to_display(p, &info->var, info))
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1047  		return;
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1048  
d1baa4ffa677bf6 drivers/video/console/fbcon.c    Antonino A. Daplas        2007-07-17  1049  	if (!info->fbcon_par)
d1baa4ffa677bf6 drivers/video/console/fbcon.c    Antonino A. Daplas        2007-07-17  1050  		con2fb_acquire_newinfo(vc, info, vc->vc_num, -1);
d1baa4ffa677bf6 drivers/video/console/fbcon.c    Antonino A. Daplas        2007-07-17  1051  
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1052  	/* If we are not the first console on this
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1053  	   fb, copy the font from that console */
e614b18dcedb247 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1054  	t = &fb_display[fg_console];
e614b18dcedb247 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1055  	if (!p->fontdata) {
e614b18dcedb247 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1056  		if (t->fontdata) {
e614b18dcedb247 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1057  			struct vc_data *fvc = vc_cons[fg_console].d;
e614b18dcedb247 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1058  
e614b18dcedb247 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1059  			vc->vc_font.data = (void *)(p->fontdata =
e614b18dcedb247 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1060  						    fvc->vc_font.data);
e614b18dcedb247 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1061  			vc->vc_font.width = fvc->vc_font.width;
e614b18dcedb247 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1062  			vc->vc_font.height = fvc->vc_font.height;
a1ac250a82a5e97 drivers/video/fbdev/core/fbcon.c Peilin Ye                 2020-11-12  1063  			vc->vc_font.charcount = fvc->vc_font.charcount;
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1064  			p->userfont = t->userfont;
e614b18dcedb247 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1065  
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1066  			if (p->userfont)
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1067  				REFCOUNT(p->fontdata)++;
e614b18dcedb247 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1068  		} else {
e614b18dcedb247 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1069  			const struct font_desc *font = NULL;
e614b18dcedb247 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1070  
e614b18dcedb247 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1071  			if (!fontname[0] || !(font = find_font(fontname)))
e614b18dcedb247 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1072  				font = get_default_font(info->var.xres,
2d2699d98492489 drivers/video/console/fbcon.c    Antonino A. Daplas        2007-05-08  1073  							info->var.yres,
2d2699d98492489 drivers/video/console/fbcon.c    Antonino A. Daplas        2007-05-08  1074  							info->pixmap.blit_x,
2d2699d98492489 drivers/video/console/fbcon.c    Antonino A. Daplas        2007-05-08  1075  							info->pixmap.blit_y);
e614b18dcedb247 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1076  			vc->vc_font.width = font->width;
e614b18dcedb247 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1077  			vc->vc_font.height = font->height;
e614b18dcedb247 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1078  			vc->vc_font.data = (void *)(p->fontdata = font->data);
a1ac250a82a5e97 drivers/video/fbdev/core/fbcon.c Peilin Ye                 2020-11-12  1079  			vc->vc_font.charcount = font->charcount;
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1080  		}
e614b18dcedb247 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1081  	}
e614b18dcedb247 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1082  
b8c909454f046b5 drivers/video/console/fbcon.c    Antonino A. Daplas        2005-09-09  1083  	vc->vc_can_do_color = (fb_get_color_depth(&info->var, &info->fix)!=1);
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1084  	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
a1ac250a82a5e97 drivers/video/fbdev/core/fbcon.c Peilin Ye                 2020-11-12  1085  	if (vc->vc_font.charcount == 256) {
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1086  		vc->vc_hi_font_mask = 0;
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1087  	} else {
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1088  		vc->vc_hi_font_mask = 0x100;
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1089  		if (vc->vc_can_do_color)
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1090  			vc->vc_complement_mask <<= 1;
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1091  	}
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1092  
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1093  	if (!*svc->vc_uni_pagedir_loc)
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1094  		con_set_default_unimap(svc);
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1095  	if (!*vc->vc_uni_pagedir_loc)
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1096  		con_copy_unimap(vc, svc);
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1097  
e4fc27618b75234 drivers/video/console/fbcon.c    Antonino A. Daplas        2005-11-08  1098  	ops = info->fbcon_par;
f235f664a8afabc drivers/video/console/fbcon.c    Scot Doyle                2015-10-09  1099  	ops->cur_blink_jiffies = msecs_to_jiffies(vc->vc_cur_blink_ms);
c9e6a36492504e3 drivers/video/fbdev/core/fbcon.c Hans de Goede             2017-11-25  1100  
2428e59b5309286 drivers/video/console/fbcon.c    Marcin Slusarz            2008-02-06  1101  	p->con_rotate = initial_rotation;
c9e6a36492504e3 drivers/video/fbdev/core/fbcon.c Hans de Goede             2017-11-25  1102  	if (p->con_rotate == -1)
c9e6a36492504e3 drivers/video/fbdev/core/fbcon.c Hans de Goede             2017-11-25  1103  		p->con_rotate = info->fbcon_rotate_hint;
c9e6a36492504e3 drivers/video/fbdev/core/fbcon.c Hans de Goede             2017-11-25  1104  	if (p->con_rotate == -1)
f2f4946b0adfd6f drivers/video/fbdev/core/fbcon.c Hans de Goede             2017-11-25  1105  		p->con_rotate = FB_ROTATE_UR;
c9e6a36492504e3 drivers/video/fbdev/core/fbcon.c Hans de Goede             2017-11-25  1106  
b73deed32d08740 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-01-09  1107  	set_blitting_type(vc, info);
e4fc27618b75234 drivers/video/console/fbcon.c    Antonino A. Daplas        2005-11-08  1108  
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1109  	cols = vc->vc_cols;
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1110  	rows = vc->vc_rows;
e4fc27618b75234 drivers/video/console/fbcon.c    Antonino A. Daplas        2005-11-08  1111  	new_cols = FBCON_SWAP(ops->rotate, info->var.xres, info->var.yres);
e4fc27618b75234 drivers/video/console/fbcon.c    Antonino A. Daplas        2005-11-08  1112  	new_rows = FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
e4fc27618b75234 drivers/video/console/fbcon.c    Antonino A. Daplas        2005-11-08  1113  	new_cols /= vc->vc_font.width;
e4fc27618b75234 drivers/video/console/fbcon.c    Antonino A. Daplas        2005-11-08  1114  	new_rows /= vc->vc_font.height;
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1115  
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1116  	/*
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1117  	 * We must always set the mode. The mode of the previous console
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1118  	 * driver could be in the same resolution but we are using different
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1119  	 * hardware so we have to initialize the hardware.
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1120  	 *
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1121  	 * We need to do it in fbcon_init() to prevent screen corruption.
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1122  	 */
6ca8dfd78187d82 drivers/video/console/fbcon.c    Jiri Slaby                2016-06-23  1123  	if (con_is_visible(vc) && vc->vc_mode == KD_TEXT) {
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1124  		if (info->fbops->fb_set_par &&
0fcf6ada2b8eb42 drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  1125  		    !(ops->flags & FBCON_FLAGS_INIT)) {
0fcf6ada2b8eb42 drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  1126  			ret = info->fbops->fb_set_par(info);
0fcf6ada2b8eb42 drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  1127  
0fcf6ada2b8eb42 drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  1128  			if (ret)
0fcf6ada2b8eb42 drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  1129  				printk(KERN_ERR "fbcon_init: detected "
0fcf6ada2b8eb42 drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  1130  					"unhandled fb_set_par error, "
0fcf6ada2b8eb42 drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  1131  					"error code %d\n", ret);
0fcf6ada2b8eb42 drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  1132  		}
0fcf6ada2b8eb42 drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  1133  
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1134  		ops->flags |= FBCON_FLAGS_INIT;
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1135  	}
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1136  
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1137  	ops->graphics = 0;
^1da177e4c3f415 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1138  

:::::: The code at line 1028 was first introduced by commit
:::::: 0f5e5bb1b0e22e842d1488b62a1a3b971f20e61c Revert "fbcon: Disable accelerated scrolling"

:::::: TO: Helge Deller <deller@gmx.de>
:::::: CC: Helge Deller <deller@gmx.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
