Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7764E56C440
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240033AbiGHUUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239177AbiGHUUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:20:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ED71C91A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 13:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657311608; x=1688847608;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rV3dhdPtTfcu/jomnR5C1BvDvT4TNSjTYVg09Gv4X+c=;
  b=UWTSmDOqf51hsH0vmRQ4UpNfWLS+cn/S9nfT3fgdsnsWSST5pTsC7f/2
   0TLaw4r3wpfR8iLx6ocibnpirBTMp3wbJoPxCy9fAkf57vO8tfjsefEeo
   V9m6dwcEbNF2Nz4/zI4sXaxyXt329sQnwaAgrQTHNgfNHpZlSUC9+InQN
   oFKqD7gXgNX+QanHE8pvD+stBaCj1242qQ/eBjjdlGUluExXn+rCWdMQx
   WDk7lRs/UNBrvsPR66CZ3wl8UPFIzuYo9VVM4SR8dUkImjQVLs8WSGXdX
   stc+A5mMGoxPjkf4YNPSMntwXaajtUqt/jOkjEXRRLLGYMm/d458No7sr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="370670908"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="370670908"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 13:20:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="594239897"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 08 Jul 2022 13:20:06 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9uSL-000Nu0-O9;
        Fri, 08 Jul 2022 20:20:05 +0000
Date:   Sat, 9 Jul 2022 04:19:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     kbuild-all@lists.01.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Subject: [geert-m68k:atari-drm-wip 35/35]
 drivers/gpu/drm/tiny/atari_drm.c:1024:29: warning: variable 'linesize' set
 but not used
Message-ID: <202207090456.TkBv7Mpl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git atari-drm-wip
head:   149db8fecb508c948620b3cb7a0737ebf226f862
commit: 149db8fecb508c948620b3cb7a0737ebf226f862 [35/35] drm: atari: Add a DRM driver for Atari graphics hardware
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220709/202207090456.TkBv7Mpl-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git/commit/?id=149db8fecb508c948620b3cb7a0737ebf226f862
        git remote add geert-m68k https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git
        git fetch --no-tags geert-m68k atari-drm-wip
        git checkout 149db8fecb508c948620b3cb7a0737ebf226f862
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/gpu/drm/tiny/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/tiny/atari_drm.c: In function 'falcon_decode_var':
>> drivers/gpu/drm/tiny/atari_drm.c:1024:29: warning: variable 'linesize' set but not used [-Wunused-but-set-variable]
    1024 |                         int linesize;
         |                             ^~~~~~~~
   drivers/gpu/drm/tiny/atari_drm.c: In function 'ext_set_col_reg':
>> drivers/gpu/drm/tiny/atari_drm.c:2177:31: warning: variable 'tmp' set but not used [-Wunused-but-set-variable]
    2177 |                 unsigned char tmp = INB(0x3da); \
         |                               ^~~
   drivers/gpu/drm/tiny/atari_drm.c:2199:17: note: in expansion of macro 'DACDelay'
    2199 |                 DACDelay;
         |                 ^~~~~~~~
>> drivers/gpu/drm/tiny/atari_drm.c:2177:31: warning: variable 'tmp' set but not used [-Wunused-but-set-variable]
    2177 |                 unsigned char tmp = INB(0x3da); \
         |                               ^~~
   drivers/gpu/drm/tiny/atari_drm.c:2201:17: note: in expansion of macro 'DACDelay'
    2201 |                 DACDelay;
         |                 ^~~~~~~~
>> drivers/gpu/drm/tiny/atari_drm.c:2177:31: warning: variable 'tmp' set but not used [-Wunused-but-set-variable]
    2177 |                 unsigned char tmp = INB(0x3da); \
         |                               ^~~
   drivers/gpu/drm/tiny/atari_drm.c:2203:17: note: in expansion of macro 'DACDelay'
    2203 |                 DACDelay;
         |                 ^~~~~~~~
