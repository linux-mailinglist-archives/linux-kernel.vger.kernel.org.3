Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEABC529D1B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241910AbiEQI7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiEQI7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:59:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5892ED6E
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652777955; x=1684313955;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7Wo6oyge8N+FYzZ6w1cZPEwxqDK5QUTR67FkSmdctNM=;
  b=KP6Q//bf6kNH2cSmEmDAE2yD5EvoFjl2JJ6PH6x3xLRMRssHLXC87DXV
   RIXM/bC8Zj7Y/Z9eknTT0Oy9NQNvkFhFUYwFCmRB86BKupiBk6eqvM7Yj
   y4v77RE9olP0T0S2zO1utkkakS50Qa9ijpxCx8+eh/m+b7x7Wk8nla0RX
   fjGBmJOBBJVDKUXBF/u7KUwHagkQCD/v6ahQe5wU2rPT0n8ho2sgcpXOJ
   jsvRChUNiUJHYTOaYj51k4SZP2iy7qVB7eloNksGVALlE4kPMsAXRAWiO
   xWteAOEGtaqHid6e9Bl9VEW3GuTD66HhTh8eQvFgW8Oa1FZ2bIsrM8Z3p
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="296392658"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="296392658"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 01:59:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="574422112"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 17 May 2022 01:59:14 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqt2v-0000mF-Nm;
        Tue, 17 May 2022 08:59:13 +0000
Date:   Tue, 17 May 2022 16:58:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [rt-devel:linux-5.18.y-rt-rebase 54/94] kernel/softirq.c:640:1:
 sparse: sparse: symbol '__pcpu_scope_timersd' was not declared. Should it be
 static?
Message-ID: <202205171631.KEPyrRtL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-5.18.y-rt-rebase
head:   df0c990058a5bce1eed5d3512c6efe4eacc62bed
commit: 191f7764ab356da2cb7fc1a216b56b6ec0405f04 [54/94] rcutorture: Also force sched priority to timersd on boosting test.
config: i386-randconfig-s002-20220516 (https://download.01.org/0day-ci/archive/20220517/202205171631.KEPyrRtL-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?id=191f7764ab356da2cb7fc1a216b56b6ec0405f04
        git remote add rt-devel https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
        git fetch --no-tags rt-devel linux-5.18.y-rt-rebase
        git checkout 191f7764ab356da2cb7fc1a216b56b6ec0405f04
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
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
