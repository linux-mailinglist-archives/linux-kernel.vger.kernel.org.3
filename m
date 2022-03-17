Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9635D4DD104
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 00:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiCQXEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 19:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiCQXEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 19:04:01 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D2319BFC1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 16:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647558164; x=1679094164;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CSzoxUhh8hZ7J0pgyJ5dB8hc+ItTa+n+HXD4RDPKlU4=;
  b=iYAWRYuJiVVlxhoDr3cvZYdPlQRARFlg6fcTo8fn3BkheGBji/UUhnoi
   Q7/xgKEX8syfxXxLRXQKQ5ahUjJcteOKq+KZBvVH9anD68Ee/iEgGcffF
   oqbONYZUlx6KSp8pFoLrsSi9UvAOafE0/WjT8FSE9Mga9f90f1cVIIP1g
   C52DH/SItUEsY8ZDFu4FUvYmuycHx8UtwT0XUDXgFPNCfOJwkhGWyRX0q
   KfO4zlsgej2FuosZLS3u28NPK+jBk5Sfsomyy4esTLeU48ogylRNBcpg3
   nsxUDTT2WfmlyjAvISXaHJPNh8NFXsbCSk5x+IpdDjiEV89Bs4YipDkhI
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="256950294"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="256950294"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 16:02:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="558146356"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 17 Mar 2022 16:02:24 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUz8S-000ECC-2k; Thu, 17 Mar 2022 23:02:24 +0000
Date:   Fri, 18 Mar 2022 07:01:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: arch/mips/boot/compressed/../../lib/bswapdi.c:5:28: warning: no
 previous prototype for '__bswapdi2'
Message-ID: <202203180644.cQo8rUA8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   56e337f2cf1326323844927a04e9dbce9a244835
commit: f78b25ee922ef6faf59a258af1b9388ca894cfd9 mips: decompressor: do not copy source files while building
date:   4 months ago
config: mips-randconfig-r036-20220317 (https://download.01.org/0day-ci/archive/20220318/202203180644.cQo8rUA8-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f78b25ee922ef6faf59a258af1b9388ca894cfd9
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f78b25ee922ef6faf59a258af1b9388ca894cfd9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/mips/boot/compressed/bswapdi.c:2:
>> arch/mips/boot/compressed/../../lib/bswapdi.c:5:28: warning: no previous prototype for '__bswapdi2' [-Wmissing-prototypes]
       5 | unsigned long long notrace __bswapdi2(unsigned long long u)
         |                            ^~~~~~~~~~


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

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
