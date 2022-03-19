Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DBF4DEAEA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 22:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236841AbiCSVHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 17:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiCSVHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 17:07:05 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5821621BE
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 14:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647723943; x=1679259943;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=b4bAioACX0VArPrHl1KxX6Gj9W707LmVRs/Io9dLIPo=;
  b=l/sCN7b3y71GQG+G+E6IV1zIG2zf0nc4AB6oPmpaVctezRUkdfY5GSov
   hxw4PmsyJw4q5iJ+rD4LbOFHF4QsikFqWVo7Yvux1XwuFiWdgGNLvBA8+
   doUsdSUyuDALeflO98NF7QI7JyjJWR5ukTJRlidR8cOSqTvhL7Ez1VVBk
   y++LQT9hpeUFD4AofC2fZWT4X0uuy3yoprn832HL1Og8npyJc7N8vr2F4
   /kvt92q4fDL84PUDM52E3VOTmlPQMHaxT84LJoBDX3nbbG9hhfSmuhn+Z
   uPClz3I8hrPWNHmXb8F0YhSH7GLbDoARbve480aQXInBDs20B3P/ZLzdT
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="244800654"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="244800654"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 14:05:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="517899820"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 19 Mar 2022 14:05:40 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVgGZ-000GIU-QN; Sat, 19 Mar 2022 21:05:39 +0000
Date:   Sun, 20 Mar 2022 05:05:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [linux-stable-rc:queue/5.10 9399/9999]
 drivers/video/fbdev/core/fbcon.c:1036:6: warning: variable 'cap' set but not
 used
Message-ID: <202203200530.lG8DJ5qi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/5.10
head:   9b118919119ad8c625aca9ba42d836bbacea026a
commit: 57e8859acc6024ca9041f7fa58a0afed2ed6ea87 [9399/9999] fbcon: Add option to enable legacy hardware acceleration
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20220320/202203200530.lG8DJ5qi-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=57e8859acc6024ca9041f7fa58a0afed2ed6ea87
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/5.10
        git checkout 57e8859acc6024ca9041f7fa58a0afed2ed6ea87
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/video/fbdev/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/video/fbdev/core/fbcon.c: In function 'fbcon_init':
>> drivers/video/fbdev/core/fbcon.c:1036:6: warning: variable 'cap' set but not used [-Wunused-but-set-variable]
    1036 |  int cap, ret;
         |      ^~~
   drivers/video/fbdev/core/fbcon.c: In function 'fbcon_exit':
   drivers/video/fbdev/core/fbcon.c:3370:7: warning: variable 'pending' set but not used [-Wunused-but-set-variable]
    3370 |   int pending = 0;
         |       ^~~~~~~


vim +/cap +1036 drivers/video/fbdev/core/fbcon.c

