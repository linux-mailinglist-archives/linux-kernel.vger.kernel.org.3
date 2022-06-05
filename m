Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFF453DE93
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 00:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351619AbiFEWOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 18:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235909AbiFEWOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 18:14:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14D24A3C9
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 15:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654467240; x=1686003240;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CctuFE2R2ZyK67GiYVfDjlk6qASqOTichirYJ8V+u6E=;
  b=TW1v4lRWifYLMUOVIqrlh3WWRPgvw9/WVADRp3YQqNw0GpCBaYyfYzJu
   fqyBzZYRkB0AqK0NZRvHKBajGTSnM8DokJLEXST4sojD+BEegiP3G168G
   2t4Wj2+W3cmHduN1HTdEnyBA3l7SACeFP2nN9CmBudk3SRmWko3Qaipfe
   aiA0pquem2JMtCDtn69bSM0XyNHlRxk10SueIDXUrpzgUroLkUykCJOYY
   Fq4YSVCf8IRH195heyESYJFcf5wxmIEeNcTdmqiMCC1Il4LCOWxd7TOKu
   46o09m1m4I9Hzcp0WjbuECxNrCrcyyLMh0thRDCbYlIXw/zYwSgt2RmBA
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="276408942"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="276408942"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 15:14:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="614070982"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 05 Jun 2022 15:13:59 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxyVS-000CIC-Fi;
        Sun, 05 Jun 2022 22:13:58 +0000
Date:   Mon, 6 Jun 2022 06:13:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [peterz-queue:sched/idle 15/37] kernel/time/tick-broadcast.c:627:9:
 error: call to undeclared function 'arch_test_bit'; ISO C99 and later do not
 support implicit function declarations
Message-ID: <202206060612.7U4QNOzX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/idle
head:   e11e56428f57b36930eb0f8eed997a462010aa95
commit: b581e362d475d40edb2d1099d19a8e12721e7734 [15/37] cpuidle: Fix rcu_idle_*() usage
config: hexagon-randconfig-r024-20220605 (https://download.01.org/0day-ci/archive/20220606/202206060612.7U4QNOzX-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 416a5080d89066029f9889dc23f94de47c2fa895)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=b581e362d475d40edb2d1099d19a8e12721e7734
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue sched/idle
        git checkout b581e362d475d40edb2d1099d19a8e12721e7734
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/time/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/time/tick-broadcast.c:627:9: error: call to undeclared function 'arch_test_bit'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           return arch_test_bit(smp_processor_id(), cpumask_bits(tick_broadcast_force_mask));
                  ^
   kernel/time/tick-broadcast.c:627:9: note: did you mean '__test_bit'?
   arch/hexagon/include/asm/bitops.h:161:19: note: '__test_bit' declared here
   static inline int __test_bit(int nr, const volatile unsigned long *addr)
                     ^
   1 error generated.


vim +/arch_test_bit +627 kernel/time/tick-broadcast.c

   617	
   618	/*
   619	 * Called before going idle with interrupts disabled. Checks whether a
   620	 * broadcast event from the other core is about to happen. We detected
   621	 * that in tick_broadcast_oneshot_control(). The callsite can use this
   622	 * to avoid a deep idle transition as we are about to get the
   623	 * broadcast IPI right away.
   624	 */
   625	noinstr int tick_check_broadcast_expired(void)
   626	{
 > 627		return arch_test_bit(smp_processor_id(), cpumask_bits(tick_broadcast_force_mask));
   628	}
   629	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
