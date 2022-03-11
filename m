Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260F34D5C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 08:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347181AbiCKHdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 02:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346932AbiCKHdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:33:43 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BE642A12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 23:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646983959; x=1678519959;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7XVpZqHQeRf+Gd9hjgePhvlXmix5PEI4zFEvWIpAkRY=;
  b=kp7PY0kP+LPmW6h8Ijfizkl0s2KJvX+HpPUmG7EpP+3KAgELn/FwzeDn
   wNnFNscxeqCHkPLry/fLnPkc1UvPc4F9pEwF3ML/CQHrmU5CJQ5u7wxrN
   sfjZ07clxwtMFG66BFdDjJU7raynrWA+5/qc483txOlybFUtOwWLSNU3X
   IiMcLE4E6eiSCHE44kPx2Mb2xmefiw4QltR2K7AeUXnpLFsFKcrmrn8aS
   4ZXW/eEJeGoBPOmwNEactl8onITu0FwqepP4SID5uQxo1I0ce6kUFMP1e
   INs1HMks8yDk8y4uJEHGCZmxSUasVT7eeNUTeO+DGXKANjVwbl/0YrhPq
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="253083337"
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="253083337"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 23:32:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="712762674"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 10 Mar 2022 23:32:35 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSZlK-00062i-V6; Fri, 11 Mar 2022 07:32:34 +0000
Date:   Fri, 11 Mar 2022 15:32:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: arm-linux-gnueabi-ld: proc-v7-bugs.c:undefined reference to
 `spectre_v2_update_state'
Message-ID: <202203111535.vIYAwOq1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dda64ead7e82caa47fafe0edc36067ee64df2203
commit: b9baf5c8c5c356757f4f9d8180b5e9d234065bc3 ARM: Spectre-BHB workaround
date:   6 days ago
config: arm-randconfig-r022-20220310 (https://download.01.org/0day-ci/archive/20220311/202203111535.vIYAwOq1-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b9baf5c8c5c356757f4f9d8180b5e9d234065bc3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b9baf5c8c5c356757f4f9d8180b5e9d234065bc3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: arch/arm/mm/proc-v7-bugs.o: in function `cpu_v7_bugs_init':
   proc-v7-bugs.c:(.text+0x52): undefined reference to `spectre_v2_update_state'
>> arm-linux-gnueabi-ld: proc-v7-bugs.c:(.text+0x82): undefined reference to `spectre_v2_update_state'

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
