Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735C44D6C1E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 03:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiCLCuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 21:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiCLCuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 21:50:14 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC2411B5ED
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 18:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647053349; x=1678589349;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=R0DDQeh5n1eKIZRB8ja0lP32SSnFOHfvnUG7+NokNh8=;
  b=NdQY0Ermfci7qP0xowcEcLX2h3foiYNemgxU0VWqoZyYHOC6bJSIArk4
   fbIg7BCbl1N53U1V/1Us/5g57iRP6WcaKYYpsnSM7OTwxipTNP5DP6Kff
   YVX8E/2PMU3mLrPteWkA8UnfEPfgm0lYVz02L2T9aC7iOrJlRIfD1kbJZ
   fzCeLjpOHT7dttchox8JTN6RnoETDSL4K6OH1snU3LqtRfAcNPaKAbSE0
   bJpQGOjm7lnleeBJXyOZ0EKMtSNdIwL+5x8x4UwqGHCMKV3Q1oLIga/cI
   N29jlR9CtOuP5V1/DYoZKLZxrn61OhnDJ85y/u0xT88DxK3qVAAgEoU7E
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="236325635"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="236325635"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 18:49:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="511596133"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 11 Mar 2022 18:49:07 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSroY-0007Qh-Vn; Sat, 12 Mar 2022 02:49:06 +0000
Date:   Sat, 12 Mar 2022 10:48:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:crng/random/jd/vmid-poll 61/61]
 drivers/char/random.c:1182:17: error: implicit declaration of function
 'proc_sys_poll_notify'; did you mean 'proc_sys_poll_event'?
Message-ID: <202203121041.K4onshgj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block crng/random/jd/vmid-poll
head:   28f8622d20d2c090711dbb8bee93bd00a8bc0cd6
commit: 28f8622d20d2c090711dbb8bee93bd00a8bc0cd6 [61/61] random: add vm_id sysctl for polling
config: ia64-randconfig-r016-20220310 (https://download.01.org/0day-ci/archive/20220312/202203121041.K4onshgj-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/28f8622d20d2c090711dbb8bee93bd00a8bc0cd6
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/jd/vmid-poll
        git checkout 28f8622d20d2c090711dbb8bee93bd00a8bc0cd6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/char/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/ia64/include/asm/pgtable.h:153,
                    from include/linux/pgtable.h:6,
                    from arch/ia64/include/asm/uaccess.h:40,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/poll.h:10,
                    from drivers/char/random.c:38:
   arch/ia64/include/asm/mmu_context.h: In function 'reload_context':
   arch/ia64/include/asm/mmu_context.h:127:48: warning: variable 'old_rr4' set but not used [-Wunused-but-set-variable]
     127 |         unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
         |                                                ^~~~~~~
   drivers/char/random.c: In function 'add_vmfork_randomness':
>> drivers/char/random.c:1182:17: error: implicit declaration of function 'proc_sys_poll_notify'; did you mean 'proc_sys_poll_event'? [-Werror=implicit-function-declaration]
    1182 |                 proc_sys_poll_notify(&sysctl_vmid_poll);
         |                 ^~~~~~~~~~~~~~~~~~~~
         |                 proc_sys_poll_event
   cc1: some warnings being treated as errors


vim +1182 drivers/char/random.c

  1167	
  1168	/*
  1169	 * Handle a new unique VM ID, which is unique, not secret, so we
  1170	 * don't credit it, but we do immediately force a reseed after so
  1171	 * that it's used by the crng posthaste.
  1172	 */
  1173	void add_vmfork_randomness(const void *unique_vm_id, size_t size)
  1174	{
  1175		add_device_randomness(unique_vm_id, size);
  1176		if (crng_ready()) {
  1177			crng_reseed(true);
  1178			pr_notice("crng reseeded due to virtual machine fork\n");
  1179		}
  1180		blocking_notifier_call_chain(&vmfork_chain, 0, NULL);
  1181		if (IS_ENABLED(CONFIG_SYSCTL))
> 1182			proc_sys_poll_notify(&sysctl_vmid_poll);
  1183	}
  1184	#if IS_MODULE(CONFIG_VMGENID)
  1185	EXPORT_SYMBOL_GPL(add_vmfork_randomness);
  1186	#endif
  1187	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
