Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08354EDA94
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 15:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbiCaNdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236861AbiCaNdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:33:05 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9634D6542D
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648733478; x=1680269478;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SZoPeWvFqilnBhtd7cf6gPw78PPTX91y47PEFhfAxFo=;
  b=ADkv1Dy0VkODjd1EeoQU55+iY9/G+3v2ULshVv82UIhjmq9yFRxMiCjT
   zJplNI6pQLHvjThOFbV43r/Ax65H0Z6nv3QHuCbgZUQ9tiZYAHV3guxZ8
   6WSEwj1nR/KLZP/5GZT60yLS/j6/xh++1f0d68NNIecDSmGGBMIwyAHGQ
   YE+fR1K2G39LiM6PwK7RLRzaAxf1/Q3/y+rcsOVErk5vKX+syTJpef7VN
   bpPn7/P5nmZb8esubMlLuYn5jclzplprk1fRP9yXFutSTsqRlfB56e/p1
   lpoRh3OIGytCpsIj3xsIkvTbEE69huXSTtfF/3LJ7FXel3iER8Dkg6DN4
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="241987865"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="241987865"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 06:31:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="547333931"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 31 Mar 2022 06:31:16 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZutP-0000IC-SV;
        Thu, 31 Mar 2022 13:31:15 +0000
Date:   Thu, 31 Mar 2022 21:30:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
Subject: arch/arm64/kernel/elfcore.c:62:1: warning: the frame size of 2064
 bytes is larger than 2048 bytes
Message-ID: <202203312129.zEYwA7Ce-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   787af64d05cd528aac9ad16752d11bb1c6061bb9
commit: 6dd8b1a0b6cb3ed93d24110e02e67ff9d006610a arm64: mte: Dump the MTE tags in the core file
date:   6 weeks ago
config: arm64-randconfig-s031-20220331 (https://download.01.org/0day-ci/archive/20220331/202203312129.zEYwA7Ce-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6dd8b1a0b6cb3ed93d24110e02e67ff9d006610a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6dd8b1a0b6cb3ed93d24110e02e67ff9d006610a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm64/kernel/elfcore.c: In function 'mte_dump_tag_range':
>> arch/arm64/kernel/elfcore.c:62:1: warning: the frame size of 2064 bytes is larger than 2048 bytes [-Wframe-larger-than=]
      62 | }
         | ^


vim +62 arch/arm64/kernel/elfcore.c

    23	
    24	/* Derived from dump_user_range(); start/end must be page-aligned */
    25	static int mte_dump_tag_range(struct coredump_params *cprm,
    26				      unsigned long start, unsigned long end)
    27	{
    28		unsigned long addr;
    29	
    30		for (addr = start; addr < end; addr += PAGE_SIZE) {
    31			char tags[MTE_PAGE_TAG_STORAGE];
    32			struct page *page = get_dump_page(addr);
    33	
    34			/*
    35			 * get_dump_page() returns NULL when encountering an empty
    36			 * page table entry that would otherwise have been filled with
    37			 * the zero page. Skip the equivalent tag dump which would
    38			 * have been all zeros.
    39			 */
    40			if (!page) {
    41				dump_skip(cprm, MTE_PAGE_TAG_STORAGE);
    42				continue;
    43			}
    44	
    45			/*
    46			 * Pages mapped in user space as !pte_access_permitted() (e.g.
    47			 * PROT_EXEC only) may not have the PG_mte_tagged flag set.
    48			 */
    49			if (!test_bit(PG_mte_tagged, &page->flags)) {
    50				put_page(page);
    51				dump_skip(cprm, MTE_PAGE_TAG_STORAGE);
    52				continue;
    53			}
    54	
    55			mte_save_page_tags(page_address(page), tags);
    56			put_page(page);
    57			if (!dump_emit(cprm, tags, MTE_PAGE_TAG_STORAGE))
    58				return 0;
    59		}
    60	
    61		return 1;
  > 62	}
    63	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