>> drivers/gpu/drm/tiny/atari_drm.c:2177:31: warning: variable 'tmp' set but not used [-Wunused-but-set-variable]
    2177 |                 unsigned char tmp = INB(0x3da); \
         |                               ^~~
   drivers/gpu/drm/tiny/atari_drm.c:2205:17: note: in expansion of macro 'DACDelay'
    2205 |                 DACDelay;
         |                 ^~~~~~~~


vim +/linesize +1024 drivers/gpu/drm/tiny/atari_drm.c

   877	
   878		/* Reject uninitialized mode */
   879		if (!xres || !yres || !bpp)
   880			return -EINVAL;
   881	
   882		if (mon_type == F_MON_SM && bpp != 1)
   883			return -EINVAL;
   884	
   885		if (bpp <= 1) {
   886			bpp = 1;
   887			par->hw.falcon.f_shift = 0x400;
   888			par->hw.falcon.st_shift = 0x200;
   889		} else if (bpp <= 2) {
   890			bpp = 2;
   891			par->hw.falcon.f_shift = 0x000;
   892			par->hw.falcon.st_shift = 0x100;
   893		} else if (bpp <= 4) {
   894			bpp = 4;
   895			par->hw.falcon.f_shift = 0x000;
   896			par->hw.falcon.st_shift = 0x000;
   897		} else if (bpp <= 8) {
   898			bpp = 8;
   899			par->hw.falcon.f_shift = 0x010;
   900		} else if (bpp <= 16) {
   901			bpp = 16;		/* packed pixel mode */
   902			par->hw.falcon.f_shift = 0x100;	/* hicolor, no overlay */
   903		} else
   904			return -EINVAL;
   905		par->hw.falcon.bpp = bpp;
   906	
   907		if (mon_type == F_MON_SM || DontCalcRes) {
   908			/* Skip all calculations. VGA/TV/SC1224 only supported. */
   909			struct fb_var_screeninfo *myvar = &atafb_predefined[0];
   910	
   911			if (bpp > myvar->bits_per_pixel ||
   912			    var->xres > myvar->xres ||
   913			    var->yres > myvar->yres)
   914				return -EINVAL;
   915			fbhw->get_par(par);	/* Current par will be new par */
   916			goto set_screen_base;	/* Don't forget this */
   917		}
   918	
   919		/* Only some fixed resolutions < 640x400 */
   920		if (xres <= 320)
   921			xres = 320;
   922		else if (xres <= 640 && bpp != 16)
   923			xres = 640;
   924		if (yres <= 200)
   925			yres = 200;
   926		else if (yres <= 240)
   927			yres = 240;
   928		else if (yres <= 400)
   929			yres = 400;
   930	
   931		/* 2 planes must use STE compatibility mode */
   932		par->hw.falcon.ste_mode = bpp == 2;
   933		par->hw.falcon.mono = bpp == 1;
   934	
   935		/* Total and visible scanline length must be a multiple of one longword,
   936		 * this and the console fontwidth yields the alignment for xres and
   937		 * xres_virtual.
   938		 * TODO: this way "odd" fontheights are not supported
   939		 *
   940		 * Special case in STE mode: blank and graphic positions don't align,
   941		 * avoid trash at right margin
   942		 */
   943		if (par->hw.falcon.ste_mode)
   944			xres = (xres + 63) & ~63;
   945		else if (bpp == 1)
   946			xres = (xres + 31) & ~31;
   947		else
   948			xres = (xres + 15) & ~15;
   949		if (yres >= 400)
   950			yres = (yres + 15) & ~15;
   951		else
   952			yres = (yres + 7) & ~7;
   953	
   954		if (xres_virtual < xres)
   955			xres_virtual = xres;
   956		else if (bpp == 1)
   957			xres_virtual = (xres_virtual + 31) & ~31;
   958		else
   959			xres_virtual = (xres_virtual + 15) & ~15;
   960	
   961		if (yres_virtual <= 0)
   962			yres_virtual = 0;
   963		else if (yres_virtual < yres)
   964			yres_virtual = yres;
   965	
   966		par->hw.falcon.line_width = bpp * xres / 16;
   967		par->hw.falcon.line_offset = bpp * (xres_virtual - xres) / 16;
   968	
   969		/* single or double pixel width */
   970		xstretch = (xres < 640) ? 2 : 1;
   971	
   972	#if 0 /* SM124 supports only 640x400, this is rejected above */
   973		if (mon_type == F_MON_SM) {
   974			if (xres != 640 && yres != 400)
   975				return -EINVAL;
   976			plen = 1;
   977			pclock = &f32;
   978			/* SM124-mode is special */
   979			par->hw.falcon.ste_mode = 1;
   980			par->hw.falcon.f_shift = 0x000;
   981			par->hw.falcon.st_shift = 0x200;
   982			left_margin = hsync_len = 128 / plen;
   983			right_margin = 0;
   984			/* TODO set all margins */
   985		} else
   986	#endif
   987		if (mon_type == F_MON_SC || mon_type == F_MON_TV) {
   988			plen = 2 * xstretch;
   989			if (var->pixclock > f32.t * plen)
   990				return -EINVAL;
   991			pclock = &f32;
   992			if (yres > 240)
   993				interlace = 1;
   994			if (var->pixclock == 0) {
   995				/* set some minimal margins which center the screen */
   996				left_margin = 32;
   997				right_margin = 18;
   998				hsync_len = pclock->hsync / plen;
   999				upper_margin = 31;
  1000				lower_margin = 14;
  1001				vsync_len = interlace ? 3 : 4;
  1002			} else {
  1003				left_margin = var->left_margin;
  1004				right_margin = var->right_margin;
  1005				hsync_len = var->hsync_len;
  1006				upper_margin = var->upper_margin;
  1007				lower_margin = var->lower_margin;
  1008				vsync_len = var->vsync_len;
  1009				if (var->vmode & FB_VMODE_INTERLACED) {
  1010					upper_margin = (upper_margin + 1) / 2;
  1011					lower_margin = (lower_margin + 1) / 2;
  1012					vsync_len = (vsync_len + 1) / 2;
  1013				} else if (var->vmode & FB_VMODE_DOUBLE) {
  1014					upper_margin *= 2;
  1015					lower_margin *= 2;
  1016					vsync_len *= 2;
  1017				}
  1018			}
  1019		} else {			/* F_MON_VGA */
  1020			if (bpp == 16)
  1021				xstretch = 2;	/* Double pixel width only for hicolor */
  1022			/* Default values are used for vert./hor. timing if no pixelclock given. */
  1023			if (var->pixclock == 0) {
> 1024				int linesize;
  1025	
  1026				/* Choose master pixelclock depending on hor. timing */
  1027				plen = 1 * xstretch;
  1028				if ((plen * xres + f25.right + f25.hsync + f25.left) *
  1029				    fb_info.monspecs.hfmin < f25.f)
  1030					pclock = &f25;
  1031				else if ((plen * xres + f32.right + f32.hsync +
  1032					  f32.left) * fb_info.monspecs.hfmin < f32.f)
  1033					pclock = &f32;
  1034				else if ((plen * xres + fext.right + fext.hsync +
  1035					  fext.left) * fb_info.monspecs.hfmin < fext.f &&
  1036				         fext.f)
  1037					pclock = &fext;
  1038				else
  1039					return -EINVAL;
  1040	
  1041				left_margin = pclock->left / plen;
  1042				right_margin = pclock->right / plen;
  1043				hsync_len = pclock->hsync / plen;
  1044				linesize = left_margin + xres + right_margin + hsync_len;
  1045				upper_margin = 31;
  1046				lower_margin = 11;
  1047				vsync_len = 3;
  1048			} else {
  1049				/* Choose largest pixelclock <= wanted clock */
  1050				int i;
  1051				unsigned long pcl = ULONG_MAX;
  1052				pclock = 0;
  1053				for (i = 1; i <= 4; i *= 2) {
  1054					if (f25.t * i >= var->pixclock &&
  1055					    f25.t * i < pcl) {
  1056						pcl = f25.t * i;
  1057						pclock = &f25;
  1058					}
  1059					if (f32.t * i >= var->pixclock &&
  1060					    f32.t * i < pcl) {
  1061						pcl = f32.t * i;
  1062						pclock = &f32;
  1063					}
  1064					if (fext.t && fext.t * i >= var->pixclock &&
  1065					    fext.t * i < pcl) {
  1066						pcl = fext.t * i;
  1067						pclock = &fext;
  1068					}
  1069				}
  1070				if (!pclock)
  1071					return -EINVAL;
  1072				plen = pcl / pclock->t;
  1073	
  1074				left_margin = var->left_margin;
  1075				right_margin = var->right_margin;
  1076				hsync_len = var->hsync_len;
  1077				upper_margin = var->upper_margin;
  1078				lower_margin = var->lower_margin;
  1079				vsync_len = var->vsync_len;
  1080				/* Internal unit is [single lines per (half-)frame] */
  1081				if (var->vmode & FB_VMODE_INTERLACED) {
  1082					/* # lines in half frame */
  1083					/* External unit is [lines per full frame] */
  1084					upper_margin = (upper_margin + 1) / 2;
  1085					lower_margin = (lower_margin + 1) / 2;
  1086					vsync_len = (vsync_len + 1) / 2;
  1087				} else if (var->vmode & FB_VMODE_DOUBLE) {
  1088					/* External unit is [double lines per frame] */
  1089					upper_margin *= 2;
  1090					lower_margin *= 2;
  1091					vsync_len *= 2;
  1092				}
  1093			}
  1094			if (pclock == &fext)
  1095				longoffset = 1;	/* VIDEL doesn't synchronize on short offset */
  1096		}
  1097		/* Is video bus bandwidth (32MB/s) too low for this resolution? */
  1098		/* this is definitely wrong if bus clock != 32MHz */
  1099		if (pclock->f / plen / 8 * bpp > 32000000L)
  1100			return -EINVAL;
  1101	
  1102		if (vsync_len < 1)
  1103			vsync_len = 1;
  1104	
  1105		/* include sync lengths in right/lower margin for all calculations */
  1106		right_margin += hsync_len;
  1107		lower_margin += vsync_len;
  1108	
  1109		/* ! In all calculations of margins we use # of lines in half frame
  1110		 * (which is a full frame in non-interlace mode), so we can switch
  1111		 * between interlace and non-interlace without messing around
  1112		 * with these.
  1113		 */
  1114	again:
  1115		/* Set base_offset 128 and video bus width */
  1116		par->hw.falcon.vid_control = mon_type | f030_bus_width;
  1117		if (!longoffset)
  1118			par->hw.falcon.vid_control |= VCO_SHORTOFFS;	/* base_offset 64 */
  1119		if (var->sync & FB_SYNC_HOR_HIGH_ACT)
  1120			par->hw.falcon.vid_control |= VCO_HSYPOS;
  1121		if (var->sync & FB_SYNC_VERT_HIGH_ACT)
  1122			par->hw.falcon.vid_control |= VCO_VSYPOS;
  1123		/* Pixelclock */
  1124		par->hw.falcon.vid_control |= pclock->control_mask;
  1125		/* External or internal clock */
  1126		par->hw.falcon.sync = pclock->sync_mask | 0x2;
  1127		/* Pixellength and prescale */
  1128		par->hw.falcon.vid_mode = (2 / plen) << 2;
  1129		if (doubleline)
  1130			par->hw.falcon.vid_mode |= VMO_DOUBLE;
  1131		if (interlace)
  1132			par->hw.falcon.vid_mode |= VMO_INTER;
  1133	
  1134		/*********************
  1135		 * Horizontal timing: unit = [master clock cycles]
  1136		 * unit of hxx-registers: [master clock cycles * prescale]
  1137		 * Hxx-registers are 9 bit wide
  1138		 *
  1139		 * 1 line = ((hht + 2) * 2 * prescale) clock cycles
  1140		 *
  1141		 * graphic output = hdb & 0x200 ?
  1142		 *        ((hht + 2) * 2 - hdb + hde) * prescale - hdboff + hdeoff:
  1143		 *        (hht + 2  - hdb + hde) * prescale - hdboff + hdeoff
  1144		 * (this must be a multiple of plen*128/bpp, on VGA pixels
  1145		 *  to the right may be cut off with a bigger right margin)
  1146		 *
  1147		 * start of graphics relative to start of 1st halfline = hdb & 0x200 ?
  1148		 *        (hdb - hht - 2) * prescale + hdboff :
  1149		 *        hdb * prescale + hdboff
  1150		 *
  1151		 * end of graphics relative to start of 1st halfline =
  1152		 *        (hde + hht + 2) * prescale + hdeoff
  1153		 *********************/
  1154		/* Calculate VIDEL registers */
  1155	{
  1156		prescale = hxx_prescale(&par->hw.falcon);
  1157		base_off = par->hw.falcon.vid_control & VCO_SHORTOFFS ? 64 : 128;
  1158	
  1159		/* Offsets depend on video mode */
  1160		/* Offsets are in clock cycles, divide by prescale to
  1161		 * calculate hd[be]-registers
  1162		 */
  1163		if (par->hw.falcon.f_shift & 0x100) {
  1164			align = 1;
  1165			hde_off = 0;
  1166			hdb_off = (base_off + 16 * plen) + prescale;
  1167		} else {
  1168			align = 128 / bpp;
  1169			hde_off = ((128 / bpp + 2) * plen);
  1170			if (par->hw.falcon.ste_mode)
  1171				hdb_off = (64 + base_off + (128 / bpp + 2) * plen) + prescale;
  1172			else
  1173				hdb_off = (base_off + (128 / bpp + 18) * plen) + prescale;
  1174		}
  1175	
  1176		gstart = (prescale / 2 + plen * left_margin) / prescale;
  1177		/* gend1 is for hde (gend-gstart multiple of align), shifter's xres */
  1178		gend1 = gstart + roundup(xres, align) * plen / prescale;
  1179		/* gend2 is for hbb, visible xres (rest to gend1 is cut off by hblank) */
  1180		gend2 = gstart + xres * plen / prescale;
  1181		par->HHT = plen * (left_margin + xres + right_margin) /
  1182				   (2 * prescale) - 2;
  1183	/*	par->HHT = (gend2 + plen * right_margin / prescale) / 2 - 2;*/
  1184	
  1185		par->HDB = gstart - hdb_off / prescale;
  1186		par->HBE = gstart;
  1187		if (par->HDB < 0)
  1188			par->HDB += par->HHT + 2 + 0x200;
  1189		par->HDE = gend1 - par->HHT - 2 - hde_off / prescale;
  1190		par->HBB = gend2 - par->HHT - 2;
  1191	#if 0
  1192		/* One more Videl constraint: data fetch of two lines must not overlap */
  1193		if ((par->HDB & 0x200) && (par->HDB & ~0x200) - par->HDE <= 5) {
  1194			/* if this happens increase margins, decrease hfreq. */
  1195		}
  1196	#endif
  1197		if (hde_off % prescale)
  1198			par->HBB++;		/* compensate for non matching hde and hbb */
  1199		par->HSS = par->HHT + 2 - plen * hsync_len / prescale;
  1200		if (par->HSS < par->HBB)
  1201			par->HSS = par->HBB;
  1202	}
  1203	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
