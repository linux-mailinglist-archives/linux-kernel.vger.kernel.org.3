Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCE3487FF9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 01:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbiAHAmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 19:42:33 -0500
Received: from mga12.intel.com ([192.55.52.136]:60453 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231947AbiAHAma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 19:42:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641602550; x=1673138550;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UMPcSZi98T/kjWJzwXxsSJyp21VbWWkCxEBBArt8ZDU=;
  b=S6Uv24D2AYhrVgS9QgFDEzDdIBB82hPOLso5BqY7r24RP3A9afBw1cbE
   ZRy/cUpmxnzV6kZQ7Ef/TPIrLSccaVPLIs5c9KR54YVYKnN4dLuSEYEIT
   ZzfLV4jwMK76XSsn6TRWgHHLZvLyrM3MRxphxDs54npXnRpAKp0VcomfT
   VoBEAGc1ooacXVl1ak4uqs+OPsPzJIN0Ih5dlMrDSalYQlwlXF79PICfY
   ek55dQeFjI+Tqrcnjjl8g4truVRwdz4QrF9JvstdHcV4Jz0z9mwuK8gYk
   kYRfNBcYxe7W7pyh84vqeKSs8Ii8BQZcGBqciCVRYJhBoYDM6DUdn2mvv
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="222956096"
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="222956096"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 16:42:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="489452989"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 07 Jan 2022 16:42:28 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5zoR-000077-Qp; Sat, 08 Jan 2022 00:42:27 +0000
Date:   Sat, 8 Jan 2022 08:41:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Prasad Sodagudi <psodagud@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Elliot Berman <eberman@codeaurora.org>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-5.10
 142/9999] drivers/android/debug_symbols.c:11:10: fatal error:
 asm/stacktrace.h: No such file or directory
Message-ID: <202201080759.2KcaQBpB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prasad,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-5.10
head:   05c23b7a503851e3be7e68453899e0ed922016f7
commit: 3fcbb15c1a91a318fb9367bee24603af24648a2d [142/9999] ANDROID: android: Create debug_symbols driver
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220108/202201080759.2KcaQBpB-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/3fcbb15c1a91a318fb9367bee24603af24648a2d
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-5.10
        git checkout 3fcbb15c1a91a318fb9367bee24603af24648a2d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash

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
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
