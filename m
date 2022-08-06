Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0FF58B884
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 00:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbiHFWCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 18:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiHFWCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 18:02:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1018810FDD
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 15:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659823332; x=1691359332;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5yzgfx+0Pm3S0AYaaU6Wmzbl3SnGhoMWl9DF9xge984=;
  b=lY8LWAeMb8bz0U99gEdhOEymM4FQ+qScjrb3/RBf+XPih/P2FuXSG90m
   k+vB7rwgdzHRO2O8HnXFoxy2VQUTTaW6nguEDtui7JfigT/obPyk0WSEH
   1XE8DDJk6swC/YwWSzxQ6uAp2AgxNdGgEhIpgnhcBi3hFO+awEcpVs1gT
   iBKwe6zJXGdOfg8iddlrV0NK0mMgygJWxHIET+UcE0qglAQGrW61Wvsmj
   cGgoJrO/21F/DIQjJmsNtdQTMVkSsy2H1sCpl+knUwR6vlhUGb8/v6wa6
   wkpo+UaIumQJH7brW+EKWnMh/KZBbJa+ZohVOHfUU6sR9y0PEML5F7LaX
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="277320176"
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="277320176"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 15:02:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="931610093"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 06 Aug 2022 15:02:09 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKRs1-000KiN-0B;
        Sat, 06 Aug 2022 22:02:09 +0000
Date:   Sun, 7 Aug 2022 06:01:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/core/fbmem.c:885:17: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202208070524.5P8ADxzG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   af3e9579ecfbe1796334bb25a2f0a6437983673a
commit: f68f2ff91512c199ec24883001245912afc17873 fortify: Detect struct member overflows in memcpy() at compile-time
date:   6 months ago
config: mips-randconfig-s042-20220807 (https://download.01.org/0day-ci/archive/20220807/202208070524.5P8ADxzG-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f68f2ff91512c199ec24883001245912afc17873
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f68f2ff91512c199ec24883001245912afc17873
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash drivers/video/fbdev/core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   drivers/video/fbdev/core/fbmem.c:808:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] src @@
   drivers/video/fbdev/core/fbmem.c:808:17: sparse:     expected void const *
   drivers/video/fbdev/core/fbmem.c:808:17: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] src
   drivers/video/fbdev/core/fbmem.c:808:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] src @@
   drivers/video/fbdev/core/fbmem.c:808:17: sparse:     expected void const *
   drivers/video/fbdev/core/fbmem.c:808:17: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] src
   drivers/video/fbdev/core/fbmem.c:808:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] src @@
   drivers/video/fbdev/core/fbmem.c:808:17: sparse:     expected void const *
   drivers/video/fbdev/core/fbmem.c:808:17: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] src
>> drivers/video/fbdev/core/fbmem.c:885:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dst @@
   drivers/video/fbdev/core/fbmem.c:885:17: sparse:     expected void const *
   drivers/video/fbdev/core/fbmem.c:885:17: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dst
>> drivers/video/fbdev/core/fbmem.c:885:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dst @@
   drivers/video/fbdev/core/fbmem.c:885:17: sparse:     expected void const *
   drivers/video/fbdev/core/fbmem.c:885:17: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dst
   drivers/video/fbdev/core/fbmem.c:885:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dst @@
   drivers/video/fbdev/core/fbmem.c:885:17: sparse:     expected void *
   drivers/video/fbdev/core/fbmem.c:885:17: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dst

vim +885 drivers/video/fbdev/core/fbmem.c

