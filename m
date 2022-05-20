Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5654B52E31D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 05:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345160AbiETD3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 23:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiETD24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 23:28:56 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56CE126989
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 20:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653017335; x=1684553335;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/2Rd7aRGXDFx0VPd9x4FavskHTE+idupHl56Dc9ywwA=;
  b=cO7fECGjz/kx5zqBNDAT74qwE/1yx4QU5lSawr0PKUVKrpEuJVJzGxdR
   va9SzmzGUEaDhk4fM23Y2SFnwIItlaErcDFPioBumqhHrwluhkVYSkRPP
   Q0lqi4/apQmme3JlFS6kFcNUj+fziIYCuF6OD0DGxpPTJ6rYJt/GJbzrM
   WcG+4ZOhtNsqxrgewHMRjFaIfOnJWt3YEk/EaR+4sth1ghHXovm/yrKjn
   0bzUFssUEYELsrRSq44WdmEFKrlCl3CDtQNkc4sabbPbm1/uN2hwx8GDE
   Gy3Arsii5BSQWMadVuAt9HY1bJYcUdXL72EqTm8Jnp2SSZiNKFV61d9W7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="335521923"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="335521923"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 20:28:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="570581574"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 19 May 2022 20:28:53 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrtJt-0004El-4i;
        Fri, 20 May 2022 03:28:53 +0000
Date:   Fri, 20 May 2022 11:28:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [ammarfaizi2-block:palmer/linux/riscv-compat 20/20]
 riscv64-linux-ld: arch/riscv/kernel/compat_syscall_table.o:undefined
 reference to `compat_sys_fadvise64_64'
Message-ID: <202205201131.BsQlHAIj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
head:   9be8459298eadb39b9fe9974b890239e9c123107
commit: 9be8459298eadb39b9fe9974b890239e9c123107 [20/20] riscv: compat: Add COMPAT Kbuild skeletal support
config: riscv-randconfig-r004-20220519 (https://download.01.org/0day-ci/archive/20220520/202205201131.BsQlHAIj-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/9be8459298eadb39b9fe9974b890239e9c123107
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/riscv-compat
        git checkout 9be8459298eadb39b9fe9974b890239e9c123107
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> riscv64-linux-ld: arch/riscv/kernel/compat_syscall_table.o:(.rodata+0x6f8): undefined reference to `compat_sys_fadvise64_64'
   pahole: .tmp_vmlinux.btf: No such file or directory
   .btf.vmlinux.bin.o: file not recognized: file format not recognized

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
