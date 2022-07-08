Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576E356B24D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 07:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbiGHFkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 01:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiGHFk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 01:40:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356BA2AE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 22:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657258828; x=1688794828;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RejFxuZNOyQtMVrDj19TKfdSTi+LhnFqwl0PLN1HOvI=;
  b=H8McJcxvxxwTiXs9wmr3rosQHiVOjrmp7lW6VpXRbLbsyxcVmS5jEcRt
   xamHcABsaj5+8tJriuebjyD8xTjsfd1ZTlpK/1yLfpH0f61ls/29FkupM
   ZMeDCWmaklnZluDTKoiT4+/XiVWbju6OZf21KMfSOxwJnDdN84k0/4nUF
   11Ck1I/Lrarrh+17yPD6WJaEx/661vthLYrvwXICWWd62GzyZ/vwyjQVN
   xjazO2cCHRmAjUf4s7LiMr9XaKLLrDS5EmqJlm61XEnZjYQAVKSEuT72J
   096ZzHb6yv9t73vx/DWIFKQQVVMxQ7w+50fIk4c8+3LPpufAH8gYQTEsu
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="264609445"
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="264609445"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 22:40:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="696768025"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jul 2022 22:40:26 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9gj3-000MyM-MH;
        Fri, 08 Jul 2022 05:40:25 +0000
Date:   Fri, 8 Jul 2022 13:39:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: arch/mips/boot/compressed/../../lib/bswapdi.c:5:28: warning: no
 previous prototype for '__bswapdi2'
Message-ID: <202207081322.pj8QnG2I-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e8a4e1c1bb697b1d9fc48f0e56dc0f50bc024bee
commit: f78b25ee922ef6faf59a258af1b9388ca894cfd9 mips: decompressor: do not copy source files while building
date:   8 months ago
config: mips-randconfig-r033-20220707 (https://download.01.org/0day-ci/archive/20220708/202207081322.pj8QnG2I-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f78b25ee922ef6faf59a258af1b9388ca894cfd9
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f78b25ee922ef6faf59a258af1b9388ca894cfd9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
