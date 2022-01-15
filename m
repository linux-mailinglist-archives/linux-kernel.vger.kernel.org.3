Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699ED48F633
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 10:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbiAOJow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 04:44:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:64836 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231547AbiAOJov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 04:44:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642239891; x=1673775891;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3QND4MUyY31lpyay/oy3VT0yoSi/k/xi8c5d8hhWzIE=;
  b=KQME24mZDCmNmwxaiPYsoFzPHRf2wrjiIZ8tPgcyXKKQv6lWUFcMeP/p
   VzFGUJxZ+vtfU7KRZ1kJ9+GYjAQ6TVZXt+GxwkqGO0rmh28F7p4tvzwCH
   GdajYGE40gFfal6q6FMOthkNAwuYQDAONrW5RmUZBTWGl6OLcly490jdH
   P9IiwrCcGsKg6OlBaZz5FnV4Bp/lfytCpt0nnkHjF2jXToLDI9BKAYBvz
   6rs4edi6xdmQfxdrLoYG5QreYAnL3Ye10eEQry/G5OukIMjWVRdqBzTfd
   QTxJi+zxY6yED8G1K8Zq1vM0K2evYALvzEKsTwtDml9tXb8HIkbK58gG4
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="307739413"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="307739413"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2022 01:44:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="692530403"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 15 Jan 2022 01:44:50 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8fc9-0009ba-CT; Sat, 15 Jan 2022 09:44:49 +0000
Date:   Sat, 15 Jan 2022 17:44:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1593/2384]
 ./usr/include/linux/if_bonding.h:47:10: fatal error: 'uapi/linux/sockios.h'
 file not found
Message-ID: <202201151716.5dWSky8j-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   4c707c1c0de83967079b4e385012fa5b00e2cd11
commit: eb4b43a3bb224895dcd3976b63def55ee42203f5 [1593/2384] headers/deps: net: Optimize the header dependencies of <uapi/linux/if_bonding.h>
config: i386-randconfig-a006 (https://download.01.org/0day-ci/archive/20220115/202201151716.5dWSky8j-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d1021978b8e7e35dcc30201ca1731d64b5a602a8)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=eb4b43a3bb224895dcd3976b63def55ee42203f5
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout eb4b43a3bb224895dcd3976b63def55ee42203f5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/linux/if_bonding.h:47:10: fatal error: 'uapi/linux/sockios.h' file not found
   #include <uapi/linux/sockios.h>
            ^~~~~~~~~~~~~~~~~~~~~~
   1 error generated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
