Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4221251EA35
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 22:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358398AbiEGU7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 16:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbiEGU67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 16:58:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DDC205D6
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 13:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651956911; x=1683492911;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IW5GA9KY5fGNk8pn2J9fOJ9P5JzlJf02ctQI0dsVQ/U=;
  b=K8WniyiRhyhIp0k+dxXJF0+Kl3ufn9riUB1KzWsgcXs8e+FO5zeTVA7c
   /+DjGO5k5KZwDLdrl+fpBC3vRw1tqCrSiVIl03M/adg9G9gHVfOSkEtNh
   GKNNyadRA4dhm8vLVtXtxApPl/SpE/nN/Gv56gCuJudqW5iJFq/zSVpqr
   4dxee55VT/bjX7u0WTP1JBWJiC0pmovfKxKS/edySW0ozuAqb+71M97lM
   ZeKvn5EdwZySoLhH9Amx8jpvqETgdUCdwlebPRxvkjnstC4BJTTZg0jlc
   WVNvMdMKnsl31P36XJChQF06hlHS7dNWjMwFeAN/sK175ClhZVQOKQIIz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10340"; a="266343911"
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="scan'208";a="266343911"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 13:55:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="scan'208";a="622361229"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 07 May 2022 13:55:08 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnRSG-000Ext-7v;
        Sat, 07 May 2022 20:55:08 +0000
Date:   Sun, 8 May 2022 04:54:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alex Shi <alexs@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: drivers/hwmon/ltq-cputemp.c:23:2: error: call to undeclared function
 'ltq_cgu_w32'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <202205080416.vzIXy16B-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   30c8e80f79329617012f07b09b70114592092ea4
commit: e8c07082a810fbb9db303a2b66b66b8d7e588b53 Kbuild: move to -std=gnu11
date:   8 weeks ago
config: mips-randconfig-r022-20220507 (https://download.01.org/0day-ci/archive/20220508/202205080416.vzIXy16B-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project af4cf1c6b8ed0d8102fc5e69acdc2fcbbcdaa9a7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e8c07082a810fbb9db303a2b66b66b8d7e588b53
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e8c07082a810fbb9db303a2b66b66b8d7e588b53
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/hwmon/ltq-cputemp.c:23:2: error: call to undeclared function 'ltq_cgu_w32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           ltq_cgu_w32(ltq_cgu_r32(CGU_GPHY1_CR) | CGU_TEMP_PD, CGU_GPHY1_CR);
           ^
>> drivers/hwmon/ltq-cputemp.c:23:14: error: call to undeclared function 'ltq_cgu_r32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           ltq_cgu_w32(ltq_cgu_r32(CGU_GPHY1_CR) | CGU_TEMP_PD, CGU_GPHY1_CR);
                       ^
   drivers/hwmon/ltq-cputemp.c:28:2: error: call to undeclared function 'ltq_cgu_w32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           ltq_cgu_w32(ltq_cgu_r32(CGU_GPHY1_CR) & ~CGU_TEMP_PD, CGU_GPHY1_CR);
           ^
   drivers/hwmon/ltq-cputemp.c:28:14: error: call to undeclared function 'ltq_cgu_r32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           ltq_cgu_w32(ltq_cgu_r32(CGU_GPHY1_CR) & ~CGU_TEMP_PD, CGU_GPHY1_CR);
                       ^
   drivers/hwmon/ltq-cputemp.c:39:12: error: call to undeclared function 'ltq_cgu_r32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   value = (ltq_cgu_r32(CGU_GPHY1_CR) >> 9) & 0x01FF;
                            ^
   drivers/hwmon/ltq-cputemp.c:92:24: error: use of undeclared identifier 'SOC_TYPE_VR9_2'
           if (ltq_soc_type() != SOC_TYPE_VR9_2)
                                 ^
   6 errors generated.


vim +/ltq_cgu_w32 +23 drivers/hwmon/ltq-cputemp.c

7074d0a9275860 Florian Eckert 2017-09-01  20  
7074d0a9275860 Florian Eckert 2017-09-01  21  static void ltq_cputemp_enable(void)
7074d0a9275860 Florian Eckert 2017-09-01  22  {
7074d0a9275860 Florian Eckert 2017-09-01 @23  	ltq_cgu_w32(ltq_cgu_r32(CGU_GPHY1_CR) | CGU_TEMP_PD, CGU_GPHY1_CR);
7074d0a9275860 Florian Eckert 2017-09-01  24  }
7074d0a9275860 Florian Eckert 2017-09-01  25  

:::::: The code at line 23 was first introduced by commit
:::::: 7074d0a92758603369655ef5d4f49e6caaae0b4e hwmon: (ltq-cputemp) add cpu temp sensor driver

:::::: TO: Florian Eckert <fe@dev.tdt.de>
:::::: CC: Guenter Roeck <linux@roeck-us.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
