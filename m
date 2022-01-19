Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD35493555
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 08:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351922AbiASHVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 02:21:23 -0500
Received: from mga11.intel.com ([192.55.52.93]:59860 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239455AbiASHVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 02:21:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642576883; x=1674112883;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UlyLrecXPFLtaUGmJDSkWxMDzv0o/7oN26Rnww04KwA=;
  b=NxdK7ltY3DpkkgXbFlra7KFrYv4s5XO0cbdqIvZ+pBpkrRR7nA/eLFww
   FZiCCXjej5qO0PDqQAIVBYbw6DlO5tgnzicYFO7WrciCta7HKBhj1E7BJ
   Yzb4xJzY3yjeGJc8CujZTqnqK1kAB5cOAvCM8BMOByOntPW86KGtsYlfG
   gVqjHQZcGUcn2P4C2tshDysdqUFULzGH0bndRQvhqh44iievj73uVlW0d
   uE4bUTB4LhHvDSDmyonJRfNPBykw/zUWhUkn+AtlLhg+2fcSXSyMsDtul
   cECql9Uddj44B87CD7KxJO57TebHavVf59LaCgL9KIFlIf8CVanxTk8xk
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="242566853"
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="242566853"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 23:21:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="767165783"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jan 2022 23:21:21 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nA5HV-000DMh-4S; Wed, 19 Jan 2022 07:21:21 +0000
Date:   Wed, 19 Jan 2022 15:20:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matteo Croce <mcroce@microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [esmil:visionfive 21/80] string.c:(.text+0x1184): multiple
 definition of `memset'; mm/kasan/shadow.o:shadow.c:(.text+0xfc): first
 defined here
Message-ID: <202201191551.ZXYUjRiZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   e46c3a7e373e6faa03399f1a41c29cf7546c37cb
commit: 55f013c0bc3e224cf34271c3cc11f7443b11553f [21/80] riscv: optimized memset
config: riscv-randconfig-r042-20220119 (https://download.01.org/0day-ci/archive/20220119/202201191551.ZXYUjRiZ-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/55f013c0bc3e224cf34271c3cc11f7443b11553f
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 55f013c0bc3e224cf34271c3cc11f7443b11553f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   riscv64-linux-ld: lib/string.o: in function `memset':
>> string.c:(.text+0x1184): multiple definition of `memset'; mm/kasan/shadow.o:shadow.c:(.text+0xfc): first defined here
   riscv64-linux-ld: lib/string.o: in function `memcpy':
   string.c:(.text+0x1414): multiple definition of `memcpy'; mm/kasan/shadow.o:shadow.c:(.text+0x174): first defined here
--
>> mm/kasan/shadow.c:42:7: warning: no previous prototype for 'memset' [-Wmissing-prototypes]
      42 | void *memset(void *addr, int c, size_t len)
         |       ^~~~~~
   mm/kasan/shadow.c:63:7: warning: no previous prototype for 'memcpy' [-Wmissing-prototypes]
      63 | void *memcpy(void *dest, const void *src, size_t len)
         |       ^~~~~~

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
