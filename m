Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AB457258A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 21:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbiGLTTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 15:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236145AbiGLTT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 15:19:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19B6115D99
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 11:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657652192; x=1689188192;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=p0ATnqkVHIiZ5SqLuCX+FdOCVkwi80hX/jKTCfvxPJ8=;
  b=O8JKd+q7/5JXfh4kxe/eL7ElRoPXjPGvDVhespHlc4WgjlDLMZP0ZHwW
   MDgMb+NyB+vAPnAv+PGTnxHBegTqYsvE5A/FqAIwRm3YBQOlAPpxkplTa
   rQFt0ie7dkiCueERb9Aw+B8fNiqlwu1Bk4IGqQ4zvR5/jhOI3HSDGEhp2
   j0kqrz4FprfkpIEy6YYHV5Gs9t0eXa47Zc1jl3WWPLYcWWn+Dr9bkm1G0
   qiUY2rt/XolaP5ZuE20bODHm/v0euq5XY/GRO7g32endlR2KYmbswT2gb
   eDha7Cc++nkVaEKUseOcuKecQxY97+zwEv6xOIKRPyOyjejQV4BhJc59Y
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="286147303"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="286147303"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 11:56:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="595396957"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 12 Jul 2022 11:56:30 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBL3d-0002ax-RN;
        Tue, 12 Jul 2022 18:56:29 +0000
Date:   Wed, 13 Jul 2022 02:56:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/arm/kernel/irq.c:51:12: sparse: sparse: symbol
 '__pcpu_scope_irq_stack_ptr' was not declared. Should it be static?
Message-ID: <202207130201.9faZVIMa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   72a8e05d4f66b5af7854df4490e3135168694b6b
commit: 9c46929e7989efacc1dd0a1dd662a839897ea2b6 ARM: implement THREAD_INFO_IN_TASK for uniprocessor systems
date:   7 months ago
config: arm-randconfig-s031-20220712 (https://download.01.org/0day-ci/archive/20220713/202207130201.9faZVIMa-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9c46929e7989efacc1dd0a1dd662a839897ea2b6
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9c46929e7989efacc1dd0a1dd662a839897ea2b6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/kernel/ arch/arm/mach-iop32x/ arch/arm/mach-mmp/ arch/arm/mach-mv78xx0/ arch/arm/mach-omap1/ arch/arm/mach-orion5x/ arch/arm/mach-spear/ arch/arm/mm/ drivers/clk/pxa/ drivers/isdn/hardware/mISDN/ drivers/net/ethernet/3com/ drivers/net/ethernet/alacritech/ drivers/net/ethernet/broadcom/ drivers/net/ethernet/brocade/bna/ drivers/net/ethernet/dlink/ drivers/net/ethernet/emulex/benet/ drivers/net/ethernet/google/gve/ drivers/net/ethernet/marvell/ drivers/scsi/ drivers/usb/host/ drivers/video/fbdev/omap/ drivers/w1/masters/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/arm/kernel/irq.c:51:12: sparse: sparse: symbol '__pcpu_scope_irq_stack_ptr' was not declared. Should it be static?

vim +/__pcpu_scope_irq_stack_ptr +51 arch/arm/kernel/irq.c

d4664b6c987f803 Ard Biesheuvel 2021-10-05  50  
d4664b6c987f803 Ard Biesheuvel 2021-10-05 @51  asmlinkage DEFINE_PER_CPU_READ_MOSTLY(u8 *, irq_stack_ptr);
d4664b6c987f803 Ard Biesheuvel 2021-10-05  52  

:::::: The code at line 51 was first introduced by commit
:::::: d4664b6c987f80338407889c1e3f3abe7e16be94 ARM: implement IRQ stacks

:::::: TO: Ard Biesheuvel <ardb@kernel.org>
:::::: CC: Ard Biesheuvel <ardb@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
