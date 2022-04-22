Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1F950B821
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447799AbiDVNRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447805AbiDVNRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:17:13 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36415580EC
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650633259; x=1682169259;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7SBMJY2Qo5zlpc9kt8+bESQSdagf2RsT2Ca0UID8SSU=;
  b=YqJxiqd+p2L4n8U8hbPPxqZ2izeksBHU3BRxbi0TXcYWh80aMsGXN8tz
   Z9WPS25npO3NzjN9saA3X/HLp6WQdmeLypGRgUxaJB8S0bwy/drZSC8dX
   4JKXN2ca54q/20i4g/fhpz/3/lTQ+ba8nZIyzxbuYki+RkWHR5UGPczjl
   TQp0i8g5IMeOuP/YUYhErH5QkXQvc+b8tS7OwtrUfzT1xrK57dZuikKoF
   ogtRdeteT7tobiaHpmvLnwaz+Cvok/0CYKheJ/eB9nkd/yBdv2MHUMV0C
   riSqVifkQMWT30ddSaUrD+ivrmcaXlwuIYt4IB/sQ6YIIvrfQoLvj2xgb
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="262269295"
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="262269295"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 06:14:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="511569890"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Apr 2022 06:14:17 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nht72-000A86-Di;
        Fri, 22 Apr 2022 13:14:16 +0000
Date:   Fri, 22 Apr 2022 21:13:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     YunQiang Su <yunqiang.su@cipunited.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: arch/mips/boot/compressed/../../lib/bswapdi.c:5:28: warning: no
 previous prototype for function '__bswapdi2'
Message-ID: <202204222130.Bc3dL9dC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d569e86915b7f2f9795588591c8d5ea0b66481cb
commit: 31b2f3dc851c65fee288612432c4fc956f1a264e MIPS: enable both vmlinux.gz.itb and vmlinuz for generic
date:   4 months ago
config: mips-randconfig-r003-20220422 (https://download.01.org/0day-ci/archive/20220422/202204222130.Bc3dL9dC-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=31b2f3dc851c65fee288612432c4fc956f1a264e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 31b2f3dc851c65fee288612432c4fc956f1a264e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/mips/boot/compressed/bswapdi.c:2:
>> arch/mips/boot/compressed/../../lib/bswapdi.c:5:28: warning: no previous prototype for function '__bswapdi2' [-Wmissing-prototypes]
   unsigned long long notrace __bswapdi2(unsigned long long u)
                              ^
   arch/mips/boot/compressed/../../lib/bswapdi.c:5:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   unsigned long long notrace __bswapdi2(unsigned long long u)
   ^
   static 
   1 warning generated.


vim +/__bswapdi2 +5 arch/mips/boot/compressed/../../lib/bswapdi.c

1ee3630a3e57f3 Ralf Baechle 2015-09-29   4  
aedcfbe06558a9 Harvey Hunt  2016-05-25  @5  unsigned long long notrace __bswapdi2(unsigned long long u)
1ee3630a3e57f3 Ralf Baechle 2015-09-29   6  {
1ee3630a3e57f3 Ralf Baechle 2015-09-29   7  	return (((u) & 0xff00000000000000ull) >> 56) |
1ee3630a3e57f3 Ralf Baechle 2015-09-29   8  	       (((u) & 0x00ff000000000000ull) >> 40) |
1ee3630a3e57f3 Ralf Baechle 2015-09-29   9  	       (((u) & 0x0000ff0000000000ull) >> 24) |
1ee3630a3e57f3 Ralf Baechle 2015-09-29  10  	       (((u) & 0x000000ff00000000ull) >>  8) |
1ee3630a3e57f3 Ralf Baechle 2015-09-29  11  	       (((u) & 0x00000000ff000000ull) <<  8) |
1ee3630a3e57f3 Ralf Baechle 2015-09-29  12  	       (((u) & 0x0000000000ff0000ull) << 24) |
1ee3630a3e57f3 Ralf Baechle 2015-09-29  13  	       (((u) & 0x000000000000ff00ull) << 40) |
1ee3630a3e57f3 Ralf Baechle 2015-09-29  14  	       (((u) & 0x00000000000000ffull) << 56);
1ee3630a3e57f3 Ralf Baechle 2015-09-29  15  }
1ee3630a3e57f3 Ralf Baechle 2015-09-29  16  

:::::: The code at line 5 was first introduced by commit
:::::: aedcfbe06558a9f53002e82d5be64c6c94687726 MIPS: lib: Mark intrinsics notrace

:::::: TO: Harvey Hunt <harvey.hunt@imgtec.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
