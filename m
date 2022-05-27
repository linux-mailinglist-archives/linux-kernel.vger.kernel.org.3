Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14355367D0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 22:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354601AbiE0UBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 16:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237527AbiE0UBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 16:01:16 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF09CB05
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 13:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653681674; x=1685217674;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lZCMiI1VnQJ/p1KmiG1znNJG1up51Z8rbzWk22DmNF4=;
  b=UBv9BEahLqbzHa5QABbcGoGf7MGVZds1awwBDDMdAwjWf12DpzSvYo/l
   iuk5YNu1ZWRAvH6t7FrDpnRlDsVvfD00eBqBNeMwpKiIVzXIpw+lTsjln
   1Nss1GcTTELfdvTPgaSWa82uuPQQSwKjoI6gLzcNsDTXPmf2VbghA/VYJ
   1uNrRQ2zf1psMK6k1QzDeOs9vSYUdXBJFAhiNhtmSMsYtQq0EyPUQPxpM
   /+gN/sJ6d9YQ9+iOfngZMtffpYbfcRNcwAMN0HdXqRfB7aNtO/i30kj9J
   KYni81e6YBVeNOtP8HuRRLleIZlq1ER4jtCvGdZh++NVi905WGtW8Wezd
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="274666694"
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="274666694"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 13:01:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="610508086"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 May 2022 13:01:13 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nug92-00055R-L9;
        Fri, 27 May 2022 20:01:12 +0000
Date:   Sat, 28 May 2022 04:00:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     akpm <akpm@linux-foundation.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [akpm-mm:junk 1/1] init/Kconfig:1836: syntax error
Message-ID: <202205280358.pxZFVubB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git junk
head:   2b061d186be09113797ef84364c6506e7953193a
commit: 2b061d186be09113797ef84364c6506e7953193a [1/1] Merge branch 'mm-stable' into junk
config: mips-allyesconfig
compiler: mips-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=2b061d186be09113797ef84364c6506e7953193a
        git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
        git fetch --no-tags akpm-mm junk
        git checkout 2b061d186be09113797ef84364c6506e7953193a
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 ARCH=mips  allyesconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 ARCH=mips 

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> init/Kconfig:1836: syntax error
   init/Kconfig:1835: invalid statement
   init/Kconfig:1891: syntax error
   init/Kconfig:1890: invalid statement
   init/Kconfig:1891: invalid statement
>> lib/Kconfig.debug:703: syntax error
   lib/Kconfig.debug:702: invalid statement
   lib/Kconfig.debug:739: syntax error
   lib/Kconfig.debug:738: invalid statement
   lib/Kconfig.debug:739: invalid statement
   make[2]: *** [scripts/kconfig/Makefile:77: allyesconfig] Error 1
   make[1]: *** [Makefile:629: allyesconfig] Error 2
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'allyesconfig' not remade because of errors.
--
>> init/Kconfig:1836: syntax error
   init/Kconfig:1835: invalid statement
   init/Kconfig:1891: syntax error
   init/Kconfig:1890: invalid statement
   init/Kconfig:1891: invalid statement
>> lib/Kconfig.debug:703: syntax error
   lib/Kconfig.debug:702: invalid statement
   lib/Kconfig.debug:739: syntax error
   lib/Kconfig.debug:738: invalid statement
   lib/Kconfig.debug:739: invalid statement
   make[2]: *** [scripts/kconfig/Makefile:77: oldconfig] Error 1
   make[1]: *** [Makefile:629: oldconfig] Error 2
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'oldconfig' not remade because of errors.
--
>> init/Kconfig:1836: syntax error
   init/Kconfig:1835: invalid statement
   init/Kconfig:1891: syntax error
   init/Kconfig:1890: invalid statement
   init/Kconfig:1891: invalid statement
>> lib/Kconfig.debug:703: syntax error
   lib/Kconfig.debug:702: invalid statement
   lib/Kconfig.debug:739: syntax error
   lib/Kconfig.debug:738: invalid statement
   lib/Kconfig.debug:739: invalid statement
   make[2]: *** [scripts/kconfig/Makefile:77: olddefconfig] Error 1
   make[1]: *** [Makefile:629: olddefconfig] Error 2
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'olddefconfig' not remade because of errors.


vim +1836 init/Kconfig

0793a61d4df8da Thomas Gleixner   2008-12-04  1834  
2b061d186be091 Andrew Morton     2022-05-27  1835  <<<<<<< HEAD
f8891e5e1f93a1 Christoph Lameter 2006-06-30 @1836  config VM_EVENT_COUNTERS
f8891e5e1f93a1 Christoph Lameter 2006-06-30  1837  	default y
6a108a14fa356e David Rientjes    2011-01-20  1838  	bool "Enable VM event counters for /proc/vmstat" if EXPERT
f8891e5e1f93a1 Christoph Lameter 2006-06-30  1839  	help
2aea4fb61609ba Paul Jackson      2006-12-22  1840  	  VM event counters are needed for event counts to be shown.
2aea4fb61609ba Paul Jackson      2006-12-22  1841  	  This option allows the disabling of the VM event counters
6a108a14fa356e David Rientjes    2011-01-20  1842  	  on EXPERT systems.  /proc/vmstat will only show page counts
2aea4fb61609ba Paul Jackson      2006-12-22  1843  	  if VM event counters are disabled.
f8891e5e1f93a1 Christoph Lameter 2006-06-30  1844  

:::::: The code at line 1836 was first introduced by commit
:::::: f8891e5e1f93a128c3900f82035e8541357896a7 [PATCH] Light weight event counters

:::::: TO: Christoph Lameter <clameter@sgi.com>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
