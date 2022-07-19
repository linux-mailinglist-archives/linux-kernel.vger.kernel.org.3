Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB0657A881
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 22:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240288AbiGSUth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 16:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240174AbiGSUtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 16:49:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73805A164
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 13:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658263773; x=1689799773;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1FETl9/GOw92C0K59SvpN3kdI7uId9kecaBzsARiyjw=;
  b=DaD7IfKwm782eDW2vef8IJexaFRPXyMnRsjgsR2iU9KTO0M/2F713dzO
   fEOChmxMOrYrTO0sGQi+X6XaeDBaOqg+VEc2VQetbBHk7rBgDjZy4m4K4
   zsUNMnseZ9trmWm778nRIzxfMZPFA500/0TTpFWg48MHj9EfxjXawcglB
   3E9zf9fw+YyXjZn0DE81v2nh+hz1V13BzFce65mjZ4daSJQXu9dqwQgIo
   L4WUmjUxN82RJd9xdzOxvzXEOoVRzfwDHbmLg1aw6V66MOgMZjm8NnYwE
   wQHYWo+fStAW/3tiSJbeny4XzAV0FsbMJ4QGAJwqTSkCqeTdXR3MeSirj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="350579517"
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="350579517"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 13:49:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="625349135"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 19 Jul 2022 13:49:31 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDu9r-00062d-1P;
        Tue, 19 Jul 2022 20:49:31 +0000
Date:   Wed, 20 Jul 2022 04:49:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: arch/arm/mach-versatile/versatile.c:56:14: warning: no previous
 prototype for function 'mmc_status'
Message-ID: <202207200433.KqmAK60e-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ca85855bdcae8f84f1512e88b4c75009ea17ea2f
commit: d7445676e86900f8dc363825033ff62416c216e0 ARM: versatile: move integrator/realview/vexpress to versatile
date:   4 months ago
config: arm-versatile_defconfig (https://download.01.org/0day-ci/archive/20220720/202207200433.KqmAK60e-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project fa0c7639e91fa1cd0cf2ff0445a1634a90fe850a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d7445676e86900f8dc363825033ff62416c216e0
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d7445676e86900f8dc363825033ff62416c216e0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm/mach-versatile/versatile.c:56:14: warning: no previous prototype for function 'mmc_status' [-Wmissing-prototypes]
   unsigned int mmc_status(struct device *dev)
                ^
   arch/arm/mach-versatile/versatile.c:56:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   unsigned int mmc_status(struct device *dev)
   ^
   static 
   1 warning generated.


vim +/mmc_status +56 arch/arm/mach-versatile/versatile.c

a7096789211193 arch/arm/mach-versatile/versatile_dt.c Rob Herring 2015-12-08  55  
a7096789211193 arch/arm/mach-versatile/versatile_dt.c Rob Herring 2015-12-08 @56  unsigned int mmc_status(struct device *dev)
a7096789211193 arch/arm/mach-versatile/versatile_dt.c Rob Herring 2015-12-08  57  {
a7096789211193 arch/arm/mach-versatile/versatile_dt.c Rob Herring 2015-12-08  58  	struct amba_device *adev = container_of(dev, struct amba_device, dev);
a7096789211193 arch/arm/mach-versatile/versatile_dt.c Rob Herring 2015-12-08  59  	u32 mask;
a7096789211193 arch/arm/mach-versatile/versatile_dt.c Rob Herring 2015-12-08  60  
a7096789211193 arch/arm/mach-versatile/versatile_dt.c Rob Herring 2015-12-08  61  	if (adev->res.start == VERSATILE_MMCI0_BASE)
a7096789211193 arch/arm/mach-versatile/versatile_dt.c Rob Herring 2015-12-08  62  		mask = 1;
a7096789211193 arch/arm/mach-versatile/versatile_dt.c Rob Herring 2015-12-08  63  	else
a7096789211193 arch/arm/mach-versatile/versatile_dt.c Rob Herring 2015-12-08  64  		mask = 2;
a7096789211193 arch/arm/mach-versatile/versatile_dt.c Rob Herring 2015-12-08  65  
a7096789211193 arch/arm/mach-versatile/versatile_dt.c Rob Herring 2015-12-08  66  	return readl(versatile_sys_base + VERSATILE_SYS_MCI_OFFSET) & mask;
a7096789211193 arch/arm/mach-versatile/versatile_dt.c Rob Herring 2015-12-08  67  }
a7096789211193 arch/arm/mach-versatile/versatile_dt.c Rob Herring 2015-12-08  68  

:::::: The code at line 56 was first introduced by commit
:::::: a70967892111934e292485ce84f1bab38cc55380 ARM: versatile: merge mach code into a single file

:::::: TO: Rob Herring <robh@kernel.org>
:::::: CC: Arnd Bergmann <arnd@arndb.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
