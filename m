Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD1F53F4A6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 05:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbiFGDjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 23:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236199AbiFGDjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 23:39:04 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACD74BBA6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 20:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654573143; x=1686109143;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Avy2sqKSeP/2BVfXsbBCTHzhif1t2PvxXg1Ps5KVMic=;
  b=jASwlRTInvDZVagwB5s5lEQFNehDJiBrW8JFMuRYinSS6mhvEuoeOADF
   j6n88gSOJ2BoDAhyuOWr1N+NmtKpIIUw+AB8rPY4bv96k0omNei+0y+4O
   8xGcTJq90TBF2PJYbFy3+1FHsvxBEkOhbGGN5C9/tHlGSnaZSHa2YV+2J
   s71u9WSF9D6TvWpNaRzLeM+UvYXH+NraxAvsJN3R1OG+BpHXfKIC/ONWW
   y5LB/ql6yp9h65YOE74InoTMVoNlgK2fS4opkyUso8Qx1Mt6wGnFQkM4C
   JeR1iKbMMgFvkX+5o3pgplqUsWx2EoFd6vSFYHlKgyNB3IvTVwzEfykyy
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="276987792"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="276987792"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 20:38:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="826163314"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 06 Jun 2022 20:38:40 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyQ3D-000DJd-JP;
        Tue, 07 Jun 2022 03:38:39 +0000
Date:   Tue, 7 Jun 2022 11:37:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/video/console/sticore.c:1132:5: error: redefinition of
 'fb_is_primary_device'
Message-ID: <202206071130.gOM8ootu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e71e60cd74df9386c3f684c54888f2367050b831
commit: cf936af790a3ef5f41ff687ec91bfbffee141278 parisc/stifb: Implement fb_is_primary_device()
date:   3 days ago
config: parisc-randconfig-r012-20220606 (https://download.01.org/0day-ci/archive/20220607/202206071130.gOM8ootu-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cf936af790a3ef5f41ff687ec91bfbffee141278
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout cf936af790a3ef5f41ff687ec91bfbffee141278
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
