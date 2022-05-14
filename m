Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1336452715D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 15:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbiENNkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 09:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbiENNkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 09:40:20 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BB623153
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 06:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652535618; x=1684071618;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ATOwkom89fRH40zG0QcAYWcTUk7vSqR49LMlHjMCims=;
  b=GzGc8M/ZajOhvnAwBMYs+tu0QxypdwSKs8+LXYwVCgob8JOmV04CiYmr
   ANzy0gC/KJ+dxzAsRcm7oBDaDp0DnIzD9YA+Cf64YFzy2Q8b5TOmVgHim
   ihYB0WQ0vcA+s6Vo4jMeMnrRpgMQbM+8HX48dsU9T/nP0vJpfKOfGrHt2
   BDTxT5gieQhUfOUCteHuqJkdwMhaBkj28s2xnzmHB96Tdgq+yegGICsvc
   tW8XXp+PN1PeFVS6LWqvBWuWAuZt/F0TvacxIZpzDkkcZFWCamjKuWmOT
   Q8WcDf+o+ggR4TUgCRHUv7UcmbbE8bX+WTG9Y4SCnAt3U7u8/6OeKnp0H
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10347"; a="258069513"
X-IronPort-AV: E=Sophos;i="5.91,226,1647327600"; 
   d="scan'208";a="258069513"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2022 06:40:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,226,1647327600"; 
   d="scan'208";a="521793037"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 14 May 2022 06:40:15 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nps0E-0000h3-Ij;
        Sat, 14 May 2022 13:40:14 +0000
Date:   Sat, 14 May 2022 21:39:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [nsaenz-rpi:ct-work-defer-wip 24/25] arch/x86/mm/tlb.c:1010:12:
 error: use of undeclared identifier 'CONTEXT_WORK_TLBI'
Message-ID: <202205142105.ZgamkxvX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git ct-work-defer-wip
head:   ed63029652239a6befad96dd473b16332913f889
commit: ac6fd7356ff9f2e0f040ef337d3eb731454ce49f [24/25] context_tracking,x86: Fix Kernel TLBi vs NOHZ_FULL
config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20220514/202205142105.ZgamkxvX-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 38189438b69ca27b4c6ce707c52dbd217583d046)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git/commit/?id=ac6fd7356ff9f2e0f040ef337d3eb731454ce49f
        git remote add nsaenz-rpi https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git
        git fetch --no-tags nsaenz-rpi ct-work-defer-wip
        git checkout ac6fd7356ff9f2e0f040ef337d3eb731454ce49f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/x86/mm/tlb.c:1010:12: error: use of undeclared identifier 'CONTEXT_WORK_TLBI'
                                                 CONTEXT_WORK_TLBI);
                                                 ^
   1 error generated.
--
>> arch/x86/mm/pat/set_memory.c:367:12: error: use of undeclared identifier 'CONTEXT_WORK_TLBI'
                                                 CONTEXT_WORK_TLBI);
                                                 ^
   1 error generated.


vim +/CONTEXT_WORK_TLBI +1010 arch/x86/mm/tlb.c

  1006	
  1007	static bool do_kernel_flush_cond(int cpu, void *info)
  1008	{
  1009		return !context_tracking_set_cpu_work(cpu, CONTEXT_USER | CONTEXT_GUEST,
> 1010						      CONTEXT_WORK_TLBI);
  1011	}
  1012	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
