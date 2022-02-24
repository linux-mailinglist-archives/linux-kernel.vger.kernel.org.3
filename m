Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494194C224C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiBXDWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiBXDWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:22:35 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F372E108557
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645672927; x=1677208927;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OynSba4mHM1MAyMIHRKIVijs0iCtorhqp5ScGjHOuIg=;
  b=bVpMKurShMKM5F+m/5g8mG/ZqGyR7NX6zb2JooiYQRZ2Ou2YOcW2tyTp
   Kgv3qc2+7jfXeUKfe3sEwaHyBbjTW8NREkMmLRbqeEVAi1gIZ21o18vWn
   +LYoXG3kC1eShDSEI5+gt/4Lsj+CFQ81L1PsgIz0gKTCCgF1fEoUBkf+g
   P3EMCBdBvxiMnDgSAxKZEcohytHfJZtfY1ior3e5XrAPQw80Sbag0sxfd
   BFtZVuFTo91WIFJD+AOfb1tRqoQXDASGeFL9Niwq49r/WFQUJYhK21NEE
   R4zGEX8zW0zK1W9jA4weF4TeBh0CdIE1oQlXS4JYXR6LoNO9s50tkzl3B
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="239535299"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="239535299"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 19:22:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="491446159"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 Feb 2022 19:22:01 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN4hc-0002Af-4T; Thu, 24 Feb 2022 03:22:00 +0000
Date:   Thu, 24 Feb 2022 11:21:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [trondmy-nfs-2.6:testing 42/44] ERROR: modpost: "xxh32"
 [fs/nfs/nfs.ko] undefined!
Message-ID: <202202241146.nxe34boY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git testing
head:   3882cc488a3048791d7f06393d3e7c55ba3eda6f
commit: 5d2f1b8a2961967f7712baaea33b6e83daf732f8 [42/44] NFS: Convert readdir page cache to use a cookie based index
config: mips-jazz_defconfig (https://download.01.org/0day-ci/archive/20220224/202202241146.nxe34boY-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add trondmy-nfs-2.6 git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git
        git fetch --no-tags trondmy-nfs-2.6 testing
        git checkout 5d2f1b8a2961967f7712baaea33b6e83daf732f8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "xxh32" [fs/nfs/nfs.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
