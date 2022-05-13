Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0925258F1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 02:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359502AbiEMA3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 20:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiEMA3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 20:29:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0CF27735B
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 17:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652401749; x=1683937749;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eVnkNw5Yly48tgPlZ6Kp8aq/AvG8H1BFZ4rih/ORGDQ=;
  b=Dp2z+xvL5cW8UrOc4Px+neqnJCYSYFlnqZ4AKcymn+iQziBSRbrU+0Wg
   JS2AVM3mZoEa4Luz4/1zU+kTU0mLFbcfo1WXNKbz3+tZLa7MY07RtoXrG
   pM0hxlku3E5qwSCqimPi6M4j6fOO+YVlazQe9NQGxs6rdi63tbBdw4XmD
   jrGz+2RkdPCdD4uqpUAwXc7nm1Wpme2I7Tb1DZ3K7xbZhSp/4ZAN9VT8m
   TmrZ8i+GDVvOeQDYtrsSe2cSTzJ6OuUiHboLHjz6txnS6I0MqWOpUvZMS
   R7fh3AHwDFwwIvF+fnscqwV/q4JZFoum0biZL3gJ/gVjLeITpHgkin9tr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="270306525"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="270306525"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 17:29:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="624632720"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 12 May 2022 17:29:07 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npJB5-000L6G-Bl;
        Fri, 13 May 2022 00:29:07 +0000
Date:   Fri, 13 May 2022 08:29:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/tdfxfb.c:1118:17: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202205130718.EXPqeZmq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f3f19f939c11925dadd3f4776f99f8c278a7017b
commit: 28e77cc1c0686621a4d416f599cee5ab369daa0a fortify: Detect struct member overflows in memset() at compile-time
date:   3 months ago
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220513/202205130718.EXPqeZmq-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=28e77cc1c0686621a4d416f599cee5ab369daa0a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 28e77cc1c0686621a4d416f599cee5ab369daa0a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash drivers/video/fbdev/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
>> drivers/video/fbdev/tdfxfb.c:1118:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *cursorbase @@
   drivers/video/fbdev/tdfxfb.c:1118:17: sparse:     expected void const *
   drivers/video/fbdev/tdfxfb.c:1118:17: sparse:     got unsigned char [noderef] [usertype] __iomem *cursorbase
>> drivers/video/fbdev/tdfxfb.c:1118:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *cursorbase @@
   drivers/video/fbdev/tdfxfb.c:1118:17: sparse:     expected void const *
   drivers/video/fbdev/tdfxfb.c:1118:17: sparse:     got unsigned char [noderef] [usertype] __iomem *cursorbase
   drivers/video/fbdev/tdfxfb.c:1118:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got unsigned char [noderef] [usertype] __iomem *cursorbase @@
   drivers/video/fbdev/tdfxfb.c:1118:17: sparse:     expected void *
   drivers/video/fbdev/tdfxfb.c:1118:17: sparse:     got unsigned char [noderef] [usertype] __iomem *cursorbase
   drivers/video/fbdev/tdfxfb.c:1129:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tdfxfb.c:1132:33: sparse: sparse: cast removes address space '__iomem' of expression
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   drivers/video/fbdev/pvr2fb.c:336:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:336:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:338:31: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:345:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:347:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:349:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:540:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:541:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:560:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:569:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:573:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:574:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:579:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:581:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:584:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:585:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:588:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:591:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:595:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:595:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:596:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:600:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:612:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:614:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:616:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/pvr2fb.c:800:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/pvr2fb.c:800:9: sparse:     expected void const *
   drivers/video/fbdev/pvr2fb.c:800:9: sparse:     got char [noderef] __iomem *screen_base
>> drivers/video/fbdev/pvr2fb.c:800:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/pvr2fb.c:800:9: sparse:     expected void const *
   drivers/video/fbdev/pvr2fb.c:800:9: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/pvr2fb.c:800:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/pvr2fb.c:800:9: sparse:     expected void *
   drivers/video/fbdev/pvr2fb.c:800:9: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/pvr2fb.c:832:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:1071:11: sparse: sparse: Using plain integer as NULL pointer
   drivers/video/fbdev/pvr2fb.c:233:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:233:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:240:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:240:9: sparse: sparse: cast removes address space '__iomem' of expression
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
>> drivers/video/fbdev/sstfb.c:337:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/sstfb.c:337:9: sparse:     expected void const *
   drivers/video/fbdev/sstfb.c:337:9: sparse:     got char [noderef] __iomem *screen_base
