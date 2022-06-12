Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CED8547879
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 06:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbiFLESA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 00:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiFLER6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 00:17:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187F454023
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 21:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655007477; x=1686543477;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xYTF9xrekhEG/loqk93CTSpre1JqjkwroBtQhH4zffE=;
  b=Ke0cbbJEuk8LFbNzkvih4rWxQycIClfhmn3ATk3T2szJb1fF6bWsMMAa
   TnBy9WgomrRLP0fPWT96n5Ma4FmDxOZCechfm+QOfKcXWklWqgOXCODeG
   erBAuxo8uxvOALvrlFjdSf6/eD9DXm49SqoCgxUHjonZtjx7/DSze1wXm
   1NW0+xRaI7Ey6LL6/FJ8J0ltG/MTS0P1pUR4YqqUaXG12J5A/5BltaiPK
   zsNQoO4PrGs3BJXgSuI6s1cXn7xPN+lHbEBVk2Yh7qAoORGS8RVnZ+YKh
   RlxGaiR/FYSq2fq40uLITMC2rkc2apFOTNtQXi6BDh8lq5fid/O8FFmXB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="258422392"
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="258422392"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 21:17:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="534633461"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 Jun 2022 21:17:55 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0F2w-000Jaz-H8;
        Sun, 12 Jun 2022 04:17:54 +0000
Date:   Sun, 12 Jun 2022 12:17:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [rt-devel:linux-5.19.y-rt-rebase 15/51] kernel/softirq.c:640:1:
 sparse: sparse: symbol '__pcpu_scope_timersd' was not declared. Should it be
 static?
Message-ID: <202206121239.4M5FVUYK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-5.19.y-rt-rebase
head:   2a0438f3107478348ce5a998e511c82f0f32316e
commit: 7c45ac654e3ff9d9e629823c40813117bb6968ff [15/51] rcutorture: Also force sched priority to timersd on boosting test.
config: sparc64-randconfig-s032-20220612 (https://download.01.org/0day-ci/archive/20220612/202206121239.4M5FVUYK-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-30-g92122700-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?id=7c45ac654e3ff9d9e629823c40813117bb6968ff
        git remote add rt-devel https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
        git fetch --no-tags rt-devel linux-5.19.y-rt-rebase
        git checkout 7c45ac654e3ff9d9e629823c40813117bb6968ff
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/softirq.c:640:1: sparse: sparse: symbol '__pcpu_scope_timersd' was not declared. Should it be static?

vim +/__pcpu_scope_timersd +640 kernel/softirq.c

   639	
 > 640	DEFINE_PER_CPU(struct task_struct *, timersd);
   641	static DEFINE_PER_CPU(unsigned long, pending_timer_softirq);
   642	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
