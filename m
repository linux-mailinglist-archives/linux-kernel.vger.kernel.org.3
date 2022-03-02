Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322664C9B85
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 03:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237354AbiCBCxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 21:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbiCBCxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 21:53:19 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D99B7D1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 18:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646189557; x=1677725557;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xTUi+/0UsNKKERWKVwZSJY3Mpv2H6siz+M55CHQPXFc=;
  b=bejuYInhzMw4sI+xU5lIgmJ+1FPG8OmALiPQGhu0borGBYWZWJnzRvxM
   s/FrEWnppADbMS7pDEPIQwf38ROgpGbIecf4ehvnleXahu/zRstUx6bOR
   ExrEDSSZtM78feVBhei9afYCiCAvegRO5KhNsbcpfbrx6ZFxln++i4c4/
   LQ9ULmDYuJhrAFhZjq9Rb2RcpsqRZO0X/UAqg+4PDGC2qjFvDINo9Ttw9
   Sur7Tb73zVYxd5Wy6IkzXmxu5BCfr/yYxsqPwaB/2dzFjdc/rP9da6wDX
   whnh2a4uiqHSkK9ZuzumWToNBLEKLIB5iOGeB4yFh19png6VZha4wGBTV
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="253488537"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="253488537"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 18:52:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="641535771"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 01 Mar 2022 18:52:34 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPF6P-0000xW-PN; Wed, 02 Mar 2022 02:52:33 +0000
Date:   Wed, 2 Mar 2022 10:51:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dust Li <dust.li@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Tony Lu <tonylu@linux.alibaba.com>
Subject: [saeed:net-next-mlx5 100/108] WARNING: modpost:
 vmlinux.o(.text+0x1fc2f20): Section mismatch in reference from the function
 trace_event_raw_event_smc_msg_event() to the variable
 .init.data:initcall_level_names
Message-ID: <202203020919.C37R7nSW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git net-next-mlx5
head:   f6aab83b7decaf651cffe7fdac7d0bb316ea6bca
commit: 462791bbfa350189e309a5a94541f6b63cd874e8 [100/108] net/smc: add sysctl interface for SMC
config: xtensa-randconfig-r034-20220301 (https://download.01.org/0day-ci/archive/20220302/202203020919.C37R7nSW-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git/commit/?id=462791bbfa350189e309a5a94541f6b63cd874e8
        git remote add saeed https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git
        git fetch --no-tags saeed net-next-mlx5
        git checkout 462791bbfa350189e309a5a94541f6b63cd874e8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0x1fc2f20): Section mismatch in reference from the function trace_event_raw_event_smc_msg_event() to the variable .init.data:initcall_level_names
The function trace_event_raw_event_smc_msg_event() references
the variable __initdata initcall_level_names.
This is often because trace_event_raw_event_smc_msg_event lacks a __initdata
annotation or the annotation of initcall_level_names is wrong.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
