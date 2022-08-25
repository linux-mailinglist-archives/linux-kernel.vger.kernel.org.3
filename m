Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76865A1A31
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 22:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237828AbiHYUVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 16:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiHYUVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 16:21:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A86DBBA60
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 13:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661458901; x=1692994901;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vIMrk+gHFNYfF1f1RBRo7xdPhB8tzua6kM75IZDVmkQ=;
  b=HGMupn86K2QaQxAAbOlg0OP6JSLznPvsi0uJPVJ3brROsn3v651bWn3+
   6OlyOfGmE3R/AFyw1x7z7oDpaoMlqb+bLkBQ4nRKY/aqHjKoq1OXghtXM
   BIY65Vmnh2QvZNhNEatYeancwbvQwg4Q/KleaRTooSnK4D8Il1mZiHp9z
   pGpLjZQS3o17C0ob+wjvmHRQPidCv70EwUEm3waGUS+YnUyOewXprpuXL
   Y61P7IjIa+RRFiWAqU2p2aAr/yPvdi6GAevZ0CJ5rcLat/NdP0kG99AxG
   BxPAnfNpELCeF2kIOcPdPBaBeKD3znbP9ht67qj6S+5PrPhQJ7cVmMd1k
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="295130614"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="295130614"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 13:21:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="752627209"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 25 Aug 2022 13:21:39 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRJMA-0002qi-1O;
        Thu, 25 Aug 2022 20:21:38 +0000
Date:   Fri, 26 Aug 2022 04:20:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:perf/wip.rewrite 1/8]
 arch/s390/kernel/perf_pai_crypto.c:438:25: error: initialization of 'void
 (*)(struct perf_event_pmu_context *, bool)' {aka 'void (*)(struct
 perf_event_pmu_context *, _Bool)'} from incompatible pointer type 'void
 (*)(struct perf_event_context *, bool)' {ak...
Message-ID: <202208260405.2IwYS5s3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/wip.rewrite
head:   b149fd14e2fb487c8d8b07d353421101c33bbf2b
commit: 9cfa6ca70dab0951f2631f8baf29e1370925b4d6 [1/8] perf: Rewrite core context handling
config: s390-randconfig-r044-20220824 (https://download.01.org/0day-ci/archive/20220826/202208260405.2IwYS5s3-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=9cfa6ca70dab0951f2631f8baf29e1370925b4d6
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue perf/wip.rewrite
        git checkout 9cfa6ca70dab0951f2631f8baf29e1370925b4d6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/s390/kernel/perf_pai_crypto.c:438:25: error: initialization of 'void (*)(struct perf_event_pmu_context *, bool)' {aka 'void (*)(struct perf_event_pmu_context *, _Bool)'} from incompatible pointer type 'void (*)(struct perf_event_context *, bool)' {aka 'void (*)(struct perf_event_context *, _Bool)'} [-Werror=incompatible-pointer-types]
     438 |         .sched_task   = paicrypt_sched_task,
         |                         ^~~~~~~~~~~~~~~~~~~
   arch/s390/kernel/perf_pai_crypto.c:438:25: note: (near initialization for 'paicrypt.sched_task')
   cc1: some warnings being treated as errors


vim +438 arch/s390/kernel/perf_pai_crypto.c

39d62336f5c126 Thomas Richter 2022-05-04  428  
39d62336f5c126 Thomas Richter 2022-05-04  429  /* Performance monitoring unit for mapped counters */
39d62336f5c126 Thomas Richter 2022-05-04  430  static struct pmu paicrypt = {
39d62336f5c126 Thomas Richter 2022-05-04  431  	.task_ctx_nr  = perf_invalid_context,
39d62336f5c126 Thomas Richter 2022-05-04  432  	.event_init   = paicrypt_event_init,
39d62336f5c126 Thomas Richter 2022-05-04  433  	.add	      = paicrypt_add,
39d62336f5c126 Thomas Richter 2022-05-04  434  	.del	      = paicrypt_del,
39d62336f5c126 Thomas Richter 2022-05-04  435  	.start	      = paicrypt_start,
39d62336f5c126 Thomas Richter 2022-05-04  436  	.stop	      = paicrypt_stop,
39d62336f5c126 Thomas Richter 2022-05-04  437  	.read	      = paicrypt_read,
39d62336f5c126 Thomas Richter 2022-05-04 @438  	.sched_task   = paicrypt_sched_task,
39d62336f5c126 Thomas Richter 2022-05-04  439  	.attr_groups  = paicrypt_attr_groups
39d62336f5c126 Thomas Richter 2022-05-04  440  };
39d62336f5c126 Thomas Richter 2022-05-04  441  

:::::: The code at line 438 was first introduced by commit
:::::: 39d62336f5c126ad6dccdf66cd249f2d0e86d3c9 s390/pai: add support for cryptography counters

:::::: TO: Thomas Richter <tmricht@linux.ibm.com>
:::::: CC: Heiko Carstens <hca@linux.ibm.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
