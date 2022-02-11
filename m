Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EA84B2099
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 09:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348199AbiBKIvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 03:51:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbiBKIvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 03:51:38 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D670CE80
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 00:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644569497; x=1676105497;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bHJCV8MMzu80z8MF5GnsjtrinDXB2IirHq5wwEWBYgM=;
  b=ja3iBmfNhiAZuGlNMXkytV6Vjm4kWzC+mt1943NqsYJYDyVXF3ZQkDez
   n1qbDRtGNWf3GJ3JLiT1GDLGE7L/uDLcpQQR3MF/xvEcohXNelZIzeR3a
   C5veFaYP08Qm4qTPPLNsfIHhskpapb7S2efcaR5JRquXUbfpb6W5azg3z
   ppt5ckj5DsZqk5c7LciMXNny2oPna+/T7GnqxsK+12iBZuRImdXkdSs1f
   rjk86ZXHSqrjcSGshs2LvoxAisMfyfkp5kH8wqnowLLWjokMcE+kTZWuN
   RWZLiQPgiPRRL8LGyU4lgoT/YNlY9LbNCxT3PcpuVSViGRmOUky2q+OIn
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="248523940"
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="248523940"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 00:51:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="630167207"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 11 Feb 2022 00:51:36 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIReR-0004MZ-NJ; Fri, 11 Feb 2022 08:51:35 +0000
Date:   Fri, 11 Feb 2022 16:50:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ramji Jiyani <ramjiyani@google.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android-mainline
 17/21] kernel/gki_module.c:35:6: warning: no previous prototype for
 'gki_is_module_protected_symbol'
Message-ID: <202202111611.znc1YtAj-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-mainline
head:   368cd631746c9d700f41883314865ea3ab05cfb7
commit: 5ffc4c2275478f8d4c17795dc5f1b552559fff26 [17/21] Revert "Revert "ANDROID: GKI: Add module load time protected symbol lookup""
config: sparc-buildonly-randconfig-r006-20220211 (https://download.01.org/0day-ci/archive/20220211/202202111611.znc1YtAj-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/5ffc4c2275478f8d4c17795dc5f1b552559fff26
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-mainline
        git checkout 5ffc4c2275478f8d4c17795dc5f1b552559fff26
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/gki_module.c:35:6: warning: no previous prototype for 'gki_is_module_protected_symbol' [-Wmissing-prototypes]
      35 | bool gki_is_module_protected_symbol(const char *name)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/gki_module.c:46:6: warning: no previous prototype for 'gki_is_module_exported_symbol' [-Wmissing-prototypes]
      46 | bool gki_is_module_exported_symbol(const char *name)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for NET_PTP_CLASSIFY
   Depends on NET
   Selected by
   - GKI_HIDDEN_NET_CONFIGS
   WARNING: unmet direct dependencies detected for HVC_DRIVER
   Depends on TTY
   Selected by
   - GKI_HIDDEN_VIRTUAL_CONFIGS
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
