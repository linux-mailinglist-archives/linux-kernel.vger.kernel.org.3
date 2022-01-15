Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E4348F8D9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 19:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbiAOSqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 13:46:38 -0500
Received: from mga02.intel.com ([134.134.136.20]:17566 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230304AbiAOSqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 13:46:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642272393; x=1673808393;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=A9b4CYutbtgHSOaFSTaOM0YmLueRpAqU1k2FeuzllV8=;
  b=mqgchSLnarnllg3hzyz/AEI1HG+l565TAnVUeT0YyqUCCeVOcJA7dGDe
   3rpIq5GFeYrmhoV01N4puKXLD5M9DprYW6N4p5/+KT657KO45b7wSzXWI
   cCMdm4PJm5JXhyCP6TK8+KNnjWIDFGg94SfWwQH9vjOWaAS7mfu8S74Tf
   6Nxi07Pn9o8HoDUxis47S2FHazsgxKWqyAEkNVZHdOvFwjx889O0dl4qW
   VIRfc8MsX0kQhAH/LkUhdRwSd/qG8EJKjU/XVfAUQqonKKDS1F2DX+7AT
   5xYYJxBvTtf53ptWNEoRvXZio7z61IH6AdyOzkOyWzgm1IcoPzZfnR5WL
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10228"; a="231784389"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="231784389"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2022 10:46:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="577623984"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jan 2022 10:46:31 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8o4N-000AEM-3M; Sat, 15 Jan 2022 18:46:31 +0000
Date:   Sun, 16 Jan 2022 02:45:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1596/2384]
 ./usr/include/linux/netdevice.h:29:10: fatal error: 'uapi/linux/if.h' file
 not found
Message-ID: <202201160228.e57G1RsG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   4c707c1c0de83967079b4e385012fa5b00e2cd11
commit: 5d5fc815f35aee2826c6b83d677576c46132c10c [1596/2384] headers/deps: net: Optimize <uapi/linux/netdevice.h>
config: i386-randconfig-a006 (https://download.01.org/0day-ci/archive/20220116/202201160228.e57G1RsG-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d1021978b8e7e35dcc30201ca1731d64b5a602a8)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=5d5fc815f35aee2826c6b83d677576c46132c10c
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 5d5fc815f35aee2826c6b83d677576c46132c10c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
   In file included from ./usr/include/linux/if_arp.h:27:
>> ./usr/include/linux/netdevice.h:29:10: fatal error: 'uapi/linux/if.h' file not found
   #include <uapi/linux/if.h>
            ^~~~~~~~~~~~~~~~~
   1 error generated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
