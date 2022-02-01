Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD1E4A5B3D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 12:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbiBALdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 06:33:39 -0500
Received: from mga14.intel.com ([192.55.52.115]:13326 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233560AbiBALdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 06:33:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643715219; x=1675251219;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WzjwqsEXrJgeo+koXSG78hIKP9gKAf+pvPzb74oxbqg=;
  b=IhIUpdJk68SyJPvSdzJoqkkQariv2UoRSNWfyqZhjwqsYPtWqc4WxrVg
   aekIT8aTqt2vfaJ+7d4yVyf9W9VjGeX/K9Gc8DUiXRQ6QWYtqLn1UvviZ
   k2891eMJeQWa1umE801XLWNmwUBTrSiqsOm/hMOV/PplDSxHkF74tSLun
   E2H6GVusPW6NymQECNn5xdK7yW3gYZCX/GxgJsnDX+AzdxmNHy+Qu46aY
   /GcO0qEVFyTXDK/L10mGlPYUTnDqjupR8LHraBLLyqfn4LiMaybtMb3Vy
   GC4dGNGq2A2lDmtSlyLiNQukF2GL0NYS/Gz6sDWJEG2BOuYJAQCFmEur7
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="247889831"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="247889831"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 03:33:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="583003092"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 01 Feb 2022 03:33:37 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nErPg-000TCR-RE; Tue, 01 Feb 2022 11:33:32 +0000
Date:   Tue, 1 Feb 2022 19:33:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tri Vo <trong@google.com>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-trusty-5.10
 5870/5871] aarch64-linux-ld: trusty-ipc.c:undefined reference to
 `trusty_dma_buf_get_shared_mem_id'
Message-ID: <202202011931.flPRO9aB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-trusty-5.10
head:   b60d55f33484d855a546f7cfc59a28a5771e8bee
commit: 629a4d3318cc1234675f62b69fba8791592e8a83 [5870/5871] ANDROID: trusty: Support setting trusty_shared_mem_id_t
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220201/202202011931.flPRO9aB-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/629a4d3318cc1234675f62b69fba8791592e8a83
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-trusty-5.10
        git checkout 629a4d3318cc1234675f62b69fba8791592e8a83
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: drivers/trusty/trusty-ipc.o: in function `dn_share_fd':
   trusty-ipc.c:(.text+0x337c): undefined reference to `trusty_dma_buf_get_ffa_tag'
>> aarch64-linux-ld: trusty-ipc.c:(.text+0x3398): undefined reference to `trusty_dma_buf_get_shared_mem_id'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
