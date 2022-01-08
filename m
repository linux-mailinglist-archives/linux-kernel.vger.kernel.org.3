Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C54948863F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 22:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiAHVUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 16:20:12 -0500
Received: from mga04.intel.com ([192.55.52.120]:29084 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229492AbiAHVUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 16:20:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641676812; x=1673212812;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ndCv+G5iqec2CTcl45H/FyqzgGEsJ90lhw5hGVPd7wc=;
  b=QpXb+27BtnQBTEvdRLfMzWIy75tI3QUex2GXUiVDxS/Rj52+Bab8JiGt
   eGhVqgN6IC9X+jTkkTWuXScmEm4p2sjiuGCFKTKUvB1bgJTSyim6CH2k8
   nFp+xX6O+jZD0r/NzwFpqX3oXqY2l6sGn16lP+q4DdgF3wENFmetyOYMx
   RCrUFEir6/Oh2xRc14zPHzGB/Cv0+Qvzdjd8eoy5YvfnNVEIDcYjsWnh1
   G3jcqz2lqCho7H/Hf6DHOmAhi5B7XXy+wr6o2aSKaPMuF4mSuKYm+bqYh
   LwX32Ce4SzuGdKr514xVDbAxSIYVyjx2R5NE1ziXHnG2qQMLHb3ed7IQu
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10221"; a="241854032"
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="241854032"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 13:20:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="575444826"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 08 Jan 2022 13:20:10 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6J8E-00014C-8C; Sat, 08 Jan 2022 21:20:10 +0000
Date:   Sun, 9 Jan 2022 05:19:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 2294/2300] drivers/video/fbdev/bt431.h:210:17:
 error: implicit declaration of function 'DIV_ROUND_UP'
Message-ID: <202201090404.fXkl0j7u-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   4e348e961395297bb17f101cc63bc133d8a348e9
commit: a35948847a1e0bf875f580f821cb871ce16d4c60 [2294/2300] headers/deps: time: Optimize <linux/time64.h> dependencies, remove <linux/time64_api.h> inclusion
config: mips-decstation_defconfig (https://download.01.org/0day-ci/archive/20220109/202201090404.fXkl0j7u-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=a35948847a1e0bf875f580f821cb871ce16d4c60
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout a35948847a1e0bf875f580f821cb871ce16d4c60
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/video/fbdev/pmag-aa-fb.c:44:
   drivers/video/fbdev/bt431.h: In function 'bt431_set_cursor':
>> drivers/video/fbdev/bt431.h:210:17: error: implicit declaration of function 'DIV_ROUND_UP' [-Werror=implicit-function-declaration]
     210 |         width = DIV_ROUND_UP(width, 8);
         |                 ^~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/DIV_ROUND_UP +210 drivers/video/fbdev/bt431.h

^1da177e4c3f41 drivers/video/bt431.h       Linus Torvalds    2005-04-16  201  
90c83176e5cfa6 drivers/video/fbdev/bt431.h Maciej W. Rozycki 2016-02-22  202  static inline void bt431_set_cursor(struct bt431_regs *regs,
90c83176e5cfa6 drivers/video/fbdev/bt431.h Maciej W. Rozycki 2016-02-22  203  				    const char *data, const char *mask,
90c83176e5cfa6 drivers/video/fbdev/bt431.h Maciej W. Rozycki 2016-02-22  204  				    u16 rop, u16 width, u16 height)
^1da177e4c3f41 drivers/video/bt431.h       Linus Torvalds    2005-04-16  205  {
90c83176e5cfa6 drivers/video/fbdev/bt431.h Maciej W. Rozycki 2016-02-22  206  	u16 x, y;
^1da177e4c3f41 drivers/video/bt431.h       Linus Torvalds    2005-04-16  207  	int i;
^1da177e4c3f41 drivers/video/bt431.h       Linus Torvalds    2005-04-16  208  
90c83176e5cfa6 drivers/video/fbdev/bt431.h Maciej W. Rozycki 2016-02-22  209  	i = 0;
90c83176e5cfa6 drivers/video/fbdev/bt431.h Maciej W. Rozycki 2016-02-22 @210  	width = DIV_ROUND_UP(width, 8);
^1da177e4c3f41 drivers/video/bt431.h       Linus Torvalds    2005-04-16  211  	bt431_select_reg(regs, BT431_REG_CRAM_BASE);
90c83176e5cfa6 drivers/video/fbdev/bt431.h Maciej W. Rozycki 2016-02-22  212  	for (y = 0; y < BT431_CURSOR_SIZE; y++)
90c83176e5cfa6 drivers/video/fbdev/bt431.h Maciej W. Rozycki 2016-02-22  213  		for (x = 0; x < BT431_CURSOR_SIZE / 8; x++) {
90c83176e5cfa6 drivers/video/fbdev/bt431.h Maciej W. Rozycki 2016-02-22  214  			u16 val = 0;
90c83176e5cfa6 drivers/video/fbdev/bt431.h Maciej W. Rozycki 2016-02-22  215  
90c83176e5cfa6 drivers/video/fbdev/bt431.h Maciej W. Rozycki 2016-02-22  216  			if (y < height && x < width) {
90c83176e5cfa6 drivers/video/fbdev/bt431.h Maciej W. Rozycki 2016-02-22  217  				val = mask[i];
90c83176e5cfa6 drivers/video/fbdev/bt431.h Maciej W. Rozycki 2016-02-22  218  				if (rop == ROP_XOR)
90c83176e5cfa6 drivers/video/fbdev/bt431.h Maciej W. Rozycki 2016-02-22  219  					val = (val << 8) | (val ^ data[i]);
^1da177e4c3f41 drivers/video/bt431.h       Linus Torvalds    2005-04-16  220  				else
90c83176e5cfa6 drivers/video/fbdev/bt431.h Maciej W. Rozycki 2016-02-22  221  					val = (val << 8) | (val & data[i]);
90c83176e5cfa6 drivers/video/fbdev/bt431.h Maciej W. Rozycki 2016-02-22  222  				i++;
90c83176e5cfa6 drivers/video/fbdev/bt431.h Maciej W. Rozycki 2016-02-22  223  			}
90c83176e5cfa6 drivers/video/fbdev/bt431.h Maciej W. Rozycki 2016-02-22  224  			bt431_write_cmap_inc(regs, val);
^1da177e4c3f41 drivers/video/bt431.h       Linus Torvalds    2005-04-16  225  		}
^1da177e4c3f41 drivers/video/bt431.h       Linus Torvalds    2005-04-16  226  }
^1da177e4c3f41 drivers/video/bt431.h       Linus Torvalds    2005-04-16  227  

:::::: The code at line 210 was first introduced by commit
:::::: 90c83176e5cfa666bb2e7643d74ca87e08e171cb video: fbdev: pmag-aa-fb: Adapt to current APIs

:::::: TO: Maciej W. Rozycki <macro@linux-mips.org>
:::::: CC: Tomi Valkeinen <tomi.valkeinen@ti.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
