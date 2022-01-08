Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B25488392
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 13:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiAHMZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 07:25:56 -0500
Received: from mga01.intel.com ([192.55.52.88]:30509 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231714AbiAHMZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 07:25:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641644755; x=1673180755;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/S9BNnRUmAiTxCzVmSytKteT3uwSiw/QAMqL2kCcMgM=;
  b=bOx+rH8xxvMJw3H9+z+oJTw8yfe/YdqP0r+EWs8vhmRLLgrd9uQYrgSh
   UiMwKqf09tyQB6DzixjhPG77lON+W42gp2jkY/Q3DfNAuJrd2slk8TZj1
   gCLIMM622lSUwIFLm0rfRA722Bx5EYXDzhaqqC6XmjcoTumv1UUKLHVs8
   LXwUcFVMm+30yKCZ/d0uxDnZNNCTW3ktMGucwpRZEvMmFHay/7B7TZY2n
   fgqO3KfK3hCU7DIN+M6qaHQ49/dkETNA3+LvMKSw3gvzLrLF2jc0cdWfM
   PZnPzapIUhXvncnSXutTnAi9bx2aAGZeB2E/90PiWfTIvzLxrM+Xlmlsv
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="267325252"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="267325252"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 04:25:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="473634492"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Jan 2022 04:25:53 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6AnB-0000c7-1o; Sat, 08 Jan 2022 12:25:53 +0000
Date:   Sat, 8 Jan 2022 20:25:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: powerpc64-linux-ld: arch/powerpc/net/bpf_jit_comp64.o:undefined
 reference to `powerpc_security_features'
Message-ID: <202201082018.ACTZm4jh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d1587f7bfe9a0f97a75d42ac1489aeda551106bc
commit: b7540d62509453263604a155bf2d5f0ed450cba2 powerpc/bpf: Emit stf barrier instruction sequences for BPF_NOSPEC
date:   3 months ago
config: powerpc64-randconfig-c024-20220107 (https://download.01.org/0day-ci/archive/20220108/202201082018.ACTZm4jh-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b7540d62509453263604a155bf2d5f0ed450cba2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b7540d62509453263604a155bf2d5f0ed450cba2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> powerpc64-linux-ld: arch/powerpc/net/bpf_jit_comp64.o:(.toc+0x0): undefined reference to `powerpc_security_features'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
