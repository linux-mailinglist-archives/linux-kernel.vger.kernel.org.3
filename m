Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFDD449EC99
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 21:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344054AbiA0UlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 15:41:22 -0500
Received: from mga04.intel.com ([192.55.52.120]:52771 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238714AbiA0UlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 15:41:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643316078; x=1674852078;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PtXUQzPfEgkweEHkVOvRzld+rVCoXr9X4ootNwJo2Kc=;
  b=lNb2EFg7WVbQrUPVHiVIkishjksT3edldzabFJMhtuO5Mt5nEDW194DI
   aeQ+l+ltGtyPU5f1VsH7P/Av5azwkIcKw5s1OGjhzUIiTMEsBYV2Ipr3F
   0lhznSMFXvAhpm2V4blsXKRat2S4OtWQbv6yG9Doq9S33oQaKUU12Y13j
   7k3Luh5DuHycb9srhqNNnf9dL6IETwqLUQaf9IJhwdpco+wbK3IFd2pwm
   ZE30W6d9U1r7GTKAuQt/hjSUJFFogEEU/UPu4QEglYP0Te4Y9YcAe1HAB
   4RVup1f+WtVNCoSBklCM8NRrwNQXpwb4JDZPgO6KZz7qHIJXJhGAxia4d
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="245800442"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="245800442"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 12:41:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="597961775"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jan 2022 12:41:17 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDBa0-000N1Z-Dg; Thu, 27 Jan 2022 20:41:16 +0000
Date:   Fri, 28 Jan 2022 04:40:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ramji Jiyani <ramjiyani@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android13-5.10
 9410/9999] kernel/gki_module.c:35:6: warning: no previous prototype for
 function 'gki_is_module_protected_symbol'
Message-ID: <202201280406.7Em0aA4W-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android13-5.10
head:   7edc8bc69d7def26c4528360c9ec96dbeadcd0a1
commit: 9ab6a242258a9ac17506b74c6ed7332703d536f4 [9410/9999] ANDROID: GKI: Add module load time protected symbol lookup
config: arm-randconfig-r023-20220127 (https://download.01.org/0day-ci/archive/20220128/202201280406.7Em0aA4W-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f400a6012c668dfaa73462caf067ceb074e66c47)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/ammarfaizi2/linux-block/commit/9ab6a242258a9ac17506b74c6ed7332703d536f4
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android13-5.10
        git checkout 9ab6a242258a9ac17506b74c6ed7332703d536f4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/gki_module.c:35:6: warning: no previous prototype for function 'gki_is_module_protected_symbol' [-Wmissing-prototypes]
   bool gki_is_module_protected_symbol(const char *name)
        ^
   kernel/gki_module.c:35:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool gki_is_module_protected_symbol(const char *name)
   ^
   static 
>> kernel/gki_module.c:46:6: warning: no previous prototype for function 'gki_is_module_exported_symbol' [-Wmissing-prototypes]
   bool gki_is_module_exported_symbol(const char *name)
        ^
   kernel/gki_module.c:46:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool gki_is_module_exported_symbol(const char *name)
   ^
   static 
   2 warnings generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for PHYLINK
   Depends on NETDEVICES
   Selected by
   - GKI_HIDDEN_ETHERNET_CONFIGS
   WARNING: unmet direct dependencies detected for WEXT_SPY
   Depends on NET && WIRELESS
   Selected by
   - GKI_LEGACY_WEXT_ALLCONFIG
   WARNING: unmet direct dependencies detected for WIRELESS_EXT
   Depends on NET && WIRELESS
   Selected by
   - GKI_LEGACY_WEXT_ALLCONFIG
   WARNING: unmet direct dependencies detected for WEXT_CORE
   Depends on NET && WIRELESS && (CFG80211_WEXT || WIRELESS_EXT
   Selected by
   - GKI_LEGACY_WEXT_ALLCONFIG
   WARNING: unmet direct dependencies detected for NET_PTP_CLASSIFY
   Depends on NET
   Selected by
   - GKI_HIDDEN_NET_CONFIGS
   WARNING: unmet direct dependencies detected for SND_PCM_IEC958
   Depends on SOUND && !UML && SND
   Selected by
   - GKI_HIDDEN_SND_SOC_CONFIGS
   WARNING: unmet direct dependencies detected for HMM_MIRROR
   Depends on MMU
   Selected by
   - GKI_HIDDEN_GPU_CONFIGS
   WARNING: unmet direct dependencies detected for WEXT_PROC
   Depends on NET && WIRELESS && PROC_FS && WEXT_CORE
   Selected by
   - GKI_LEGACY_WEXT_ALLCONFIG
   WARNING: unmet direct dependencies detected for WEXT_PRIV
   Depends on NET && WIRELESS
   Selected by
   - GKI_LEGACY_WEXT_ALLCONFIG
   WARNING: unmet direct dependencies detected for PAGE_POOL
   Depends on NET
   Selected by
   - GKI_HIDDEN_NET_CONFIGS


vim +/gki_is_module_protected_symbol +35 kernel/gki_module.c

    29	
    30	/**
    31	 * gki_is_module_protected_symbol - Is a symbol protected from unsigned module?
    32	 *
    33	 * @name:	Symbol being checked against protection from unsigned module
    34	 */
  > 35	bool gki_is_module_protected_symbol(const char *name)
    36	{
    37		return bsearch(name, gki_protected_symbols, NO_OF_PROTECTED_SYMBOLS,
    38			       MAX_PROTECTED_NAME_LEN, cmp_name) != NULL;
    39	}
    40	
    41	/**
    42	 * gki_is_module_exported_symbol - Is a symbol exported from a GKI module?
    43	 *
    44	 * @name:	Symbol being checked against exported symbols from GKI modules
    45	 */
  > 46	bool gki_is_module_exported_symbol(const char *name)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