^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1027  
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1028  static void fbcon_init(struct vc_data *vc, int init)
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1029  {
1f4ed2fb01f80f drivers/video/fbdev/core/fbcon.c Daniel Vetter             2019-05-28  1030  	struct fb_info *info;
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1031  	struct fbcon_ops *ops;
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1032  	struct vc_data **default_mode = vc->vc_display_fg;
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1033  	struct vc_data *svc = *default_mode;
50233393f0cf9b drivers/video/fbdev/core/fbcon.c Daniel Vetter             2019-05-28  1034  	struct fbcon_display *t, *p = &fb_display[vc->vc_num];
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1035  	int logo = 1, new_rows, new_cols, rows, cols, charcnt = 256;
460f6b1a238d2e drivers/video/fbdev/core/fbcon.c Helge Deller              2022-02-02 @1036  	int cap, ret;
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1037  
1f4ed2fb01f80f drivers/video/fbdev/core/fbcon.c Daniel Vetter             2019-05-28  1038  	if (WARN_ON(info_idx == -1))
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1039  	    return;
306958e8e8d150 drivers/video/console/fbcon.c    Adrian Bunk               2005-05-01  1040  
1f4ed2fb01f80f drivers/video/fbdev/core/fbcon.c Daniel Vetter             2019-05-28  1041  	if (con2fb_map[vc->vc_num] == -1)
1f4ed2fb01f80f drivers/video/fbdev/core/fbcon.c Daniel Vetter             2019-05-28  1042  		con2fb_map[vc->vc_num] = info_idx;
1f4ed2fb01f80f drivers/video/fbdev/core/fbcon.c Daniel Vetter             2019-05-28  1043  
1f4ed2fb01f80f drivers/video/fbdev/core/fbcon.c Daniel Vetter             2019-05-28  1044  	info = registered_fb[con2fb_map[vc->vc_num]];
460f6b1a238d2e drivers/video/fbdev/core/fbcon.c Helge Deller              2022-02-02  1045  	cap = info->flags;
306958e8e8d150 drivers/video/console/fbcon.c    Adrian Bunk               2005-05-01  1046  
3c5a1b111373e6 drivers/video/fbdev/core/fbcon.c Andreas Schwab            2019-05-06  1047  	if (logo_shown < 0 && console_loglevel <= CONSOLE_LOGLEVEL_QUIET)
10993504d64735 drivers/video/fbdev/core/fbcon.c Prarit Bhargava           2019-02-08  1048  		logo_shown = FBCON_LOGO_DONTSHOW;
10993504d64735 drivers/video/fbdev/core/fbcon.c Prarit Bhargava           2019-02-08  1049  
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1050  	if (vc != svc || logo_shown == FBCON_LOGO_DONTSHOW ||
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1051  	    (info->fix.type == FB_TYPE_TEXT))
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1052  		logo = 0;
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1053  
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1054  	if (var_to_display(p, &info->var, info))
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1055  		return;
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1056  
d1baa4ffa677bf drivers/video/console/fbcon.c    Antonino A. Daplas        2007-07-17  1057  	if (!info->fbcon_par)
d1baa4ffa677bf drivers/video/console/fbcon.c    Antonino A. Daplas        2007-07-17  1058  		con2fb_acquire_newinfo(vc, info, vc->vc_num, -1);
d1baa4ffa677bf drivers/video/console/fbcon.c    Antonino A. Daplas        2007-07-17  1059  
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1060  	/* If we are not the first console on this
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1061  	   fb, copy the font from that console */
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1062  	t = &fb_display[fg_console];
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1063  	if (!p->fontdata) {
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1064  		if (t->fontdata) {
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1065  			struct vc_data *fvc = vc_cons[fg_console].d;
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1066  
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1067  			vc->vc_font.data = (void *)(p->fontdata =
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1068  						    fvc->vc_font.data);
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1069  			vc->vc_font.width = fvc->vc_font.width;
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1070  			vc->vc_font.height = fvc->vc_font.height;
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1071  			p->userfont = t->userfont;
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1072  
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1073  			if (p->userfont)
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1074  				REFCOUNT(p->fontdata)++;
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1075  		} else {
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1076  			const struct font_desc *font = NULL;
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1077  
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1078  			if (!fontname[0] || !(font = find_font(fontname)))
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1079  				font = get_default_font(info->var.xres,
2d2699d9849248 drivers/video/console/fbcon.c    Antonino A. Daplas        2007-05-08  1080  							info->var.yres,
2d2699d9849248 drivers/video/console/fbcon.c    Antonino A. Daplas        2007-05-08  1081  							info->pixmap.blit_x,
2d2699d9849248 drivers/video/console/fbcon.c    Antonino A. Daplas        2007-05-08  1082  							info->pixmap.blit_y);
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1083  			vc->vc_font.width = font->width;
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1084  			vc->vc_font.height = font->height;
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1085  			vc->vc_font.data = (void *)(p->fontdata = font->data);
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1086  			vc->vc_font.charcount = 256; /* FIXME  Need to
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1087  							support more fonts */
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1088  		}
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1089  	}
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1090  
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1091  	if (p->userfont)
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1092  		charcnt = FNTCHARCNT(p->fontdata);
e614b18dcedb24 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-06-26  1093  
b8c909454f046b drivers/video/console/fbcon.c    Antonino A. Daplas        2005-09-09  1094  	vc->vc_can_do_color = (fb_get_color_depth(&info->var, &info->fix)!=1);
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1095  	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1096  	if (charcnt == 256) {
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1097  		vc->vc_hi_font_mask = 0;
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1098  	} else {
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1099  		vc->vc_hi_font_mask = 0x100;
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1100  		if (vc->vc_can_do_color)
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1101  			vc->vc_complement_mask <<= 1;
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1102  	}
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1103  
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1104  	if (!*svc->vc_uni_pagedir_loc)
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1105  		con_set_default_unimap(svc);
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1106  	if (!*vc->vc_uni_pagedir_loc)
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1107  		con_copy_unimap(vc, svc);
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1108  
e4fc27618b7523 drivers/video/console/fbcon.c    Antonino A. Daplas        2005-11-08  1109  	ops = info->fbcon_par;
f235f664a8afab drivers/video/console/fbcon.c    Scot Doyle                2015-10-09  1110  	ops->cur_blink_jiffies = msecs_to_jiffies(vc->vc_cur_blink_ms);
c9e6a36492504e drivers/video/fbdev/core/fbcon.c Hans de Goede             2017-11-25  1111  
2428e59b530928 drivers/video/console/fbcon.c    Marcin Slusarz            2008-02-06  1112  	p->con_rotate = initial_rotation;
c9e6a36492504e drivers/video/fbdev/core/fbcon.c Hans de Goede             2017-11-25  1113  	if (p->con_rotate == -1)
c9e6a36492504e drivers/video/fbdev/core/fbcon.c Hans de Goede             2017-11-25  1114  		p->con_rotate = info->fbcon_rotate_hint;
c9e6a36492504e drivers/video/fbdev/core/fbcon.c Hans de Goede             2017-11-25  1115  	if (p->con_rotate == -1)
f2f4946b0adfd6 drivers/video/fbdev/core/fbcon.c Hans de Goede             2017-11-25  1116  		p->con_rotate = FB_ROTATE_UR;
c9e6a36492504e drivers/video/fbdev/core/fbcon.c Hans de Goede             2017-11-25  1117  
b73deed32d0874 drivers/video/console/fbcon.c    Antonino A. Daplas        2006-01-09  1118  	set_blitting_type(vc, info);
e4fc27618b7523 drivers/video/console/fbcon.c    Antonino A. Daplas        2005-11-08  1119  
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1120  	cols = vc->vc_cols;
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1121  	rows = vc->vc_rows;
e4fc27618b7523 drivers/video/console/fbcon.c    Antonino A. Daplas        2005-11-08  1122  	new_cols = FBCON_SWAP(ops->rotate, info->var.xres, info->var.yres);
e4fc27618b7523 drivers/video/console/fbcon.c    Antonino A. Daplas        2005-11-08  1123  	new_rows = FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
e4fc27618b7523 drivers/video/console/fbcon.c    Antonino A. Daplas        2005-11-08  1124  	new_cols /= vc->vc_font.width;
e4fc27618b7523 drivers/video/console/fbcon.c    Antonino A. Daplas        2005-11-08  1125  	new_rows /= vc->vc_font.height;
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1126  
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1127  	/*
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1128  	 * We must always set the mode. The mode of the previous console
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1129  	 * driver could be in the same resolution but we are using different
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1130  	 * hardware so we have to initialize the hardware.
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1131  	 *
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1132  	 * We need to do it in fbcon_init() to prevent screen corruption.
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1133  	 */
6ca8dfd78187d8 drivers/video/console/fbcon.c    Jiri Slaby                2016-06-23  1134  	if (con_is_visible(vc) && vc->vc_mode == KD_TEXT) {
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1135  		if (info->fbops->fb_set_par &&
0fcf6ada2b8eb4 drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  1136  		    !(ops->flags & FBCON_FLAGS_INIT)) {
0fcf6ada2b8eb4 drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  1137  			ret = info->fbops->fb_set_par(info);
0fcf6ada2b8eb4 drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  1138  
0fcf6ada2b8eb4 drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  1139  			if (ret)
0fcf6ada2b8eb4 drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  1140  				printk(KERN_ERR "fbcon_init: detected "
0fcf6ada2b8eb4 drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  1141  					"unhandled fb_set_par error, "
0fcf6ada2b8eb4 drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  1142  					"error code %d\n", ret);
0fcf6ada2b8eb4 drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  1143  		}
0fcf6ada2b8eb4 drivers/video/console/fbcon.c    Florian Tobias Schandinat 2009-09-22  1144  
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1145  		ops->flags |= FBCON_FLAGS_INIT;
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1146  	}
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1147  
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1148  	ops->graphics = 0;
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds            2005-04-16  1149  

:::::: The code at line 1036 was first introduced by commit
:::::: 460f6b1a238d2ee1d69a4911f81ee1728242f0dd Revert "fbcon: Disable accelerated scrolling"

:::::: TO: Helge Deller <deller@gmx.de>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
