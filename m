Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C758D4EB4DF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 22:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbiC2UxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 16:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbiC2UxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:53:12 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050FC175868
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648587088; x=1680123088;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KF5fL2N5W3c8RxnvdQKVSD8wAXgTvnERndgwIpIMHT0=;
  b=D8zW3X0hn2iCAY0pxSlRbW2R/U7UIReG/o2SyQXKxIZN6c6wgt4pVOZF
   Yq+tpE2RCRxU2u0LoxUxEOltLhs+rkCxM6bcujzvH8FoABKelyiJ5CoUW
   5chcLASfFoUhsWxs0xPXqEJoAem3CwexVREcg5Qk/Q/eTqv0dNrRxanpa
   fgZJR7JckbBw0e8MYxfF4keOgmOEvoUJ/8QrwXF7X+a9JFgfe+ctigtks
   8btNebsR27gAxTgMOvulzpSVB+VDZ7c7Jlh3ICnhDTATlx78vXJZp2SOQ
   TI/4z6ihOTn3mvebFysuEFilAZE8/bUqG+ftD1FVYkyyJPrtPzX5TbWZH
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="239300396"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="239300396"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 13:51:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="521605826"
Received: from lkp-server01.sh.intel.com (HELO 3965e2759b93) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Mar 2022 13:51:26 -0700
Received: from kbuild by 3965e2759b93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZIoH-0000eh-O6; Tue, 29 Mar 2022 20:51:25 +0000
Date:   Wed, 30 Mar 2022 04:50:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/xtensa/boot/boot-elf/bootstrap.S:58: Error: invalid register
 'atomctl' for 'wsr' instruction
Message-ID: <202203300413.qP8NZbrV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1930a6e739c4b4a654a69164dbe39e554d228915
commit: c20e1117d9aa22c558646a1060ddd1dd042fb107 xtensa: add kernel ABI selection to Kconfig
date:   3 weeks ago
config: xtensa-randconfig-r014-20220329 (https://download.01.org/0day-ci/archive/20220330/202203300413.qP8NZbrV-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c20e1117d9aa22c558646a1060ddd1dd042fb107
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c20e1117d9aa22c558646a1060ddd1dd042fb107
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/xtensa/boot/boot-elf/bootstrap.S: Assembler messages:
>> arch/xtensa/boot/boot-elf/bootstrap.S:58: Error: invalid register 'atomctl' for 'wsr' instruction
   arch/xtensa/boot/boot-elf/bootstrap.S:68: Warning: value 0x1a0003000 truncated to 0xa0003000


vim +58 arch/xtensa/boot/boot-elf/bootstrap.S

e85e335f8ff615f Max Filippov 2012-12-03  42  
e85e335f8ff615f Max Filippov 2012-12-03  43  	.align  4
e85e335f8ff615f Max Filippov 2012-12-03  44  _SetupMMU:
09af39f649dac66 Max Filippov 2021-07-26  45  #if XCHAL_HAVE_WINDOWED
e85e335f8ff615f Max Filippov 2012-12-03  46  	movi	a0, 0
e85e335f8ff615f Max Filippov 2012-12-03  47  	wsr	a0, windowbase
e85e335f8ff615f Max Filippov 2012-12-03  48  	rsync
e85e335f8ff615f Max Filippov 2012-12-03  49  	movi	a0, 1
e85e335f8ff615f Max Filippov 2012-12-03  50  	wsr	a0, windowstart
e85e335f8ff615f Max Filippov 2012-12-03  51  	rsync
09af39f649dac66 Max Filippov 2021-07-26  52  #endif
e85e335f8ff615f Max Filippov 2012-12-03  53  	movi	a0, 0x1F
e85e335f8ff615f Max Filippov 2012-12-03  54  	wsr	a0, ps
e85e335f8ff615f Max Filippov 2012-12-03  55  	rsync
e85e335f8ff615f Max Filippov 2012-12-03  56  
e85e335f8ff615f Max Filippov 2012-12-03  57  #ifndef CONFIG_INITIALIZE_XTENSA_MMU_INSIDE_VMLINUX
e85e335f8ff615f Max Filippov 2012-12-03 @58  	initialize_mmu

:::::: The code at line 58 was first introduced by commit
:::::: e85e335f8ff615f74e29e09cc2599f095600114b xtensa: add MMU v3 support

:::::: TO: Max Filippov <jcmvbkbc@gmail.com>
:::::: CC: Chris Zankel <chris@zankel.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
