Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501044EA4BE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 03:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiC2Br1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 21:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiC2BrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 21:47:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34FB1C8DBA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 18:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648518343; x=1680054343;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Aob2vTiZCQrw/und1hAVyOL3DpoUPd0Gp66mZE0Bbdg=;
  b=ey8bl0GYiW9q6LULo/gjvqXBfN7bW4ZfTjqERUxw4YgkOnJO4j8XFUmu
   C+ePbM14rC6HL8bjvS+umjnhufln2Erc5fm93iAQnkg3ZQZumylmsbXEM
   sYE4n0i5jbjrLrV0AOlJeUouoqglsCE/wt0Azji15eZF4rfVYJHHL4ruO
   LdivUJHkXeV2e+OQmTQ7E857Vjw3zE2ZfKFSuB1QFqkp32/gRPOx6sPl4
   GffMIHh2L1jMai4mLnNL2KwAUAONl9qxDcaktHbzoiP5Yz7QcRiES5W44
   p/8lb1PI1D75XrIpN5MQk8k2MuZycQzEk46WhlGfMNlhWFisfm5kQR/d4
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="257967756"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="257967756"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 18:45:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="564184431"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 28 Mar 2022 18:45:41 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZ0vV-0002VB-3W; Tue, 29 Mar 2022 01:45:41 +0000
Date:   Tue, 29 Mar 2022 09:44:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_linecards 84/97]
 include/linux/stddef.h:8:14: warning: passing argument 3 of
 '__nsim_dev_port_add' makes integer from pointer without a cast
Message-ID: <202203290945.2MnxOMgc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_linecards
head:   7acc15a4d5cd40bc4ab8bafe3f376adacd6f4bb2
commit: 9f172debd1c3d2de76650ee4e20aaa1bc31bb79e [84/97] netdevsim: allow port objects to be linked with line cards
config: nios2-allyesconfig (https://download.01.org/0day-ci/archive/20220329/202203290945.2MnxOMgc-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/9f172debd1c3d2de76650ee4e20aaa1bc31bb79e
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_linecards
        git checkout 9f172debd1c3d2de76650ee4e20aaa1bc31bb79e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash drivers/net/netdevsim/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from ./arch/nios2/include/generated/asm/rwonce.h:1,
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
