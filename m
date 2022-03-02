Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CED4C9B79
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 03:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239174AbiCBCwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 21:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbiCBCwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 21:52:17 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE50AA2C9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 18:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646189495; x=1677725495;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dgnWJ/jYHVTibGNF4UZfyHXn6+dXseh+YDMWeoYCDXo=;
  b=UCdSzDNbPlGToxnQnF0sS9wKeYIL7poJVWpmWCXs2R7/qqUHwblrwEsE
   b8qmiar/pGOkGhIKpGf3QIU9Jw9OGArvkIiAxJkCHW06+BePW4jQu8fMb
   AmN+SUKVbRcwkL1Pmjux/5MF8i1x2D5tyzwaA99wQGgGMqe2nOcplnQGJ
   iVCShQpVboPmPtU1qZYtFDzEbLqvrVTLyDKRhnhF7us/Xt2LvjhFxH3Gm
   9JVxW/fUzwVztpquIBZnBhDNefr5GTK2BgPD+VmqCTcMwz/0QZ0G/CYrO
   YG9CZ7J9t1LpeHzyE2dmdPBfoAH7Fr693ndiTIwtoQgSN/p3Ph2Md0pt1
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="316509666"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="316509666"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 18:51:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="493381690"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 01 Mar 2022 18:51:34 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPF5R-0000wF-BL; Wed, 02 Mar 2022 02:51:33 +0000
Date:   Wed, 2 Mar 2022 10:51:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dust Li <dust.li@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Tony Lu <tonylu@linux.alibaba.com>
Subject: [saeed:net-next-mlx5 100/108] WARNING: modpost:
 vmlinux.o(.text+0x12ced2d): Section mismatch in reference from the function
 smc_sysctl_exit() to the variable .init.data:smc_sysctl_ops
Message-ID: <202203020706.79iSCfMF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220302/202203020706.79iSCfMF-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git/commit/?id=462791bbfa350189e309a5a94541f6b63cd874e8
        git remote add saeed https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git
        git fetch --no-tags saeed net-next-mlx5
        git checkout 462791bbfa350189e309a5a94541f6b63cd874e8
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0x12ced2d): Section mismatch in reference from the function smc_sysctl_exit() to the variable .init.data:smc_sysctl_ops
The function smc_sysctl_exit() references
the variable __initdata smc_sysctl_ops.
This is often because smc_sysctl_exit lacks a __initdata
annotation or the annotation of smc_sysctl_ops is wrong.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
