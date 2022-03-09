Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387C14D2807
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 06:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiCIE6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 23:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiCIE6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 23:58:52 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C888DE8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 20:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646801874; x=1678337874;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4+tpppr2nS3z3jqvQ18eYrd8CDvGD+af7zUmyFkKqOM=;
  b=dwacL0R33tFthWwCBDO8gqzEfqy+uqZ2aYCodcgr+K3wVrBmPoaJAYfn
   WSDT+UGRb7keKEtnQuaK7UUJ2LVIucg3VdqvlHB/L3fhdYJ+24OwrRhJK
   kbeygL1QXQExTdmUeOe4cp0tREkYkeb2Z/9QIUPOxCMAP6lSHLrYKAA5Y
   2dzaI22Z+66od9ysbhE8OtZcZrOzO2SkDrqFoL+D24IbKGlqTcSEAT4bD
   lCCpY/Jj+zCs1PgBzDgsmXoJIPrnI9VzhGiOHvvjV3DhnDLSr7bFB0iEk
   3tLdphXONablYHLsSJwcBR5WHVYzgHDInZROKmDNN8fxg2WKd7QsQqnxI
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="318114731"
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="318114731"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 20:57:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="643913005"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 08 Mar 2022 20:57:52 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRoOV-0002c8-6N; Wed, 09 Mar 2022 04:57:51 +0000
Date:   Wed, 9 Mar 2022 12:57:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [linux-stable-rc:queue/5.10 9971/9999]
 arch/arm/kernel/spectre.c:13:14: error: expected ';' after return statement
Message-ID: <202203091205.qc6V73C4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/5.10
head:   fbf58a03f7a4df716d2470b8badfa0cada9e6fde
commit: 06036e20ed2d16694cd91fd64fe6f031756c138c [9971/9999] ARM: include unprivileged BPF status in Spectre V2 reporting
config: arm-milbeaut_m10v_defconfig (https://download.01.org/0day-ci/archive/20220309/202203091205.qc6V73C4-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 276ca87382b8f16a65bddac700202924228982f6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=06036e20ed2d16694cd91fd64fe6f031756c138c
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/5.10
        git checkout 06036e20ed2d16694cd91fd64fe6f031756c138c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/arm/kernel/spectre.c:13:14: error: expected ';' after return statement
           return false
                       ^
                       ;
   1 error generated.


vim +13 arch/arm/kernel/spectre.c

     7	
     8	static bool _unprivileged_ebpf_enabled(void)
     9	{
    10	#ifdef CONFIG_BPF_SYSCALL
    11		return !sysctl_unprivileged_bpf_disabled;
    12	#else
  > 13		return false
    14	#endif
    15	}
    16	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
