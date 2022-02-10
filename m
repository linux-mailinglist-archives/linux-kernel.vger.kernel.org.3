Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EBC4B163A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 20:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343943AbiBJT0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 14:26:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbiBJT0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:26:06 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A845BED
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 11:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644521167; x=1676057167;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gX3EHuEY3grbC3ebvrtPPRZIZDZO1U8MbJmtFmFU9ng=;
  b=MBsSLmbKdeQlUKOlRFmWIVVgqIaHMzchSWSGEuBo/sqihZ+H1iU7oIPj
   tYWXN4UZJDnml+ZzcWZTceVi2OJM5EmHWNGbpjzSnk7qskeegjXzWKpCS
   YkBQGLzqIBYepc7lCKihkvj2k1Cyj4ctDRwCGznkMqkRnKPm3XwPDJy9e
   2LmHBnb056wa19gQZeuBAUpRxSFdFUHMciv8ed7/wI80o3eQb+OCxfaQE
   Ypa6UsGpnL8F5z94ObLRzgbrqhMioXbJrkjohZ4sXbePdnv/vV8PEB5lK
   s1IQxYWhLvxMLbQZtyHmq47rBd80yzf4xqQAGrueyXvyjaQuY2ITOT0qD
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="233132840"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="233132840"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 11:26:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="602144820"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 10 Feb 2022 11:26:05 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIF4u-0003fh-Mn; Thu, 10 Feb 2022 19:26:04 +0000
Date:   Fri, 11 Feb 2022 03:25:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wei Fu <wefu@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Liu Shaohua <liush@allwinnertech.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [csky-linux:riscv_compat_v6_svpbmt-v6 12/35] WARNING: modpost:
 vmlinux.o(.text.unlikely+0x8dc): Section mismatch in reference from the
 function riscv_cpufeature_patch_func() to the function
 .init.text:cpufeature_probe()
Message-ID: <202202110359.05keld0L-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/c-sky/csky-linux riscv_compat_v6_svpbmt-v6
head:   54acb36c958fc990cc59889f79c8ddca7386c295
commit: bac41a3372f9586652716665df9da6c4059b9309 [12/35] riscv: add RISC-V Svpbmt extension support
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20220211/202202110359.05keld0L-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/c-sky/csky-linux/commit/bac41a3372f9586652716665df9da6c4059b9309
        git remote add csky-linux https://github.com/c-sky/csky-linux
        git fetch --no-tags csky-linux riscv_compat_v6_svpbmt-v6
        git checkout bac41a3372f9586652716665df9da6c4059b9309
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text.unlikely+0x8dc): Section mismatch in reference from the function riscv_cpufeature_patch_func() to the function .init.text:cpufeature_probe()
The function riscv_cpufeature_patch_func() references
the function __init cpufeature_probe().
This is often because riscv_cpufeature_patch_func lacks a __init
annotation or the annotation of cpufeature_probe is wrong.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
