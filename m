Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA6546D80F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbhLHQ2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:28:25 -0500
Received: from mga17.intel.com ([192.55.52.151]:20520 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236757AbhLHQ2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:28:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="218547562"
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="218547562"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 08:24:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="612140573"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 08 Dec 2021 08:24:50 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muzkP-0000mu-BW; Wed, 08 Dec 2021 16:24:49 +0000
Date:   Thu, 9 Dec 2021 00:24:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kees:memcpy/step2/next-20211206 8/19]
 drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202112090054.dh3ZS3k5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git memcpy/step2/next-20211206
head:   082faead4a3c2e5d9f541f97d8d4d5fa0f88dce0
commit: 155d6a9544f46fb8ae0e7e3c11a4deac352e7b9a [8/19] fortify: Detect struct member overflows in memmove() at compile-time
config: i386-randconfig-s001-20211207 (https://download.01.org/0day-ci/archive/20211209/202112090054.dh3ZS3k5-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=155d6a9544f46fb8ae0e7e3c11a4deac352e7b9a
        git remote add kees https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
        git fetch --no-tags kees memcpy/step2/next-20211206
        git checkout 155d6a9544f46fb8ae0e7e3c11a4deac352e7b9a
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/video/fbdev/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dest @@
   drivers/video/fbdev/hgafb.c:496:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:496:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dest
>> drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] src @@
   drivers/video/fbdev/hgafb.c:496:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:496:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] src
>> drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dest @@
   drivers/video/fbdev/hgafb.c:496:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:496:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dest
>> drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] src @@
   drivers/video/fbdev/hgafb.c:496:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:496:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] src
>> drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dest @@
   drivers/video/fbdev/hgafb.c:496:25: sparse:     expected void *
   drivers/video/fbdev/hgafb.c:496:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dest
   drivers/video/fbdev/hgafb.c:496:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] src @@
   drivers/video/fbdev/hgafb.c:496:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:496:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] src
   drivers/video/fbdev/hgafb.c:507:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dest @@
   drivers/video/fbdev/hgafb.c:507:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:507:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dest
   drivers/video/fbdev/hgafb.c:507:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] src @@
   drivers/video/fbdev/hgafb.c:507:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:507:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] src
   drivers/video/fbdev/hgafb.c:507:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dest @@
   drivers/video/fbdev/hgafb.c:507:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:507:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dest
   drivers/video/fbdev/hgafb.c:507:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] src @@
   drivers/video/fbdev/hgafb.c:507:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:507:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] src
   drivers/video/fbdev/hgafb.c:507:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dest @@
   drivers/video/fbdev/hgafb.c:507:25: sparse:     expected void *
   drivers/video/fbdev/hgafb.c:507:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dest
   drivers/video/fbdev/hgafb.c:507:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] src @@
   drivers/video/fbdev/hgafb.c:507:25: sparse:     expected void const *
   drivers/video/fbdev/hgafb.c:507:25: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] src

vim +496 drivers/video/fbdev/hgafb.c

^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  482  
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  483  static void hgafb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  484  {
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  485  	u_int rows, y1, y2;
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  486  	u8 __iomem *src;
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  487  	u8 __iomem *dest;
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  488  
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  489  	if (area->dy <= area->sy) {
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  490  		y1 = area->sy;
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  491  		y2 = area->dy;
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  492  
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  493  		for (rows = area->height; rows--; ) {
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  494  			src = rowaddr(info, y1) + (area->sx >> 3);
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  495  			dest = rowaddr(info, y2) + (area->dx >> 3);
529ed806d4540d drivers/video/hgafb.c Brent Cook     2010-12-31 @496  			memmove(dest, src, (area->width >> 3));
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  497  			y1++;
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  498  			y2++;
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  499  		}
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  500  	} else {
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  501  		y1 = area->sy + area->height - 1;
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  502  		y2 = area->dy + area->height - 1;
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  503  
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  504  		for (rows = area->height; rows--;) {
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  505  			src = rowaddr(info, y1) + (area->sx >> 3);
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  506  			dest = rowaddr(info, y2) + (area->dx >> 3);
529ed806d4540d drivers/video/hgafb.c Brent Cook     2010-12-31  507  			memmove(dest, src, (area->width >> 3));
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  508  			y1--;
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  509  			y2--;
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  510  		}
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  511  	}
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  512  }
^1da177e4c3f41 drivers/video/hgafb.c Linus Torvalds 2005-04-16  513  

:::::: The code at line 496 was first introduced by commit
:::::: 529ed806d4540d23ca2f68b28c3715d1566fc3ac video: Fix the HGA framebuffer driver

:::::: TO: Brent Cook <busterb@gmail.com>
:::::: CC: Paul Mundt <lethal@linux-sh.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
