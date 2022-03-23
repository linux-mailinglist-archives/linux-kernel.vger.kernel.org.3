Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CE74E5971
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 20:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344451AbiCWT4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 15:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344169AbiCWT4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 15:56:33 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61ED8B6FD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648065302; x=1679601302;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Mji/IWMMiADhaFHm+8S2xDl7FfNVOBT9IlCPZEx4HX0=;
  b=b/4XdYQW9BJxNIsNlLZdk5g05JLg95pZYwrWfbSY6I2wHp9va3eNufDt
   Yh3isBkamVR0wn1TkEeT7Hm8EQhnYNVF5k78WjtEaheWFAVdE/bxBOL67
   Xw0cPnpE63HeD7zxzkKvV/mLYXYUAYpeAwMJ5S55IB8IjwLlnRo25z7dA
   MGOHh0XbXPFkq3CpsRhiCApPVdmAln/cH7CF1jLKewvXtWJyy1siK9J8F
   Kva13n/a0fRvcucUIAxsplpW6sku6k4tLty8T64CUSAlO/0688z42iOIS
   sltV3c4JRB9CURoUpm1q5EH/bVy1UrjruPSe10Gt3I34qnmSWzW+eJ4Ha
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="255776545"
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="255776545"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 12:55:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="544344040"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 23 Mar 2022 12:55:01 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nX74O-000KLe-Bo; Wed, 23 Mar 2022 19:55:00 +0000
Date:   Thu, 24 Mar 2022 03:54:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:palmer/linux/riscv-ftrace_mutex_fix 1/1]
 arch/riscv/include/asm/ftrace.h:90:38: error: expected identifier or '('
 before numeric constant
Message-ID: <202203240331.uw3pfRFi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/riscv-ftrace_mutex_fix
head:   013eaa62130cd541cb2e7bf58303c509298701a8
commit: 013eaa62130cd541cb2e7bf58303c509298701a8 [1/1] RISC-V: Don't check text_mutex during stop_machine
config: riscv-randconfig-s032-20220323 (https://download.01.org/0day-ci/archive/20220324/202203240331.uw3pfRFi-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/013eaa62130cd541cb2e7bf58303c509298701a8
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/riscv-ftrace_mutex_fix
        git checkout 013eaa62130cd541cb2e7bf58303c509298701a8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/ftrace.h:22,
                    from arch/riscv/kernel/ftrace.c:8:
>> arch/riscv/include/asm/ftrace.h:90:38: error: expected identifier or '(' before numeric constant
      90 | #define riscv_ftrace_in_stop_machine 0
         |                                      ^
   arch/riscv/kernel/ftrace.c:14:5: note: in expansion of macro 'riscv_ftrace_in_stop_machine'
      14 | int riscv_ftrace_in_stop_machine;
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +90 arch/riscv/include/asm/ftrace.h

    88	
    89	#ifndef __ASSEMBLY__
  > 90	#define riscv_ftrace_in_stop_machine 0
    91	#endif
    92	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