>> drivers/video/fbdev/sstfb.c:337:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/sstfb.c:337:9: sparse:     expected void const *
   drivers/video/fbdev/sstfb.c:337:9: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/sstfb.c:337:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/sstfb.c:337:9: sparse:     expected void *
   drivers/video/fbdev/sstfb.c:337:9: sparse:     got char [noderef] __iomem *screen_base
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
>> drivers/video/fbdev/aty/mach64_cursor.c:156:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *dst @@
   drivers/video/fbdev/aty/mach64_cursor.c:156:13: sparse:     expected void const *
   drivers/video/fbdev/aty/mach64_cursor.c:156:13: sparse:     got unsigned char [noderef] [usertype] __iomem *dst
>> drivers/video/fbdev/aty/mach64_cursor.c:156:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *dst @@
   drivers/video/fbdev/aty/mach64_cursor.c:156:13: sparse:     expected void const *
   drivers/video/fbdev/aty/mach64_cursor.c:156:13: sparse:     got unsigned char [noderef] [usertype] __iomem *dst
   drivers/video/fbdev/aty/mach64_cursor.c:156:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got unsigned char [noderef] [usertype] __iomem *dst @@
   drivers/video/fbdev/aty/mach64_cursor.c:156:13: sparse:     expected void *
   drivers/video/fbdev/aty/mach64_cursor.c:156:13: sparse:     got unsigned char [noderef] [usertype] __iomem *dst
   drivers/video/fbdev/aty/mach64_cursor.c:187:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/aty/mach64_cursor.c:188:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/aty/mach64_cursor.c:209:30: sparse: sparse: cast removes address space '__iomem' of expression
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
>> drivers/video/fbdev/kyro/fbdev.c:733:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/kyro/fbdev.c:733:9: sparse:     expected void const *
   drivers/video/fbdev/kyro/fbdev.c:733:9: sparse:     got char [noderef] __iomem *screen_base
>> drivers/video/fbdev/kyro/fbdev.c:733:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/kyro/fbdev.c:733:9: sparse:     expected void const *
   drivers/video/fbdev/kyro/fbdev.c:733:9: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/kyro/fbdev.c:733:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/kyro/fbdev.c:733:9: sparse:     expected void *
   drivers/video/fbdev/kyro/fbdev.c:733:9: sparse:     got char [noderef] __iomem *screen_base

vim +1118 drivers/video/fbdev/tdfxfb.c

