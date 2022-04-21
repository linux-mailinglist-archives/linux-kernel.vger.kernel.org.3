Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377DE50982A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385316AbiDUGuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385172AbiDUGrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:47:21 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54DC1571E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523435; x=1682059435;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7KXzTwUe1iXGr9kDF7hwATHlkcfdunw0lijaUMYydCU=;
  b=L0xRb7SRciw9gx8mcq+JZcYfa5DIc1Og5YSuxBMOSp/8fhI4tFl5Bx2Y
   /a5rFeC0NO6IpizSvZUGYL6yBBOQhBPbXZZLdp8k6klfQn2O8Qen5QPO4
   nQCFYEEEfiryi0NivYht4pUqXQDqKyL3g89SgtegkBiVpIBFRDxMcmdjT
   sSVK4Wa7e/zkBRwCHFQtypdeXBO1ZRLEj4ND8c9WVy1ELYO3uF6lhoMT5
   vXiqY4iWf5gPW2he6MJkRdAujwqwNBDuz90fH7A3qPOEj05peKEl0WELP
   hma27kPO0uPP15LjI3FTCjZwEfbpsjmYZlWAtdYhtvi1zW8+3tZ2N5KO4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="264022264"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="264022264"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:43:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="532792902"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 20 Apr 2022 23:43:51 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQXf-00080m-0P;
        Thu, 21 Apr 2022 06:43:51 +0000
Date:   Thu, 21 Apr 2022 14:43:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2441/2579] include/linux/fs_api.h:424:29:
 error: static declaration of 'file_inode' follows non-static declaration
Message-ID: <202204210634.Db7gTUaE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: 5e5b9f1427ab55c511d68e2ee5471cbeabf50830 [2441/2579] headers/deps: mm: Optimize <linux/pagemap.h> dependencies
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220421/202204210634.Db7gTUaE-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=5e5b9f1427ab55c511d68e2ee5471cbeabf50830
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 5e5b9f1427ab55c511d68e2ee5471cbeabf50830
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/ubifs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from fs/ubifs/budget.c:21:
   In file included from fs/ubifs/ubifs.h:40:
   include/linux/fscrypt.h:758:30: error: implicit declaration of function 'file_inode' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           const struct inode *inode = file_inode(iocb->ki_filp);
                                       ^
   include/linux/fscrypt.h:758:30: note: did you mean 'folio_inode'?
   include/linux/pagemap.h:375:29: note: 'folio_inode' declared here
   static inline struct inode *folio_inode(struct folio *folio)
                               ^
   In file included from fs/ubifs/budget.c:21:
   In file included from fs/ubifs/ubifs.h:40:
   include/linux/fscrypt.h:758:22: warning: incompatible integer to pointer conversion initializing 'const struct inode *' with an expression of type 'int' [-Wint-conversion]
           const struct inode *inode = file_inode(iocb->ki_filp);
                               ^       ~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from fs/ubifs/budget.c:22:
   In file included from include/linux/writeback_api.h:16:
   In file included from include/linux/backing-dev-api.h:16:
>> include/linux/fs_api.h:424:29: error: static declaration of 'file_inode' follows non-static declaration
   static inline struct inode *file_inode(const struct file *f)
                               ^
   include/linux/fscrypt.h:758:30: note: previous implicit declaration is here
           const struct inode *inode = file_inode(iocb->ki_filp);
                                       ^
   1 warning and 2 errors generated.
--
   In file included from fs/ubifs/file.c:40:
   In file included from fs/ubifs/ubifs.h:40:
   include/linux/fscrypt.h:758:30: error: implicit declaration of function 'file_inode' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           const struct inode *inode = file_inode(iocb->ki_filp);
                                       ^
   include/linux/fscrypt.h:758:30: note: did you mean 'folio_inode'?
   include/linux/pagemap.h:375:29: note: 'folio_inode' declared here
   static inline struct inode *folio_inode(struct folio *folio)
                               ^
   In file included from fs/ubifs/file.c:40:
   In file included from fs/ubifs/ubifs.h:40:
   include/linux/fscrypt.h:758:22: warning: incompatible integer to pointer conversion initializing 'const struct inode *' with an expression of type 'int' [-Wint-conversion]
           const struct inode *inode = file_inode(iocb->ki_filp);
                               ^       ~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from fs/ubifs/file.c:42:
   In file included from include/linux/writeback_api.h:16:
   In file included from include/linux/backing-dev-api.h:16:
