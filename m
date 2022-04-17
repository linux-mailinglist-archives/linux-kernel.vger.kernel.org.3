Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78F05047A8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 13:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbiDQLT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 07:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbiDQLTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 07:19:24 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C95CD8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 04:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650194209; x=1681730209;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tbxRaF6TooTTrgnSoAXq3OhSSQCy0h1Iob2Bj/Zg5iQ=;
  b=NZxVoG5HjjGvZepUJBeguZWypJjMqQhJq7Mxaw3Wm9qzUBKuKYw6gi3q
   5PMCgxAgBEhAxgwaj8BZO+FGf6HFtg0RVmaQnrCIrn4py1K3dkv2BqisR
   LDjstuVKaTZz/tt5m7dbeIz3xWqLF7uPsjCRfYy1kbKaUUrlgPNylHsOA
   WZcARj34E85Sr/QnKlh5d+SpJUxG3i88lTjLCsPk8EwzDFTzERGPAqIm6
   ag8Db2lzxUqtmmZJVHHhnxE6O6KUBSYhFziw1ImVkYAD5Id6mTe7YF1Ox
   wc/Hp6H5ssdrxd7YJ0o1jxZTm60UYfqx1vKRcnYfYCnJ5ythe9C7XNJA5
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="262237112"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="262237112"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 04:16:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="592108960"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 17 Apr 2022 04:16:47 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ng2ta-0003tv-J3;
        Sun, 17 Apr 2022 11:16:46 +0000
Date:   Sun, 17 Apr 2022 19:16:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: fs/ntfs3/attrib.c:70:20: warning: unused function
 'attr_must_be_resident'
Message-ID: <202204171936.qeF0hGZg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konstantin,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a2c29ccd9477861b16ddc02c411a6c9665250558
commit: 6e5be40d32fb1907285277c02e74493ed43d77fe fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile
date:   8 months ago
config: mips-randconfig-r013-20220417 (https://download.01.org/0day-ci/archive/20220417/202204171936.qeF0hGZg-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c6fdb1de47bd5f26868838c37fa9e8cc1ac484bf)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6e5be40d32fb1907285277c02e74493ed43d77fe
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6e5be40d32fb1907285277c02e74493ed43d77fe
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash fs/ntfs3/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/ntfs3/attrib.c:70:20: warning: unused function 'attr_must_be_resident'
   static inline bool attr_must_be_resident(struct ntfs_sb_info
   ^
   fatal error: error in backend: Nested variants found in inline asm string: ' .set push
   .set mips64r2
   .if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/bitops.h", .line = 105, $); 0x00 ) != -1)) : $))) ) && ( 0 ); .set push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   1: ll $0, $1
   or $0, $2
   sc $0, $1
   beqz $0, 1b
   .set pop
   '
   clang-15: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 15.0.0 (git://gitmirror/llvm_project ef94609d6ebe981767788e6877b0b3b731d425af)
   Target: mips-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-ef94609d6e/bin
   clang-15: note: diagnostic msg:
   Makefile arch fs include kernel scripts source usr
--
>> fs/ntfs3/bitmap.c:59:19: warning: unused function 'wnd_bits'
   static inline u32 wnd_bits(const struct wnd_bitmap size_t i)
   ^
   fatal error: error in backend: Nested variants found in inline asm string: ' .set push
   .set mips64r2
   .if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/atomic.h", .line = 157, $); 0x00 ) != -1)) : $))) ) && ( 0 ); .set push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   1: ll $0, $1 # atomic_sub
   subu $0, $2
   sc $0, $1
   beqz $0, 1b
   .set pop
   '
   clang-15: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 15.0.0 (git://gitmirror/llvm_project ef94609d6ebe981767788e6877b0b3b731d425af)
   Target: mips-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-ef94609d6e/bin
   clang-15: note: diagnostic msg:
   Makefile arch fs include kernel scripts source usr


vim +/attr_must_be_resident +70 fs/ntfs3/attrib.c

be71b5cba2e648 Konstantin Komarov 2021-08-13  64  
be71b5cba2e648 Konstantin Komarov 2021-08-13  65  /*
be71b5cba2e648 Konstantin Komarov 2021-08-13  66   * attr_must_be_resident
be71b5cba2e648 Konstantin Komarov 2021-08-13  67   *
be71b5cba2e648 Konstantin Komarov 2021-08-13  68   * returns true if attribute must be resident
be71b5cba2e648 Konstantin Komarov 2021-08-13  69   */
be71b5cba2e648 Konstantin Komarov 2021-08-13 @70  static inline bool attr_must_be_resident(struct ntfs_sb_info *sbi,
be71b5cba2e648 Konstantin Komarov 2021-08-13  71  					 enum ATTR_TYPE type)
be71b5cba2e648 Konstantin Komarov 2021-08-13  72  {
be71b5cba2e648 Konstantin Komarov 2021-08-13  73  	const struct ATTR_DEF_ENTRY *de;
be71b5cba2e648 Konstantin Komarov 2021-08-13  74  
be71b5cba2e648 Konstantin Komarov 2021-08-13  75  	switch (type) {
be71b5cba2e648 Konstantin Komarov 2021-08-13  76  	case ATTR_STD:
be71b5cba2e648 Konstantin Komarov 2021-08-13  77  	case ATTR_NAME:
be71b5cba2e648 Konstantin Komarov 2021-08-13  78  	case ATTR_ID:
be71b5cba2e648 Konstantin Komarov 2021-08-13  79  	case ATTR_LABEL:
be71b5cba2e648 Konstantin Komarov 2021-08-13  80  	case ATTR_VOL_INFO:
be71b5cba2e648 Konstantin Komarov 2021-08-13  81  	case ATTR_ROOT:
be71b5cba2e648 Konstantin Komarov 2021-08-13  82  	case ATTR_EA_INFO:
be71b5cba2e648 Konstantin Komarov 2021-08-13  83  		return true;
be71b5cba2e648 Konstantin Komarov 2021-08-13  84  	default:
be71b5cba2e648 Konstantin Komarov 2021-08-13  85  		de = ntfs_query_def(sbi, type);
be71b5cba2e648 Konstantin Komarov 2021-08-13  86  		if (de && (de->flags & NTFS_ATTR_MUST_BE_RESIDENT))
be71b5cba2e648 Konstantin Komarov 2021-08-13  87  			return true;
be71b5cba2e648 Konstantin Komarov 2021-08-13  88  		return false;
be71b5cba2e648 Konstantin Komarov 2021-08-13  89  	}
be71b5cba2e648 Konstantin Komarov 2021-08-13  90  }
be71b5cba2e648 Konstantin Komarov 2021-08-13  91  

:::::: The code at line 70 was first introduced by commit
:::::: be71b5cba2e6485e8959da7a9f9a44461a1bb074 fs/ntfs3: Add attrib operations

:::::: TO: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
:::::: CC: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
