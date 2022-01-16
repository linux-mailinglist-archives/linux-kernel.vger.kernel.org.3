Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925B548FDB7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 17:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbiAPP7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 10:59:05 -0500
Received: from mga02.intel.com ([134.134.136.20]:5452 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232426AbiAPP7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 10:59:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642348743; x=1673884743;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/f2pNQ4PV7SPzdN485bwzOcHSv6xR3obCYGKlCERdJw=;
  b=a9BiUqmTbBLf0Z6nNkzuQdXF9m+FK/vvQBJoOfCfvHrzao2OrNRfVa09
   IJi36H8W2FqzYdRDWUC209AaPDfuE/tmAvJ3KTjDkx/4sqvMifnZDVxCt
   5v1/nryVHqS59RfJ9djucGbrvkxDCRt2jiVlFE2l46IRFXJQD95cdoQT6
   RyjZqTqwTYXnwHpkGVd+m5TnBbj2Lpo/2FRLIGen8+7j0TVLWY5sUcuy0
   UJ/sP9AgOk/d/3GtCi03anYnvXJRhpMbAyfQV9fetPqbTHoN90IGIkoGU
   UkRvIOSmZJDL8vucrTHtP+XG55eUfLcgw54+FxfezJyULml1XvgZF3v5u
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10228"; a="231853474"
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="231853474"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 07:59:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="517127552"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 16 Jan 2022 07:59:02 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n97vp-000Aoq-Br; Sun, 16 Jan 2022 15:59:01 +0000
Date:   Sun, 16 Jan 2022 23:58:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>
Subject: drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c:1265:6: warning:
 stack frame size (1040) exceeds limit (1024) in '_iwl_dbg_tlv_time_point'
Message-ID: <202201162344.1eLplIwD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mukesh,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4d66020dcef83314092f2c8c89152a8d122627e2
commit: 020cde4750c5b20be309e028dec9950520384c1e iwlwifi: yoyo: support for DBGC4 for dram
date:   6 weeks ago
config: mips-randconfig-r032-20220116 (https://download.01.org/0day-ci/archive/20220116/202201162344.1eLplIwD-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 650fc40b6d8d9a5869b4fca525d5f237b0ee2803)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=020cde4750c5b20be309e028dec9950520384c1e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 020cde4750c5b20be309e028dec9950520384c1e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/net/wireless/intel/iwlwifi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c:1265:6: warning: stack frame size (1040) exceeds limit (1024) in '_iwl_dbg_tlv_time_point' [-Wframe-larger-than]
   void _iwl_dbg_tlv_time_point(struct iwl_fw_runtime *fwrt,
        ^
   1 warning generated.


vim +/_iwl_dbg_tlv_time_point +1265 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c

14124b25780db5 Shahar S Matityahu 2019-07-23  1264  
b8221b0f750a05 Johannes Berg      2021-08-02 @1265  void _iwl_dbg_tlv_time_point(struct iwl_fw_runtime *fwrt,

:::::: The code at line 1265 was first introduced by commit
:::::: b8221b0f750a05a7ae9cbca84932e2a36a3ee658 iwlwifi: prepare for synchronous error dumps

:::::: TO: Johannes Berg <johannes.berg@intel.com>
:::::: CC: Luca Coelho <luciano.coelho@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
