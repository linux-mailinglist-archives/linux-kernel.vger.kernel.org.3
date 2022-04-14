Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1339B5019C4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244251AbiDNROw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245261AbiDNRO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:14:27 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114EE219
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649955973; x=1681491973;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bGxfBawqL+IYMNEP8r3qx3wlLa1xc1GcPYIrjdfLzIE=;
  b=MSyehod/rY4AmV8X9P3Ld8aEtm9y1HoHh53YHMR9LOKKKdXufEAxWsHu
   hCBKkClnPN1uWfxf3G6rn+aDkm/xDxtg1KE7iFcHUFg8ufud5/2iwgT7c
   xeRWikUredzUWsga8vHnMIJH9s5rLg4hl3e/0bhEYE5DtW8S+95KECjEi
   Zt2Upf4vbq9YOMKDS9btpp5yoNGqWylySR3Wjd2kuodE0LIaqDEhAljz8
   pACzY+yXBm9/lUIThLpbuVD3XzvWUS1kuxg/n7krG9wwcezlTQc+SvkEL
   4GafphFaYVJhMmETh1CnKjaU+XiBNkuSAUb7m4g5zLxtJb7C59DVLLrhX
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="263157125"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="263157125"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 10:06:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="526989778"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 14 Apr 2022 10:06:10 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nf2v3-00019l-TX;
        Thu, 14 Apr 2022 17:06:09 +0000
Date:   Fri, 15 Apr 2022 01:05:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: arch/mips/boot/compressed/../../lib/bswapdi.c:5:28: warning: no
 previous prototype for '__bswapdi2'
Message-ID: <202204150055.OrZCCMZl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
head:   a19944809fe9942e6a96292490717904d0690c21
commit: f78b25ee922ef6faf59a258af1b9388ca894cfd9 mips: decompressor: do not copy source files while building
date:   5 months ago
config: mips-randconfig-r016-20220414 (https://download.01.org/0day-ci/archive/20220415/202204150055.OrZCCMZl-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 11.2.0
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