>> include/linux/fs_api.h:424:29: error: static declaration of 'file_inode' follows non-static declaration
   static inline struct inode *file_inode(const struct file *f)
                               ^
   include/linux/fscrypt.h:758:30: note: previous implicit declaration is here
           const struct inode *inode = file_inode(iocb->ki_filp);
                                       ^
   In file included from fs/ubifs/file.c:44:
   In file included from include/linux/syscalls_api.h:11:
   include/linux/signal.h:97:11: warning: array index 3 is past the end of the array (which contains 2 elements) [-Warray-bounds]
                   return (set->sig[3] | set->sig[2] |
                           ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from fs/ubifs/file.c:44:
   In file included from include/linux/syscalls_api.h:11:
   include/linux/signal.h:97:25: warning: array index 2 is past the end of the array (which contains 2 elements) [-Warray-bounds]
                   return (set->sig[3] | set->sig[2] |
                                         ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from fs/ubifs/file.c:44:
   In file included from include/linux/syscalls_api.h:11:
   include/linux/signal.h:113:11: warning: array index 3 is past the end of the array (which contains 2 elements) [-Warray-bounds]
                   return  (set1->sig[3] == set2->sig[3]) &&
                            ^         ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from fs/ubifs/file.c:44:
   In file included from include/linux/syscalls_api.h:11:
   include/linux/signal.h:113:27: warning: array index 3 is past the end of the array (which contains 2 elements) [-Warray-bounds]
                   return  (set1->sig[3] == set2->sig[3]) &&
                                            ^         ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from fs/ubifs/file.c:44:
   In file included from include/linux/syscalls_api.h:11:
   include/linux/signal.h:114:5: warning: array index 2 is past the end of the array (which contains 2 elements) [-Warray-bounds]
                           (set1->sig[2] == set2->sig[2]) &&
                            ^         ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from fs/ubifs/file.c:44:
   In file included from include/linux/syscalls_api.h:11:
   include/linux/signal.h:114:21: warning: array index 2 is past the end of the array (which contains 2 elements) [-Warray-bounds]
                           (set1->sig[2] == set2->sig[2]) &&
                                            ^         ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from fs/ubifs/file.c:44:
   In file included from include/linux/syscalls_api.h:11:
   include/linux/signal.h:156:1: warning: array index 3 is past the end of the array (which contains 2 elements) [-Warray-bounds]
   _SIG_SET_BINOP(sigorsets, _sig_or)
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:137:8: note: expanded from macro '_SIG_SET_BINOP'
                   a3 = a->sig[3]; a2 = a->sig[2];                         \
                        ^      ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from fs/ubifs/file.c:44:
   In file included from include/linux/syscalls_api.h:11:
   include/linux/signal.h:156:1: warning: array index 2 is past the end of the array (which contains 2 elements) [-Warray-bounds]
   _SIG_SET_BINOP(sigorsets, _sig_or)
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:137:24: note: expanded from macro '_SIG_SET_BINOP'
                   a3 = a->sig[3]; a2 = a->sig[2];                         \
                                        ^      ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from fs/ubifs/file.c:44:
   In file included from include/linux/syscalls_api.h:11:
   include/linux/signal.h:156:1: warning: array index 3 is past the end of the array (which contains 2 elements) [-Warray-bounds]
   _SIG_SET_BINOP(sigorsets, _sig_or)
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:138:8: note: expanded from macro '_SIG_SET_BINOP'
                   b3 = b->sig[3]; b2 = b->sig[2];                         \
                        ^      ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from fs/ubifs/file.c:44:
   In file included from include/linux/syscalls_api.h:11:
   include/linux/signal.h:156:1: warning: array index 2 is past the end of the array (which contains 2 elements) [-Warray-bounds]
   _SIG_SET_BINOP(sigorsets, _sig_or)
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:138:24: note: expanded from macro '_SIG_SET_BINOP'
                   b3 = b->sig[3]; b2 = b->sig[2];                         \
                                        ^      ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from fs/ubifs/file.c:44:
   In file included from include/linux/syscalls_api.h:11:
   include/linux/signal.h:156:1: warning: array index 3 is past the end of the array (which contains 2 elements) [-Warray-bounds]


vim +/file_inode +424 include/linux/fs_api.h

0f5d0a0fe62409 Ingo Molnar 2022-04-16  423  
0f5d0a0fe62409 Ingo Molnar 2022-04-16 @424  static inline struct inode *file_inode(const struct file *f)
0f5d0a0fe62409 Ingo Molnar 2022-04-16  425  {
0f5d0a0fe62409 Ingo Molnar 2022-04-16  426  	return f->f_inode;
0f5d0a0fe62409 Ingo Molnar 2022-04-16  427  }
0f5d0a0fe62409 Ingo Molnar 2022-04-16  428  

:::::: The code at line 424 was first introduced by commit
:::::: 0f5d0a0fe6240979a116fdd86cc2997879173bff headers/deps: fs: Split <linux/fs.h> into <linux/fs_types.h> and <linux/fs_api.h>

:::::: TO: Ingo Molnar <mingo@kernel.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
