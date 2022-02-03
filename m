Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4664A7E01
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 03:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348746AbiBCCjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 21:39:41 -0500
Received: from mga05.intel.com ([192.55.52.43]:31049 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233972AbiBCCjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 21:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643855980; x=1675391980;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lITZsN+IdLY9iNo4fc/A84KWKDjHAy49UxtSWZ5bsXM=;
  b=BcjNHuKJdTC57ibUQ+VWRLJfp0NK7zTkCOb3EzXUjU426KoQXr82R+d5
   e5jua3YP8CET/vULHe5oD16F5SeRGrh9b1rcIbqrtSquqtil2cc5xVCyB
   UKnem3ntitAUfJkZebjBsbIzgvuFhexGpteoncr1xImtUchr91fFuxtB+
   m3PFTauiDQJsaPOrJN71oVO3yYvw/4tac0Z/78d/O53fAyyiGyb10nS4v
   AxElCLtXP0a/3q+yI7B1u1wsIgr/wqh/R8Tk6NRmtylvmpLiu6gBgNW4w
   W82Q2q0u256FyObiDujklDJA5oODiYSNBfV9ibofke0UK48SteARQVEcG
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="334423052"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="334423052"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 18:39:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="483090430"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 02 Feb 2022 18:39:38 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFS26-000VRj-96; Thu, 03 Feb 2022 02:39:38 +0000
Date:   Thu, 3 Feb 2022 10:39:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>
Subject: drivers/perf/arm-cmn.c:356:15: sparse: sparse: symbol
 'arm_cmn_debugfs' was not declared. Should it be static?
Message-ID: <202202030812.II1K2ZXf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   88808fbbead481aedb46640a5ace69c58287f56a
commit: a88fa6c28b867a387e3af202d6dbbb754d3aa2f1 perf/arm-cmn: Add debugfs topology info
date:   7 weeks ago
config: sparc64-randconfig-s032-20220203 (https://download.01.org/0day-ci/archive/20220203/202202030812.II1K2ZXf-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a88fa6c28b867a387e3af202d6dbbb754d3aa2f1
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a88fa6c28b867a387e3af202d6dbbb754d3aa2f1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc64 SHELL=/bin/bash drivers/perf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/perf/arm-cmn.c:356:15: sparse: sparse: symbol 'arm_cmn_debugfs' was not declared. Should it be static?

vim +/arm_cmn_debugfs +356 drivers/perf/arm-cmn.c

   355	
 > 356	struct dentry *arm_cmn_debugfs;
   357	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
