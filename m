Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C284ECC6F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347858AbiC3Sj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350979AbiC3SiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:38:22 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D7E5BE54
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648665388; x=1680201388;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dsZkV85VOjyfqJhpnTC+Fd4cW3CGBcgeUV/g0lbKhuI=;
  b=Xg3s9wHp5Xb95fX3qCfU/xTCBTfJAm4+tC5zjn54QqTPiWsPe3R9HYnD
   ayBtWBdNI1KHdY8peupPTsyDibuOqV2f6Cmb8PWXDTBnT1QKcDgc0jZ/G
   A/XQRvzmFG8BlPSIy8Km824Vi1bVZIXm2gbIf/2YVwpjfneZrJivzEgN3
   +K5q5Z4aW2DxQXhlJbRiuRoIlX3aAXSaY4M/LlUwbNle5ce+nyo1rPRSK
   OmnJOVuGHPqfS9EJuE4a00PKa3h0GsCgbpbY5A86Gs8dAVW4LvhqUuDW5
   wtFonJBBWuFnc1GM6t0EIJLbWeOq9ll+ilLVqEYwPaDigh1EUb69xP97a
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="322799161"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="322799161"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 11:36:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="654007180"
Received: from lkp-server02.sh.intel.com (HELO 56431612eabd) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 30 Mar 2022 11:36:26 -0700
Received: from kbuild by 56431612eabd with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZdBB-0000JK-Nf;
        Wed, 30 Mar 2022 18:36:25 +0000
Date:   Thu, 31 Mar 2022 02:36:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/arm/kernel/irq.c:51:12: sparse: sparse: symbol
 '__pcpu_scope_irq_stack_ptr' was not declared. Should it be static?
Message-ID: <202203310200.MFNPVX0L-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d888c83fcec75194a8a48ccd283953bdba7b2550
commit: cafc0eab168917ec9c0cd47d530a40cd40eb2928 ARM: v7m: enable support for IRQ stacks
date:   4 months ago
config: arm-randconfig-s031-20220327 (https://download.01.org/0day-ci/archive/20220331/202203310200.MFNPVX0L-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cafc0eab168917ec9c0cd47d530a40cd40eb2928
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout cafc0eab168917ec9c0cd47d530a40cd40eb2928
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/kernel/

If you fix the issue, kindly add following tag as appropriate
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
