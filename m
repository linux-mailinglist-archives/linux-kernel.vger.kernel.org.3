Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950EB4878B8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239187AbiAGOPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:15:02 -0500
Received: from mga14.intel.com ([192.55.52.115]:24223 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238832AbiAGOPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:15:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641564901; x=1673100901;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UxygRW9KXyGCMdlEcsdfrrpGx84oQ5xtQOv4pnVp1VI=;
  b=cVNt14ujWGKx6G0iwl485BNWV5XzdYQqU8QvckOO3bg5kD+MSEBk6jAH
   cE1P4L7UALbY1FNu3BWihAJvVp75Un99jfweFiZX59G3NFua1OLyVGXiE
   sa5AC404VAGf+LoePnO9FhdUo6VmpkKVAWnW2pw8EQBgxn8+HvEkVOlrk
   mCtgZDASoA3U0mN8oAP9tXL0ntLrzovKegYIMsYPWyemhoinRJRo1rdcT
   /j5nnkC+DobrExXxQxw0ukWNEWQ7+M6e2wEvrGVuEjdJYFvqXSv2qlB3d
   GvIXD24TMMZsqtzZvuXkIIzPz9widMzssXAHS2hxpuVMmsg6jXMGZkkYH
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="243070940"
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="243070940"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 06:15:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="557271223"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 07 Jan 2022 06:14:59 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5q1C-000Ikc-U6; Fri, 07 Jan 2022 14:14:58 +0000
Date:   Fri, 7 Jan 2022 22:14:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Prasad Sodagudi <psodagud@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Yogesh Lal <quic_ylal@quicinc.com>,
        Elliot Berman <eberman@codeaurora.org>
Subject: [ammarfaizi2-block:google/android/kernel/common/android13-5.15
 1113/2544] drivers/android/android_debug_symbols.c:11:10: fatal error:
 asm/stacktrace.h: No such file or directory
Message-ID: <202201072236.CqiwYsTl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prasad,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android13-5.15
head:   1d50adbe5ad4df334a576ab1d43c176306255e8a
commit: b2df67a932b5cbd6535de9f1a6e63004992ad014 [1113/2544] ANDROID: android: Create debug_symbols driver
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220107/202201072236.CqiwYsTl-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/b2df67a932b5cbd6535de9f1a6e63004992ad014
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android13-5.15
        git checkout b2df67a932b5cbd6535de9f1a6e63004992ad014
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/android/android_debug_symbols.c:11:10: fatal error: asm/stacktrace.h: No such file or directory
      11 | #include <asm/stacktrace.h>
         |          ^~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +11 drivers/android/android_debug_symbols.c

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
