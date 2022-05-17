Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C37C52ADB7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 23:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiEQV7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 17:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiEQV7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 17:59:05 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98C24B1D0
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652824744; x=1684360744;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/pJlWhY/khFLyPEJmOzUml3LUIYyj5VhrnvmwnmacYM=;
  b=H3kEYWGY3AJvWzFqc4xr6h+IVwbSDIARq++0SHMKfddDqonE0fnSgz6P
   FcUoxtVuqQjbmQejPncR1fcCK2eF4gfxT1VAZhF+MLEksgsY74IA7W4+9
   MkICvA5EqmiMqW3sRySGaaPzcKLgSeACt7rDnRk2UOiUz6Lwlr8sqCpZd
   zJdND6LwenrEwunW811w84+/8jn7Wj9hW6mxRD0S6pV/tdC9/6a7eEaQi
   m+rTB95kIA87aRU7KtOjzg0H+c+jxupJzLbQHNrAOiPyE1dsFlF6G7XT3
   quc6NNWo0CkuvGWbXev2lEkFRSLccAElEeVxF2YyVoFoGygtuTPg3warf
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="251863311"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="251863311"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 14:59:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="545107471"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 17 May 2022 14:59:03 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nr5Da-0001Tp-DR;
        Tue, 17 May 2022 21:59:02 +0000
Date:   Wed, 18 May 2022 05:58:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [rt-devel:linux-5.18.y-rt-rebase 55/94] kernel/softirq.c:641:1:
 sparse: sparse: symbol '__pcpu_scope_pending_timer_softirq' was not
 declared. Should it be static?
Message-ID: <202205180539.k0x6jZJq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-5.18.y-rt-rebase
head:   df0c990058a5bce1eed5d3512c6efe4eacc62bed
commit: e9b4bc6bcdfacbbe8125749a6135af2e61a3476c [55/94] tick: Fix timer storm since introduction of timersd
config: i386-randconfig-s002-20220516 (https://download.01.org/0day-ci/archive/20220518/202205180539.k0x6jZJq-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?id=e9b4bc6bcdfacbbe8125749a6135af2e61a3476c
        git remote add rt-devel https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
        git fetch --no-tags rt-devel linux-5.18.y-rt-rebase
        git checkout e9b4bc6bcdfacbbe8125749a6135af2e61a3476c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   kernel/softirq.c:640:1: sparse: sparse: symbol '__pcpu_scope_timersd' was not declared. Should it be static?
>> kernel/softirq.c:641:1: sparse: sparse: symbol '__pcpu_scope_pending_timer_softirq' was not declared. Should it be static?

Please review and possibly fold the followup patch.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
