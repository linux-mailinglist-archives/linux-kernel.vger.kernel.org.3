Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C314A3071
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 17:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351896AbiA2QLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 11:11:24 -0500
Received: from mga02.intel.com ([134.134.136.20]:33836 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233274AbiA2QLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 11:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643472682; x=1675008682;
  h=date:from:cc:subject:message-id:mime-version;
  bh=Vam+xzF8b0eUjkmZAxI9VEUITXI2zXjEdpBNsFjy+HI=;
  b=jpj41be9/rHkWOrsd/DconnGzNHA3fNuFz38+jvK/FEAIYvLFTUGhkve
   ESKjDwvwOj2MwHHZa5dBynPhqfUGIas2lSpVe7AOAltlc9Pg5G3+YHKoS
   YsKEE/9QEbu21XK9moO/ndeOkVjEqvhhMWI4yHEZGmjnCrLmc8InlNTHi
   RLFYIWzey1mB6JgZg42ACVGGZ/n35HB1lGRVgbGJ0T//zi8TKesjuqxOh
   G3EVg7tUmyUKOGSuuTx4lmr5WLtI1l1Zfq8eSSjFVT6TIza9lTnfaGCB9
   9QQKRJa8cAWNAxVTFVl0OBnUVjy62QawweH1pKAAbiMDawDNkXd0H43Zt
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="234669237"
X-IronPort-AV: E=Sophos;i="5.88,326,1635231600"; 
   d="scan'208";a="234669237"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2022 08:11:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,326,1635231600"; 
   d="scan'208";a="481096928"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Jan 2022 08:11:20 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDqJr-000POA-OJ; Sat, 29 Jan 2022 16:11:19 +0000
Date:   Sun, 30 Jan 2022 00:10:55 +0800
From:   kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: drivers/input/touchscreen/ads7846.c:705:24: warning: taking address
 of packed member 'data' of class or structure 'ads7846_buf' may result in an
 unaligned pointer value
Message-ID: <202201300020.SS6KSznh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cb323ee75d24e7acc2f188d123ba6df46159cf09
commit: 415e915fdfc775ad0c6675fde1008f6f43dd6251 Merge tag 'v5.11' into next
date:   11 months ago
config: mips-randconfig-r025-20220129 (https://download.01.org/0day-ci/archive/20220130/202201300020.SS6KSznh-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 33b45ee44b1f32ffdbc995e6fec806271b4b3ba4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=415e915fdfc775ad0c6675fde1008f6f43dd6251
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 415e915fdfc775ad0c6675fde1008f6f43dd6251
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/kernel/ drivers/input/touchscreen/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/input/touchscreen/ads7846.c:705:24: warning: taking address of packed member 'data' of class or structure 'ads7846_buf' may result in an unaligned pointer value [-Waddress-of-packed-member]
           value = be16_to_cpup(&buf->data);
                                 ^~~~~~~~~
   1 warning generated.


vim +705 drivers/input/touchscreen/ads7846.c

2991a1ca6e9b13 Jason Wang     2010-10-13  700  
6965eece2a89c3 Oleksij Rempel 2021-01-20  701  static int ads7846_get_value(struct ads7846_buf *buf)
2991a1ca6e9b13 Jason Wang     2010-10-13  702  {
879f2fea8a5a74 Andrey Gelman  2015-10-06  703  	int value;
2991a1ca6e9b13 Jason Wang     2010-10-13  704  
6965eece2a89c3 Oleksij Rempel 2021-01-20 @705  	value = be16_to_cpup(&buf->data);
879f2fea8a5a74 Andrey Gelman  2015-10-06  706  
879f2fea8a5a74 Andrey Gelman  2015-10-06  707  	/* enforce ADC output is 12 bits width */
879f2fea8a5a74 Andrey Gelman  2015-10-06  708  	return (value >> 3) & 0xfff;
2991a1ca6e9b13 Jason Wang     2010-10-13  709  }
ffa458c1bd9b6f David Brownell 2006-01-08  710  

:::::: The code at line 705 was first introduced by commit
:::::: 6965eece2a89c3f1d00881c6052ee1e987870c08 Input: ads7846 - convert to one message

:::::: TO: Oleksij Rempel <o.rempel@pengutronix.de>
:::::: CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
