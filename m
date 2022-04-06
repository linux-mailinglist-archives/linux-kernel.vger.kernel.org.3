Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836094F5622
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 08:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343971AbiDFFry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 01:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2360608AbiDFDjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 23:39:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3FC20E97E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 17:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649203820; x=1680739820;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Cu9LFP1qebym8kf9nc0GqBQdxX6vpo1JJg9iLpIztAM=;
  b=W3XSqAyICqWdh69z6MZgAIX4Kj/w40HP3p32i5OdSQHNSC4ef7yEpZGo
   xvi4AYR7Qv5jY6R2CQ2nxhJXmBF478QSNXev6cjPJ0rWRmmiiiy/CXieC
   g3/D4uteGFU8+02942SoMU754+jv066TcPNVbGsk1fCaD0RoSuj0csEj7
   rHiz9dCp03DYinCGEHmtPmrj5sOMD8ckiKZmr1z3H5PCWABXqyG/YLnr1
   dLv6AQ9y00B1Mvm0e4RObg/g10/ayHnFnVPhR6YwyRVehVMec9Ry9GSLp
   ZUCGw8buMogpKJEYxod5rcf34AW9iIxIsllD+K1A4pJwBbJmL0CgG+4i6
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="347342702"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="347342702"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 17:09:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="588148922"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 05 Apr 2022 17:09:42 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbtEz-0003tt-Er;
        Wed, 06 Apr 2022 00:09:41 +0000
Date:   Wed, 6 Apr 2022 08:09:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>
Subject: ld.lld: error: kernel/built-in.a(kallsyms.o):(function
 lookup_symbol_name: .text+0x7dc): relocation R_RISCV_PCREL_HI20 out of
 range: -524489 is not in [-524288, 524287]; references kallsyms_names
Message-ID: <202204060800.J5dy8mkW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3e732ebf7316ac83e8562db7e64cc68aec390a18
commit: 606b102876e3741851dfb09d53f3ee57f650a52c drm: fb_helper: fix CONFIG_FB dependency
date:   6 months ago
config: riscv-randconfig-r042-20220405 (https://download.01.org/0day-ci/archive/20220406/202204060800.J5dy8mkW-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=606b102876e3741851dfb09d53f3ee57f650a52c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 606b102876e3741851dfb09d53f3ee57f650a52c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: kernel/built-in.a(kallsyms.o):(function lookup_symbol_name: .text+0x7dc): relocation R_RISCV_PCREL_HI20 out of range: -524489 is not in [-524288, 524287]; references kallsyms_names
   >>> referenced by kallsyms.c
   >>> defined in kernel/built-in.a(kallsyms.o)
--
>> ld.lld: error: kernel/built-in.a(kallsyms.o):(function lookup_symbol_name: .text+0x840): relocation R_RISCV_PCREL_HI20 out of range: -524489 is not in [-524288, 524287]; references kallsyms_token_index
   >>> referenced by kallsyms.c
   >>> defined in kernel/built-in.a(kallsyms.o)
--
>> ld.lld: error: kernel/built-in.a(kallsyms.o):(function lookup_symbol_name: .text+0x848): relocation R_RISCV_PCREL_HI20 out of range: -524489 is not in [-524288, 524287]; references kallsyms_token_table
   >>> referenced by kallsyms.c
   >>> defined in kernel/built-in.a(kallsyms.o)
--
>> ld.lld: error: kernel/built-in.a(kallsyms.o):(function lookup_symbol_attrs: .text+0x9bc): relocation R_RISCV_PCREL_HI20 out of range: -524489 is not in [-524288, 524287]; references kallsyms_markers
   >>> referenced by kallsyms.c
   >>> defined in kernel/built-in.a(kallsyms.o)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
