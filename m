Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FFE4BF091
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 05:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240199AbiBVDsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 22:48:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiBVDsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 22:48:16 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F19524BD3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 19:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645501672; x=1677037672;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ay21XNpMYTX5RnLpflKexkXgUtuSuC5IhzNLm8m5hWI=;
  b=Pr9EaY9Pw+ZnLv0Q4AjtU+OQYDwTQqsFvCvJr171Rq22R/eGGeaj4HjI
   8xMZ5s6cTk+z3m9Qp5SMVfkUuUEUa4nmFFwBAkK4Cfxh7F8rg7oDCjIs/
   q3bo6YSGr+NbXrtGOaLujYig3L1Ls7jyMRi2IV0rkc6hUgBMuuJlfgQop
   8ndTt1a7kt+Z9/yOe4Dsw18m2F33fkxZ+lYceHfenxzQdDi8b2HQArgbV
   DMFMcDH4ffXQJC+mehqfgmDfGyfLBF+SOMiX0s6npcaFvnlfnUqDXn2+U
   BS0H3MzHYeHy7xE32IrB+NKpuYd0sKRzEiyZ5t3p3lhPJa20/BV6VjwL8
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="239022882"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="239022882"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 19:47:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="532062778"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 21 Feb 2022 19:47:50 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMM9V-0002IG-P2; Tue, 22 Feb 2022 03:47:49 +0000
Date:   Tue, 22 Feb 2022 11:46:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Prasad Sodagudi <psodagud@codeaurora.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Elliot Berman <eberman@codeaurora.org>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-5.10-2021-11
 239/9999] drivers/android/debug_symbols.c:11:10: fatal error:
 asm/stacktrace.h: No such file or directory
Message-ID: <202202221136.tCMedR7t-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prasad,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-5.10-2021-11
head:   6207e9121a093289b249b66385af719b68c4b889
commit: 3fcbb15c1a91a318fb9367bee24603af24648a2d [239/9999] ANDROID: android: Create debug_symbols driver
config: ia64-allmodconfig (https://download.01.org/0day-ci/archive/20220222/202202221136.tCMedR7t-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/3fcbb15c1a91a318fb9367bee24603af24648a2d
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-5.10-2021-11
        git checkout 3fcbb15c1a91a318fb9367bee24603af24648a2d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/android/debug_symbols.c:11:10: fatal error: asm/stacktrace.h: No such file or directory
      11 | #include <asm/stacktrace.h>
         |          ^~~~~~~~~~~~~~~~~~
   compilation terminated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for SND_VMASTER
   Depends on SOUND && !UML && SND
   Selected by
   - GKI_HIDDEN_SND_CONFIGS
   WARNING: unmet direct dependencies detected for SND_PCM_IEC958
   Depends on SOUND && !UML && SND
   Selected by
   - GKI_HIDDEN_SND_SOC_CONFIGS
   WARNING: unmet direct dependencies detected for SND_JACK
   Depends on SOUND && !UML && SND
   Selected by
   - GKI_HIDDEN_SND_CONFIGS
   WARNING: unmet direct dependencies detected for SND_JACK_INPUT_DEV
   Depends on SOUND && !UML && SND && SND_JACK
   Selected by
   - GKI_HIDDEN_SND_CONFIGS
   WARNING: unmet direct dependencies detected for SND_PCM_ELD
   Depends on SOUND && !UML && SND
   Selected by
   - GKI_HIDDEN_SND_CONFIGS
   WARNING: unmet direct dependencies detected for SND_INTEL_NHLT
   Depends on SOUND && !UML && SND
   Selected by
   - GKI_HIDDEN_SND_CONFIGS && ACPI


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
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
