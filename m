Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7FB508553
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377409AbiDTKBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377387AbiDTKBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:01:05 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49803BF93
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 02:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650448699; x=1681984699;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QsVDzCgMMO62z5IJ4j+AqCI92gDvYnLj4qqbwiAS8nY=;
  b=Jne9VVNXaWdgUc9UX0A6205WgsfBviP801Zi73yaGydtdHY29aI9F1Nf
   05QvenDfTK5Co93VRs3VEQGsvT0ZskAR428b4RJ90rBpPHoEZd488wuCX
   0HDA6GZYi29KtlSEYoeBQv54DTAM/nN4n7Fh6YJ0Chx4BagrkoyOEdoZR
   PZSraohhBxxncmiUeXljEYIoru+cFaF5Nh39gNbwSU+jT+H4WoC0p+7cW
   Ry0vvbb7AAcdjfWMg873gOigS+hKRT8PcLhAHpvo4wvuKYKCDC1WtcynP
   a8oV2vzEjCeOMwmQe5n+vU5/ldYg9fsXIPJq30EXGETn+lEJrLA7t5JCQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="251296712"
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="251296712"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 02:58:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="658003739"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 20 Apr 2022 02:58:17 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nh76G-0006r0-J5;
        Wed, 20 Apr 2022 09:58:16 +0000
Date:   Wed, 20 Apr 2022 17:57:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: [ammarfaizi2-block:paulmck/linux-rcu/dev 28/28]
 kernel/rcu/tree_nocb.h:1213:3: warning: misleading indentation; statement is
 not part of the previous 'if'
Message-ID: <202204201732.oTzYh0Xo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev
head:   ad68d8bf085421e4f22731c8b64c0b774a154e06
commit: ad68d8bf085421e4f22731c8b64c0b774a154e06 [28/28] rcu/nocb: Add an option to offload all CPUs on boot
config: riscv-randconfig-r024-20220420 (https://download.01.org/0day-ci/archive/20220420/202204201732.oTzYh0Xo-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/ad68d8bf085421e4f22731c8b64c0b774a154e06
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/dev
        git checkout ad68d8bf085421e4f22731c8b64c0b774a154e06
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/rcu/tree.c:5031:
>> kernel/rcu/tree_nocb.h:1213:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                   offload_all = false; /* NO_HZ_FULL has its own mask. */
                   ^
   kernel/rcu/tree_nocb.h:1211:2: note: previous statement is here
           if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
           ^
   kernel/rcu/tree_nocb.h:1198:6: warning: unused variable 'cpu' [-Wunused-variable]
           int cpu;
               ^
   kernel/rcu/tree_nocb.h:1199:7: warning: variable 'need_rcu_nocb_mask' set but not used [-Wunused-but-set-variable]
           bool need_rcu_nocb_mask = false;
                ^
   kernel/rcu/tree_nocb.h:1200:7: warning: variable 'offload_all' set but not used [-Wunused-but-set-variable]
           bool offload_all = false;
                ^
   kernel/rcu/tree_nocb.h:1201:19: warning: unused variable 'rdp' [-Wunused-variable]
           struct rcu_data *rdp;
                            ^
   kernel/rcu/tree_nocb.h:1217:2: error: expected identifier or '('
           if (need_rcu_nocb_mask) {
           ^
   kernel/rcu/tree_nocb.h:1227:2: error: expected identifier or '('
           if (!rcu_state.nocb_is_setup)
           ^
   kernel/rcu/tree_nocb.h:1231:2: error: expected identifier or '('
           if (tick_nohz_full_running)
           ^
   kernel/rcu/tree_nocb.h:1235:2: error: expected identifier or '('
           if (offload_all)
           ^
   kernel/rcu/tree_nocb.h:1238:2: error: expected identifier or '('
           if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
           ^
   kernel/rcu/tree_nocb.h:1243:2: error: expected identifier or '('
           if (cpumask_empty(rcu_nocb_mask))
           ^
   kernel/rcu/tree_nocb.h:1245:2: error: expected identifier or '('
           else
           ^
   kernel/rcu/tree_nocb.h:1248:2: error: expected identifier or '('
           if (rcu_nocb_poll)
           ^
   kernel/rcu/tree_nocb.h:1251:2: error: expected identifier or '('
           for_each_cpu(cpu, rcu_nocb_mask) {
           ^
   include/linux/cpumask.h:276:2: note: expanded from macro 'for_each_cpu'
           for ((cpu) = -1;                                \
           ^
   In file included from kernel/rcu/tree.c:5031:
   kernel/rcu/tree_nocb.h:1259:2: error: type specifier missing, defaults to 'int' [-Werror,-Wimplicit-int]
           rcu_organize_nocb_kthreads();
           ^
   kernel/rcu/tree_nocb.h:1259:28: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
           rcu_organize_nocb_kthreads();
                                     ^
                                      void
   kernel/rcu/tree_nocb.h:1259:2: error: conflicting types for 'rcu_organize_nocb_kthreads'
           rcu_organize_nocb_kthreads();
           ^
   kernel/rcu/tree.h:463:20: note: previous declaration is here
   static void __init rcu_organize_nocb_kthreads(void);
                      ^
   In file included from kernel/rcu/tree.c:5031:
   kernel/rcu/tree_nocb.h:1260:1: error: extraneous closing brace ('}')
   }
   ^
   5 warnings and 13 errors generated.


vim +/if +1213 kernel/rcu/tree_nocb.h

  1209	
  1210	#if defined(CONFIG_NO_HZ_FULL)
  1211		if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
  1212			need_rcu_nocb_mask = true;
> 1213			offload_all = false; /* NO_HZ_FULL has its own mask. */
  1214		}
  1215	#endif /* #if defined(CONFIG_NO_HZ_FULL) */
  1216	
  1217		if (need_rcu_nocb_mask) {
  1218			if (!cpumask_available(rcu_nocb_mask)) {
  1219				if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
  1220					pr_info("rcu_nocb_mask allocation failed, callback offloading disabled.\n");
  1221					return;
  1222				}
  1223			}
  1224			rcu_state.nocb_is_setup = true;
  1225		}
  1226	
  1227		if (!rcu_state.nocb_is_setup)
  1228			return;
  1229	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
