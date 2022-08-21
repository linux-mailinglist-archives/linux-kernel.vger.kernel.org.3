Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B9C59B189
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 06:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiHUERg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 00:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiHUERe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 00:17:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B83B2A418
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 21:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661055453; x=1692591453;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wM3FKnArUncvsjopDHaYM1i2CV3Ud9ekC7wHWKOHMzs=;
  b=jvoWOnpPSoD3tOOMNax3D53Nftp8ddd4GordLxYHfd1pFQLNOi/KFeg/
   ZnVO8EFlBa0NdMBqqo6rTaLvBb1Ewv/CR3+PWVHBwC3MhB6cVCxH4FKBh
   tXlBXp1uR6sUWpJvFpm4l49XA7DWEOU6TRXJV2cAUCq4rAb4POL2kjo1A
   CKoQdZp63J+cOwKN+BX29nzq5Wk41PE3VFbxcI+PLMLMHXJjpDCFuJSy2
   RfpOAEKxrWHRwh8E3JAYeThRkxEHJLLrt/Ah0zmAc3O+d/YR7lBiiu2w3
   qO4vNAZe7JPXrjE3C7Z/SOmuCekDcC/CROBNGsnbgdV0Uty7u83wRoEJa
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10445"; a="294007166"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="294007166"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 21:17:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="784513729"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 20 Aug 2022 21:17:31 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPcOw-0003dh-30;
        Sun, 21 Aug 2022 04:17:30 +0000
Date:   Sun, 21 Aug 2022 12:17:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:viro/vfs/work.termios2 4/8]
 arch/sparc/kernel/termios.c:15:5: error: no previous prototype for
 'kernel_termios_to_user_termio'
