Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B636B4F1857
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348121AbiDDP3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245461AbiDDP3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:29:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE8133370
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 08:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649086040; x=1680622040;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yU/nrfZ263LR5VUhJwSEVaYnpMgbfMGsS35R5MUtslE=;
  b=Pk3wm5SZx3ZEjLwr2ph5MtheWVddxvcuMCy87rv8PBxMCzW9/LF1fgfG
   02zdPOD+D2N/bIzyqnBZhy6Gpbm75yu7kP/zrd76m8saNJNy8SKT0jsNr
   NScOetvdzbzc6TkP2K7Fq4KIwQeBIUiWV7hJRSwcoeILN5u9IOEt8SySd
   boNuMd+q08NM1Z/LnaP3TiUm78y5XbcXi30Ul/Bjsb40+37Z4PjPPdxlc
   rvO2RwdpoMlgjMi0e7zOrA61Tbn3CLZJnrAtFjW+GOtW2Wc8HVv177TRD
   0qdFFQpimklBUU06jvVnSmyj6QbLzgCcm1axQ5phlLpnfhDcEalCxiio0
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="346979034"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="346979034"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 08:27:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="657540959"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 04 Apr 2022 08:27:18 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbObt-00029g-EE;
        Mon, 04 Apr 2022 15:27:17 +0000
Date:   Mon, 4 Apr 2022 23:27:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: arch/arm/mach-iop32x/cp6.c:10:6: warning: no previous prototype for
 'iop_enable_cp6'
Message-ID: <202204042312.fVSuandr-lkp@intel.com>
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

Hi Arnd,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3123109284176b1532874591f7c81f3837bbdc17
commit: 6f5d248d05db9c4991366154f1a657a630faa583 ARM: iop32x: use GENERIC_IRQ_MULTI_HANDLER
date:   4 months ago
config: arm-randconfig-r002-20220404 (https://download.01.org/0day-ci/archive/20220404/202204042312.fVSuandr-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6f5d248d05db9c4991366154f1a657a630faa583
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6f5d248d05db9c4991366154f1a657a630faa583
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm/mach-iop32x/cp6.c:10:6: warning: no previous prototype for 'iop_enable_cp6' [-Wmissing-prototypes]
      10 | void iop_enable_cp6(void)
         |      ^~~~~~~~~~~~~~
   arch/arm/mach-iop32x/cp6.c:43:13: warning: no previous prototype for 'iop_init_cp6_handler' [-Wmissing-prototypes]
      43 | void __init iop_init_cp6_handler(void)
         |             ^~~~~~~~~~~~~~~~~~~~


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
