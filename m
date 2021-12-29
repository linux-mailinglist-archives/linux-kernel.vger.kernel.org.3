Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5F6481446
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 15:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240454AbhL2O5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 09:57:09 -0500
Received: from mga02.intel.com ([134.134.136.20]:50682 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233681AbhL2O5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 09:57:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640789827; x=1672325827;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6ugdZcGIneaCYhIVRdRjyCv5QCbeHqw4trm5u9986oo=;
  b=XLEotPncHBtPIFYHjntK2VxBygvk8m28zyM1H34r1C+sVgNrxitIWPWI
   5RrGFidAtKAyFa5Rmc8CKcSKWRkpIwRsPITVL82zXV3/dcxHe9ejVD3aC
   7Swg96mSwdS7JOUGYFwzg30PvJweCF+3XwsMBCa1LniCefo4dsZ7NkaYR
   yiDu9NmNeTpeA2htVmIGuls2fWWCyUgx9gSYUSIzbDroIgsg49allyTtT
   3qrlwKbhFhmdRfFUuiq/tyG04ykVQ/IDg9Cw+dvSJg3rCbq9+MB6BzHv4
   EpY5LG8bDpD2smLDfn/1GMVOJ+JDlMWbTi+22Uc0xLw+1sibY+gtL4uv7
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="228834219"
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="228834219"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 06:57:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="619056640"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 29 Dec 2021 06:57:04 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2aO0-000939-AK; Wed, 29 Dec 2021 14:57:04 +0000
Date:   Wed, 29 Dec 2021 22:56:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [congwang:sch_bpf 3/3] ERROR: modpost: "qdisc_lookup_rcu"
 [net/sched/sch_bpf.ko] undefined!
Message-ID: <202112292229.XxqsKDIS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/congwang/linux.git sch_bpf
head:   5fb0da1e47e0c68da0323a3e0399b2628a13e999
commit: 5fb0da1e47e0c68da0323a3e0399b2628a13e999 [3/3] net_sched: introduce eBPF based Qdisc
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20211229/202112292229.XxqsKDIS-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/congwang/linux/commit/5fb0da1e47e0c68da0323a3e0399b2628a13e999
        git remote add congwang https://github.com/congwang/linux.git
        git fetch --no-tags congwang sch_bpf
        git checkout 5fb0da1e47e0c68da0323a3e0399b2628a13e999
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "qdisc_lookup_rcu" [net/sched/sch_bpf.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
