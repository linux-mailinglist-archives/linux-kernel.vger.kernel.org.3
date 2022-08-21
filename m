Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B6A59B181
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 06:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiHUEHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 00:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiHUEHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 00:07:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FDC25584
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 21:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661054853; x=1692590853;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nEA0cX1pfTBMFBV7ZyOMOwz1blihlZBhYcmmxhHkfBs=;
  b=jXLpU9umTSml+iv1qMfJbfYZ0r4kzUSkx2ON+r1J8bqseSUGeuRolJ8g
   vZ/pAJBbFacqkqXX8bWgPkn4U6qD3KLQnSqkA7rI9bt4jZuHietfQwo3d
   AtJRm+etb6FEuPVAkWXUREQnPNx3yiD3JytZAesqCdJ4Nh9GQfRRFgSa5
   hwnC+N0xM/A7wO+dSS6kU//iIcjSMNp8r4CpgUnmzmLH07gIGCqiz9qgS
   S+hLk6joSpi4QEmIITf37NVgIHnSbBBlEix3sEwDkVrXdVzuU6cmpMMNS
   w54qWjJm0EWRoNnwM023EJI71bCV90kVKLfgRFw4wj0iLf8IGP1MAHK2H
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10445"; a="290779958"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="290779958"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 21:07:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="608594268"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 20 Aug 2022 21:07:30 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPcFG-0003cX-18;
        Sun, 21 Aug 2022 04:07:30 +0000
Date:   Sun, 21 Aug 2022 12:07:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:viro/vfs/work.termios2 4/8]
 arch/alpha/kernel/termios.c:5:5: warning: no previous prototype for
 'user_termio_to_kernel_termios'
Message-ID: <202208211203.xvc2wVjR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block viro/vfs/work.termios2
head:   efc5ae91c846283431afc7bfc57e947bf1fd4158
commit: 7f3d795b7f3bd329e9b0eea427bcbbf205ee60d5 [4/8] termios: start unifying non-UAPI parts of asm/termios.h
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220821/202208211203.xvc2wVjR-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/7f3d795b7f3bd329e9b0eea427bcbbf205ee60d5
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block viro/vfs/work.termios2
        git checkout 7f3d795b7f3bd329e9b0eea427bcbbf205ee60d5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash arch/alpha/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/alpha/kernel/termios.c:5:5: warning: no previous prototype for 'user_termio_to_kernel_termios' [-Wmissing-prototypes]
       5 | int user_termio_to_kernel_termios(struct ktermios *termios,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/alpha/kernel/termios.c:33:5: warning: no previous prototype for 'kernel_termios_to_user_termio' [-Wmissing-prototypes]
      33 | int kernel_termios_to_user_termio(struct termio __user *termio,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/user_termio_to_kernel_termios +5 arch/alpha/kernel/termios.c

8eb5cc958018d9 Al Viro 2022-08-20   4  
8eb5cc958018d9 Al Viro 2022-08-20  @5  int user_termio_to_kernel_termios(struct ktermios *termios,
8eb5cc958018d9 Al Viro 2022-08-20   6  						struct termio __user *termio)
8eb5cc958018d9 Al Viro 2022-08-20   7  {
8eb5cc958018d9 Al Viro 2022-08-20   8  	struct termio v;
8eb5cc958018d9 Al Viro 2022-08-20   9  	bool canon;
8eb5cc958018d9 Al Viro 2022-08-20  10  
8eb5cc958018d9 Al Viro 2022-08-20  11  	if (copy_from_user(&v, termio, sizeof(struct termio)))
8eb5cc958018d9 Al Viro 2022-08-20  12  		return -EFAULT;
8eb5cc958018d9 Al Viro 2022-08-20  13  
8eb5cc958018d9 Al Viro 2022-08-20  14  	termios->c_iflag = (0xffff0000 & termios->c_iflag) | v.c_iflag;
8eb5cc958018d9 Al Viro 2022-08-20  15  	termios->c_oflag = (0xffff0000 & termios->c_oflag) | v.c_oflag;
8eb5cc958018d9 Al Viro 2022-08-20  16  	termios->c_cflag = (0xffff0000 & termios->c_cflag) | v.c_cflag;
8eb5cc958018d9 Al Viro 2022-08-20  17  	termios->c_lflag = (0xffff0000 & termios->c_lflag) | v.c_lflag;
8eb5cc958018d9 Al Viro 2022-08-20  18  	termios->c_line = (0xffff0000 & termios->c_lflag) | v.c_line;
8eb5cc958018d9 Al Viro 2022-08-20  19  
8eb5cc958018d9 Al Viro 2022-08-20  20  	canon = v.c_lflag & ICANON;
8eb5cc958018d9 Al Viro 2022-08-20  21  	termios->c_cc[VINTR]  = v.c_cc[_VINTR];
8eb5cc958018d9 Al Viro 2022-08-20  22  	termios->c_cc[VQUIT]  = v.c_cc[_VQUIT];
8eb5cc958018d9 Al Viro 2022-08-20  23  	termios->c_cc[VERASE] = v.c_cc[_VERASE];
8eb5cc958018d9 Al Viro 2022-08-20  24  	termios->c_cc[VKILL]  = v.c_cc[_VKILL];
8eb5cc958018d9 Al Viro 2022-08-20  25  	termios->c_cc[VEOL2]  = v.c_cc[_VEOL2];
8eb5cc958018d9 Al Viro 2022-08-20  26  	termios->c_cc[VSWTC]  = v.c_cc[_VSWTC];
8eb5cc958018d9 Al Viro 2022-08-20  27  	termios->c_cc[canon ? VEOF : VMIN]  = v.c_cc[_VEOF];
8eb5cc958018d9 Al Viro 2022-08-20  28  	termios->c_cc[canon ? VEOL : VTIME] = v.c_cc[_VEOL];
8eb5cc958018d9 Al Viro 2022-08-20  29  
8eb5cc958018d9 Al Viro 2022-08-20  30  	return 0;
8eb5cc958018d9 Al Viro 2022-08-20  31  }
8eb5cc958018d9 Al Viro 2022-08-20  32  
8eb5cc958018d9 Al Viro 2022-08-20 @33  int kernel_termios_to_user_termio(struct termio __user *termio,

:::::: The code at line 5 was first introduced by commit
:::::: 8eb5cc958018d99c96d15cf9637fd07531551802 termios: uninline conversion helpers

:::::: TO: Al Viro <viro@zeniv.linux.org.uk>
:::::: CC: Al Viro <viro@zeniv.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
