Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B1753D703
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 15:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbiFDNZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 09:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiFDNZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 09:25:40 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6781C138
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 06:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654349139; x=1685885139;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6s8Z8C91QPPbCucJPa8iFjLLhwuVNRUPeXapcesFNwo=;
  b=b1m4r0YRKNMy5w9zc3yS3sjogm7mL9mMVYXPUwvLsAiJz8fcV0Y4ML04
   PNoOIjcEnWO1NhTp2JIYorW4T3X/I/Ttz4a8oAoyOyvCPWBqEA9PeiIRj
   kLtsGKdqpcqUoyzePtILfP32mPoc9UeDEwRANhCnerOFNlw4NKmHjDJ+x
   BRnC0vS+yTBAUg3PvsFAtGOFApGPI9Ogszybu+SJgAYKoZpba/HRLRD9T
   mtmjFM76l7uKaM51zNPGjHrAd2rHiGyjCCVhB8qXFb2kdtRv5XR8BtQmY
   tE2ZZriGokUwAZFy7GtT44iE1UO29W7P3hzSbUVOz/p5DpcrqAw4xCpT9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="276499133"
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="276499133"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 06:25:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="722135650"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jun 2022 06:25:38 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxTmb-000AuR-JC;
        Sat, 04 Jun 2022 13:25:37 +0000
Date:   Sat, 4 Jun 2022 21:25:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [deller-fbdev:sti-fixes 1/3] drivers/video/console/sticore.c:1132:5:
 error: redefinition of 'fb_is_primary_device'
Message-ID: <202206042154.K6D7MXNw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git sti-fixes
head:   8f37351b420207e71968a48f12dfd7502b0ccb04
commit: 5e57f5568087c724e2cdaf3e38a96d109f40235b [1/3] parisc/stifb: Implement fb_is_primary_device()
config: parisc-buildonly-randconfig-r005-20220531 (https://download.01.org/0day-ci/archive/20220604/202206042154.K6D7MXNw-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git/commit/?id=5e57f5568087c724e2cdaf3e38a96d109f40235b
        git remote add deller-fbdev git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git
        git fetch --no-tags deller-fbdev sti-fixes
        git checkout 5e57f5568087c724e2cdaf3e38a96d109f40235b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/video/console/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/video/console/sticore.c:1132:5: error: redefinition of 'fb_is_primary_device'
    1132 | int fb_is_primary_device(struct fb_info *info)
         |     ^~~~~~~~~~~~~~~~~~~~
   In file included from drivers/video/console/sticore.c:33:
   arch/parisc/include/asm/fb.h:18:19: note: previous definition of 'fb_is_primary_device' with type 'int(struct fb_info *)'
      18 | static inline int fb_is_primary_device(struct fb_info *info)
         |                   ^~~~~~~~~~~~~~~~~~~~


vim +/fb_is_primary_device +1132 drivers/video/console/sticore.c

  1130	
  1131	/* check if given fb_info is the primary device */
> 1132	int fb_is_primary_device(struct fb_info *info)
  1133	{
  1134		struct sti_struct *sti;
  1135	
  1136		sti = sti_get_rom(0);
  1137	
  1138		/* if no built-in graphics card found, allow any fb driver as default */
  1139		if (!sti)
  1140			return true;
  1141	
  1142		/* return true if it's the default built-in framebuffer driver */
  1143		return (sti->info == info);
  1144	}
  1145	EXPORT_SYMBOL(fb_is_primary_device);
  1146	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
