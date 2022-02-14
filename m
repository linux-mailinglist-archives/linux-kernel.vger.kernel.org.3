Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414104B3FC1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 03:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbiBNCse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 21:48:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbiBNCsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 21:48:33 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27693F882
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 18:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644806905; x=1676342905;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QGWxKqDhs1yAt74sVIjYk8Q5hgilS7buJkuGWiuDDxU=;
  b=NzovQL/eEF3SpS17Ylu6zDf20mzxB2bx2FG+TgLAejmfkxtbERxS/pg0
   0/BNw4TfibLu2I+kMFTVL7ngIrXMuktA4uQ0vUwYHsLkonry0u6pmHv1s
   PQ1ftjROdLiMXZX/tyu2TTQWwvIEoa9P42hR4nhXBac7T5z7Tj9FRo6Mo
   HOQcBjiV9F1CBL7Swu6Z2gQZyQ3fvQV6oxwtBa2FI3wsf5PjbJqB2n0F0
   7Su/WgRHEH7izZBwnL5jeb23c21mb/piE/6Elqi9JIlMdQJdvPS9v9yVE
   OLb12yaM/ZeyfBZIQgLOambarWD1bA/9fv5JwfJN4EBA48kAaawbVQOUI
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="229961488"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="229961488"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 18:48:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="527803825"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 13 Feb 2022 18:48:24 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJRPb-00086l-Kf; Mon, 14 Feb 2022 02:48:23 +0000
Date:   Mon, 14 Feb 2022 10:47:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/wip.ibt 7/15] arch/x86/kernel/setup.c:66:1: error:
 'nocf_check' attribute ignored. Use '-fcf-protection' option to enable it
Message-ID: <202202141030.qhNGDbYM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt
head:   ede73fa4e97e8f275401a989b8d9df192a2c3ec4
commit: 9947fe456516712bd4df7139f2ff329cc14ba745 [7/15] x86: Don't generate ENDBR in .discard.text
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220214/202202141030.qhNGDbYM-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=9947fe456516712bd4df7139f2ff329cc14ba745
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/wip.ibt
        git checkout 9947fe456516712bd4df7139f2ff329cc14ba745
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/x86/kernel/setup.c:66:1: error: 'nocf_check' attribute ignored. Use '-fcf-protection' option to enable it [-Werror=attributes]
      66 | RESERVE_BRK(dmi_alloc, 65536);
         | ^~~~~~~~~~~
   cc1: all warnings being treated as errors
--
>> arch/x86/mm/init.c:178:1: error: 'nocf_check' attribute ignored. Use '-fcf-protection' option to enable it [-Werror=attributes]
     178 | RESERVE_BRK(early_pgt_alloc, INIT_PGT_BUF_SIZE);
         | ^~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +66 arch/x86/kernel/setup.c

2b72394e408964 Pekka Enberg                  2009-04-28  64  
e808bae2407a08 Thadeu Lima de Souza Cascardo 2010-02-09  65  #ifdef CONFIG_DMI
796216a57fe45c Jeremy Fitzhardinge           2009-03-12 @66  RESERVE_BRK(dmi_alloc, 65536);
e808bae2407a08 Thadeu Lima de Souza Cascardo 2010-02-09  67  #endif
796216a57fe45c Jeremy Fitzhardinge           2009-03-12  68  
c0b5842a457d44 Ingo Molnar                   2009-01-27  69  

:::::: The code at line 66 was first introduced by commit
:::::: 796216a57fe45c04adc35bda1f0782efec78a713 x86: allow extend_brk users to reserve brk space

:::::: TO: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
:::::: CC: H. Peter Anvin <hpa@zytor.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
