Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5874E4D9BED
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348569AbiCONPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241900AbiCONPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:15:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092E4522DE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647350036; x=1678886036;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+20xdbajyHFSen4Yu/rVLmjmpfu9q7FELU8hGBn0ELs=;
  b=XFDglky8yR51PzQ4kwE/24lMIZnQM+faWXGhcffAEMjeb786Uug8EhmK
   vuQTJDhBDKTxJUB4KjjCP0s7y7eGzDHsCjnBA4FD9c4U2GXxHTQYhKEsu
   ydOSic5aPAXI/wJK7s1XS6wQ/c57O/dMt8Zhol+hEe6C/foh9dvUSchrF
   CyBJXFsRXviF1HbiALa9ZbBlodkUWUQtTkKU/amKRjh6jkONztdLXKFwF
   Fr59NfV6nMlZ6C70aGmSiAc5y1JGPMxgV6SI9fMkJ+5KR0XIAhCasYnwu
   E3NU+V+tLVu8wVa8zOL3Pw3++b+KbS7AsWVJYbTmS89faLlkgzGccrS76
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256021506"
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="256021506"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 06:13:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="714151227"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 15 Mar 2022 06:13:54 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nU6zp-000B0m-Kn; Tue, 15 Mar 2022 13:13:53 +0000
Date:   Tue, 15 Mar 2022 21:13:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/core 16/16] kernel/sched/core.c:5220:20: warning:
 no previous prototype for 'task_sched_runtime'
Message-ID: <202203152116.qphmikIZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/core
head:   4ff8f2ca6ccd9e0cc5665d09f86d631b3ae3a14c
commit: 4ff8f2ca6ccd9e0cc5665d09f86d631b3ae3a14c [16/16] sched/headers: Reorganize, clean up and optimize kernel/sched/sched.h dependencies
config: nds32-allnoconfig (https://download.01.org/0day-ci/archive/20220315/202203152116.qphmikIZ-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=4ff8f2ca6ccd9e0cc5665d09f86d631b3ae3a14c
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/core
        git checkout 4ff8f2ca6ccd9e0cc5665d09f86d631b3ae3a14c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/sched/core.c:5220:20: warning: no previous prototype for 'task_sched_runtime' [-Wmissing-prototypes]
    5220 | unsigned long long task_sched_runtime(struct task_struct *p)
         |                    ^~~~~~~~~~~~~~~~~~
>> kernel/sched/core.c:9403:13: warning: no previous prototype for 'sched_init_smp' [-Wmissing-prototypes]
    9403 | void __init sched_init_smp(void)
         |             ^~~~~~~~~~~~~~
>> kernel/sched/core.c:9431:13: warning: no previous prototype for 'sched_init' [-Wmissing-prototypes]
    9431 | void __init sched_init(void)
         |             ^~~~~~~~~~


vim +/task_sched_runtime +5220 kernel/sched/core.c

6075620b0590eaf kernel/sched/core.c Giovanni Gherdovich 2016-08-05  5214  
c5f8d99585d7b5b kernel/sched.c      Hidetoshi Seto      2009-03-31  5215  /*
c5f8d99585d7b5b kernel/sched.c      Hidetoshi Seto      2009-03-31  5216   * Return accounted runtime for the task.
c5f8d99585d7b5b kernel/sched.c      Hidetoshi Seto      2009-03-31  5217   * In case the task is currently running, return the runtime plus current's
c5f8d99585d7b5b kernel/sched.c      Hidetoshi Seto      2009-03-31  5218   * pending runtime that have not been accounted yet.
c5f8d99585d7b5b kernel/sched.c      Hidetoshi Seto      2009-03-31  5219   */
c5f8d99585d7b5b kernel/sched.c      Hidetoshi Seto      2009-03-31 @5220  unsigned long long task_sched_runtime(struct task_struct *p)
c5f8d99585d7b5b kernel/sched.c      Hidetoshi Seto      2009-03-31  5221  {
eb58075149b7f03 kernel/sched/core.c Peter Zijlstra      2015-07-31  5222  	struct rq_flags rf;
c5f8d99585d7b5b kernel/sched.c      Hidetoshi Seto      2009-03-31  5223  	struct rq *rq;
6e998916dfe327e kernel/sched/core.c Stanislaw Gruszka   2014-11-12  5224  	u64 ns;
c5f8d99585d7b5b kernel/sched.c      Hidetoshi Seto      2009-03-31  5225  

:::::: The code at line 5220 was first introduced by commit
:::::: c5f8d99585d7b5b7e857fabf8aefd0174903a98c posixtimers, sched: Fix posix clock monotonicity

:::::: TO: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
:::::: CC: Ingo Molnar <mingo@elte.hu>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
