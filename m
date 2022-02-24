Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952194C2414
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 07:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiBXG2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 01:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiBXG2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 01:28:37 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E21DCA0F0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 22:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645684087; x=1677220087;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=up+fFLtCvzSit6/nAfnwouRZf6sHsZQetM34qZYRsB4=;
  b=fOQyyOfHYvV4TSKpkXy7Y6ws3TwxMxtPY8TF/MK5Od5FyJSQvD0rjkLk
   9VFm92L3iH/40/OzadQMwfgqzZ9rCdK69j9kfjzMoVsFaw0Ag6l/x/Xmk
   9nQAKLflYsHg0F8Dm4I+JGgPoObqovjrGMMbesL3ANF9xuiXv4AIPiasj
   8SovsIXVF6Om8w/S/j2qGfdW1eEMmSvGUUqO5ZQmUC9ZWsa7d5K+r4DeB
   EimxVXJjgRhyu7rJsVjQ1B8sK3h9FrlEfvUQ87uJZltncLvDA5Fe1b31x
   6yoOTIyjK4eMC69Vox8nY5AKcrPYR5hYgFdW1qA5wKxWFbTDgTbr/JyCK
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="232136620"
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="232136620"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 22:28:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="491490235"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 Feb 2022 22:28:06 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN7bh-0002Lr-9g; Thu, 24 Feb 2022 06:28:05 +0000
Date:   Thu, 24 Feb 2022 14:27:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/wip.ibt 27/42]
 arch/x86/kernel/alternative.c:713:48: error: expected ')' before
 'ANNOTATE_NOENDBR'
Message-ID: <202202241413.vjfNrYxY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt
head:   27b6438f414b6a37b60dcd90c8980397586d49db
commit: 894eca106331b66d8f1c261d40386c043da75ee2 [27/42] x86/ibt: Annotate text references
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220224/202202241413.vjfNrYxY-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=894eca106331b66d8f1c261d40386c043da75ee2
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/wip.ibt
        git checkout 894eca106331b66d8f1c261d40386c043da75ee2
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/x86/kernel/alternative.c:713:48: error: expected ')' before 'ANNOTATE_NOENDBR'
     713 | " .pushsection .init.text, \"ax\", @progbits\n"
         |                                                ^
         |                                                )
   ......
     716 |  ANNOTATE_NOENDBR
         |  ~~~~~~~~~~~~~~~~                               
   arch/x86/kernel/alternative.c:712:5: note: to match this '('
     712 | asm (
         |     ^
   arch/x86/kernel/alternative.c: In function 'int3_selftest':
   arch/x86/kernel/alternative.c:761:16: error: expected string literal before 'ANNOTATE_NOENDBR'
     761 |  asm volatile (ANNOTATE_NOENDBR
         |                ^~~~~~~~~~~~~~~~


vim +713 arch/x86/kernel/alternative.c

ecc606103837b98 Peter Zijlstra 2019-07-08  711  
ecc606103837b98 Peter Zijlstra 2019-07-08  712  asm (
ecc606103837b98 Peter Zijlstra 2019-07-08 @713  "	.pushsection	.init.text, \"ax\", @progbits\n"
ecc606103837b98 Peter Zijlstra 2019-07-08  714  "	.type		int3_magic, @function\n"
ecc606103837b98 Peter Zijlstra 2019-07-08  715  "int3_magic:\n"
894eca106331b66 Peter Zijlstra 2022-02-17  716  	ANNOTATE_NOENDBR
ecc606103837b98 Peter Zijlstra 2019-07-08  717  "	movl	$1, (%" _ASM_ARG1 ")\n"
b17c2baa305cccb Peter Zijlstra 2021-12-04  718  	ASM_RET
ecc606103837b98 Peter Zijlstra 2019-07-08  719  "	.size		int3_magic, .-int3_magic\n"
ecc606103837b98 Peter Zijlstra 2019-07-08  720  "	.popsection\n"
ecc606103837b98 Peter Zijlstra 2019-07-08  721  );
7457c0da024b181 Peter Zijlstra 2019-05-03  722  

:::::: The code at line 713 was first introduced by commit
:::::: ecc606103837b98a2b665e8f14e533a6c72bbdc0 x86/alternatives: Fix int3_emulate_call() selftest stack corruption

:::::: TO: Peter Zijlstra <peterz@infradead.org>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