Message-ID: <202208211216.lQW1aQyr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block viro/vfs/work.termios2
head:   efc5ae91c846283431afc7bfc57e947bf1fd4158
commit: 7f3d795b7f3bd329e9b0eea427bcbbf205ee60d5 [4/8] termios: start unifying non-UAPI parts of asm/termios.h
config: sparc-randconfig-r012-20220821 (https://download.01.org/0day-ci/archive/20220821/202208211216.lQW1aQyr-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/7f3d795b7f3bd329e9b0eea427bcbbf205ee60d5
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block viro/vfs/work.termios2
        git checkout 7f3d795b7f3bd329e9b0eea427bcbbf205ee60d5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/sparc/kernel/termios.c:15:5: error: no previous prototype for 'kernel_termios_to_user_termio' [-Werror=missing-prototypes]
      15 | int kernel_termios_to_user_termio(struct termio __user *termio,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/sparc/kernel/termios.c:33:5: error: no previous prototype for 'user_termios_to_kernel_termios' [-Werror=missing-prototypes]
      33 | int user_termios_to_kernel_termios(struct ktermios *k,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/sparc/kernel/termios.c:55:5: error: no previous prototype for 'kernel_termios_to_user_termios' [-Werror=missing-prototypes]
      55 | int kernel_termios_to_user_termios(struct termios2 __user *u,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/sparc/kernel/termios.c:77:5: error: no previous prototype for 'user_termios_to_kernel_termios_1' [-Werror=missing-prototypes]
      77 | int user_termios_to_kernel_termios_1(struct ktermios *k,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/sparc/kernel/termios.c:97:5: error: no previous prototype for 'kernel_termios_to_user_termios_1' [-Werror=missing-prototypes]
      97 | int kernel_termios_to_user_termios_1(struct termios __user *u,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/kernel_termios_to_user_termio +15 arch/sparc/kernel/termios.c

8eb5cc958018d9 Al Viro 2022-08-20  14  
8eb5cc958018d9 Al Viro 2022-08-20 @15  int kernel_termios_to_user_termio(struct termio __user *termio,
8eb5cc958018d9 Al Viro 2022-08-20  16  						struct ktermios *termios)
8eb5cc958018d9 Al Viro 2022-08-20  17  {
8eb5cc958018d9 Al Viro 2022-08-20  18  	struct termio v;
8eb5cc958018d9 Al Viro 2022-08-20  19  	memset(&v, 0, sizeof(struct termio));
8eb5cc958018d9 Al Viro 2022-08-20  20  	v.c_iflag = termios->c_iflag;
8eb5cc958018d9 Al Viro 2022-08-20  21  	v.c_oflag = termios->c_oflag;
8eb5cc958018d9 Al Viro 2022-08-20  22  	v.c_cflag = termios->c_cflag;
8eb5cc958018d9 Al Viro 2022-08-20  23  	v.c_lflag = termios->c_lflag;
8eb5cc958018d9 Al Viro 2022-08-20  24  	v.c_line = termios->c_line;
8eb5cc958018d9 Al Viro 2022-08-20  25  	memcpy(v.c_cc, termios->c_cc, NCC);
8eb5cc958018d9 Al Viro 2022-08-20  26  	if (!(v.c_lflag & ICANON)) {
8eb5cc958018d9 Al Viro 2022-08-20  27  		v.c_cc[_VMIN] = termios->c_cc[VMIN];
8eb5cc958018d9 Al Viro 2022-08-20  28  		v.c_cc[_VTIME] = termios->c_cc[VTIME];
8eb5cc958018d9 Al Viro 2022-08-20  29  	}
8eb5cc958018d9 Al Viro 2022-08-20  30  	return copy_to_user(termio, &v, sizeof(struct termio));
8eb5cc958018d9 Al Viro 2022-08-20  31  }
8eb5cc958018d9 Al Viro 2022-08-20  32  
8eb5cc958018d9 Al Viro 2022-08-20 @33  int user_termios_to_kernel_termios(struct ktermios *k,
8eb5cc958018d9 Al Viro 2022-08-20  34  						 struct termios2 __user *u)
8eb5cc958018d9 Al Viro 2022-08-20  35  {
8eb5cc958018d9 Al Viro 2022-08-20  36  	int err;
8eb5cc958018d9 Al Viro 2022-08-20  37  	err  = get_user(k->c_iflag, &u->c_iflag);
8eb5cc958018d9 Al Viro 2022-08-20  38  	err |= get_user(k->c_oflag, &u->c_oflag);
8eb5cc958018d9 Al Viro 2022-08-20  39  	err |= get_user(k->c_cflag, &u->c_cflag);
8eb5cc958018d9 Al Viro 2022-08-20  40  	err |= get_user(k->c_lflag, &u->c_lflag);
8eb5cc958018d9 Al Viro 2022-08-20  41  	err |= get_user(k->c_line,  &u->c_line);
8eb5cc958018d9 Al Viro 2022-08-20  42  	err |= copy_from_user(k->c_cc, u->c_cc, NCCS);
8eb5cc958018d9 Al Viro 2022-08-20  43  	if (k->c_lflag & ICANON) {
8eb5cc958018d9 Al Viro 2022-08-20  44  		err |= get_user(k->c_cc[VEOF], &u->c_cc[VEOF]);
8eb5cc958018d9 Al Viro 2022-08-20  45  		err |= get_user(k->c_cc[VEOL], &u->c_cc[VEOL]);
8eb5cc958018d9 Al Viro 2022-08-20  46  	} else {
8eb5cc958018d9 Al Viro 2022-08-20  47  		err |= get_user(k->c_cc[VMIN],  &u->c_cc[_VMIN]);
8eb5cc958018d9 Al Viro 2022-08-20  48  		err |= get_user(k->c_cc[VTIME], &u->c_cc[_VTIME]);
8eb5cc958018d9 Al Viro 2022-08-20  49  	}
8eb5cc958018d9 Al Viro 2022-08-20  50  	err |= get_user(k->c_ispeed,  &u->c_ispeed);
8eb5cc958018d9 Al Viro 2022-08-20  51  	err |= get_user(k->c_ospeed,  &u->c_ospeed);
8eb5cc958018d9 Al Viro 2022-08-20  52  	return err;
8eb5cc958018d9 Al Viro 2022-08-20  53  }
8eb5cc958018d9 Al Viro 2022-08-20  54  
8eb5cc958018d9 Al Viro 2022-08-20 @55  int kernel_termios_to_user_termios(struct termios2 __user *u,
8eb5cc958018d9 Al Viro 2022-08-20  56  						 struct ktermios *k)
8eb5cc958018d9 Al Viro 2022-08-20  57  {
8eb5cc958018d9 Al Viro 2022-08-20  58  	int err;
8eb5cc958018d9 Al Viro 2022-08-20  59  	err  = put_user(k->c_iflag, &u->c_iflag);
8eb5cc958018d9 Al Viro 2022-08-20  60  	err |= put_user(k->c_oflag, &u->c_oflag);
8eb5cc958018d9 Al Viro 2022-08-20  61  	err |= put_user(k->c_cflag, &u->c_cflag);
8eb5cc958018d9 Al Viro 2022-08-20  62  	err |= put_user(k->c_lflag, &u->c_lflag);
8eb5cc958018d9 Al Viro 2022-08-20  63  	err |= put_user(k->c_line, &u->c_line);
8eb5cc958018d9 Al Viro 2022-08-20  64  	err |= copy_to_user(u->c_cc, k->c_cc, NCCS);
8eb5cc958018d9 Al Viro 2022-08-20  65  	if (!(k->c_lflag & ICANON)) {
8eb5cc958018d9 Al Viro 2022-08-20  66  		err |= put_user(k->c_cc[VMIN],  &u->c_cc[_VMIN]);
8eb5cc958018d9 Al Viro 2022-08-20  67  		err |= put_user(k->c_cc[VTIME], &u->c_cc[_VTIME]);
8eb5cc958018d9 Al Viro 2022-08-20  68  	} else {
8eb5cc958018d9 Al Viro 2022-08-20  69  		err |= put_user(k->c_cc[VEOF], &u->c_cc[VEOF]);
8eb5cc958018d9 Al Viro 2022-08-20  70  		err |= put_user(k->c_cc[VEOL], &u->c_cc[VEOL]);
8eb5cc958018d9 Al Viro 2022-08-20  71  	}
8eb5cc958018d9 Al Viro 2022-08-20  72  	err |= put_user(k->c_ispeed, &u->c_ispeed);
8eb5cc958018d9 Al Viro 2022-08-20  73  	err |= put_user(k->c_ospeed, &u->c_ospeed);
8eb5cc958018d9 Al Viro 2022-08-20  74  	return err;
8eb5cc958018d9 Al Viro 2022-08-20  75  }
8eb5cc958018d9 Al Viro 2022-08-20  76  
8eb5cc958018d9 Al Viro 2022-08-20 @77  int user_termios_to_kernel_termios_1(struct ktermios *k,
8eb5cc958018d9 Al Viro 2022-08-20  78  						 struct termios __user *u)
8eb5cc958018d9 Al Viro 2022-08-20  79  {
8eb5cc958018d9 Al Viro 2022-08-20  80  	int err;
8eb5cc958018d9 Al Viro 2022-08-20  81  	err  = get_user(k->c_iflag, &u->c_iflag);
8eb5cc958018d9 Al Viro 2022-08-20  82  	err |= get_user(k->c_oflag, &u->c_oflag);
8eb5cc958018d9 Al Viro 2022-08-20  83  	err |= get_user(k->c_cflag, &u->c_cflag);
8eb5cc958018d9 Al Viro 2022-08-20  84  	err |= get_user(k->c_lflag, &u->c_lflag);
8eb5cc958018d9 Al Viro 2022-08-20  85  	err |= get_user(k->c_line,  &u->c_line);
8eb5cc958018d9 Al Viro 2022-08-20  86  	err |= copy_from_user(k->c_cc, u->c_cc, NCCS);
8eb5cc958018d9 Al Viro 2022-08-20  87  	if (k->c_lflag & ICANON) {
8eb5cc958018d9 Al Viro 2022-08-20  88  		err |= get_user(k->c_cc[VEOF], &u->c_cc[VEOF]);
8eb5cc958018d9 Al Viro 2022-08-20  89  		err |= get_user(k->c_cc[VEOL], &u->c_cc[VEOL]);
8eb5cc958018d9 Al Viro 2022-08-20  90  	} else {
8eb5cc958018d9 Al Viro 2022-08-20  91  		err |= get_user(k->c_cc[VMIN],  &u->c_cc[_VMIN]);
8eb5cc958018d9 Al Viro 2022-08-20  92  		err |= get_user(k->c_cc[VTIME], &u->c_cc[_VTIME]);
8eb5cc958018d9 Al Viro 2022-08-20  93  	}
8eb5cc958018d9 Al Viro 2022-08-20  94  	return err;
8eb5cc958018d9 Al Viro 2022-08-20  95  }
8eb5cc958018d9 Al Viro 2022-08-20  96  
8eb5cc958018d9 Al Viro 2022-08-20 @97  int kernel_termios_to_user_termios_1(struct termios __user *u,

:::::: The code at line 15 was first introduced by commit
:::::: 8eb5cc958018d99c96d15cf9637fd07531551802 termios: uninline conversion helpers

:::::: TO: Al Viro <viro@zeniv.linux.org.uk>
:::::: CC: Al Viro <viro@zeniv.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
