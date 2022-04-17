Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA895048ED
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 20:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbiDQSeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 14:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbiDQSeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 14:34:36 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19421C919
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 11:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650220319; x=1681756319;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=03tWKc4tGSNlrP2AZkNUi1dPEIZp6mwmNGkTwQG7Otk=;
  b=kktrdlWntTmUwzlSenDtiFSR7eTWuQOKfWsRxwbtq0ARFARWxtsD0i3Q
   4J8Ih8uBGrzxHP4cl90neRqoKJ4rXpEvkFz8ocp0agxJkj6GIwrgrhlGd
   6x4sZdbvoKGLNeE6XB9WFaQQrOopVQ4Ua9M5h8QVACcq17exkXTPgVapJ
   vyVdHD19OFP8M4e9iQkaSLi70WfoC+0dUt1j8ZSYimgd3Zqm1GW16Qsy3
   u58K22PPKOlD8pSBhFcXiknK2ZcR+TVkyw6AvQV0hYXqbhicuK97Rz2OJ
   RKKFnyZPZkOe1uAN0XgxkDuf/qhJXl6Skvmwug9XXubP+ChUNxqW7S2VQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="288488841"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="288488841"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 11:31:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="592171763"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 17 Apr 2022 11:31:56 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ng9gh-00045o-KC;
        Sun, 17 Apr 2022 18:31:55 +0000
Date:   Mon, 18 Apr 2022 02:31:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [kees:for-next/randstruct 5/5] include/linux/cred.h:254:17: error:
 no member named 'non_rcu' in 'struct cred'
