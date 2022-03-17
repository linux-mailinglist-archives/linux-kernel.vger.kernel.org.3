Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70E54DD0BB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 23:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiCQWbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 18:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiCQWbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 18:31:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009971697B3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647556231; x=1679092231;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RLq+jbYOHZ3v2hFGMjLPhr/TJ4Byl5PWB49G9X3oN0o=;
  b=HHIpuDvnavHx7IWokrAMFrLQFOjzhl2nJoBpEFwHNn2XsG/ngMaonwDC
   FBAcBgIoTXGc2kkAaWhMC7w4D9iIpsltmA/KSNFNmAsYKO2ALcbwz2rxB
   l8JV/rBrnQIh6DMZbxB0NlbvOyVSX5zN3ScC/XY/rcpsBuMqCMOcz4sA4
   fm2hRg2nNZaU9yKwm00gzinaEwjQogK8PrUgnlJJ3GCjiz/PxJ8vrQDoe
   6wNaI5bxjNRfwi7XTZJFoADqiPie7oF8B2UQ9iWx3OpghcnXJCts+/wkM
   K0utSQvTDrcYGLMy1Rn2d8mOfM72kRWFSu/3fQg1NiTTul7kTFAqzv+za
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="239159038"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="239159038"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 15:30:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="647221128"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 17 Mar 2022 15:30:17 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUydN-000EAC-5h; Thu, 17 Mar 2022 22:30:17 +0000
Date:   Fri, 18 Mar 2022 06:30:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>
Subject: /tmp/cch5VBly.s: Warning: Can not find match relax hint.  Line: 1841
Message-ID: <202203180600.lgiajPmN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexei,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   56e337f2cf1326323844927a04e9dbce9a244835
commit: 29db4bea1d10b73749d7992c1fc9ac13499e8871 bpf: Prepare relo_core.c for kernel duty.
date:   4 months ago
config: nds32-buildonly-randconfig-r001-20220317 (https://download.01.org/0day-ci/archive/20220318/202203180600.lgiajPmN-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=29db4bea1d10b73749d7992c1fc9ac13499e8871
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 29db4bea1d10b73749d7992c1fc9ac13499e8871
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   tools/lib/bpf/relo_core.c: In function 'bpf_core_apply_relo_insn':
   tools/lib/bpf/relo_core.c:1346:1: warning: the frame size of 1160 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    1346 | }
         | ^
   /tmp/cch5VBly.s: Assembler messages:
>> /tmp/cch5VBly.s: Warning: Can not find match relax hint.  Line: 1841

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
