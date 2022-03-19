Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A944E18CA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 23:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244278AbiCSWSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 18:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbiCSWSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 18:18:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2FF19ABC4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 15:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647728204; x=1679264204;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6dYfmkcIyCAPrBT5TULXnQbOQ/f76+B48352NpuKJpI=;
  b=eOMZNJh8/fehkvljEg0PR9fl5luIn1HULAH8tCiwOC8NTeG3YXB0m6TC
   AHIN92ITvZIJFXVBpRs7yjDSkKAAgSrcy5IV2wui69trtvgJsil397wnH
   2p1WXvNCGrJmZ/r/RQW3i+GXiPMxlbjwvN8ARoFQfofjtQYQMl4Wmr/9W
   JrokncJBw649X147E2P+/u59YmFg0JC5pmBZ26E2PqTQWOkBLtj2aDcyY
   4JENQXGcF5uK21OvrrvvwGhvuxHCYEJbUUXrK94fiMYnT+KzlWLiex/6L
   /5DhznLbxcV4Og37Q9KiMDvuBFZFgXoUyU0MPPp+swLpvGXF5FFXhZifc
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="244803815"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="244803815"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 15:16:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="715994112"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 19 Mar 2022 15:16:41 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVhNJ-000GKb-79; Sat, 19 Mar 2022 22:16:41 +0000
Date:   Sun, 20 Mar 2022 06:16:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: powerpc-linux-ld: warning: orphan section `.init.plt' from
 `drivers/platform/chrome/cros_ec_trace.o' being placed in section
 `.init.plt'
Message-ID: <202203200632.36TZEYf8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   34e047aa16c0123bbae8e2f6df33e5ecc1f56601
commit: 8581fd402a0cf80b5298e3b225e7a7bd8f110e69 treewide: Add missing includes masked by cgroup -> bpf dependency
date:   4 months ago
config: powerpc-randconfig-c024-20220320 (https://download.01.org/0day-ci/archive/20220320/202203200632.36TZEYf8-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8581fd402a0cf80b5298e3b225e7a7bd8f110e69
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8581fd402a0cf80b5298e3b225e7a7bd8f110e69
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> powerpc-linux-ld: warning: orphan section `.init.plt' from `drivers/platform/chrome/cros_ec_trace.o' being placed in section `.init.plt'
>> powerpc-linux-ld: warning: orphan section `.init.plt' from `drivers/platform/chrome/cros_ec_trace.o' being placed in section `.init.plt'
>> powerpc-linux-ld: warning: orphan section `.init.plt' from `drivers/platform/chrome/cros_ec_trace.o' being placed in section `.init.plt'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
