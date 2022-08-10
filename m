Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9090558F47D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 00:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbiHJWpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 18:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiHJWpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 18:45:13 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AF4B1D
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 15:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660171511; x=1691707511;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FZk05PnzfpZYv13WuCDtib67exbknEX1WpGYM+QodmI=;
  b=NBHtnXOscMh9c94SZrvAeAVJTv27r1n4FC+pZcsSUmPOrRwk36LYYmB8
   Kbe4pF0JcLMttrEkdbtFCzAQ43jBDdq7HCb2HF4BzJ+hxZxvKziZ7Bmk+
   jZOzKS6fN7xLupCJp0DVy0B9Y8CvtfMBCk9+aNYRyHfU+jZko3YGZja6B
   JqcyxQLhgGE1KkKNm2+Yzi2zao0cvLq4hUloAyMrSqMfRi7b2IbGU7Ovp
   vrq8rKIAs0XjUiuG8yF6jR02OMZB4E+fRx0SCkgL4/37CoxTGZKavJ5yW
   JrNlDhzyuQkdF4IZ8vvbSCV5D+H0SPFXYA/vxvlUYhwqDVXIFUos7tSHL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="271594849"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="271594849"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 15:45:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="555909598"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 10 Aug 2022 15:45:09 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLuRo-0000np-2c;
        Wed, 10 Aug 2022 22:45:08 +0000
Date:   Thu, 11 Aug 2022 06:44:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/aty/atyfb_base.c:3742:37: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202208110636.sDlv0hlK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aeb6e6ac18c73ec287b3b1e2c913520699358c13
commit: 5d6f52671e76ca2d55d74e676ac4c38ceb14a2d3 ARM: rework endianess selection
date:   4 months ago
config: arm-randconfig-s053-20220810 (https://download.01.org/0day-ci/archive/20220811/202208110636.sDlv0hlK-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5d6f52671e76ca2d55d74e676ac4c38ceb14a2d3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5d6f52671e76ca2d55d74e676ac4c38ceb14a2d3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/net/vmxnet3/ drivers/video/fbdev/aty/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/video/fbdev/aty/atyfb_base.c:3742:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got unsigned char [usertype] *addr @@
   drivers/video/fbdev/aty/atyfb_base.c:3742:37: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/video/fbdev/aty/atyfb_base.c:3742:37: sparse:     got unsigned char [usertype] *addr
--
>> drivers/net/vmxnet3/vmxnet3_drv.c:228:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le64 [usertype] addr @@     got unsigned long long [usertype] @@
   drivers/net/vmxnet3/vmxnet3_drv.c:228:23: sparse:     expected restricted __le64 [usertype] addr
   drivers/net/vmxnet3/vmxnet3_drv.c:228:23: sparse:     got unsigned long long [usertype]
   drivers/net/vmxnet3/vmxnet3_drv.c:229:16: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:230:25: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:244:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/net/vmxnet3/vmxnet3_drv.c:244:22: sparse:     expected unsigned int [usertype]
   drivers/net/vmxnet3/vmxnet3_drv.c:244:22: sparse:     got restricted __le32 [usertype]
   drivers/net/vmxnet3/vmxnet3_drv.c:256:24: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:1248:43: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __wsum [usertype] csum @@     got restricted __be16 [usertype] @@
   drivers/net/vmxnet3/vmxnet3_drv.c:1248:43: sparse:     expected restricted __wsum [usertype] csum
   drivers/net/vmxnet3/vmxnet3_drv.c:1248:43: sparse:     got restricted __be16 [usertype]
   drivers/net/vmxnet3/vmxnet3_drv.c:1390:17: sparse: sparse: restricted __le64 degrades to integer
   drivers/net/vmxnet3/vmxnet3_drv.c:1679:33: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] addr @@     got restricted __le64 [usertype] addr @@
   drivers/net/vmxnet3/vmxnet3_drv.c:1679:33: sparse:     expected unsigned int [usertype] addr
   drivers/net/vmxnet3/vmxnet3_drv.c:1679:33: sparse:     got restricted __le64 [usertype] addr
   drivers/net/vmxnet3/vmxnet3_drv.c:1685:33: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] addr @@     got restricted __le64 [usertype] addr @@
   drivers/net/vmxnet3/vmxnet3_drv.c:1685:33: sparse:     expected unsigned int [usertype] addr
   drivers/net/vmxnet3/vmxnet3_drv.c:1685:33: sparse:     got restricted __le64 [usertype] addr
   drivers/net/vmxnet3/vmxnet3_drv.c:2307:31: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] *vfTable @@     got restricted __le32 * @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2307:31: sparse:     expected unsigned int [usertype] *vfTable
   drivers/net/vmxnet3/vmxnet3_drv.c:2307:31: sparse:     got restricted __le32 *
   drivers/net/vmxnet3/vmxnet3_drv.c:2324:39: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] *vfTable @@     got restricted __le32 * @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2324:39: sparse:     expected unsigned int [usertype] *vfTable
   drivers/net/vmxnet3/vmxnet3_drv.c:2324:39: sparse:     got restricted __le32 *
   drivers/net/vmxnet3/vmxnet3_drv.c:2346:39: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] *vfTable @@     got restricted __le32 * @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2346:39: sparse:     expected unsigned int [usertype] *vfTable
   drivers/net/vmxnet3/vmxnet3_drv.c:2346:39: sparse:     got restricted __le32 *
   drivers/net/vmxnet3/vmxnet3_drv.c:2398:39: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] *vfTable @@     got restricted __le32 * @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2398:39: sparse:     expected unsigned int [usertype] *vfTable
   drivers/net/vmxnet3/vmxnet3_drv.c:2398:39: sparse:     got restricted __le32 *
   drivers/net/vmxnet3/vmxnet3_drv.c:2444:31: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/vmxnet3/vmxnet3_drv.c:2457:17: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [usertype] size @@     got restricted __le16 [usertype] mfTableLen @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2457:17: sparse:     expected unsigned int [usertype] size
   drivers/net/vmxnet3/vmxnet3_drv.c:2457:17: sparse:     got restricted __le16 [usertype] mfTableLen
   drivers/net/vmxnet3/vmxnet3_drv.c:2495:49: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2495:49: sparse:     expected unsigned int [usertype]
   drivers/net/vmxnet3/vmxnet3_drv.c:2495:49: sparse:     got restricted __le32 [usertype]
   drivers/net/vmxnet3/vmxnet3_drv.c:2536:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] txDataRingDescSize @@     got restricted __le32 [usertype] @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2536:41: sparse:     expected restricted __le16 [usertype] txDataRingDescSize
   drivers/net/vmxnet3/vmxnet3_drv.c:2536:41: sparse:     got restricted __le32 [usertype]
   drivers/net/vmxnet3/vmxnet3_drv.c:2634:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] confVer @@     got int @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2634:34: sparse:     expected restricted __le32 [usertype] confVer
   drivers/net/vmxnet3/vmxnet3_drv.c:2634:34: sparse:     got int

