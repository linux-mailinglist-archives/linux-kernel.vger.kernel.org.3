Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B24D4C8794
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiCAJPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiCAJPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:15:48 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2C8593BB
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 01:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646126108; x=1677662108;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ueRuIoz8c1TdAaEnO8jopbYQ47yyncVMR5lUSopp0pc=;
  b=jSWyKP2w27gWgkA3K6TANmM0IE+V4vAMpTF9N6ZpXiaj4yeQzidCpQXB
   HnSLAgMbI95qg2gyOAN7XDin2PlSgHskIrxtq0v8TCr1F+ZCEAIyP/USp
   rhpdLknhDCZdgNcCQwrG9EfQkb4mSSwDDJwqGRxC9GJ1PQ0MNAo62FClA
   FExFZRn/vG676ZZSqqBLduv2vbeNMLQ2GGx/BjC1WGx4kKNTdVY5kG5zS
   uI9jEUIpLyBQqYtAWYEt7SSJz5V4SujA6Hes4NkNCR5d8nhJskuECkTpO
   2fP8oeESjfMuY9oGn8r2nLWjaj31egMiwEbIgpOqj8S33s/AomkJyaFkF
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="240506863"
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="240506863"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 01:15:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="534819775"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 01 Mar 2022 01:15:07 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOyb4-0000DH-E2; Tue, 01 Mar 2022 09:15:06 +0000
Date:   Tue, 1 Mar 2022 17:14:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [amir73il:sb_iostats 4/8] include/linux/fs.h:3686:1: error: non-void
 function does not return a value in all control paths
Message-ID: <202203011714.24Dz5EuE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/amir73il/linux sb_iostats
head:   ecfdb413f2105083296e9cb45290eb1f01b0ef5c
commit: 8b022d3080d57a2a42917c1b36d7b4c27a4fac4e [4/8] fs: add iostats counters to struct super_block
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20220301/202203011714.24Dz5EuE-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/amir73il/linux/commit/8b022d3080d57a2a42917c1b36d7b4c27a4fac4e
        git remote add amir73il https://github.com/amir73il/linux
        git fetch --no-tags amir73il sb_iostats
        git checkout 8b022d3080d57a2a42917c1b36d7b4c27a4fac4e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
>> include/linux/fs.h:3686:1: error: non-void function does not return a value in all control paths [-Werror,-Wreturn-type]
   }
   ^
   1 error generated.
   make[2]: *** [scripts/Makefile.build:121: arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1191: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +3686 include/linux/fs.h

  3681	
  3682	static inline s64 sb_iostats_counter_read(struct super_block *sb, int id)
  3683	{
  3684		if (sb_has_iostats(sb))
  3685			return percpu_counter_sum_positive(&sb->s_iostats.counter[id]);
> 3686	}
  3687	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
