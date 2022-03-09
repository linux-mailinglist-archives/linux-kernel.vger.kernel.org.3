Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC394D293C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiCIHC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiCIHC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:02:57 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B851E4D2D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 23:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646809319; x=1678345319;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EnpyLsOZzre3Gu3cWxZjDjcmz38M518zCl8vreDZPAI=;
  b=kPV6NHOS87bEhkN8rNGnFHIYQlIVbvZW74uAGEToqN3qPwsn44+mEuId
   dkuur8uZKDXwUWuSV/i6XcIoQOQK7mJ1up8pRuL39DMi4Mj+RBOl2bYba
   pCcL+RbzzlGu/JxPUCzrdIFpjr9T2B0GuV/SWkL2iYnvLH25ekpOCzGHZ
   BbumJxcl8yTEVkvFhOS6CoJqTE33ByzYwjvx4/Hfc46SVPRXzOnD6eZxh
   5/qjJnD+9YigZ5pmd+v21BoiXEc7Lm8aZokOcZddvalhCUtLg2w8gLJkL
   47i6kKPciSP4gF4z2D1jWGbCLVTT1w5iLw2/BrIdNT3C5/20zcOr6lMi8
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="318133152"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="318133152"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 23:01:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="814632039"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 08 Mar 2022 23:01:57 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRqKa-0002oD-Dc; Wed, 09 Mar 2022 07:01:56 +0000
Date:   Wed, 9 Mar 2022 15:01:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>
Subject: [ammarfaizi2-block:palmer/linux/riscv-compat 6/20]
 arch/arm64/include/asm/compat.h:69:8: error: redefinition of 'struct
 compat_statfs'
Message-ID: <202203091419.D7J4hUgo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/riscv-compat
head:   ab7e33a6b819f009c3c9ccf69b2f44c1ad84a5a0
commit: edacaabe96fd3b87ddd5e9972ba89718af564124 [6/20] asm-generic: compat: Cleanup duplicate definitions
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20220309/202203091419.D7J4hUgo-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/edacaabe96fd3b87ddd5e9972ba89718af564124
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/riscv-compat
        git checkout edacaabe96fd3b87ddd5e9972ba89718af564124
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/arm64/include/asm/stat.h:13,
                    from include/linux/stat.h:6,
                    from include/linux/sysfs.h:22,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from include/acpi/apei.h:9,
                    from include/acpi/ghes.h:5,
                    from include/linux/arm_sdei.h:8,
                    from arch/arm64/kernel/asm-offsets.c:10:
>> arch/arm64/include/asm/compat.h:69:8: error: redefinition of 'struct compat_statfs'
      69 | struct compat_statfs {
         |        ^~~~~~~~~~~~~
   In file included from arch/arm64/include/asm/compat.h:18,
                    from arch/arm64/include/asm/stat.h:13,
                    from include/linux/stat.h:6,
                    from include/linux/sysfs.h:22,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from include/acpi/apei.h:9,
                    from include/acpi/ghes.h:5,
                    from include/linux/arm_sdei.h:8,
                    from arch/arm64/kernel/asm-offsets.c:10:
   include/asm-generic/compat.h:80:8: note: originally defined here
      80 | struct compat_statfs {
         |        ^~~~~~~~~~~~~
   make[2]: *** [scripts/Makefile.build:121: arch/arm64/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1191: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +69 arch/arm64/include/asm/compat.h

3dd681d944f6d8 Will Deacon 2012-03-05  68  
3dd681d944f6d8 Will Deacon 2012-03-05 @69  struct compat_statfs {
3dd681d944f6d8 Will Deacon 2012-03-05  70  	int		f_type;
3dd681d944f6d8 Will Deacon 2012-03-05  71  	int		f_bsize;
3dd681d944f6d8 Will Deacon 2012-03-05  72  	int		f_blocks;
3dd681d944f6d8 Will Deacon 2012-03-05  73  	int		f_bfree;
3dd681d944f6d8 Will Deacon 2012-03-05  74  	int		f_bavail;
3dd681d944f6d8 Will Deacon 2012-03-05  75  	int		f_files;
3dd681d944f6d8 Will Deacon 2012-03-05  76  	int		f_ffree;
3dd681d944f6d8 Will Deacon 2012-03-05  77  	compat_fsid_t	f_fsid;
3dd681d944f6d8 Will Deacon 2012-03-05  78  	int		f_namelen;	/* SunOS ignores this field. */
3dd681d944f6d8 Will Deacon 2012-03-05  79  	int		f_frsize;
3dd681d944f6d8 Will Deacon 2012-03-05  80  	int		f_flags;
3dd681d944f6d8 Will Deacon 2012-03-05  81  	int		f_spare[4];
3dd681d944f6d8 Will Deacon 2012-03-05  82  };
3dd681d944f6d8 Will Deacon 2012-03-05  83  

:::::: The code at line 69 was first introduced by commit
:::::: 3dd681d944f6d861f12ee03aff17a14342963330 arm64: 32-bit (compat) applications support

:::::: TO: Will Deacon <will.deacon@arm.com>
:::::: CC: Catalin Marinas <catalin.marinas@arm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
