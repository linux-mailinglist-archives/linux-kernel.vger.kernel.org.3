Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7341254790F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 07:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbiFLF7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 01:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiFLF7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 01:59:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387AE60BAB
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 22:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655013539; x=1686549539;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JvuE46RlP1v/SThWWDPDAPBjmBvcAgsLTB8hiK3rSIc=;
  b=Rcm29f15zAu07KzZ1ZD3PRfJbbJ2PiRgCu0+qSM58FN3RDcHvdEMEdTe
   xNxxeQrd57hs+aKx1A/BazRfxnGJ/TutlGg0dErmUpVd/R5Dogu6uWeAf
   sq5K6WWS9x8itKyLhrjVLxRwNrzZrghMzzdzZDON6xmkF5QWhS5jtuNXf
   SzmJNEboKSgwCBh/cM9kXZWii0xfaKEkRauWAJshpPTgglKacLCD1V176
   eNPyJDNDbgWKZ1dJzJXspjbzJhm9PIhPNrLgYF909vdAPBmWl9IV6g+DZ
   L/ugMeAZll+N2ZvmwljL7KrJS3xXruuZiJrbaLhm/Xo1q/zWHNmuIJrS9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="261062119"
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="261062119"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 22:58:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="672664733"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jun 2022 22:58:57 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0Gci-000JeJ-IZ;
        Sun, 12 Jun 2022 05:58:56 +0000
Date:   Sun, 12 Jun 2022 13:58:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [rt-devel:linux-5.19.y-rt-rebase 16/51] kernel/softirq.c:641:1:
 sparse: sparse: symbol '__pcpu_scope_pending_timer_softirq' was not
 declared. Should it be static?
Message-ID: <202206121359.nWdmw9Ww-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-5.19.y-rt-rebase
head:   2a0438f3107478348ce5a998e511c82f0f32316e
commit: 6695684acc6e0ab2b0a84ae59933797a0e148afc [16/51] tick: Fix timer storm since introduction of timersd
config: sparc64-randconfig-s032-20220612 (https://download.01.org/0day-ci/archive/20220612/202206121359.nWdmw9Ww-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-30-g92122700-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?id=6695684acc6e0ab2b0a84ae59933797a0e148afc
        git remote add rt-devel https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
        git fetch --no-tags rt-devel linux-5.19.y-rt-rebase
        git checkout 6695684acc6e0ab2b0a84ae59933797a0e148afc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   kernel/softirq.c:640:1: sparse: sparse: symbol '__pcpu_scope_timersd' was not declared. Should it be static?
>> kernel/softirq.c:641:1: sparse: sparse: symbol '__pcpu_scope_pending_timer_softirq' was not declared. Should it be static?

vim +/__pcpu_scope_pending_timer_softirq +641 kernel/softirq.c

   639	
   640	DEFINE_PER_CPU(struct task_struct *, timersd);
 > 641	DEFINE_PER_CPU(unsigned long, pending_timer_softirq);
   642	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
