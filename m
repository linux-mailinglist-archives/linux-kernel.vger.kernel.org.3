Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378584A596D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 10:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbiBAJpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 04:45:35 -0500
Received: from mga05.intel.com ([192.55.52.43]:1975 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236025AbiBAJpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 04:45:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643708732; x=1675244732;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2PDjrfnypp5a0yXMmV0ApeDlQofZx6TanEhO1UKTVzs=;
  b=SHlpFPup//13j4B/4oko8uOtm4Pv2Yi5GUVpdl2kV/xvqOlFGwnSqH1E
   DWKbtwuTBcCYvEtgl46CGOw6k9dV6uPEH9G4LtBixdjLQrA809V77k86R
   ZO0c69YznZ7agTH2KtvTMCNSdJDabjrzIhV5zIvx3HmVwK1ehlsXzoiSu
   L8uJRb71SJQzorulO4PS/EVBWLyYVHj5Ya/CLJZ1BGPGpCkGlCwPSwceA
   MNjUf95+ejMxIx6JIFAAOYjQA4TMfOWK5B62Xt305AYFVxbl2DSPLUjL1
   pUOobxHOyWA6kbSLgENZDGcpSDHb4e7FI8DkCVn81WN3lYSYmm88oWmA9
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="334011425"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="334011425"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 01:45:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="482231117"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 01 Feb 2022 01:45:29 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEpj6-000T4c-Uf; Tue, 01 Feb 2022 09:45:28 +0000
Date:   Tue, 1 Feb 2022 17:45:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>
Subject: drivers/video/fbdev/core/fbmem.c:1165:7: error: use of undeclared
 identifier 'blank'
Message-ID: <202202011708.N9Yuf48f-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20220201-103710/Yizhuo-Zhai/fbdev-fbmem-Fix-the-implicit-type-casting/20220131-150528
head:   385d42ed58600c12390f350f56849260a19138a9
commit: 385d42ed58600c12390f350f56849260a19138a9 fbdev: fbmem: Fix the implicit type casting
date:   7 hours ago
config: arm-magician_defconfig (https://download.01.org/0day-ci/archive/20220201/202202011708.N9Yuf48f-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 6b1e844b69f15bb7dffaf9365cd2b355d2eb7579)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/0day-ci/linux/commit/385d42ed58600c12390f350f56849260a19138a9
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20220201-103710/Yizhuo-Zhai/fbdev-fbmem-Fix-the-implicit-type-casting/20220131-150528
        git checkout 385d42ed58600c12390f350f56849260a19138a9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/video/fbdev/core/fbmem.c:1165:7: error: use of undeclared identifier 'blank'
                   if (blank > FB_BLANK_POWERDOWN)
                       ^
   drivers/video/fbdev/core/fbmem.c:1166:4: error: use of undeclared identifier 'blank'
                           blank = FB_BLANK_POWERDOWN;
                           ^
   2 errors generated.


vim +/blank +1165 drivers/video/fbdev/core/fbmem.c

  1087	
  1088	static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
  1089				unsigned long arg)
  1090	{
  1091		const struct fb_ops *fb;
  1092		struct fb_var_screeninfo var;
  1093		struct fb_fix_screeninfo fix;
  1094		struct fb_cmap cmap_from;
  1095		struct fb_cmap_user cmap;
  1096		void __user *argp = (void __user *)arg;
  1097		long ret = 0;
  1098	
  1099		switch (cmd) {
  1100		case FBIOGET_VSCREENINFO:
  1101			lock_fb_info(info);
  1102			var = info->var;
  1103			unlock_fb_info(info);
  1104	
  1105			ret = copy_to_user(argp, &var, sizeof(var)) ? -EFAULT : 0;
  1106			break;
  1107		case FBIOPUT_VSCREENINFO:
  1108			if (copy_from_user(&var, argp, sizeof(var)))
  1109				return -EFAULT;
  1110			console_lock();
  1111			lock_fb_info(info);
  1112			ret = fb_set_var(info, &var);
  1113			if (!ret)
  1114				fbcon_update_vcs(info, var.activate & FB_ACTIVATE_ALL);
  1115			unlock_fb_info(info);
  1116			console_unlock();
  1117			if (!ret && copy_to_user(argp, &var, sizeof(var)))
  1118				ret = -EFAULT;
  1119			break;
  1120		case FBIOGET_FSCREENINFO:
  1121			lock_fb_info(info);
  1122			memcpy(&fix, &info->fix, sizeof(fix));
  1123			if (info->flags & FBINFO_HIDE_SMEM_START)
  1124				fix.smem_start = 0;
  1125			unlock_fb_info(info);
  1126	
  1127			ret = copy_to_user(argp, &fix, sizeof(fix)) ? -EFAULT : 0;
  1128			break;
  1129		case FBIOPUTCMAP:
  1130			if (copy_from_user(&cmap, argp, sizeof(cmap)))
  1131				return -EFAULT;
  1132			ret = fb_set_user_cmap(&cmap, info);
  1133			break;
  1134		case FBIOGETCMAP:
  1135			if (copy_from_user(&cmap, argp, sizeof(cmap)))
  1136				return -EFAULT;
  1137			lock_fb_info(info);
  1138			cmap_from = info->cmap;
  1139			unlock_fb_info(info);
  1140			ret = fb_cmap_to_user(&cmap_from, &cmap);
  1141			break;
  1142		case FBIOPAN_DISPLAY:
  1143			if (copy_from_user(&var, argp, sizeof(var)))
  1144				return -EFAULT;
  1145			console_lock();
  1146			lock_fb_info(info);
  1147			ret = fb_pan_display(info, &var);
  1148			unlock_fb_info(info);
  1149			console_unlock();
  1150			if (ret == 0 && copy_to_user(argp, &var, sizeof(var)))
  1151				return -EFAULT;
  1152			break;
  1153		case FBIO_CURSOR:
  1154			ret = -EINVAL;
  1155			break;
  1156		case FBIOGET_CON2FBMAP:
  1157			ret = fbcon_get_con2fb_map_ioctl(argp);
  1158			break;
  1159		case FBIOPUT_CON2FBMAP:
  1160			ret = fbcon_set_con2fb_map_ioctl(argp);
  1161			break;
  1162		case FBIOBLANK:
  1163			console_lock();
  1164			lock_fb_info(info);
> 1165			if (blank > FB_BLANK_POWERDOWN)
  1166				blank = FB_BLANK_POWERDOWN;
  1167			ret = fb_blank(info, arg);
  1168			/* might again call into fb_blank */
  1169			fbcon_fb_blanked(info, arg);
  1170			unlock_fb_info(info);
  1171			console_unlock();
  1172			break;
  1173		default:
  1174			lock_fb_info(info);
  1175			fb = info->fbops;
  1176			if (fb->fb_ioctl)
  1177				ret = fb->fb_ioctl(info, cmd, arg);
  1178			else
  1179				ret = -ENOTTY;
  1180			unlock_fb_info(info);
  1181		}
  1182		return ret;
  1183	}
  1184	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
