Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E6048855C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 19:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiAHSeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 13:34:08 -0500
Received: from mga06.intel.com ([134.134.136.31]:7381 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229933AbiAHSeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 13:34:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641666846; x=1673202846;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RPLlKS7QXjNchTmA1oMEU6PugeV8pY3fAoX40O/Rbw4=;
  b=lo9tb8HnWlM4llnEIBMmja8p9Sl05/4v1+/0ApUOcqkTy4N5tzKMStIq
   JzGXc/0lVmC5LLLxLSH3KvVvOPXoYzJcdjQ/r/Ig64v2xbEBlvre4SXpE
   Edr0seO1bgeXPqkm5zqKIRI0cI9Ytp7pPtI/ffsrj8HEL7FjK3sSseR+3
   yHWDSNO/TAVIypl2dxyyQTbf7CzzTa9ZmNrVF9f9iMakxW1RbyqCZxQKd
   MM9QwrjS+Pn33hP2Mpp0VyLY+kOvZiBw8Rz0qPpeIYktMQPVyHNfjTNcm
   n1ihvbHQoB1nukTrtRo6MJQ4+u0iOckk5dNvQIAdv220pRvSDUWaoRDMN
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10221"; a="303775238"
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="303775238"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 10:34:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="471641026"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 08 Jan 2022 10:34:04 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6GXT-0000ui-Rd; Sat, 08 Jan 2022 18:34:03 +0000
Date:   Sun, 9 Jan 2022 02:33:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1594/2375]
 usr/include/linux/netlink.h:5:10: fatal error: 'uapi/linux/types.h' file not
 found
Message-ID: <202201090221.qvOVp5rt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   351ceeab2ef96ab2fc306934ddb201b44636181b
commit: e1d1301c65f465182ed976c1641d45e9baf7d83d [1594/2375] headers/deps: net: Optimize <uapi/linux/netlink.h>
config: i386-buildonly-randconfig-r006-20220108 (https://download.01.org/0day-ci/archive/20220109/202201090221.qvOVp5rt-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f3a344d2125fa37e59bae1b0874442c650a19607)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=e1d1301c65f465182ed976c1641d45e9baf7d83d
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout e1d1301c65f465182ed976c1641d45e9baf7d83d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/hyperv/ drivers/clk/ samples/connector/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from samples/connector/ucon.c:14:
>> usr/include/linux/netlink.h:5:10: fatal error: 'uapi/linux/types.h' file not found
   #include <uapi/linux/types.h>
            ^~~~~~~~~~~~~~~~~~~~
   1 error generated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
