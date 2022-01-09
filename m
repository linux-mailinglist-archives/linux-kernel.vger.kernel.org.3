Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65BDD488711
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 01:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbiAIAOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 19:14:16 -0500
Received: from mga09.intel.com ([134.134.136.24]:46508 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230433AbiAIAOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 19:14:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641687256; x=1673223256;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nOzIpnj/3fn8ZPIeteqMUZyZN/pDtF7sbD403qb50A0=;
  b=crTfL6WxKq9z6gVP1De34fu493/8emCSjcXTr07s9u99BhyuTJn1LyUl
   QuQr8dZC/y9GsOYRmQxHQDYjfrgs4WrG/xz1kU0EShSLc5U9k/EqU20BU
   3AAmm3GeXTSCakcyGZjRXnW7+VdJTSi9e+l+ji6UQfwPpPmvDaNM1gEQb
   BW1m7rKzLNMNwizLae78ipDkcW+2O4nO+Cmo/WDqwK6SzR4LcEo5gHKxH
   w1PvsIaPwi70k+gyBUqkXjyjvL6p7FnC3Rfe8kzKfdkckOvKZeJgy3DPZ
   H9pVgG4Oul+JtuD/F6Z/HNcHee0Zknt8mQ3QxoyFm9PWH2mNrmOoFFEst
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10221"; a="242843982"
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="242843982"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 16:14:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="690182760"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 Jan 2022 16:14:14 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6Lqf-0001CP-Pw; Sun, 09 Jan 2022 00:14:13 +0000
Date:   Sun, 9 Jan 2022 08:14:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 920/2375] ./usr/include/linux/kcm.h:18:10:
 fatal error: 'uapi/linux/sockios.h' file not found
Message-ID: <202201090844.Mu25XN32-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   351ceeab2ef96ab2fc306934ddb201b44636181b
commit: fbfff3a144bbd21e3878f580b3e14e47b663f9de [920/2375] headers/deps: Add header dependencies to .h files: <uapi/linux/sockios.h>
config: i386-randconfig-r031-20220108 (https://download.01.org/0day-ci/archive/20220109/202201090844.Mu25XN32-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f3a344d2125fa37e59bae1b0874442c650a19607)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=fbfff3a144bbd21e3878f580b3e14e47b663f9de
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout fbfff3a144bbd21e3878f580b3e14e47b663f9de
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/linux/kcm.h:18:10: fatal error: 'uapi/linux/sockios.h' file not found
   #include <uapi/linux/sockios.h>
            ^~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
--
   In file included from <built-in>:1:
>> ./usr/include/linux/rds.h:38:10: fatal error: 'uapi/linux/sockios.h' file not found
   #include <uapi/linux/sockios.h>
            ^~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
--
   In file included from <built-in>:1:
>> ./usr/include/linux/x25.h:15:10: fatal error: 'uapi/linux/sockios.h' file not found
   #include <uapi/linux/sockios.h>
            ^~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
--
   In file included from <built-in>:1:
>> ./usr/include/linux/if_tunnel.h:5:10: fatal error: 'uapi/linux/sockios.h' file not found
   #include <uapi/linux/sockios.h>
            ^~~~~~~~~~~~~~~~~~~~~~
   1 error generated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
