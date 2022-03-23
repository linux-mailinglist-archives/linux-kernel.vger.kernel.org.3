Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E864E5BC2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 00:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344900AbiCWXUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 19:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239014AbiCWXUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 19:20:52 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4757F286E8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 16:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648077562; x=1679613562;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eJnCARi65QMeGfeINdrTFSvt1d7nKe5MpBSreV0AXmw=;
  b=TnfEnOdfO6ABPRVuUt3nT9L1Bo1JHxZ7cslONlfZ13DXRTvYfZG+9r93
   TI/sURFQpVE/OG7aC1tSfM2Wdb/3ayLjmRFDPQVgiUQ+UafpybMbtROIG
   HfXWyaLVH61iDQTTMkW2fCB4Eliq+5AQHAFRPKpGBtYT+K/N1XXUGxORf
   uf2aszdsXrKFMe1IOToyo5z8tS+nGp7K2c2+cXdQ4USxjgdpM22tNkxgP
   +cI7IvQNLBEjlIyXsLMTHYwQblidH0NI044wI6y2gdjyVC3ws4QNSK2+u
   SqZuhnBKLDh0Cw7nnE4LFuPKjZd0WDpcMlGZxIIBXXCcSYPfDACTsRW4u
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="283100447"
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="283100447"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 16:19:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="561128632"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 23 Mar 2022 16:19:20 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXAG7-000KTC-RM; Wed, 23 Mar 2022 23:19:19 +0000
Date:   Thu, 24 Mar 2022 07:18:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_linecards 14/27]
 include/linux/stddef.h:8:14: warning: passing argument 3 of
 '__nsim_dev_port_add' makes integer from pointer without a cast
Message-ID: <202203240754.0XOFWwW1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_linecards
head:   4a0e7275ecdf8f8cfd4c1a2e9acd45f93f04c0df
commit: a4347ad737edaf74ab771e14854e259ef224ab1c [14/27] netdevsim: allow port objects to be linked with line cards
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220324/202203240754.0XOFWwW1-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/a4347ad737edaf74ab771e14854e259ef224ab1c
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_linecards
        git checkout a4347ad737edaf74ab771e14854e259ef224ab1c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash drivers/net/netdevsim/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from ./arch/m68k/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:255,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/debugfs.h:15,
                    from drivers/net/netdevsim/dev.c:18:
   drivers/net/netdevsim/dev.c: In function 'nsim_esw_switchdev_enable':
>> include/linux/stddef.h:8:14: warning: passing argument 3 of '__nsim_dev_port_add' makes integer from pointer without a cast [-Wint-conversion]
       8 | #define NULL ((void *)0)
         |              ^~~~~~~~~~~
         |              |
         |              void *
   drivers/net/netdevsim/dev.c:638:43: note: in expansion of macro 'NULL'
     638 |                                           NULL, i);
         |                                           ^~~~
   drivers/net/netdevsim/dev.c:613:34: note: expected 'unsigned int' but argument is of type 'void *'
     613 |                     unsigned int port_index);
         |                     ~~~~~~~~~~~~~^~~~~~~~~~
   drivers/net/netdevsim/dev.c:637:23: error: too many arguments to function '__nsim_dev_port_add'
     637 |                 err = __nsim_dev_port_add(nsim_dev, NSIM_DEV_PORT_TYPE_VF,
         |                       ^~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/dev.c:612:1: note: declared here
     612 | __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
         | ^~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/dev.c:651:25: error: too many arguments to function '__nsim_dev_port_del'
     651 |                         __nsim_dev_port_del(nsim_dev_port, NULL, i);
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/dev.c:614:13: note: declared here
     614 | static void __nsim_dev_port_del(struct nsim_dev_port *nsim_dev_port);
         |             ^~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/dev.c: At top level:
   drivers/net/netdevsim/dev.c:1393:12: error: conflicting types for '__nsim_dev_port_add'; have 'int(struct nsim_dev *, enum nsim_dev_port_type,  struct nsim_dev_linecard *, unsigned int)'
    1393 | static int __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
         |            ^~~~~~~~~~~~~~~~~~~
   drivers/net/netdevsim/dev.c:612:1: note: previous declaration of '__nsim_dev_port_add' with type 'int(struct nsim_dev *, enum nsim_dev_port_type,  unsigned int)'
     612 | __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
         | ^~~~~~~~~~~~~~~~~~~
>> drivers/net/netdevsim/dev.c:612:1: warning: '__nsim_dev_port_add' used but never defined


vim +/__nsim_dev_port_add +8 include/linux/stddef.h

^1da177e4c3f41 Linus Torvalds   2005-04-16  6  
^1da177e4c3f41 Linus Torvalds   2005-04-16  7  #undef NULL
^1da177e4c3f41 Linus Torvalds   2005-04-16 @8  #define NULL ((void *)0)
6e218287432472 Richard Knutsson 2006-09-30  9  

:::::: The code at line 8 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
