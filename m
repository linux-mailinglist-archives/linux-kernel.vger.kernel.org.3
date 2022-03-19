Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646E14DE553
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 04:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241903AbiCSDUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 23:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiCSDUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 23:20:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EEA326D5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 20:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647659940; x=1679195940;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ijC+RvfLXuTSiKQ2ed5zSGoSdIy/RoQ7r8TmJ1x81rk=;
  b=AOdDA92/15Qy9ul9Roy8pCHRsgjUo1euO5ifDrTHMYClk1oYOxtJJk8y
   zPczBLlF+r07PL0xFZMFbTo+mQ9hJYTpqW3WEUacRGx47MmxEzUVtj9BL
   I13WlknRmBkxJ8OvEwlZpdUK4F8fM7F7LZ71DpttRe1bsXdzyThfv+wVz
   Jf5JZv+mBDXVc2ADlcyYgYXENQ8VmW3uo1Nb4dKq5KvRBKhBeud/9jpAS
   pP4N8+JbINH2Ks6YW05E672C1bccVyYjWgg1YtUEoxjt/HoSk+fsa2/nr
   m0j/RbFm5h8ODeII2RdAUQU3g0M+GVlAQcHZor969HlL9Xk0emV2v1CSq
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="343704994"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="343704994"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 20:18:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="715755627"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 18 Mar 2022 20:18:58 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVPcH-000FTF-RC; Sat, 19 Mar 2022 03:18:57 +0000
Date:   Sat, 19 Mar 2022 11:18:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kees:for-next/execve 12/15] fs/binfmt_elf_test.c:52:1: warning: the
 frame size of 1056 bytes is larger than 1024 bytes
Message-ID: <202203191122.mbOGJL7c-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve
head:   dd664099002db909912a23215f8775c97f7f4f10
commit: 9e1a3ce0a952450a1163cc93ab1df6d4fa8c8155 [12/15] binfmt_elf: Introduce KUnit test
config: powerpc-randconfig-r031-20220318 (https://download.01.org/0day-ci/archive/20220319/202203191122.mbOGJL7c-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=9e1a3ce0a952450a1163cc93ab1df6d4fa8c8155
        git remote add kees https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
        git fetch --no-tags kees for-next/execve
        git checkout 9e1a3ce0a952450a1163cc93ab1df6d4fa8c8155
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from fs/binfmt_elf.c:2351:
   fs/binfmt_elf_test.c: In function 'total_mapping_size_test':
>> fs/binfmt_elf_test.c:52:1: warning: the frame size of 1056 bytes is larger than 1024 bytes [-Wframe-larger-than=]
      52 | }
         | ^


vim +52 fs/binfmt_elf_test.c

     3	
     4	static void total_mapping_size_test(struct kunit *test)
     5	{
     6		struct elf_phdr empty[] = {
     7			{ .p_type = PT_LOAD, .p_vaddr = 0, .p_memsz = 0, },
     8			{ .p_type = PT_INTERP, .p_vaddr = 10, .p_memsz = 999999, },
     9		};
    10		/*
    11		 * readelf -lW /bin/mount | grep '^  .*0x0' | awk '{print "\t\t{ .p_type = PT_" \
    12		 *				$1 ", .p_vaddr = " $3 ", .p_memsz = " $6 ", },"}'
    13		 */
    14		struct elf_phdr mount[] = {
    15			{ .p_type = PT_PHDR, .p_vaddr = 0x00000040, .p_memsz = 0x0002d8, },
    16			{ .p_type = PT_INTERP, .p_vaddr = 0x00000318, .p_memsz = 0x00001c, },
    17			{ .p_type = PT_LOAD, .p_vaddr = 0x00000000, .p_memsz = 0x0033a8, },
    18			{ .p_type = PT_LOAD, .p_vaddr = 0x00004000, .p_memsz = 0x005c91, },
    19			{ .p_type = PT_LOAD, .p_vaddr = 0x0000a000, .p_memsz = 0x0022f8, },
    20			{ .p_type = PT_LOAD, .p_vaddr = 0x0000d330, .p_memsz = 0x000d40, },
    21			{ .p_type = PT_DYNAMIC, .p_vaddr = 0x0000d928, .p_memsz = 0x000200, },
    22			{ .p_type = PT_NOTE, .p_vaddr = 0x00000338, .p_memsz = 0x000030, },
    23			{ .p_type = PT_NOTE, .p_vaddr = 0x00000368, .p_memsz = 0x000044, },
    24			{ .p_type = PT_GNU_PROPERTY, .p_vaddr = 0x00000338, .p_memsz = 0x000030, },
    25			{ .p_type = PT_GNU_EH_FRAME, .p_vaddr = 0x0000b490, .p_memsz = 0x0001ec, },
    26			{ .p_type = PT_GNU_STACK, .p_vaddr = 0x00000000, .p_memsz = 0x000000, },
    27			{ .p_type = PT_GNU_RELRO, .p_vaddr = 0x0000d330, .p_memsz = 0x000cd0, },
    28		};
    29		size_t mount_size = 0xE070;
    30		/* https://lore.kernel.org/linux-fsdevel/YfF18Dy85mCntXrx@fractal.localdomain */
    31		struct elf_phdr unordered[] = {
    32			{ .p_type = PT_LOAD, .p_vaddr = 0x00000000, .p_memsz = 0x0033a8, },
    33			{ .p_type = PT_LOAD, .p_vaddr = 0x0000d330, .p_memsz = 0x000d40, },
    34			{ .p_type = PT_LOAD, .p_vaddr = 0x00004000, .p_memsz = 0x005c91, },
    35			{ .p_type = PT_LOAD, .p_vaddr = 0x0000a000, .p_memsz = 0x0022f8, },
    36		};
    37	
    38		/* No headers, no size. */
    39		KUNIT_EXPECT_EQ(test, total_mapping_size(NULL, 0), 0);
    40		KUNIT_EXPECT_EQ(test, total_mapping_size(empty, 0), 0);
    41		/* Empty headers, no size. */
    42		KUNIT_EXPECT_EQ(test, total_mapping_size(empty, 1), 0);
    43		/* No PT_LOAD headers, no size. */
    44		KUNIT_EXPECT_EQ(test, total_mapping_size(&empty[1], 1), 0);
    45		/* Empty PT_LOAD and non-PT_LOAD headers, no size. */
    46		KUNIT_EXPECT_EQ(test, total_mapping_size(empty, 2), 0);
    47	
    48		/* Normal set of PT_LOADS, and expected size. */
    49		KUNIT_EXPECT_EQ(test, total_mapping_size(mount, ARRAY_SIZE(mount)), mount_size);
    50		/* Unordered PT_LOADs result in same size. */
    51		KUNIT_EXPECT_EQ(test, total_mapping_size(unordered, ARRAY_SIZE(unordered)), mount_size);
  > 52	}
    53	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