^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1038  
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1039  static int tdfxfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1040  {
a807f618b625944 drivers/video/tdfxfb.c Antonino A. Daplas 2006-01-09  1041  	struct tdfx_par *par = info->par;
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1042  	u32 vidcfg;
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1043  
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1044  	if (!hwcursor)
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1045  		return -EINVAL;	/* just to force soft_cursor() call */
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1046  
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1047  	/* Too large of a cursor or wrong bpp :-( */
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1048  	if (cursor->image.width > 64 ||
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1049  	    cursor->image.height > 64 ||
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1050  	    cursor->image.depth > 1)
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1051  		return -EINVAL;
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1052  
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1053  	vidcfg = tdfx_inl(par, VIDPROCCFG);
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1054  	if (cursor->enable)
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1055  		tdfx_outl(par, VIDPROCCFG, vidcfg | VIDCFG_HWCURSOR_ENABLE);
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1056  	else
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1057  		tdfx_outl(par, VIDPROCCFG, vidcfg & ~VIDCFG_HWCURSOR_ENABLE);
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1058  
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1059  	/*
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1060  	 * If the cursor is not be changed this means either we want the
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1061  	 * current cursor state (if enable is set) or we want to query what
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1062  	 * we can do with the cursor (if enable is not set)
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1063  	 */
8af1d50f7f67937 drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1064  	if (!cursor->set)
8af1d50f7f67937 drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1065  		return 0;
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1066  
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1067  	/* fix cursor color - XFree86 forgets to restore it properly */
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1068  	if (cursor->set & FB_CUR_SETCMAP) {
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1069  		struct fb_cmap cmap = info->cmap;
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1070  		u32 bg_idx = cursor->image.bg_color;
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1071  		u32 fg_idx = cursor->image.fg_color;
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1072  		unsigned long bg_color, fg_color;
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1073  
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1074  		fg_color = (((u32)cmap.red[fg_idx]   & 0xff00) << 8) |
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1075  			   (((u32)cmap.green[fg_idx] & 0xff00) << 0) |
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1076  			   (((u32)cmap.blue[fg_idx]  & 0xff00) >> 8);
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1077  		bg_color = (((u32)cmap.red[bg_idx]   & 0xff00) << 8) |
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1078  			   (((u32)cmap.green[bg_idx] & 0xff00) << 0) |
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1079  			   (((u32)cmap.blue[bg_idx]  & 0xff00) >> 8);
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1080  		banshee_make_room(par, 2);
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1081  		tdfx_outl(par, HWCURC0, bg_color);
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1082  		tdfx_outl(par, HWCURC1, fg_color);
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1083  	}
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1084  
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1085  	if (cursor->set & FB_CUR_SETPOS) {
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1086  		int x = cursor->image.dx;
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1087  		int y = cursor->image.dy - info->var.yoffset;
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1088  
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1089  		x += 63;
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1090  		y += 63;
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1091  		banshee_make_room(par, 1);
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1092  		tdfx_outl(par, HWCURLOC, (y << 16) + x);
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1093  	}
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1094  	if (cursor->set & (FB_CUR_SETIMAGE | FB_CUR_SETSHAPE)) {
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1095  		/*
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1096  		 * Voodoo 3 and above cards use 2 monochrome cursor patterns.
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1097  		 *    The reason is so the card can fetch 8 words at a time
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1098  		 * and are stored on chip for use for the next 8 scanlines.
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1099  		 * This reduces the number of times for access to draw the
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1100  		 * cursor for each screen refresh.
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1101  		 *    Each pattern is a bitmap of 64 bit wide and 64 bit high
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1102  		 * (total of 8192 bits or 1024 bytes). The two patterns are
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1103  		 * stored in such a way that pattern 0 always resides in the
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1104  		 * lower half (least significant 64 bits) of a 128 bit word
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1105  		 * and pattern 1 the upper half. If you examine the data of
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1106  		 * the cursor image the graphics card uses then from the
25985edcedea639 drivers/video/tdfxfb.c Lucas De Marchi    2011-03-30  1107  		 * beginning you see line one of pattern 0, line one of
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1108  		 * pattern 1, line two of pattern 0, line two of pattern 1,
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1109  		 * etc etc. The linear stride for the cursor is always 16 bytes
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1110  		 * (128 bits) which is the maximum cursor width times two for
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1111  		 * the two monochrome patterns.
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1112  		 */
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1113  		u8 __iomem *cursorbase = info->screen_base + info->fix.smem_len;
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1114  		u8 *bitmap = (u8 *)cursor->image.data;
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1115  		u8 *mask = (u8 *)cursor->mask;
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1116  		int i;
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1117  
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16 @1118  		fb_memset(cursorbase, 0, 1024);
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1119  
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1120  		for (i = 0; i < cursor->image.height; i++) {
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1121  			int h = 0;
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1122  			int j = (cursor->image.width + 7) >> 3;
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1123  
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1124  			for (; j > 0; j--) {
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1125  				u8 data = *mask ^ *bitmap;
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1126  				if (cursor->rop == ROP_COPY)
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1127  					data = *mask & *bitmap;
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1128  				/* Pattern 0. Copy the cursor mask to it */
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1129  				fb_writeb(*mask, cursorbase + h);
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1130  				mask++;
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1131  				/* Pattern 1. Copy the cursor bitmap to it */
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1132  				fb_writeb(data, cursorbase + h + 8);
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1133  				bitmap++;
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1134  				h++;
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1135  			}
90b0f08536531ab drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1136  			cursorbase += 16;
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1137  		}
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1138  	}
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1139  	return 0;
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1140  }
^1da177e4c3f415 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1141  

:::::: The code at line 1118 was first introduced by commit
:::::: 90b0f08536531abbbe7b5d4944792da08cadde01 tdfxfb: hardware cursor

:::::: TO: Krzysztof Helt <krzysztof.h1@wp.pl>
:::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
