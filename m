Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA7A4ECEEA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 23:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbiC3Vni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 17:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbiC3Vng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 17:43:36 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C17A517D6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 14:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648676511; x=1680212511;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f5s+xzgDBJONZVtRIXVk5+pVqalThtgSX+lwS4QrAhg=;
  b=ZlYaIlYcXiLA0eafeLb51+jFZzp26yZmt+vs/ihSohUkuaJ4tgyq1nSP
   3GoekUPzUboHXWwJwuYzJGUWk1Z9kii3EAEiq13VoBnBuJHwCah43jJNf
   iv5QMrQWVs177segDnSxkeiAmXBZwZByDOBgFERFhMhWzkibhhivLowIl
   TU4Y10nU6zoTB2fJo48S8HwOJacxqrmCq9wgd6TVnQ5PmZ38ccacAa8aC
   exb3Kt++TBLR4qCc0hEu2P6CxCxPIadPJpIhZADmoGT6Tp8HPtPHcBlJ2
   OEkJnIF+sPdIeSnqqWfgcCxSuEEIQBFrbefIgCEhmtpf33/BPL4hDb8+B
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="320349195"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="320349195"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 14:41:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="654131417"
Received: from lkp-server02.sh.intel.com (HELO 56431612eabd) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 30 Mar 2022 14:41:49 -0700
Received: from kbuild by 56431612eabd with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZg4a-0000Wm-8A;
        Wed, 30 Mar 2022 21:41:48 +0000
Date:   Thu, 31 Mar 2022 05:41:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: arch/arm/mach-iop32x/cp6.c:10:6: warning: no previous prototype for
 function 'iop_enable_cp6'
Message-ID: <202203310512.uBfXEXYW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d888c83fcec75194a8a48ccd283953bdba7b2550
commit: 6f5d248d05db9c4991366154f1a657a630faa583 ARM: iop32x: use GENERIC_IRQ_MULTI_HANDLER
date:   4 months ago
config: arm-randconfig-r024-20220330 (https://download.01.org/0day-ci/archive/20220331/202203310512.uBfXEXYW-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6f5d248d05db9c4991366154f1a657a630faa583
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6f5d248d05db9c4991366154f1a657a630faa583
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm/mach-iop32x/cp6.c:10:6: warning: no previous prototype for function 'iop_enable_cp6' [-Wmissing-prototypes]
   void iop_enable_cp6(void)
        ^
   arch/arm/mach-iop32x/cp6.c:10:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void iop_enable_cp6(void)
   ^
   static 
   arch/arm/mach-iop32x/cp6.c:43:13: warning: no previous prototype for function 'iop_init_cp6_handler' [-Wmissing-prototypes]
   void __init iop_init_cp6_handler(void)
               ^
   arch/arm/mach-iop32x/cp6.c:43:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init iop_init_cp6_handler(void)
   ^
   static 
   2 warnings generated.


vim +/iop_enable_cp6 +10 arch/arm/mach-iop32x/cp6.c

     9	
  > 10	void iop_enable_cp6(void)
    11	{
    12		u32 temp;
    13	
    14	        /* enable cp6 access */
    15	        asm volatile (
    16			"mrc	p15, 0, %0, c15, c1, 0\n\t"
    17			"orr	%0, %0, #(1 << 6)\n\t"
    18			"mcr	p15, 0, %0, c15, c1, 0\n\t"
    19			"mrc	p15, 0, %0, c15, c1, 0\n\t"
    20			"mov	%0, %0\n\t"
    21			"sub	pc, pc, #4  @ cp_wait\n\t"
    22			: "=r"(temp));
    23	}
    24	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
