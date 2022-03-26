Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2394E828E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 18:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbiCZRFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 13:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbiCZRFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 13:05:24 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1413178687
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 10:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648314149; x=1679850149;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uJUCOLKORHZmEOmOVwjW1Uu2iAq6H2ypEnt67xM6ujc=;
  b=EH86DJTepJujW2JYFw+FZ0nsyP49Lbae1EQ86dLzaWugIt9AC480/tFO
   Zb3+HuL9CHmHShUVc77RrYYHUSAGbQ3/DkitOpF2rUlpAGy7QCXFWILk1
   0cs8d6SgVLfycEdh01I8h7avxV6dIn99m752pAba+zAFl1Rt3KsDg6kk0
   O0Td6GyKhN3RTscgiuBuug3s3iSt1OD+XCKSX/QikbqjdmZxVrin1MXPU
   vMHkdpHynBCcs7OVlsxsWYAjx5n3BULrLu0+tf5uMGP0efFsQtc0MW7OA
   DZEWTMax+BbVFI0LsukGT+Cv/XyrcVGXf+tjWh7GLI2GHlDqo5uFkSZjk
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10298"; a="345230823"
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="345230823"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 10:02:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="502081273"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 26 Mar 2022 10:02:27 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nY9o2-0000D1-GF; Sat, 26 Mar 2022 17:02:26 +0000
Date:   Sun, 27 Mar 2022 01:01:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yannick Fertre <yannick.fertre@st.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Eric Anholt <eric@anholt.net>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: drivers/video/fbdev/core/fbmem.c:1496:15: warning: no previous
 declaration for 'get_fb_unmapped_area'
Message-ID: <202203270028.vzpaWr13-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yannick,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   52d543b5497cf31d6baeb0bcfe5a5474c3238578
commit: b759012c5fa761ee08998c80fc4ad6343c258487 drm/stm: Add STM32 LTDC driver
date:   4 years, 11 months ago
config: arm-randconfig-r023-20220326 (https://download.01.org/0day-ci/archive/20220327/202203270028.vzpaWr13-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 7.5.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b759012c5fa761ee08998c80fc4ad6343c258487
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b759012c5fa761ee08998c80fc4ad6343c258487
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-7.5.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash M=drivers/video/fbdev/core

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/video/fbdev/core/fbmem.c:1496:15: warning: no previous declaration for 'get_fb_unmapped_area' [-Wmissing-declarations]
    unsigned long get_fb_unmapped_area(struct file *filp,
                  ^~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/core/fbmem.c:719:37: warning: 'fb_proc_fops' defined but not used [-Wunused-const-variable=]
    static const struct file_operations fb_proc_fops = {
                                        ^~~~~~~~~~~~


vim +/get_fb_unmapped_area +1496 drivers/video/fbdev/core/fbmem.c

^1da177e4c3f415 drivers/video/fbmem.c            Linus Torvalds    2005-04-16  1494  
82f42e4cc164ed4 drivers/video/fbdev/core/fbmem.c Benjamin Gaignard 2017-01-04  1495  #ifdef CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA
82f42e4cc164ed4 drivers/video/fbdev/core/fbmem.c Benjamin Gaignard 2017-01-04 @1496  unsigned long get_fb_unmapped_area(struct file *filp,
82f42e4cc164ed4 drivers/video/fbdev/core/fbmem.c Benjamin Gaignard 2017-01-04  1497  				   unsigned long addr, unsigned long len,
82f42e4cc164ed4 drivers/video/fbdev/core/fbmem.c Benjamin Gaignard 2017-01-04  1498  				   unsigned long pgoff, unsigned long flags)
82f42e4cc164ed4 drivers/video/fbdev/core/fbmem.c Benjamin Gaignard 2017-01-04  1499  {
82f42e4cc164ed4 drivers/video/fbdev/core/fbmem.c Benjamin Gaignard 2017-01-04  1500  	struct fb_info * const info = filp->private_data;
82f42e4cc164ed4 drivers/video/fbdev/core/fbmem.c Benjamin Gaignard 2017-01-04  1501  	unsigned long fb_size = PAGE_ALIGN(info->fix.smem_len);
82f42e4cc164ed4 drivers/video/fbdev/core/fbmem.c Benjamin Gaignard 2017-01-04  1502  
82f42e4cc164ed4 drivers/video/fbdev/core/fbmem.c Benjamin Gaignard 2017-01-04  1503  	if (pgoff > fb_size || len > fb_size - pgoff)
82f42e4cc164ed4 drivers/video/fbdev/core/fbmem.c Benjamin Gaignard 2017-01-04  1504  		return -EINVAL;
82f42e4cc164ed4 drivers/video/fbdev/core/fbmem.c Benjamin Gaignard 2017-01-04  1505  
82f42e4cc164ed4 drivers/video/fbdev/core/fbmem.c Benjamin Gaignard 2017-01-04  1506  	return (unsigned long)info->screen_base + pgoff;
82f42e4cc164ed4 drivers/video/fbdev/core/fbmem.c Benjamin Gaignard 2017-01-04  1507  }
82f42e4cc164ed4 drivers/video/fbdev/core/fbmem.c Benjamin Gaignard 2017-01-04  1508  #endif
82f42e4cc164ed4 drivers/video/fbdev/core/fbmem.c Benjamin Gaignard 2017-01-04  1509  

:::::: The code at line 1496 was first introduced by commit
:::::: 82f42e4cc164ed486c9e2b1b74e65b176830d947 fbmem: add a default get_fb_unmapped_area function

:::::: TO: Benjamin Gaignard <benjamin.gaignard@linaro.org>
:::::: CC: Daniel Vetter <daniel.vetter@ffwll.ch>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
