Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6E54E8171
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 15:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbiCZOk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 10:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiCZOk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 10:40:56 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5B517ECC6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 07:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648305559; x=1679841559;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pCsHdo0R4JvWWSHvwAy7g2k+udGsLopzmt5/nsIAcCc=;
  b=Uiwjv8RMBuSCqqG3cSOmptL+Gc0PLRHfpFCI6aJc1miUyoagdb5CR5cx
   MkLROV6INBQbRb/tpCeDjk/b2juwSlSIix9wgAY/Z3Kt7eN3dEi6KJ6MJ
   nECWLoDqAoCYeFOGXORuvOAb6HNrKq6n/6X7cfgi7Vu4dh71bns5wjttE
   UPJ+/qngHdVfqVkiKx5L16XTrSwSwO6pUj2TeO9hzmYfeGv2nMbD/O0lz
   gIS5roIaf05sBvaY1hGKokHJNJiOcAsVlLAcuQyimucvyK4tzRdqsk89f
   idTzLTlcwFhgDCCZbedatqcFZViTreifJ67BGKaDy6+WoCQa9WNl83/9p
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10298"; a="319489436"
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="319489436"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 07:39:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="520503426"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 26 Mar 2022 07:39:18 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nY7ZV-00005R-Ln; Sat, 26 Mar 2022 14:39:17 +0000
Date:   Sat, 26 Mar 2022 22:38:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: powerpc-linux-ld: warning: orphan section `.ftrace.tramp' from
 `drivers/platform/chrome/cros_ec_trace.o' being placed in section
 `.ftrace.tramp'
Message-ID: <202203262233.4tgzPTZZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gwendal,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   52d543b5497cf31d6baeb0bcfe5a5474c3238578
commit: d453ceb6549af8798913de6a20444cb7200fdb69 platform/chrome: sensorhub: Add trace events for sample
date:   8 months ago
config: powerpc-randconfig-m031-20220326 (https://download.01.org/0day-ci/archive/20220326/202203262233.4tgzPTZZ-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d453ceb6549af8798913de6a20444cb7200fdb69
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d453ceb6549af8798913de6a20444cb7200fdb69
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   powerpc-linux-ld: warning: orphan section `.init.plt' from `drivers/platform/chrome/cros_ec_trace.o' being placed in section `.init.plt'
>> powerpc-linux-ld: warning: orphan section `.ftrace.tramp' from `drivers/platform/chrome/cros_ec_trace.o' being placed in section `.ftrace.tramp'
   powerpc-linux-ld: warning: orphan section `.init.plt' from `drivers/platform/chrome/cros_ec_trace.o' being placed in section `.init.plt'
>> powerpc-linux-ld: warning: orphan section `.ftrace.tramp' from `drivers/platform/chrome/cros_ec_trace.o' being placed in section `.ftrace.tramp'
   powerpc-linux-ld: warning: orphan section `.init.plt' from `drivers/platform/chrome/cros_ec_trace.o' being placed in section `.init.plt'
>> powerpc-linux-ld: warning: orphan section `.ftrace.tramp' from `drivers/platform/chrome/cros_ec_trace.o' being placed in section `.ftrace.tramp'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
