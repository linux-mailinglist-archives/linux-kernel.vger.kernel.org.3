Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD3351A35B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351976AbiEDPPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351829AbiEDPPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:15:44 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271A741325
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 08:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651677128; x=1683213128;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=azBmu/lR3NWJpuubsX5xRpD8NmunoaWmUaThrpZSyp8=;
  b=Kl8UXq3ky7/OYRqnBgAaLKLNZ66iijFruqk+rz/ZF6VTUGLiwWRzmarZ
   lwnJMdmLA3tMPlxBPjuepnjCYpv1NU4EOwtIK2o2gt9DQ8HmDoKsp8aG6
   4QYY4BDl3PlzGiZd+Tpv69uDgK/2QMPx04MuDd100qf0EGZ6g3kGvU46w
   vy7Io+G1GHOaCR10nqzgut2M9zrVuBMclYgJBkvkTs2Z1bDk77P8ka+dw
   BsmXVZYiqUeR1cDGHWZvDWbc5ZdL3aaDLcApn1ogd0I8KdA0tZBj2Xes+
   hLWOlMwmCOaNCLkGVyxbWZaHchgvDcHPxDpQuXZNEMzsZQzly464ewnuY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="266637049"
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="266637049"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 08:12:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="536870654"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 04 May 2022 08:12:06 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmGfd-000BTH-RG;
        Wed, 04 May 2022 15:12:05 +0000
Date:   Wed, 4 May 2022 23:11:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jirislaby:devel 53/73] drivers/video/console/vgacon.c:371:35:
 warning: comparison of distinct pointer types lacks a cast
Message-ID: <202205042318.pbCvFqrn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git devel
head:   fab642eca5e0ca41e656c8a0685cadf975b7ff88
commit: 9aaf33513f7cd36e3ac26196731192e7d7d92a99 [53/73] vt: rename and document struct uni_pagedir
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20220504/202205042318.pbCvFqrn-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=9aaf33513f7cd36e3ac26196731192e7d7d92a99
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby devel
        git checkout 9aaf33513f7cd36e3ac26196731192e7d7d92a99
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/video/console/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/video/console/vgacon.c: In function 'vgacon_init':
   drivers/video/console/vgacon.c:370:11: error: assignment to 'struct uni_pagedir *' from incompatible pointer type 'struct uni_pagedict *' [-Werror=incompatible-pointer-types]
     370 |         p = *c->vc_uni_pagedir_loc;
         |           ^
