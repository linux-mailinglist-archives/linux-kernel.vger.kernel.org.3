Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EE6535061
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 16:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347598AbiEZOMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 10:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiEZOML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:12:11 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3686C1ED2
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653574329; x=1685110329;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cdS+6RMM6jUt8rBjDLC4rrEek6GHvI0IU671aslbkgI=;
  b=cstftcE+fK26aLNdsuDM1IX9j8rNE489CeJqwSA94+Q8HYGLfoOF5ncr
   JYJGHrYN8xu0DeCSfgbj5JS9nGVSkzZlchiRMejiVVjkOpmALd1A2c9Ap
   EQ5k42UUN5MSaby8V3oFk2d4BhGvEzAkL5XEZWKHi2kFwDzuGqSe5t4tY
   AEYMZ5/Ssu2H9bgtxjn/OjNuQKNN2TNkBWv/+L+Stem2Oge3DlzGl1ykG
   wDtOw65GV4edxgXpc5vh0MYxE4+kay7NPIszfL6nKsNy5APaiLcWSVrXp
   jt9RdeW6vPoR5kEEEVBkgjPBamN1Hb+XyO4mVmsH7G2AP3J+aj+5nQNkw
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="254040173"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="254040173"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 07:12:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="630931545"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 26 May 2022 07:12:08 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuEDf-0003uu-Kt;
        Thu, 26 May 2022 14:12:07 +0000
Date:   Thu, 26 May 2022 22:11:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: [peterz-queue:objtool/urgent 9/9]
 arch/x86/include/asm/extable.h:47:86: warning: 'noreturn' function does
 return
Message-ID: <202205262227.2m2DJfpJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git objtool/urgent
head:   43c6fc6a431b43163dc3950543dd87b986f25945
commit: 43c6fc6a431b43163dc3950543dd87b986f25945 [9/9] x86/extable: Annotate ex_handler_msr_mce() as a dead end
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220526/202205262227.2m2DJfpJ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=43c6fc6a431b43163dc3950543dd87b986f25945
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue objtool/urgent
        git checkout 43c6fc6a431b43163dc3950543dd87b986f25945
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/mm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/x86/include/asm/uaccess.h:13,
                    from include/linux/uaccess.h:11,
                    from arch/x86/mm/extable.c:3:
   arch/x86/include/asm/extable.h: In function 'ex_handler_msr_mce':
>> arch/x86/include/asm/extable.h:47:86: warning: 'noreturn' function does return
      47 | static inline void __noreturn ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr) { }
         |                                                                                      ^


vim +/noreturn +47 arch/x86/include/asm/extable.h

    43	
    44	#ifdef CONFIG_X86_MCE
    45	extern void __noreturn ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr);
    46	#else
  > 47	static inline void __noreturn ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr) { }
    48	#endif
    49	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