vim +3742 drivers/video/fbdev/aty/atyfb_base.c

c98959f566e0c6 drivers/video/aty/atyfb_base.c       Ville Syrjala      2006-12-08  3718  
48c68c4f1b5424 drivers/video/aty/atyfb_base.c       Greg Kroah-Hartman 2012-12-21  3719  static void atyfb_remove(struct fb_info *info)
^1da177e4c3f41 drivers/video/aty/atyfb_base.c       Linus Torvalds     2005-04-16  3720  {
^1da177e4c3f41 drivers/video/aty/atyfb_base.c       Linus Torvalds     2005-04-16  3721  	struct atyfb_par *par = (struct atyfb_par *) info->par;
^1da177e4c3f41 drivers/video/aty/atyfb_base.c       Linus Torvalds     2005-04-16  3722  
^1da177e4c3f41 drivers/video/aty/atyfb_base.c       Linus Torvalds     2005-04-16  3723  	/* restore video mode */
eafad22a05fdac drivers/video/aty/atyfb_base.c       Ville Syrjala      2009-06-30  3724  	aty_set_crtc(par, &par->saved_crtc);
eafad22a05fdac drivers/video/aty/atyfb_base.c       Ville Syrjala      2009-06-30  3725  	par->pll_ops->set_pll(info, &par->saved_pll);
^1da177e4c3f41 drivers/video/aty/atyfb_base.c       Linus Torvalds     2005-04-16  3726  
37ce69a57ff217 drivers/video/aty/atyfb_base.c       Richard Purdie     2007-02-10  3727  	unregister_framebuffer(info);
37ce69a57ff217 drivers/video/aty/atyfb_base.c       Richard Purdie     2007-02-10  3728  
5474c120aafe78 drivers/video/aty/atyfb_base.c       Michael Hanselmann 2006-06-25  3729  #ifdef CONFIG_FB_ATY_BACKLIGHT
5474c120aafe78 drivers/video/aty/atyfb_base.c       Michael Hanselmann 2006-06-25  3730  	if (M64_HAS(MOBIL_BUS))
37ce69a57ff217 drivers/video/aty/atyfb_base.c       Richard Purdie     2007-02-10  3731  		aty_bl_exit(info->bl_dev);
5474c120aafe78 drivers/video/aty/atyfb_base.c       Michael Hanselmann 2006-06-25  3732  #endif
7d89a3cb159aec drivers/video/fbdev/aty/atyfb_base.c Luis R. Rodriguez  2015-07-09  3733  	arch_phys_wc_del(par->wc_cookie);
5474c120aafe78 drivers/video/aty/atyfb_base.c       Michael Hanselmann 2006-06-25  3734  
^1da177e4c3f41 drivers/video/aty/atyfb_base.c       Linus Torvalds     2005-04-16  3735  #ifndef __sparc__
^1da177e4c3f41 drivers/video/aty/atyfb_base.c       Linus Torvalds     2005-04-16  3736  	if (par->ati_regbase)
^1da177e4c3f41 drivers/video/aty/atyfb_base.c       Linus Torvalds     2005-04-16  3737  		iounmap(par->ati_regbase);
^1da177e4c3f41 drivers/video/aty/atyfb_base.c       Linus Torvalds     2005-04-16  3738  	if (info->screen_base)
^1da177e4c3f41 drivers/video/aty/atyfb_base.c       Linus Torvalds     2005-04-16  3739  		iounmap(info->screen_base);
^1da177e4c3f41 drivers/video/aty/atyfb_base.c       Linus Torvalds     2005-04-16  3740  #ifdef __BIG_ENDIAN
^1da177e4c3f41 drivers/video/aty/atyfb_base.c       Linus Torvalds     2005-04-16  3741  	if (info->sprite.addr)
^1da177e4c3f41 drivers/video/aty/atyfb_base.c       Linus Torvalds     2005-04-16 @3742  		iounmap(info->sprite.addr);
^1da177e4c3f41 drivers/video/aty/atyfb_base.c       Linus Torvalds     2005-04-16  3743  #endif
^1da177e4c3f41 drivers/video/aty/atyfb_base.c       Linus Torvalds     2005-04-16  3744  #endif
^1da177e4c3f41 drivers/video/aty/atyfb_base.c       Linus Torvalds     2005-04-16  3745  #ifdef __sparc__
^1da177e4c3f41 drivers/video/aty/atyfb_base.c       Linus Torvalds     2005-04-16  3746  	kfree(par->mmap_map);
^1da177e4c3f41 drivers/video/aty/atyfb_base.c       Linus Torvalds     2005-04-16  3747  #endif
^1da177e4c3f41 drivers/video/aty/atyfb_base.c       Linus Torvalds     2005-04-16  3748  	if (par->aux_start)
^1da177e4c3f41 drivers/video/aty/atyfb_base.c       Linus Torvalds     2005-04-16  3749  		release_mem_region(par->aux_start, par->aux_size);
^1da177e4c3f41 drivers/video/aty/atyfb_base.c       Linus Torvalds     2005-04-16  3750  
^1da177e4c3f41 drivers/video/aty/atyfb_base.c       Linus Torvalds     2005-04-16  3751  	if (par->res_start)
^1da177e4c3f41 drivers/video/aty/atyfb_base.c       Linus Torvalds     2005-04-16  3752  		release_mem_region(par->res_start, par->res_size);
^1da177e4c3f41 drivers/video/aty/atyfb_base.c       Linus Torvalds     2005-04-16  3753  
^1da177e4c3f41 drivers/video/aty/atyfb_base.c       Linus Torvalds     2005-04-16  3754  	framebuffer_release(info);
^1da177e4c3f41 drivers/video/aty/atyfb_base.c       Linus Torvalds     2005-04-16  3755  }
^1da177e4c3f41 drivers/video/aty/atyfb_base.c       Linus Torvalds     2005-04-16  3756  

:::::: The code at line 3742 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
