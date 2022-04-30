Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6535160F4
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 01:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358511AbiD3XUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 19:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244679AbiD3XUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 19:20:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02E127CF3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 16:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651360604; x=1682896604;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sqChOqy33PyJonkgrNWZ6wBLbqHzI9vEBzvfA7M6McU=;
  b=eNvs877u4TZApMfHufOMXlqN1UbsMLJUjkTCL+uOXFwEjdwuvgjqAmoh
   U0w5BWQbHYkgOO85PUYpwg+us6Q7MGGibyhDgruwyYR3Yn2Dnu9qIgMm7
   rr5nlg06NrhTuVn7B8WkQZaSYOysglM1MFTlnw16eq098bStmvcVYR6y/
   Knvx8sMYL4c+f93pN8+VjOQ++pU0y5sJXyx+P88408fRJB+33v9sNvdWH
   qYwX2myO7bNpOUWJyjEecXyY0Qc13rzeY60vW/hIQazFuaqKt2fOpoTuW
   7cJhIfS/+zRWDKmhup581g71ViUuF6LaBQKv+gxws6bZmd1LpNTCM7wql
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10333"; a="254350742"
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="254350742"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 16:16:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="687531836"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 30 Apr 2022 16:16:43 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkwKQ-0007lf-Fb;
        Sat, 30 Apr 2022 23:16:42 +0000
Date:   Sun, 1 May 2022 07:15:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:djwong-wtf 402/403] hppa-linux-ld:
 fs/xfs/xfs_trace.o(.text+0x3ffc8): cannot reach
 00005b1d_trace_event_buffer_reserve+0, recompile with -ffunction-sections
Message-ID: <202205010746.0qhhj9wz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git djwong-wtf
head:   73df1867eb274a79a99e09bfcd41398595b05dd3
commit: 7d2ec491a077ccf727b9521f635e133c380e3a5b [402/403] xfs: fallocate free space into a file
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20220501/202205010746.0qhhj9wz-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=7d2ec491a077ccf727b9521f635e133c380e3a5b
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs djwong-wtf
        git checkout 7d2ec491a077ccf727b9521f635e133c380e3a5b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> hppa-linux-ld: fs/xfs/xfs_trace.o(.text+0x3ffc8): cannot reach 00005b1d_trace_event_buffer_reserve+0, recompile with -ffunction-sections
>> hppa-linux-ld: fs/xfs/xfs_trace.o(.text+0x3ffc8): cannot handle R_PARISC_PCREL17F for trace_event_buffer_reserve
   hppa-linux-ld: final link failed: bad value

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
