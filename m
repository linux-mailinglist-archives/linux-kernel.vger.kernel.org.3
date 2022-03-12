Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDE84D6F45
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 14:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbiCLNtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 08:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbiCLNth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 08:49:37 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F62B41636
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 05:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647092912; x=1678628912;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=m0PMow11GgjybL+zR1EgyzARPWovbBXPkKqejp2s5ig=;
  b=PxzDLFt5BSF1bBz82YORG+LsDlZxPGk0PJishvg0VcHIVKa5iYzlpl7I
   CFw9euB+YYuga5aH6rsqyXKfbwApved6xQm2m/r7ETls11dT54KETnhgN
   pBc2lh/0D2XfPfppJPfbIIBIICn1t/Gn6l6rAUQG908kSITiCdFHu2LJz
   pNrs29j94+q+A+E8TUspKiJ7iKeSmsOoTeVcCGGELScRu4FGv1vSt1Vx8
   WN1yTAjbJL5srGu/88ZPYsNS0EpIxOklHXD7VZP6A+w1hKGGskgyLdXHQ
   CflNKwl28yP11L5Ap7tZwaukLldM90SNtjIQlV+QomqMRZ8SQXdl5LDDf
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="237965421"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="237965421"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 05:48:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="817529627"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 12 Mar 2022 05:48:29 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nT26f-0007v3-4j; Sat, 12 Mar 2022 13:48:29 +0000
Date:   Sat, 12 Mar 2022 21:48:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Prasad Sodagudi <psodagud@codeaurora.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Elliot Berman <eberman@codeaurora.org>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-5.10-2022-01
 129/9999] drivers/android/debug_symbols.c:11:10: fatal error:
 asm/stacktrace.h: No such file or directory
Message-ID: <202203122107.sTzN2ohn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prasad,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-5.10-2022-01
head:   d262b276948e382dbaa38474845bac692bae4236
commit: 3fcbb15c1a91a318fb9367bee24603af24648a2d [129/9999] ANDROID: android: Create debug_symbols driver
config: microblaze-allyesconfig (https://download.01.org/0day-ci/archive/20220312/202203122107.sTzN2ohn-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/3fcbb15c1a91a318fb9367bee24603af24648a2d
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-5.10-2022-01
        git checkout 3fcbb15c1a91a318fb9367bee24603af24648a2d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/android/debug_symbols.c:11:10: fatal error: asm/stacktrace.h: No such file or directory
      11 | #include <asm/stacktrace.h>
         |          ^~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +11 drivers/android/debug_symbols.c

     2	
     3	/*
     4	 * Copyright (c) 2021, The Linux Foundation. All rights reserved.
     5	 */
     6	
     7	#include <linux/types.h>
     8	#include <linux/kernel.h>
     9	#include <linux/module.h>
    10	#include <linux/android_debug_symbols.h>
  > 11	#include <asm/stacktrace.h>
    12	#include <asm/sections.h>
    13	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
