Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554324D15F5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346384AbiCHLOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346444AbiCHLOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:14:40 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712273AA6F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646738022; x=1678274022;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pCYELmXBkIigiPJtVwTBqLUssyAEYgfH3V+jgi7461E=;
  b=C03Q7OHtgVi0z+HvN/DJnwBTbsOE1//xHVak6zbiwicAW/ZSleiVoKuf
   MXdpDMhBg2ckizrpekjXuJ+3DtUo5eYCl7vNWgq73Y51EPUL87llhsniS
   bS4qVk3GtU1dTzG5vG/ZQsG4nC7KeyjNXEGyS82AvDeAFkN042BqyQWdK
   l3nuhEut3NNNwhIcfNzqgYx4ogfDWqAqdM+ZYxniEu7gBtDo93+WWLLWD
   NHxNVwkSts+csb69WXnn+oKZShtfSzV1cVqsOGhCxjRwpvE+p9W50J6IJ
   /+8BvTJas41yt+eez10bB2s7f9Z8S/CaZWEAJpym03P+Ykq0AzpZXzKKB
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="315374225"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="315374225"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 03:13:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="595854279"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 08 Mar 2022 03:13:20 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRXmJ-0001Je-Hh; Tue, 08 Mar 2022 11:13:19 +0000
Date:   Tue, 8 Mar 2022 19:12:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wei Fu <wefu@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Liu Shaohua <liush@allwinnertech.com>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Subject: [ammarfaizi2-block:palmer/linux/riscv-d1 10/12] WARNING: modpost:
 vmlinux.o(.text.unlikely+0x1dc): Section mismatch in reference from the
 function riscv_cpufeature_patch_func() to the function
 .init.text:cpufeature_probe()
Message-ID: <202203081902.SJP6xqjp-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/riscv-d1
head:   b3cda759adb0111b5b3efd3a0b986864b647a94a
commit: e1dda1383ff02ab54b09c2173527ee1e79a220ba [10/12] riscv: add RISC-V Svpbmt extension support
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20220308/202203081902.SJP6xqjp-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/e1dda1383ff02ab54b09c2173527ee1e79a220ba
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/riscv-d1
        git checkout e1dda1383ff02ab54b09c2173527ee1e79a220ba
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text.unlikely+0x1dc): Section mismatch in reference from the function riscv_cpufeature_patch_func() to the function .init.text:cpufeature_probe()
The function riscv_cpufeature_patch_func() references
the function __init cpufeature_probe().
This is often because riscv_cpufeature_patch_func lacks a __init
annotation or the annotation of cpufeature_probe is wrong.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
