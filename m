Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CE14B3E0A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 23:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238623AbiBMWdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 17:33:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238608AbiBMWdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 17:33:19 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26625468F
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 14:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644791593; x=1676327593;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=971JhnVBoFb6X05hqx76zRjjoZWkClyuYbSZUvxRits=;
  b=eTNa1b5fmMQRhr/EdE4JkgPIuCEQMpap0MuXjNakfUclbSx/kcZddV9u
   DeuslmASVv3SwjmiAD5UPCwZC+eytK6U3KSBVWH+Fe44QNPeGvYd2EZBP
   gLm0zsX+0EEOmLFc1zTuI3hGgq7VHxgLDj6fVo64sPH37IO/H+F7C8/dx
   cBxgNkIuFu2To2D7DBb+ZagqCOrjyYDTyaWusHkLPkMFqiFSzdHypdevU
   8teYUiKCUbY4B6jDEBfNzGdbodXePxheyIX6UDYCGXBJwASPH2oir58F7
   +WD2G6ZMMSa4kCOv22vOb+FSLHrfSmd41hY1/uFvA+ZYOjQEmKnaGoe8+
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="249925016"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="249925016"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 14:33:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="569714200"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Feb 2022 14:33:11 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJNQc-0007vG-La; Sun, 13 Feb 2022 22:33:10 +0000
Date:   Mon, 14 Feb 2022 06:32:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: mm/memcontrol.c:2774:20: error: unused function 'cancel_charge'
Message-ID: <202202140629.MxlIbXOG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   754e0b0e35608ed5206d6a67a791563c631cec07
commit: 58056f77502f3567b760c9a8fc8d2e9081515b2d memcg, kmem: further deprecate kmem.limit_in_bytes
date:   3 months ago
config: arm-randconfig-r005-20220213 (https://download.01.org/0day-ci/archive/20220214/202202140629.MxlIbXOG-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project ea071884b0cc7210b3cc5fe858f0e892a779a23b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=58056f77502f3567b760c9a8fc8d2e9081515b2d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 58056f77502f3567b760c9a8fc8d2e9081515b2d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> mm/memcontrol.c:2774:20: error: unused function 'cancel_charge' [-Werror,-Wunused-function]
   static inline void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
                      ^
   mm/memcontrol.c:3339:19: error: unused function 'mem_cgroup_move_swap_account' [-Werror,-Wunused-function]
   static inline int mem_cgroup_move_swap_account(swp_entry_t entry,
                     ^
   2 errors generated.


vim +/cancel_charge +2774 mm/memcontrol.c

  2773	
> 2774	static inline void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
  2775	{
  2776		if (mem_cgroup_is_root(memcg))
  2777			return;
  2778	
  2779		page_counter_uncharge(&memcg->memory, nr_pages);
  2780		if (do_memsw_account())
  2781			page_counter_uncharge(&memcg->memsw, nr_pages);
  2782	}
  2783	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
