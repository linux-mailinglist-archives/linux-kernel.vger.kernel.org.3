Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726144E4C74
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 07:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241155AbiCWGBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 02:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiCWGBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 02:01:51 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323336C928
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 23:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648015222; x=1679551222;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GjEEWo6GnB9okYJh0yahqYzHf5yb/c33+/mD6aV6Kqk=;
  b=ZgTf1GhT1d+uAhQNAdIczVjL7xvnCs7q4ebt9HbPtyhvonFy5vzpVr+4
   GBDukZ4ik7xxIxSktaDCjktqFyvYRzOjylQGhxGfFqa2BLIJrU5j0mKon
   4WOQyOS1xBH5TeHg8or00vU//6Yie+SDvZtTr/DCWlYntNcVivSoBN7ox
   3F7qRr+iHPATIq8I40iIeUADTIV1MqGLhHBYNNHv/5CUiUw4WgxrGwksG
   7zHN/yYbtTDcAveZIMB4lx/Ok8FxWVp6UlJtZoFdEyIfYRXI05JRUj94z
   9pJBUc5SdmOOuHeBbgbkYrzIOvgH1hRtkz+115I1NWRH7zgLc+q+H26Nw
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="318738645"
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="318738645"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 23:00:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="649306070"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 22 Mar 2022 23:00:19 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWu2d-000Jj2-9r; Wed, 23 Mar 2022 06:00:19 +0000
Date:   Wed, 23 Mar 2022 13:59:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:palmer/linux/riscv-ftrace_mutex_fix 1/1]
 arch/riscv/kernel/ftrace.c:14:5: error: expected identifier or '('
Message-ID: <202203231310.ymLzRrpb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/riscv-ftrace_mutex_fix
head:   013eaa62130cd541cb2e7bf58303c509298701a8
commit: 013eaa62130cd541cb2e7bf58303c509298701a8 [1/1] RISC-V: Don't check text_mutex during stop_machine
config: riscv-randconfig-r032-20220323 (https://download.01.org/0day-ci/archive/20220323/202203231310.ymLzRrpb-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 902f4708fe1d03b0de7e5315ef875006a6adc319)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/013eaa62130cd541cb2e7bf58303c509298701a8
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/riscv-ftrace_mutex_fix
        git checkout 013eaa62130cd541cb2e7bf58303c509298701a8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/riscv/kernel/ftrace.c:8:
   In file included from include/linux/ftrace.h:10:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from arch/riscv/kernel/ftrace.c:8:
   In file included from include/linux/ftrace.h:10:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from arch/riscv/kernel/ftrace.c:8:
   In file included from include/linux/ftrace.h:10:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:1024:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
                                                     ~~~~~~~~~~ ^
>> arch/riscv/kernel/ftrace.c:14:5: error: expected identifier or '('
   int riscv_ftrace_in_stop_machine;
       ^
   arch/riscv/include/asm/ftrace.h:90:38: note: expanded from macro 'riscv_ftrace_in_stop_machine'
   #define riscv_ftrace_in_stop_machine 0
                                        ^
   7 warnings and 1 error generated.


vim +14 arch/riscv/kernel/ftrace.c

    13	
  > 14	int riscv_ftrace_in_stop_machine;
    15	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
