Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E57E4C2320
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 05:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiBXEpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 23:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiBXEpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 23:45:34 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145CA264985
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 20:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645677905; x=1677213905;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CzNFSh3HQX2KJlV4tUqEe8X057Jh8LUPE6ZUJyiLbMc=;
  b=a7A1Dp95ojaG09UhGi5Jabd7XXjRitvMlPUnvXu9ZqYryW+taVYQkDc6
   JoJAUwp9mn3VDypfXBHKboo8xl5JfhS7yDVz+I+bUi0w8h3scLrnZfXIX
   roZP9loTIFiVUby2MFONlq/IWxjOmRUDVKYMkcPLsyHSjZWXLSRAgPuw9
   0lwW+/6XASrhtmDL9gc8oso+zxyalnn9xNEFitKagehRpdjBU2q4Qblq7
   xefky51iMP+hFwOCSPaHlhE/qGhNCxPaxNFK9QjiPW1ZDDl/cqaHc/ZLf
   PKayrWgXKl8wbGMc+qIZP8lUk46kuH1iVsKELA9QEN/Xbk6erSS9Uhmly
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="250977292"
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="250977292"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 20:45:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="574080555"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 23 Feb 2022 20:45:03 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN5zy-0002H5-L6; Thu, 24 Feb 2022 04:45:02 +0000
Date:   Thu, 24 Feb 2022 12:44:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/wip.ibt 25/42] arch/x86/include/asm/ibt.h:63:15:
 error: unknown type name 'u64'
Message-ID: <202202241208.n3vmbrZZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt
head:   27b6438f414b6a37b60dcd90c8980397586d49db
commit: 3910f0559d1462af4095e3e1248686dd2d74eb99 [25/42] x86: Disable IBT around firmware
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220224/202202241208.n3vmbrZZ-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=3910f0559d1462af4095e3e1248686dd2d74eb99
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/wip.ibt
        git checkout 3910f0559d1462af4095e3e1248686dd2d74eb99
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/include/asm/linkage.h:6,
                    from include/linux/linkage.h:8,
                    from include/linux/fs.h:5,
                    from include/linux/tty.h:5,
                    from arch/um/drivers/stdio_console.c:7:
   arch/x86/include/asm/ibt.h:61:15: error: unknown type name 'bool'
      61 | static inline bool is_endbr(unsigned int val) { return false; }
         |               ^~~~
>> arch/x86/include/asm/ibt.h:63:15: error: unknown type name 'u64'
      63 | static inline u64 ibt_save(void) { return 0; }
         |               ^~~
   arch/x86/include/asm/ibt.h:64:32: error: unknown type name 'u64'
      64 | static inline void ibt_restore(u64 save) { }
         |                                ^~~
--
   In file included from arch/x86/include/asm/linkage.h:6,
                    from include/linux/linkage.h:8,
                    from include/linux/fs.h:5,
                    from arch/um/drivers/ssl.c:6:
   arch/x86/include/asm/ibt.h:61:15: error: unknown type name 'bool'
      61 | static inline bool is_endbr(unsigned int val) { return false; }
         |               ^~~~
   arch/x86/include/asm/ibt.h: In function 'is_endbr':
   arch/x86/include/asm/ibt.h:61:56: error: 'false' undeclared (first use in this function)
      61 | static inline bool is_endbr(unsigned int val) { return false; }
         |                                                        ^~~~~
   arch/x86/include/asm/ibt.h:61:56: note: each undeclared identifier is reported only once for each function it appears in
   arch/x86/include/asm/ibt.h: At top level:
>> arch/x86/include/asm/ibt.h:63:15: error: unknown type name 'u64'
      63 | static inline u64 ibt_save(void) { return 0; }
         |               ^~~
   arch/x86/include/asm/ibt.h:64:32: error: unknown type name 'u64'
      64 | static inline void ibt_restore(u64 save) { }
         |                                ^~~
--
   In file included from arch/x86/include/asm/linkage.h:6,
                    from include/linux/linkage.h:8,
                    from include/linux/fs.h:5,
                    from fs/proc/meminfo.c:2:
   arch/x86/include/asm/ibt.h:61:15: error: unknown type name 'bool'
      61 | static inline bool is_endbr(unsigned int val) { return false; }
         |               ^~~~
   arch/x86/include/asm/ibt.h: In function 'is_endbr':
   arch/x86/include/asm/ibt.h:61:56: error: 'false' undeclared (first use in this function)
      61 | static inline bool is_endbr(unsigned int val) { return false; }
         |                                                        ^~~~~
   arch/x86/include/asm/ibt.h:61:56: note: each undeclared identifier is reported only once for each function it appears in
   arch/x86/include/asm/ibt.h: At top level:
>> arch/x86/include/asm/ibt.h:63:15: error: unknown type name 'u64'
      63 | static inline u64 ibt_save(void) { return 0; }
         |               ^~~
   arch/x86/include/asm/ibt.h:64:32: error: unknown type name 'u64'
      64 | static inline void ibt_restore(u64 save) { }
         |                                ^~~
   fs/proc/meminfo.c:22:28: warning: no previous prototype for 'arch_report_meminfo' [-Wmissing-prototypes]
      22 | void __attribute__((weak)) arch_report_meminfo(struct seq_file *m)
         |                            ^~~~~~~~~~~~~~~~~~~


vim +/u64 +63 arch/x86/include/asm/ibt.h

    60	
  > 61	static inline bool is_endbr(unsigned int val) { return false; }
    62	
  > 63	static inline u64 ibt_save(void) { return 0; }
    64	static inline void ibt_restore(u64 save) { }
    65	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
