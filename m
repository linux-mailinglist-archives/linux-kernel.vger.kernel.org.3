Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7111A4C8011
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 02:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiCABGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 20:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiCABGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 20:06:20 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D742B34676
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 17:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646096740; x=1677632740;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FvpWjlfLHt8/9E7G16301nJTJ1h1zdRaqHADvP/+GEQ=;
  b=ejcpAvKqI7ztm+Kt9Vnf7V+ht4zbSu351472ContY0yYbhDmEMrFiSLR
   zRBoY10HzKN4mdLJ+6wvocxyWS0nSEi6AneNmfJlWnV/YOKGeYANXHwo2
   Q6k4bxk4pKq3dXjptW0unggB1uq2RSWQWqsrblMcw/xYElNZ4ASHIhdPA
   E08F+xE9zO+/KUY5DW6GPvQxsxxnz0tveEmXt5tCW2v3GZwv0qn+c3sdX
   Sgq+ICh8EiijXKsp9bP1JJypJsY+Qmn+FxlQWawsY6Ljhwt/A7Nl6yMLf
   za+SktOR1MQhGOPYwqlJncemq9/m4eYzvqcn33Lvrx0+QzUZcmLc6QIKB
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="232996935"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="232996935"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 17:05:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="641084023"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 28 Feb 2022 17:05:39 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOqxO-0007xd-9y; Tue, 01 Mar 2022 01:05:38 +0000
Date:   Tue, 1 Mar 2022 09:05:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [amir73il:sb_iostats 4/8] include/linux/fs.h:3648:15: error:
 implicit declaration of function 'percpu_counters_init'; did you mean
 'percpu_counter_init'?
Message-ID: <202203010903.oFHcgc04-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/amir73il/linux sb_iostats
head:   ecfdb413f2105083296e9cb45290eb1f01b0ef5c
commit: 8b022d3080d57a2a42917c1b36d7b4c27a4fac4e [4/8] fs: add iostats counters to struct super_block
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20220301/202203010903.oFHcgc04-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/amir73il/linux/commit/8b022d3080d57a2a42917c1b36d7b4c27a4fac4e
        git remote add amir73il https://github.com/amir73il/linux
        git fetch --no-tags amir73il sb_iostats
        git checkout 8b022d3080d57a2a42917c1b36d7b4c27a4fac4e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:697,
                    from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/xtensa/kernel/asm-offsets.c:21:
   include/linux/fs.h: In function 'sb_iostats_init':
>> include/linux/fs.h:3648:15: error: implicit declaration of function 'percpu_counters_init'; did you mean 'percpu_counter_init'? [-Werror=implicit-function-declaration]
    3648 |         err = percpu_counters_init(sb->s_iostats.counter,
         |               ^~~~~~~~~~~~~~~~~~~~
         |               percpu_counter_init
   include/linux/fs.h: In function 'sb_iostats_destroy':
>> include/linux/fs.h:3666:17: error: implicit declaration of function 'percpu_counters_destroy'; did you mean 'percpu_counter_destroy'? [-Werror=implicit-function-declaration]
    3666 |                 percpu_counters_destroy(sb->s_iostats.counter,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
         |                 percpu_counter_destroy
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:121: arch/xtensa/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1191: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +3648 include/linux/fs.h

  3641	
  3642	#ifdef CONFIG_FS_IOSTATS
  3643	/* Initialize per-sb I/O stats */
  3644	static inline int sb_iostats_init(struct super_block *sb)
  3645	{
  3646		int err;
  3647	
> 3648		err = percpu_counters_init(sb->s_iostats.counter,
  3649					   SB_IOSTATS_COUNTERS_NUM, 0, GFP_KERNEL);
  3650		if (!err) {
  3651			sb->s_iflags |= SB_I_IOSTATS;
  3652			sb->s_iostats.start_time = ktime_get_seconds();
  3653		}
  3654	
  3655		return err;
  3656	}
  3657	
  3658	static inline bool sb_has_iostats(struct super_block *sb)
  3659	{
  3660		return (sb->s_iflags & SB_I_IOSTATS);
  3661	}
  3662	
  3663	static inline void sb_iostats_destroy(struct super_block *sb)
  3664	{
  3665		if (sb_has_iostats(sb))
> 3666			percpu_counters_destroy(sb->s_iostats.counter,
  3667						SB_IOSTATS_COUNTERS_NUM);
  3668	}
  3669	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
