Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD554BAC97
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 23:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343868AbiBQWcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 17:32:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiBQWcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 17:32:23 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8071688D2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 14:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645137127; x=1676673127;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NISdFQeSYumSP1wtlba0+QY9T1xu+cd7/z8epP4hEME=;
  b=Wt71WiyD0gQz6/7q10kLPSZMAk/HA54X8rY0DkDnAoCczmqxtVoKudDZ
   3I9upELOHXzjONPtBS2RaIn0b0Ff+n6xs0DW0PIkXHDwWutnxrz3hcfNu
   6yRImeUk0rEPwHgcQE2MCUcKgL9hZv5KLQ+tZaLtoJUcRQjP9BDLDHneH
   ULpO/2nYZyrm7NDG83TUQ4n6L+4GlYgdAMdTE4I6opgSZpYLv7vgLxzRs
   DJ0N0TPzQmDehyOWFiT4xIFXtbNZAPBWU0hhlwpeFtDDyZfQ3ejnMjoH5
   H3pW2VFJy8XIwXQgqWq4a+JUc0v9mbDSGjQbCKC2Blqm2WWJk0VGcBpL+
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="234522136"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="234522136"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 14:32:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="503727001"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 17 Feb 2022 14:32:05 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKpJl-0000hT-2A; Thu, 17 Feb 2022 22:32:05 +0000
Date:   Fri, 18 Feb 2022 06:31:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/wip.ibt 23/24]
 arch/x86/kernel/alternative.c:757:48: error: expected ')' before
 'ANNOTATE_NOENDBR'
Message-ID: <202202180629.eWa6TvBL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt
head:   20f0cd68b8d42470e0a0459aa5db23d7dae8f83d
commit: 55d18ec3a2c0a2b4890ed79db60259d5623a59ca [23/24] x86/ibt: fixes
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220218/202202180629.eWa6TvBL-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=55d18ec3a2c0a2b4890ed79db60259d5623a59ca
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/wip.ibt
        git checkout 55d18ec3a2c0a2b4890ed79db60259d5623a59ca
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/x86/kernel/alternative.c:757:48: error: expected ')' before 'ANNOTATE_NOENDBR'
     757 | " .pushsection .init.text, \"ax\", @progbits\n"
         |                                                ^
         |                                                )
   ......
     760 |  ANNOTATE_NOENDBR
         |  ~~~~~~~~~~~~~~~~                               
   arch/x86/kernel/alternative.c:756:5: note: to match this '('
     756 | asm (
         |     ^
--
   arch/x86/lib/retpoline.S: Assembler messages:
>> arch/x86/lib/retpoline.S:15: Error: no such instruction: `annotate_noendbr'


vim +757 arch/x86/kernel/alternative.c

ecc606103837b9 Peter Zijlstra 2019-07-08  755  
ecc606103837b9 Peter Zijlstra 2019-07-08  756  asm (
ecc606103837b9 Peter Zijlstra 2019-07-08 @757  "	.pushsection	.init.text, \"ax\", @progbits\n"
ecc606103837b9 Peter Zijlstra 2019-07-08  758  "	.type		int3_magic, @function\n"
ecc606103837b9 Peter Zijlstra 2019-07-08  759  "int3_magic:\n"
55d18ec3a2c0a2 Peter Zijlstra 2022-02-17  760  	ANNOTATE_NOENDBR
ecc606103837b9 Peter Zijlstra 2019-07-08  761  "	movl	$1, (%" _ASM_ARG1 ")\n"
b17c2baa305ccc Peter Zijlstra 2021-12-04  762  	ASM_RET
ecc606103837b9 Peter Zijlstra 2019-07-08  763  "	.size		int3_magic, .-int3_magic\n"
ecc606103837b9 Peter Zijlstra 2019-07-08  764  "	.popsection\n"
ecc606103837b9 Peter Zijlstra 2019-07-08  765  );
7457c0da024b18 Peter Zijlstra 2019-05-03  766  

:::::: The code at line 757 was first introduced by commit
:::::: ecc606103837b98a2b665e8f14e533a6c72bbdc0 x86/alternatives: Fix int3_emulate_call() selftest stack corruption

:::::: TO: Peter Zijlstra <peterz@infradead.org>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
