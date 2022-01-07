Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2C14873C1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 08:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345073AbiAGHtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 02:49:47 -0500
Received: from mga06.intel.com ([134.134.136.31]:59776 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235937AbiAGHtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 02:49:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641541786; x=1673077786;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WQa6IMqpwZPSAmXokM9OppP4lB6YOU8OOtGYA63eq18=;
  b=c8CTQn+TyfAjmYb6PSPHyGnisqiXrRFpALePeNlvXClh4YoByT1+Qr/U
   Y7qgrchrMJFW5hWw8S5w7OFCroS6lwTyEef5Pll1bRkDA2VuryARUi+3R
   1gOxV07jvO/pyxOQSrNE/ZGpLFti1f6zThixa4OE9adDhrGejZcicCj09
   ftZ4Nvu0Jr9tIFygj2X/luQqEP6ONsuKj5zU1+sCQCptWo2RxUxP34kTF
   zHC8pqE2yEYXgtEmHdYPXjKcB1qLBfLyCATEg4qy64QGWGiCx3/Q84nvT
   cm4c6/6YCTxwzAcRr3FfkliyH51ag8a+JU9kw8hhUfaZxfUP1w4f4i802
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="303572004"
X-IronPort-AV: E=Sophos;i="5.88,269,1635231600"; 
   d="scan'208";a="303572004"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 23:49:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,269,1635231600"; 
   d="scan'208";a="527291732"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 06 Jan 2022 23:49:44 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5k0O-000IQL-2N; Fri, 07 Jan 2022 07:49:44 +0000
Date:   Fri, 7 Jan 2022 15:49:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:paulmck/linux-rcu/dev 50/53]
 kernel/time/tick-sched.c:1453:1: sparse: sparse: symbol
 '__pcpu_scope_tick_setup_sched_timer_help_needed' was not declared. Should
 it be static?
Message-ID: <202201071509.qlXBeLQz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev
head:   56b8a9dc5e8aa4d625a09ce87015016ae339d44d
commit: 3cda34a0004e965b08daf04fb0f2cee935654e9f [50/53] EXP timers: Non-nohz_full last-resort jiffies update on IRQ entry
config: i386-randconfig-s001-20220107 (https://download.01.org/0day-ci/archive/20220107/202201071509.qlXBeLQz-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/3cda34a0004e965b08daf04fb0f2cee935654e9f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/dev
        git checkout 3cda34a0004e965b08daf04fb0f2cee935654e9f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash kernel/time/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/time/tick-sched.c:1453:1: sparse: sparse: symbol '__pcpu_scope_tick_setup_sched_timer_help_needed' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
