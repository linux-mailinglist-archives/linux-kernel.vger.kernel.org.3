Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35784CBDDA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 13:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbiCCMel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 07:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiCCMej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 07:34:39 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41C8179259
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 04:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646310834; x=1677846834;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MTKGpSKTyTLD9D8vXVW+I6JFkBK/LZydHzOZ6o0Bm34=;
  b=ME/ijXffrI9P5TD02k7sioUo3AEIp5EEoiBpC5oXT3qQVZq/UjVvFYfg
   Wg6ZPK/+l3gyt/RlQOvW0mvAlksAbidu+W1nL0LavFjdGDNntoHwZ5AGi
   YT41ena+336K8goF79oMdde4YNnZqloplfAG1drJaM4IyHJTrdKGc16b1
   lznWLQBClsNef9buLA2KWMCl3V0X5UHUOaXSQPbuUE7C8NC8P0J1VlBrG
   5kxrO29JH+wg2VmLUvHmkHPI4yoS82QhRKHa1R9MdKWUCgtjfye7BgboD
   KeN8OAq+xiQn4yuBf5ImiygPp+OJAD19oXh2Ru5NHzk3iw4Ioa2ol1Yic
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="314377655"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="314377655"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 04:33:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="594379966"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 03 Mar 2022 04:33:53 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPkeW-0000Vc-Fj; Thu, 03 Mar 2022 12:33:52 +0000
Date:   Thu, 3 Mar 2022 20:33:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Boris Kolpackov <boris@codesynthesis.com>
Subject: [masahiroy:kbuild 9/9] include/linux/byteorder/big_endian.h:8:2:
 error: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
Message-ID: <202203032027.8qFpOWlq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git kbuild
head:   55de8686df7ed2b5237867b130e30c728bbd9db4
commit: 55de8686df7ed2b5237867b130e30c728bbd9db4 [9/9] kconfig: change .config format to use =n instead of "is not set"
config: arc-randconfig-r005-20220302 (https://download.01.org/0day-ci/archive/20220303/202203032027.8qFpOWlq-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git/commit/?id=55de8686df7ed2b5237867b130e30c728bbd9db4
        git remote add masahiroy https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
        git fetch --no-tags masahiroy kbuild
        git checkout 55de8686df7ed2b5237867b130e30c728bbd9db4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash lib/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/arc/include/uapi/asm/byteorder.h:14,
                    from include/asm-generic/bitops/le.h:6,
                    from arch/arc/include/asm/bitops.h:192,
                    from include/linux/bitops.h:33,
                    from include/linux/log2.h:12,
                    from include/asm-generic/div64.h:55,
                    from ./arch/arc/include/generated/asm/div64.h:1,
                    from include/linux/math.h:5,
                    from include/linux/math64.h:6,
                    from include/linux/time.h:6,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from lib/test_bitops.c:9:
>> include/linux/byteorder/big_endian.h:8:2: error: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Werror=cpp]
       8 | #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
         |  ^~~~~~~
   cc1: all warnings being treated as errors


vim +8 include/linux/byteorder/big_endian.h

^1da177e4c3f41 Linus Torvalds 2005-04-16   6  
e9ef073a0796e4 Babu Moger     2017-09-08   7  #ifndef CONFIG_CPU_BIG_ENDIAN
e9ef073a0796e4 Babu Moger     2017-09-08  @8  #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
e9ef073a0796e4 Babu Moger     2017-09-08   9  #endif
e9ef073a0796e4 Babu Moger     2017-09-08  10  

:::::: The code at line 8 was first introduced by commit
:::::: e9ef073a0796e46c24f037237291efe56fc28ad9 include: warn for inconsistent endian config definition

:::::: TO: Babu Moger <babu.moger@oracle.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
