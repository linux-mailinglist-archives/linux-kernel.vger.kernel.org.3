Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6EC4DC49E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbiCQLR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiCQLRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:17:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F98B1E31BF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647515788; x=1679051788;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UweCBt6LWPtIYG/hnRsZ6yBQNXQcxZmxaX8gXGfKN/A=;
  b=TidvngUvNu+KP7RCPMcJRGVFW1CYXzbKfyqU0OsQKax1igsRkYVTKs6G
   qLrNkuLj7/jDKJ4GbrtGNOthMdjQBfXAzAEYEjXpYyHWeuJkzp/pY+2sx
   QXrFJL/XbBsWOwyptv+j6nGG6PQ6uhR3MJ/w4WIZqgWsmoNTxuwGSUYfF
   G9sN1LqSdXQmeX5vgbvjDfh9YQzqqtxLoFD22WWkdA88Sun2KeELtTXki
   Om8cMFtCnCxVlo10CmRm0MowQnBbbH7Lyuf1ShSEvtckSnwqdFQYmdfdm
   JzFpq5rTGJ045zIplrlwfmaFLkr3gIIntl/qTt7x4srXwXdYhDyPiki+3
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="236785908"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="236785908"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 04:16:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="714995701"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 17 Mar 2022 04:16:27 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUo7G-000Dd2-AC; Thu, 17 Mar 2022 11:16:26 +0000
Date:   Thu, 17 Mar 2022 19:15:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 1788/2335] lib/memcat_p.c:10:8: warning: no
 previous prototype for '__memcat_p'
Message-ID: <202203171924.u5fkdJOH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: f4a35864aeccc248d3c2122bf0a8f2ba77ea8c2f [1788/2335] headers/deps: smp: Optimize <linux/smp.h> dependencies, remove <linux/smp_api.h> inclusion
config: i386-randconfig-a001-20220314 (https://download.01.org/0day-ci/archive/20220317/202203171924.u5fkdJOH-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=f4a35864aeccc248d3c2122bf0a8f2ba77ea8c2f
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout f4a35864aeccc248d3c2122bf0a8f2ba77ea8c2f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> lib/memcat_p.c:10:8: warning: no previous prototype for '__memcat_p' [-Wmissing-prototypes]
      10 | void **__memcat_p(void **a, void **b)
         |        ^~~~~~~~~~


vim +/__memcat_p +10 lib/memcat_p.c

93048c0944150b Alexander Shishkin 2018-10-16   4  
93048c0944150b Alexander Shishkin 2018-10-16   5  /*
93048c0944150b Alexander Shishkin 2018-10-16   6   * Merge two NULL-terminated pointer arrays into a newly allocated
93048c0944150b Alexander Shishkin 2018-10-16   7   * array, which is also NULL-terminated. Nomenclature is inspired by
93048c0944150b Alexander Shishkin 2018-10-16   8   * memset_p() and memcat() found elsewhere in the kernel source tree.
93048c0944150b Alexander Shishkin 2018-10-16   9   */
93048c0944150b Alexander Shishkin 2018-10-16 @10  void **__memcat_p(void **a, void **b)

:::::: The code at line 10 was first introduced by commit
:::::: 93048c0944150b316a15f92c41a4d626c8df37fd lib: Fix ia64 bootloader linkage

:::::: TO: Alexander Shishkin <alexander.shishkin@linux.intel.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
