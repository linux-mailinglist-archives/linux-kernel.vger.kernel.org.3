Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFB447F4F7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 03:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhLZC7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 21:59:32 -0500
Received: from mga06.intel.com ([134.134.136.31]:59513 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229456AbhLZC7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 21:59:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640487570; x=1672023570;
  h=date:from:cc:subject:message-id:mime-version;
  bh=Jbz3u5gJydZHb6lOxXr8ZHFuls8hGbfCbxperOuOAC4=;
  b=B6tdSlgS39PyatxyNtAX8C0UOk+s2oBmvPHELRw4VIMuGvf/IPQOozPt
   WGdqpndzvdx8IGOUMxHRIQVoUrnXT0L3Ta5dzYVSI3oFF1bhnPLVIIHhL
   n2h1UoKh0A1A8EtSS9qCuP4UrUAwpV2DMe71TiLjAI5qDL4FKw8ITT7Jg
   XInoI157MI3jJoQudT0xj70iTvzYC6YA6aNKspnh7JuQIVO5Nk9xqNVdI
   herj/O+2YQAJCulY7lq1zPaFNNUs2tZwFt+lF3GGvTXMPc+zyfylXLkhL
   lHG2ZmFByBok15H/83z63nhjeaFoC2I5E4hnag57rzUiQ3XD6eETc6pdk
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10208"; a="301838506"
X-IronPort-AV: E=Sophos;i="5.88,236,1635231600"; 
   d="scan'208";a="301838506"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2021 18:59:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,236,1635231600"; 
   d="scan'208";a="571707909"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 25 Dec 2021 18:59:29 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1Jku-0004yD-DU; Sun, 26 Dec 2021 02:59:28 +0000
Date:   Sun, 26 Dec 2021 10:58:54 +0800
From:   kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: drivers/input/touchscreen/ads7846.c:705:24: warning: taking address
 of packed member 'data' of class or structure 'ads7846_buf' may result in an
 unaligned pointer value
Message-ID: <202112261050.OodYJnM4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e2ae0d4a6b0ba461542f0fd0ba0b828658013e9f
commit: 415e915fdfc775ad0c6675fde1008f6f43dd6251 Merge tag 'v5.11' into next
date:   10 months ago
config: mips-randconfig-r033-20211226 (https://download.01.org/0day-ci/archive/20211226/202112261050.OodYJnM4-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 0c553cc1af2e4c14100df6cf4a6fc91987e778e6)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/input/touchscreen/

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
