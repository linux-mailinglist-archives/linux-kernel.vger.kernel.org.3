Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B58D48F48F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 04:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbiAOD1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 22:27:41 -0500
Received: from mga01.intel.com ([192.55.52.88]:26922 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232240AbiAOD1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 22:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642217260; x=1673753260;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KtX/m3iD5cCcMBA/Oy+QXSR/jnlYUIePE33O64k+zp0=;
  b=SK9WrSw5LtzZoDnN46UHchSfkqG4LNpvmsgTEtusUrIWIqKizI3P88xG
   FeY52su9o5ayDfTvc5NOmuCl7pFWf9/7pugprZ/vYGynSS6NYQ9JR/OnV
   /FKbusaS3teGx7ZckEgI2uFSLWdyBLlOnDQNXQm1VIAmAO5KWG7+XDd2f
   ul2e2LOo0GhlEBGg+Q5fZG2RJ64ILhGrBRWpkQYZUH1Xs3MZVYEnoZq5j
   Me0yepzS6N3CsEfgciScr7ZGJTPDVHzrndGAR1FpLosHRlYu/TUxzUH55
   3hSXLFDSqRz7yk7qrIqjK5KAxSCyZa9rvleISm+7C0KJGbA5O9xJCMRgv
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="268742613"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="268742613"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 19:27:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="475999001"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Jan 2022 19:27:38 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8Zj8-0009Ke-8j; Sat, 15 Jan 2022 03:27:38 +0000
Date:   Sat, 15 Jan 2022 11:27:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1559/2384]
 ./usr/include/linux/socket.h:5:10: fatal error: 'uapi/linux/socket_types.h'
 file not found
Message-ID: <202201151153.jUgRmbQJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   4c707c1c0de83967079b4e385012fa5b00e2cd11
commit: 4d279aea908260eca25d06d817422f7b820a790f [1559/2384] headers/deps: net: Split <linux/socket_types.h> out of <linux/socket.h>
config: i386-randconfig-a006 (https://download.01.org/0day-ci/archive/20220115/202201151153.jUgRmbQJ-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d1021978b8e7e35dcc30201ca1731d64b5a602a8)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=4d279aea908260eca25d06d817422f7b820a790f
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 4d279aea908260eca25d06d817422f7b820a790f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
   In file included from ./usr/include/rdma/rdma_user_cm.h:38:
>> ./usr/include/linux/socket.h:5:10: fatal error: 'uapi/linux/socket_types.h' file not found
   #include <uapi/linux/socket_types.h>
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
