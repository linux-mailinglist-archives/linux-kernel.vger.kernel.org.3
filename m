Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22F653C426
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 07:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240412AbiFCFZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 01:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiFCFZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 01:25:53 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB82E15706
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 22:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654233951; x=1685769951;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7Yy+YKPjezZqxZ9iAmymPlZoAsDQLdULcf7v+4p5KUI=;
  b=C9hoONmiuGLMsYKtGdoQEgkkjTLCq2sdXB2C9Ff2hr2XxSY1u1xbslSt
   hZtg337++AlPgSBnVKoMFy7lvzQXaD+crMinOI5ohePGl+Ypjqa8fXZtY
   wvw1UKnO/u8cFohzUtoze4pGZZfPvdrkJVSVivz3qoJOrb9H6wyW6g3sO
   eacqhtBmZCXwFtEkoA27Pk4tX46claiCITf/CjO4iFKZW+H0SRIdW+fZI
   Xfx5c3KYKJE/Ze7KK35FZ1TrGn/SNP0NrGcw8Dz2rHsR0yfQ7U0qtxs5N
   mqOb4J7hnfG6Y+oKh60I2zc1GDYen9m9iIAsSKAjOYSY6uuDdLDWFYZ21
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="273735926"
X-IronPort-AV: E=Sophos;i="5.91,273,1647327600"; 
   d="scan'208";a="273735926"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 22:25:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,273,1647327600"; 
   d="scan'208";a="757343217"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 02 Jun 2022 22:25:50 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwzoj-0006Or-C0;
        Fri, 03 Jun 2022 05:25:49 +0000
Date:   Fri, 3 Jun 2022 13:24:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: fs/ntfs3/attrib.c:70:20: warning: unused function
 'attr_must_be_resident'
Message-ID: <202206031318.lX6gx7wh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
head:   50fd82b3a9a9335df5d50c7ddcb81c81d358c4fc
commit: 6e5be40d32fb1907285277c02e74493ed43d77fe fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile
date:   10 months ago
config: mips-randconfig-r012-20220531 (https://download.01.org/0day-ci/archive/20220603/202206031318.lX6gx7wh-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b364c76683f8ef241025a9556300778c07b590c2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6e5be40d32fb1907285277c02e74493ed43d77fe
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6e5be40d32fb1907285277c02e74493ed43d77fe
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/dma-buf/ drivers/leds/ fs/ntfs3/

If you fix the issue, kindly add following tag where applicable
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
   clang version 15.0.0 (git://gitmirror/llvm_project b364c76683f8ef241025a9556300778c07b590c2)
   Target: mips-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-b364c76683/bin
   clang-15: note: diagnostic msg:
   Makefile arch drivers fs include kernel mm net nr_bisected scripts source usr
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
   clang version 15.0.0 (git://gitmirror/llvm_project b364c76683f8ef241025a9556300778c07b590c2)
   Target: mips-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-b364c76683/bin
   clang-15: note: diagnostic msg:
   Makefile arch drivers fs include kernel mm net nr_bisected scripts source usr


vim +/attr_must_be_resident +70 fs/ntfs3/attrib.c

be71b5cba2e6485 Konstantin Komarov 2021-08-13  64  
be71b5cba2e6485 Konstantin Komarov 2021-08-13  65  /*
be71b5cba2e6485 Konstantin Komarov 2021-08-13  66   * attr_must_be_resident
be71b5cba2e6485 Konstantin Komarov 2021-08-13  67   *
be71b5cba2e6485 Konstantin Komarov 2021-08-13  68   * returns true if attribute must be resident
be71b5cba2e6485 Konstantin Komarov 2021-08-13  69   */
be71b5cba2e6485 Konstantin Komarov 2021-08-13 @70  static inline bool attr_must_be_resident(struct ntfs_sb_info *sbi,
be71b5cba2e6485 Konstantin Komarov 2021-08-13  71  					 enum ATTR_TYPE type)
be71b5cba2e6485 Konstantin Komarov 2021-08-13  72  {
be71b5cba2e6485 Konstantin Komarov 2021-08-13  73  	const struct ATTR_DEF_ENTRY *de;
be71b5cba2e6485 Konstantin Komarov 2021-08-13  74  
be71b5cba2e6485 Konstantin Komarov 2021-08-13  75  	switch (type) {
be71b5cba2e6485 Konstantin Komarov 2021-08-13  76  	case ATTR_STD:
be71b5cba2e6485 Konstantin Komarov 2021-08-13  77  	case ATTR_NAME:
be71b5cba2e6485 Konstantin Komarov 2021-08-13  78  	case ATTR_ID:
be71b5cba2e6485 Konstantin Komarov 2021-08-13  79  	case ATTR_LABEL:
be71b5cba2e6485 Konstantin Komarov 2021-08-13  80  	case ATTR_VOL_INFO:
be71b5cba2e6485 Konstantin Komarov 2021-08-13  81  	case ATTR_ROOT:
be71b5cba2e6485 Konstantin Komarov 2021-08-13  82  	case ATTR_EA_INFO:
be71b5cba2e6485 Konstantin Komarov 2021-08-13  83  		return true;
be71b5cba2e6485 Konstantin Komarov 2021-08-13  84  	default:
be71b5cba2e6485 Konstantin Komarov 2021-08-13  85  		de = ntfs_query_def(sbi, type);
be71b5cba2e6485 Konstantin Komarov 2021-08-13  86  		if (de && (de->flags & NTFS_ATTR_MUST_BE_RESIDENT))
be71b5cba2e6485 Konstantin Komarov 2021-08-13  87  			return true;
be71b5cba2e6485 Konstantin Komarov 2021-08-13  88  		return false;
be71b5cba2e6485 Konstantin Komarov 2021-08-13  89  	}
be71b5cba2e6485 Konstantin Komarov 2021-08-13  90  }
be71b5cba2e6485 Konstantin Komarov 2021-08-13  91  

:::::: The code at line 70 was first introduced by commit
:::::: be71b5cba2e6485e8959da7a9f9a44461a1bb074 fs/ntfs3: Add attrib operations

:::::: TO: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
:::::: CC: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
