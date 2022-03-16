Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2484DA8C2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 04:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353064AbiCPDFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 23:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237407AbiCPDFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 23:05:53 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5672247392
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 20:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647399880; x=1678935880;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5IJ3bsYeffBrfv8jFPNpyIVVLUyp73LNlB8WwUsF2mg=;
  b=iKtTKsDouA8GxeaqsZTwEkH4sG1xJxvbXitsV4dRPx46ilhcukybUi3E
   xmsq84Hq7x9wB6u5+aqXKRWjZSZDpTt8X+OvsKSd1oIG/5l9yTRuHJIqW
   RBTyexLZ1/QZJIFbzAyh1DxW1zQPttFbB/jJVYpTKpcEqdam68Nogkg6n
   MZ0ODhpTR143D6XywypEIyWVNp/chyf3w5GNIG08NLZrhTMW+ESejNeS5
   2m8yLe3CP6kxciiUvVGK1ErTf0TG58GogOYdEuXC5VWt8Yhvw0Hj0OTYI
   03dr8G4ApAyue19yjYeeZcuxnyYQyvIcM+3weXU1ki1vSmGT2h4fQSNfH
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="237082781"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="237082781"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 20:04:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="516140653"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Mar 2022 20:04:38 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUJxm-000BqX-1z; Wed, 16 Mar 2022 03:04:38 +0000
Date:   Wed, 16 Mar 2022 11:04:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 2219/2335]
 arch/sparc/include/asm/page_64.h:177:33: error: implicit declaration of
 function 'pfn_valid'; did you mean 'gid_valid'?
Message-ID: <202203161013.ol6kb6T6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: 96fe05cecfceff760842012750f6955637aa928d [2219/2335] headers/deps: mm: Optimize <linux/mm_api.h> dependencies, remove <linux/mmzone_api.h> dependency
config: sparc64-buildonly-randconfig-r002-20220314 (https://download.01.org/0day-ci/archive/20220316/202203161013.ol6kb6T6-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=96fe05cecfceff760842012750f6955637aa928d
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 96fe05cecfceff760842012750f6955637aa928d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc64 SHELL=/bin/bash drivers/mtd/nand/raw/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/sparc/include/asm/page.h:8,
                    from arch/sparc/include/asm/thread_info_64.h:27,
                    from arch/sparc/include/asm/thread_info.h:5,
                    from include/linux/thread_info.h:63,
                    from arch/sparc/include/asm/current.h:15,
                    from arch/sparc/include/asm/smp_64.h:33,
                    from arch/sparc/include/asm/smp.h:5,
                    from include/linux/smp_api.h:15,
                    from include/linux/lockdep_api.h:27,
                    from include/linux/timer.h:5,
                    from include/linux/workqueue_types.h:9,
                    from include/linux/workqueue.h:5,
                    from include/linux/kobject_api.h:30,
                    from include/linux/of_api.h:26,
                    from drivers/mtd/nand/raw/nand_base.c:28:
   drivers/mtd/nand/raw/nand_base.c: In function 'nand_do_read_ops':
>> arch/sparc/include/asm/page_64.h:177:33: error: implicit declaration of function 'pfn_valid'; did you mean 'gid_valid'? [-Werror=implicit-function-declaration]
     177 | #define virt_addr_valid(kaddr)  pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
         |                                 ^~~~~~~~~
   drivers/mtd/nand/raw/nand_base.c:3448:43: note: in expansion of macro 'virt_addr_valid'
    3448 |                         use_bounce_buf = !virt_addr_valid(buf) ||
         |                                           ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +177 arch/sparc/include/asm/page_64.h

f5e706ad886b6a include/asm-sparc/page_64.h Sam Ravnborg 2008-07-17  176  
f5e706ad886b6a include/asm-sparc/page_64.h Sam Ravnborg 2008-07-17 @177  #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
f5e706ad886b6a include/asm-sparc/page_64.h Sam Ravnborg 2008-07-17  178  

:::::: The code at line 177 was first introduced by commit
:::::: f5e706ad886b6a5eb59637830110b09ccebf01c5 sparc: join the remaining header files

:::::: TO: Sam Ravnborg <sam@ravnborg.org>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
