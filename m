Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2E35271FD
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 16:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbiENOa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 10:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbiENOaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 10:30:21 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0247C1758D
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 07:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652538620; x=1684074620;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l8Umuf3SuqvhyBt8dkzAa4QPJtRZJLLyK5CjOFYtC5g=;
  b=Hsj/88MVdEoV8EiuH5JLt2E658ntq/WjSqYWs2YoVOb1yDry58Cz2EpL
   uxW9AweF5DUmKVmChmSi1qK83QB1b+VgAYwJkdU3FgxThCDt236xECKCr
   5Xst1Ii5rmtvdeOX4zKDMcjZUWezfcHkDCE6hJ5uSfoNLTn3TLHCHydKQ
   iBytLZxPLLrku6wT7G88unNcCVcc+sL3Zk1SGB42nJeixio/lQZXVffjw
   PaM9HT1iZDfNwwfAAJ0s6kCkE2LZlx29M2ImuJWDSX7KsKz08ccJNF9ac
   RiyGWauWIeIWeOnir2SoEG3qCbOo0Wwif9yloYtcVD4UoKCsSVE4UU6st
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10347"; a="252574080"
X-IronPort-AV: E=Sophos;i="5.91,226,1647327600"; 
   d="scan'208";a="252574080"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2022 07:30:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,226,1647327600"; 
   d="scan'208";a="740569057"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 14 May 2022 07:30:17 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npsme-0000jx-Bs;
        Sat, 14 May 2022 14:30:16 +0000
Date:   Sat, 14 May 2022 22:30:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [nsaenz-rpi:ct-work-defer-wip 25/25]
 arch/x86/mm/pat/set_memory.c:351:26: error: use of undeclared identifier
 'CONTEXT_WORK_CACHEI'
Message-ID: <202205142203.hnkoIxTp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git ct-work-defer-wip
head:   ed63029652239a6befad96dd473b16332913f889
commit: ed63029652239a6befad96dd473b16332913f889 [25/25] context_tracking,x86: Fix Kernel cachei vs NOHZ_FULL
config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20220514/202205142203.hnkoIxTp-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 38189438b69ca27b4c6ce707c52dbd217583d046)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git/commit/?id=ed63029652239a6befad96dd473b16332913f889
        git remote add nsaenz-rpi https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git
        git fetch --no-tags nsaenz-rpi ct-work-defer-wip
        git checkout ed63029652239a6befad96dd473b16332913f889
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/mm/pat/set_memory.c:351:6: error: use of undeclared identifier 'CONTEXT_WORK_TLBI'
                                           CONTEXT_WORK_TLBI | CONTEXT_WORK_CACHEI);
                                           ^
>> arch/x86/mm/pat/set_memory.c:351:26: error: use of undeclared identifier 'CONTEXT_WORK_CACHEI'
                                           CONTEXT_WORK_TLBI | CONTEXT_WORK_CACHEI);
                                                               ^
   arch/x86/mm/pat/set_memory.c:373:12: error: use of undeclared identifier 'CONTEXT_WORK_TLBI'
                                                 CONTEXT_WORK_TLBI);
                                                 ^
   3 errors generated.


vim +/CONTEXT_WORK_CACHEI +351 arch/x86/mm/pat/set_memory.c

   347	
   348	static bool __cpa_flush_all_cond(int cpu, void *info)
   349	{
   350		return !context_tracking_set_cpu_work(cpu, CONTEXT_USER | CONTEXT_GUEST,
 > 351						CONTEXT_WORK_TLBI | CONTEXT_WORK_CACHEI);
   352	}
   353	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