>> drivers/video/console/vgacon.c:371:35: warning: comparison of distinct pointer types lacks a cast
     371 |         if (c->vc_uni_pagedir_loc != &vgacon_uni_pagedir) {
         |                                   ^~
   drivers/video/console/vgacon.c:373:39: error: assignment to 'struct uni_pagedict **' from incompatible pointer type 'struct uni_pagedir **' [-Werror=incompatible-pointer-types]
     373 |                 c->vc_uni_pagedir_loc = &vgacon_uni_pagedir;
         |                                       ^
   cc1: some warnings being treated as errors


vim +371 drivers/video/console/vgacon.c

^1da177e4c3f41 Linus Torvalds     2005-04-16  342  
^1da177e4c3f41 Linus Torvalds     2005-04-16  343  static void vgacon_init(struct vc_data *c, int init)
^1da177e4c3f41 Linus Torvalds     2005-04-16  344  {
e4bdab70dd07d8 Takashi Iwai       2014-05-13  345  	struct uni_pagedir *p;
^1da177e4c3f41 Linus Torvalds     2005-04-16  346  
50ec42edd9784f Antonino A. Daplas 2006-06-26  347  	/*
3dfac26e2ef29f Maciej W. Rozycki  2021-10-26  348  	 * We cannot be loaded as a module, therefore init will be 1
3dfac26e2ef29f Maciej W. Rozycki  2021-10-26  349  	 * if we are the default console, however if we are a fallback
3dfac26e2ef29f Maciej W. Rozycki  2021-10-26  350  	 * console, for example if fbcon has failed registration, then
3dfac26e2ef29f Maciej W. Rozycki  2021-10-26  351  	 * init will be 0, so we need to make sure our boot parameters
3dfac26e2ef29f Maciej W. Rozycki  2021-10-26  352  	 * have been copied to the console structure for vgacon_resize
3dfac26e2ef29f Maciej W. Rozycki  2021-10-26  353  	 * ultimately called by vc_resize.  Any subsequent calls to
3dfac26e2ef29f Maciej W. Rozycki  2021-10-26  354  	 * vgacon_init init will have init set to 0 too.
50ec42edd9784f Antonino A. Daplas 2006-06-26  355  	 */
^1da177e4c3f41 Linus Torvalds     2005-04-16  356  	c->vc_can_do_color = vga_can_do_color;
3dfac26e2ef29f Maciej W. Rozycki  2021-10-26  357  	c->vc_scan_lines = vga_scan_lines;
3dfac26e2ef29f Maciej W. Rozycki  2021-10-26  358  	c->vc_font.height = c->vc_cell_height = vga_video_font_height;
50ec42edd9784f Antonino A. Daplas 2006-06-26  359  
50ec42edd9784f Antonino A. Daplas 2006-06-26  360  	/* set dimensions manually if init != 0 since vc_resize() will fail */
50ec42edd9784f Antonino A. Daplas 2006-06-26  361  	if (init) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  362  		c->vc_cols = vga_video_num_columns;
^1da177e4c3f41 Linus Torvalds     2005-04-16  363  		c->vc_rows = vga_video_num_lines;
50ec42edd9784f Antonino A. Daplas 2006-06-26  364  	} else
50ec42edd9784f Antonino A. Daplas 2006-06-26  365  		vc_resize(c, vga_video_num_columns, vga_video_num_lines);
50ec42edd9784f Antonino A. Daplas 2006-06-26  366  
^1da177e4c3f41 Linus Torvalds     2005-04-16  367  	c->vc_complement_mask = 0x7700;
a40920b42ae232 Bill Nottingham    2005-05-01  368  	if (vga_512_chars)
a40920b42ae232 Bill Nottingham    2005-05-01  369  		c->vc_hi_font_mask = 0x0800;
^1da177e4c3f41 Linus Torvalds     2005-04-16  370  	p = *c->vc_uni_pagedir_loc;
0f2893f0d1acff Takashi Iwai       2014-05-13 @371  	if (c->vc_uni_pagedir_loc != &vgacon_uni_pagedir) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  372  		con_free_unimap(c);
0f2893f0d1acff Takashi Iwai       2014-05-13  373  		c->vc_uni_pagedir_loc = &vgacon_uni_pagedir;
0f2893f0d1acff Takashi Iwai       2014-05-13  374  		vgacon_refcount++;
0f2893f0d1acff Takashi Iwai       2014-05-13  375  	}
0f2893f0d1acff Takashi Iwai       2014-05-13  376  	if (!vgacon_uni_pagedir && p)
^1da177e4c3f41 Linus Torvalds     2005-04-16  377  		con_set_default_unimap(c);
f6c06b6807ff92 Matthew Garrett    2009-11-13  378  
b434a680a29424 Matthew Garrett    2009-11-13  379  	/* Only set the default if the user didn't deliberately override it */
b434a680a29424 Matthew Garrett    2009-11-13  380  	if (global_cursor_default == -1)
b434a680a29424 Matthew Garrett    2009-11-13  381  		global_cursor_default =
b434a680a29424 Matthew Garrett    2009-11-13  382  			!(screen_info.flags & VIDEO_FLAGS_NOCURSOR);
^1da177e4c3f41 Linus Torvalds     2005-04-16  383  }
^1da177e4c3f41 Linus Torvalds     2005-04-16  384  

:::::: The code at line 371 was first introduced by commit
:::::: 0f2893f0d1acff4bb1677b60c0486adc0075cb99 vgacon: Fix & cleanup refcounting

:::::: TO: Takashi Iwai <tiwai@suse.de>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