Message-ID: <202204180214.X2Y1kbZ6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/randstruct
head:   0f9614862c554c424c7b099d2cf84a3ecd755357
commit: 0f9614862c554c424c7b099d2cf84a3ecd755357 [5/5] randstruct: Enable Clang support
config: powerpc64-allmodconfig (https://download.01.org/0day-ci/archive/20220418/202204180214.X2Y1kbZ6-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project ef94609d6ebe981767788e6877b0b3b731d425af)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc64 cross compiling tool for clang build
        # apt-get install binutils-powerpc64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=0f9614862c554c424c7b099d2cf84a3ecd755357
        git remote add kees https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
        git fetch --no-tags kees for-next/randstruct
        git checkout 0f9614862c554c424c7b099d2cf84a3ecd755357
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:10:
>> include/linux/cred.h:254:17: error: no member named 'non_rcu' in 'struct cred'
           nonconst_cred->non_rcu = 0;
           ~~~~~~~~~~~~~  ^
   include/linux/cred.h:266:17: error: no member named 'non_rcu' in 'struct cred'
           nonconst_cred->non_rcu = 0;
           ~~~~~~~~~~~~~  ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
>> include/linux/fs.h:2896:17: error: no member named 'i_nlink' in 'struct inode'
           return !inode->i_nlink || inode_unhashed(inode);
                   ~~~~~  ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   include/linux/compat.h:424:22: warning: array index 3 is past the end of the array (which contains 1 element) [-Warray-bounds]
           case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
                               ^        ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   include/linux/compat.h:424:10: warning: array index 7 is past the end of the array (which contains 2 elements) [-Warray-bounds]
           case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
                   ^     ~
   include/linux/compat.h:131:2: note: array 'sig' declared here
           compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
           ^
   include/linux/compat.h:424:42: warning: array index 6 is past the end of the array (which contains 2 elements) [-Warray-bounds]
           case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
                                                   ^     ~
   include/linux/compat.h:131:2: note: array 'sig' declared here
           compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
           ^
   include/linux/compat.h:424:53: warning: array index 3 is past the end of the array (which contains 1 element) [-Warray-bounds]
           case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
                                                              ^        ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   include/linux/compat.h:426:22: warning: array index 2 is past the end of the array (which contains 1 element) [-Warray-bounds]
           case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
                               ^        ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   include/linux/compat.h:426:10: warning: array index 5 is past the end of the array (which contains 2 elements) [-Warray-bounds]
           case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
                   ^     ~
   include/linux/compat.h:131:2: note: array 'sig' declared here
           compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
           ^
   include/linux/compat.h:426:42: warning: array index 4 is past the end of the array (which contains 2 elements) [-Warray-bounds]
           case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
                                                   ^     ~
   include/linux/compat.h:131:2: note: array 'sig' declared here
           compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
           ^
   include/linux/compat.h:426:53: warning: array index 2 is past the end of the array (which contains 1 element) [-Warray-bounds]
           case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
                                                              ^        ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   include/linux/compat.h:428:22: warning: array index 1 is past the end of the array (which contains 1 element) [-Warray-bounds]
           case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
                               ^        ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   include/linux/compat.h:428:10: warning: array index 3 is past the end of the array (which contains 2 elements) [-Warray-bounds]
           case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
                   ^     ~
   include/linux/compat.h:131:2: note: array 'sig' declared here
           compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
           ^
   include/linux/compat.h:428:42: warning: array index 2 is past the end of the array (which contains 2 elements) [-Warray-bounds]
           case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
                                                   ^     ~
   include/linux/compat.h:131:2: note: array 'sig' declared here
           compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
           ^
   include/linux/compat.h:428:53: warning: array index 1 is past the end of the array (which contains 1 element) [-Warray-bounds]
           case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
                                                              ^        ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/powerpc/kernel/asm-offsets.c:19:
   include/linux/mman.h:157:9: warning: division by zero is undefined [-Wdivision-by-zero]
                  _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mman.h:136:21: note: expanded from macro '_calc_vm_trans'
      : ((x) & (bit1)) / ((bit1) / (bit2))))
                       ^ ~~~~~~~~~~~~~~~~~
   include/linux/mman.h:158:9: warning: division by zero is undefined [-Wdivision-by-zero]
                  _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC      ) |
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mman.h:136:21: note: expanded from macro '_calc_vm_trans'
      : ((x) & (bit1)) / ((bit1) / (bit2))))
                       ^ ~~~~~~~~~~~~~~~~~
   14 warnings and 3 errors generated.
   make[2]: *** [scripts/Makefile.build:120: arch/powerpc/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1195: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +254 include/linux/cred.h

f1752eec6145c9 David Howells  2008-11-14  234  
f1752eec6145c9 David Howells  2008-11-14  235  /**
f1752eec6145c9 David Howells  2008-11-14  236   * get_cred - Get a reference on a set of credentials
f1752eec6145c9 David Howells  2008-11-14  237   * @cred: The credentials to reference
f1752eec6145c9 David Howells  2008-11-14  238   *
f1752eec6145c9 David Howells  2008-11-14  239   * Get a reference on the specified set of credentials.  The caller must
f06bc03339ad4c NeilBrown      2018-12-03  240   * release the reference.  If %NULL is passed, it is returned with no action.
98870ab0a5a3f1 David Howells  2008-11-14  241   *
98870ab0a5a3f1 David Howells  2008-11-14  242   * This is used to deal with a committed set of credentials.  Although the
98870ab0a5a3f1 David Howells  2008-11-14  243   * pointer is const, this will temporarily discard the const and increment the
98870ab0a5a3f1 David Howells  2008-11-14  244   * usage count.  The purpose of this is to attempt to catch at compile time the
98870ab0a5a3f1 David Howells  2008-11-14  245   * accidental alteration of a set of credentials that should be considered
98870ab0a5a3f1 David Howells  2008-11-14  246   * immutable.
f1752eec6145c9 David Howells  2008-11-14  247   */
d84f4f992cbd76 David Howells  2008-11-14  248  static inline const struct cred *get_cred(const struct cred *cred)
f1752eec6145c9 David Howells  2008-11-14  249  {
1c388ad054fb1e Paul Menage    2009-07-17  250  	struct cred *nonconst_cred = (struct cred *) cred;
f06bc03339ad4c NeilBrown      2018-12-03  251  	if (!cred)
f06bc03339ad4c NeilBrown      2018-12-03  252  		return cred;
e0e817392b9acf David Howells  2009-09-02  253  	validate_creds(cred);
d7852fbd0f0423 Linus Torvalds 2019-07-11 @254  	nonconst_cred->non_rcu = 0;
1c388ad054fb1e Paul Menage    2009-07-17  255  	return get_new_cred(nonconst_cred);
f1752eec6145c9 David Howells  2008-11-14  256  }
f1752eec6145c9 David Howells  2008-11-14  257  

:::::: The code at line 254 was first introduced by commit
:::::: d7852fbd0f0423937fa287a598bfde188bb68c22 access: avoid the RCU grace period for the temporary subjective credentials

:::::: TO: Linus Torvalds <torvalds@linux-foundation.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
