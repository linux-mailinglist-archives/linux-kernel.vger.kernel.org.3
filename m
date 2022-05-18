Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D776B52B95F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 14:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236067AbiERMA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 08:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236082AbiERMAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 08:00:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46FF17EC24
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 05:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652875238; x=1684411238;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WSHYkAR+Y/Y+J1/L7sMqFG8zyvb2KyZc7KeydJa4rlY=;
  b=gh4kXC2TyOvZ0OcwvpA3WJjjpXMRinsN2VwlxE2nOnyhCoSP6NtEak4/
   SYdoCbvmuK+eSjhVTTNGpN9JksJoC0B0p2y9JN0f56DHbM1grEXL9cw1D
   PIV9k08rYGkA5xoknK6QVFsj74L6uShq78TdgA5rbu7ZID26T+OgohB8k
   XtjU/ETitOKIgYDxsMVI7PTsaxwBoNPuF828Px9iSVTCHnjNsWerGXgIR
   A6wxYqPawnrATUH2S4qeUPaePbday4jY//kBr8nYkj/AN2dEpTLU49JhM
   GK+2X9o2JQ263Gd9QFcB92Dd9/ubGP9cFMFSpdglC7sa8oFTDeyHQGijc
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="271585323"
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="271585323"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 05:00:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="661115225"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 18 May 2022 05:00:32 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrILw-00029N-0G;
        Wed, 18 May 2022 12:00:32 +0000
Date:   Wed, 18 May 2022 20:00:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:paulmck/linux-rcu/dev 43/51] ERROR: modpost:
 "rcu_tasks_trace_qs_blkd" [kernel/torture.ko] undefined!
Message-ID: <202205181919.oILbHBZa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev
head:   9a9671fb7a3966dfc7dc67f6aa80acdfe185d72d
commit: 7c98805ebf93263213dac7b52846d73cebe983f3 [43/51] tasks-rcu: Track blocked RCU Tasks Trace readers
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220518/202205181919.oILbHBZa-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/7c98805ebf93263213dac7b52846d73cebe983f3
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/dev
        git checkout 7c98805ebf93263213dac7b52846d73cebe983f3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "rcu_tasks_trace_qs_blkd" [kernel/torture.ko] undefined!
>> ERROR: modpost: "rcu_tasks_trace_qs_blkd" [kernel/rcu/rcuscale.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