^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  826  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  827  static ssize_t
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  828  fb_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  829  {
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  830  	unsigned long p = *ppos;
c47747fde931c0 drivers/video/fbmem.c Linus Torvalds     2011-05-11  831  	struct fb_info *info = file_fb_info(file);
f11b478d461b71 drivers/video/fbmem.c James Hogan        2010-10-27  832  	u8 *buffer, *src;
f11b478d461b71 drivers/video/fbmem.c James Hogan        2010-10-27  833  	u8 __iomem *dst;
f11b478d461b71 drivers/video/fbmem.c James Hogan        2010-10-27  834  	int c, cnt = 0, err = 0;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  835  	unsigned long total_size;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  836  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  837  	if (!info || !info->screen_base)
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  838  		return -ENODEV;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  839  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  840  	if (info->state != FBINFO_STATE_RUNNING)
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  841  		return -EPERM;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  842  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  843  	if (info->fbops->fb_write)
3f9b0880e4a96b drivers/video/fbmem.c Antonino A. Daplas 2007-05-08  844  		return info->fbops->fb_write(info, buf, count, ppos);
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  845  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  846  	total_size = info->screen_size;
0a484a3af905a2 drivers/video/fbmem.c Antonino A. Daplas 2006-01-09  847  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  848  	if (total_size == 0)
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  849  		total_size = info->fix.smem_len;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  850  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  851  	if (p > total_size)
6a2a88668e90cd drivers/video/fbmem.c Antonino A. Daplas 2006-04-18  852  		return -EFBIG;
0a484a3af905a2 drivers/video/fbmem.c Antonino A. Daplas 2006-01-09  853  
6a2a88668e90cd drivers/video/fbmem.c Antonino A. Daplas 2006-04-18  854  	if (count > total_size) {
6a2a88668e90cd drivers/video/fbmem.c Antonino A. Daplas 2006-04-18  855  		err = -EFBIG;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  856  		count = total_size;
6a2a88668e90cd drivers/video/fbmem.c Antonino A. Daplas 2006-04-18  857  	}
6a2a88668e90cd drivers/video/fbmem.c Antonino A. Daplas 2006-04-18  858  
6a2a88668e90cd drivers/video/fbmem.c Antonino A. Daplas 2006-04-18  859  	if (count + p > total_size) {
6a2a88668e90cd drivers/video/fbmem.c Antonino A. Daplas 2006-04-18  860  		if (!err)
6a2a88668e90cd drivers/video/fbmem.c Antonino A. Daplas 2006-04-18  861  			err = -ENOSPC;
0a484a3af905a2 drivers/video/fbmem.c Antonino A. Daplas 2006-01-09  862  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  863  		count = total_size - p;
6a2a88668e90cd drivers/video/fbmem.c Antonino A. Daplas 2006-04-18  864  	}
0a484a3af905a2 drivers/video/fbmem.c Antonino A. Daplas 2006-01-09  865  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  866  	buffer = kmalloc((count > PAGE_SIZE) ? PAGE_SIZE : count,
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  867  			 GFP_KERNEL);
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  868  	if (!buffer)
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  869  		return -ENOMEM;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  870  
f11b478d461b71 drivers/video/fbmem.c James Hogan        2010-10-27  871  	dst = (u8 __iomem *) (info->screen_base + p);
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  872  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  873  	if (info->fbops->fb_sync)
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  874  		info->fbops->fb_sync(info);
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  875  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  876  	while (count) {
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  877  		c = (count > PAGE_SIZE) ? PAGE_SIZE : count;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  878  		src = buffer;
0a484a3af905a2 drivers/video/fbmem.c Antonino A. Daplas 2006-01-09  879  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  880  		if (copy_from_user(src, buf, c)) {
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  881  			err = -EFAULT;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  882  			break;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  883  		}
0a484a3af905a2 drivers/video/fbmem.c Antonino A. Daplas 2006-01-09  884  
f11b478d461b71 drivers/video/fbmem.c James Hogan        2010-10-27 @885  		fb_memcpy_tofb(dst, src, c);
f11b478d461b71 drivers/video/fbmem.c James Hogan        2010-10-27  886  		dst += c;
f11b478d461b71 drivers/video/fbmem.c James Hogan        2010-10-27  887  		src += c;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  888  		*ppos += c;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  889  		buf += c;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  890  		cnt += c;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  891  		count -= c;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  892  	}
0a484a3af905a2 drivers/video/fbmem.c Antonino A. Daplas 2006-01-09  893  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  894  	kfree(buffer);
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  895  
6a2a88668e90cd drivers/video/fbmem.c Antonino A. Daplas 2006-04-18  896  	return (cnt) ? cnt : err;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  897  }
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  898  

:::::: The code at line 885 was first introduced by commit
:::::: f11b478d461b7113eb4603b3914aaf15b7788e87 fbmem: fix fb_read, fb_write unaligned accesses

:::::: TO: James Hogan <james@albanarts.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
