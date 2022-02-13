Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB3B4B3C9D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 18:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbiBMRsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 12:48:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237488AbiBMRsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 12:48:10 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A83F5A098
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 09:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644774484; x=1676310484;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=G4lnQt9mqaSacmnUNQc0vRjPvtM79i/zVMuBcDZ8deo=;
  b=EPliIkP6ZsKESFpS8hBzX1fqgDnV5u5DEkMf/Hh3F8k0CNBUI8cr/zZd
   EVZB80hXntlXffI1OiGTBhOiYQrpSpW5Xw5suq+HvxCiE2V2AX1bLUcj9
   0TeBlT6BiLLWwMfRVzWlbwo42zjBNAzbQorAdUGRJPTwiubPkAZo11vLk
   jsuRGaSRsc1WFSjpVGxeipA+2OhSClv6gIx1/ss4uso7pcfsq+pmjang6
   VzyqsR+BtBGjSB9NHI2pw8pHrVGW1wH5/ZLeWKGRjspGWRZmOxbRlQdUy
   u9ooClAiJHzpqyKlwOpHEFf/wipuQDwKN50sitB8ix46o7sLNIjFCTpzR
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="229927770"
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="229927770"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 09:48:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="569617180"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Feb 2022 09:48:02 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJIyf-0007hB-HB; Sun, 13 Feb 2022 17:48:01 +0000
Date:   Mon, 14 Feb 2022 01:47:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: arch/arm/mach-ep93xx/ts72xx.c:154:13: error: no previous prototype
 for function 'ts72xx_register_flash'
Message-ID: <202202140141.HRZ3WZwi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b81b1829e7e39f6cebdf6e4d5484eacbceda8554
commit: 9645ccc7bd7a16cd73c3be9dee70cd702b03be37 ep93xx: clock: convert in-place to COMMON_CLK
date:   4 months ago
config: arm-randconfig-r004-20220213 (https://download.01.org/0day-ci/archive/20220214/202202140141.HRZ3WZwi-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project ea071884b0cc7210b3cc5fe858f0e892a779a23b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9645ccc7bd7a16cd73c3be9dee70cd702b03be37
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9645ccc7bd7a16cd73c3be9dee70cd702b03be37
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mach-ep93xx/ drivers/hsi/controllers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/arm/mach-ep93xx/ts72xx.c:154:13: error: no previous prototype for function 'ts72xx_register_flash' [-Werror,-Wmissing-prototypes]
   void __init ts72xx_register_flash(struct mtd_partition *parts, int n,
               ^
   arch/arm/mach-ep93xx/ts72xx.c:154:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init ts72xx_register_flash(struct mtd_partition *parts, int n,
   ^
   static 
   1 error generated.
--
>> drivers/hsi/controllers/omap_ssi_core.c:147:6: error: no previous prototype for function 'ssi_waketest' [-Werror,-Wmissing-prototypes]
   void ssi_waketest(struct hsi_client *cl, unsigned int enable)
        ^
   drivers/hsi/controllers/omap_ssi_core.c:147:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void ssi_waketest(struct hsi_client *cl, unsigned int enable)
   ^
   static 
   1 error generated.
--
>> drivers/hsi/controllers/omap_ssi_port.c:463:6: error: variable 'val' set but not used [-Werror,-Wunused-but-set-variable]
           u32 val;
               ^
>> drivers/hsi/controllers/omap_ssi_port.c:1325:6: error: variable 'mode' set but not used [-Werror,-Wunused-but-set-variable]
           u32 mode;
               ^
   2 errors generated.


vim +/ts72xx_register_flash +154 arch/arm/mach-ep93xx/ts72xx.c

030d2dd450a628 H Hartley Sweeten 2010-01-05  153  
d6d76745f4d921 Lukasz Majewski   2017-12-12 @154  void __init ts72xx_register_flash(struct mtd_partition *parts, int n,
d6d76745f4d921 Lukasz Majewski   2017-12-12  155  				  resource_size_t start)
3174c88af4b6b2 Hartley Sweeten   2009-07-20  156  {
16bcf78f8cac9c Hartley Sweeten   2010-06-10  157  	/*
16bcf78f8cac9c Hartley Sweeten   2010-06-10  158  	 * TS7200 has NOR flash all other TS72xx board have NAND flash.
16bcf78f8cac9c Hartley Sweeten   2010-06-10  159  	 */
030d2dd450a628 H Hartley Sweeten 2010-01-05  160  	if (board_is_ts7200()) {
16bcf78f8cac9c Hartley Sweeten   2010-06-10  161  		ep93xx_register_flash(2, EP93XX_CS6_PHYS_BASE, SZ_16M);
030d2dd450a628 H Hartley Sweeten 2010-01-05  162  	} else {
030d2dd450a628 H Hartley Sweeten 2010-01-05  163  		ts72xx_nand_resource[0].start = start;
030d2dd450a628 H Hartley Sweeten 2010-01-05  164  		ts72xx_nand_resource[0].end = start + SZ_16M - 1;
030d2dd450a628 H Hartley Sweeten 2010-01-05  165  
d6d76745f4d921 Lukasz Majewski   2017-12-12  166  		ts72xx_nand_data.chip.partitions = parts;
d6d76745f4d921 Lukasz Majewski   2017-12-12  167  		ts72xx_nand_data.chip.nr_partitions = n;
d6d76745f4d921 Lukasz Majewski   2017-12-12  168  
030d2dd450a628 H Hartley Sweeten 2010-01-05  169  		platform_device_register(&ts72xx_nand_flash);
030d2dd450a628 H Hartley Sweeten 2010-01-05  170  	}
3174c88af4b6b2 Hartley Sweeten   2009-07-20  171  }
3174c88af4b6b2 Hartley Sweeten   2009-07-20  172  

:::::: The code at line 154 was first introduced by commit
:::::: d6d76745f4d921ba8c58d72259b9383ee5b67b28 ARM: ep93xx: ts72xx: Rewrite ts72xx_register_flash() to accept parameters

:::::: TO: Lukasz Majewski <lukma@denx.de>
:::::: CC: Alexander Sverdlin <alexander.sverdlin@gmail.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
