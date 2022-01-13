Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43B248DFD1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 22:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbiAMVnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 16:43:11 -0500
Received: from mga07.intel.com ([134.134.136.100]:16217 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230120AbiAMVnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 16:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642110185; x=1673646185;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FkzJxU06BaeE41N535TbwXgQJ/WvGd3kIpongqJ3CfI=;
  b=fC5CIHKWsrDErN0IyRcIEX7U9L4B/V0Qw3StAYzEgp5T6zaE5guGExM6
   26uAquryle84UilXQ7atDjp1ASNsYxtDhm/X81NJ2JS12TTC+FLgHTeNl
   PYgMKrsYx/i7h5MkSt2KOD+UcARX8Yfp9rUKlD/e7SlIQ/54mw5TC3JRh
   JuPsndeDVhejG3zXtLuu3XJLiyR0zABW7z2tiBve4eLZ9kYnIJ57JkHNz
   10beJdZjzj6D0rNOBEcu5lgjNol/zXH8JjiB+ANdXTHKfWlLW4UEYGPFu
   PjWgKr1hmkE5zTUv1O2YP+okrVMXuWH2eHHhvj8pz1RQBrcsbPqTsaGoI
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="307462703"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="307462703"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 13:43:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="691955160"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 13 Jan 2022 13:43:04 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n87s7-0007fV-Bm; Thu, 13 Jan 2022 21:43:03 +0000
Date:   Fri, 14 Jan 2022 05:42:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 102/2382] ./usr/include/asm-generic/shmbuf.h:7:10:
 fatal error: uapi/asm-generic/ipcbuf.h: No such file or directory
Message-ID: <202201140535.NYurNe6f-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   1a880941a087613ed42f77001229edfcf75ea8a5
commit: bfc9d5c126bd10a654139934f14575c9b4f627ae [102/2382] headers/deps: Remove <linux/sem.h> from <linux/sched.h>
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220114/202201140535.NYurNe6f-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=bfc9d5c126bd10a654139934f14575c9b4f627ae
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout bfc9d5c126bd10a654139934f14575c9b4f627ae
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from ./usr/include/asm/shmbuf.h:6,
                    from ./usr/include/linux/shm.h:26,
                    from <command-line>:32:
>> ./usr/include/asm-generic/shmbuf.h:7:10: fatal error: uapi/asm-generic/ipcbuf.h: No such file or directory
       7 | #include <uapi/asm-generic/ipcbuf.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
