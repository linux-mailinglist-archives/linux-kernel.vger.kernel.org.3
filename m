Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F04A53C282
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241084AbiFCB3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 21:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241087AbiFCB3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 21:29:22 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B353B57F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 18:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654219743; x=1685755743;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BTN5UI1ItXsE016Lb2worRoce/9SC0gmkZSxEN5u3mc=;
  b=BgZaIdSh2/vvCqhf/Pnx30ECW/KuSUd2RqrMZ+RaSaJ6g8IF5c0P6W4H
   PbKa40U4bK5RTBmY8zLLME4Hy1gf0TI18lLRIJA3QRQJdQ+IhDJMG9FlY
   9cMh0eo8Pn3oaOvkGw/1V4dW/sA3dyv/f3va2U5dUtfGUI6Jma8O9nJVG
   KcquDACM/KkQWE6uKkr8VLaaxdEI1jEgbOEP0L7fBPeFuFA/RF7alz12H
   PVe3T3nQhoNRFZVezJUfTdTUlQpWS+ve5QopW9ZwwChEbag/It9I5wNYA
   v8PSeC1H9Red0oz3i3kEYgK72FeqIy6aNsVSytamOGel4guS8/FyjkMUT
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="256613803"
X-IronPort-AV: E=Sophos;i="5.91,273,1647327600"; 
   d="scan'208";a="256613803"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 18:29:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,273,1647327600"; 
   d="scan'208";a="607150976"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 02 Jun 2022 18:28:59 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nww7X-0005ft-9r;
        Fri, 03 Jun 2022 01:28:59 +0000
Date:   Fri, 3 Jun 2022 09:28:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [deller-fbdev:fb-fixes 1/5] drivers/video/console/sticore.c:1131:5:
 warning: no previous prototype for 'fb_is_primary_device'
Message-ID: <202206030949.FluWpZnn-lkp@intel.com>
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

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git fb-fixes
head:   d92f129b594fe3eebf2f7abfffea2e6dbdc5936c
commit: f1a3b3c2b5b1b846963ffa5b4fddfaf8c9a4c985 [1/5] parisc/stifb: Implement fb_is_primary_device()
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20220603/202206030949.FluWpZnn-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git/commit/?id=f1a3b3c2b5b1b846963ffa5b4fddfaf8c9a4c985
        git remote add deller-fbdev git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git
        git fetch --no-tags deller-fbdev fb-fixes
        git checkout f1a3b3c2b5b1b846963ffa5b4fddfaf8c9a4c985
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/video/console/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/video/console/sticore.c:1131:5: warning: no previous prototype for 'fb_is_primary_device' [-Wmissing-prototypes]
    1131 | int fb_is_primary_device(struct fb_info *info)
         |     ^~~~~~~~~~~~~~~~~~~~


vim +/fb_is_primary_device +1131 drivers/video/console/sticore.c

  1129	
  1130	/* check if given fb_info is the primary device */
> 1131	int fb_is_primary_device(struct fb_info *info)
  1132	{
  1133		struct sti_struct *sti;
  1134	
  1135		sti = sti_get_rom(0);
  1136	
  1137		/* if no built-in graphics card found, allow any fb driver as default */
  1138		if (!sti)
  1139			return true;
  1140	
  1141		/* return true if it's the default built-in framebuffer driver */
  1142		return (sti->info == info);
  1143	}
  1144	EXPORT_SYMBOL(fb_is_primary_device);
  1145	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
