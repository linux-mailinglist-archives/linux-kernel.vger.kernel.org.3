Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007854F963F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbiDHM7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiDHM7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:59:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE48175210
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 05:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649422649; x=1680958649;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MVI4Vgkqb6DiTIPHj0xrlh5P96lXeUBmGyU+faGhIzo=;
  b=BPZRQHSMLdNn7WdHa0pfqC400vq+6xKB2P0hykdOYg2LR64PMOtw5S5k
   NaoR418n6TxRDHP2gI9WIaxbPD+I0GSHbiD5X3ag7t/lz0Rgew9GcRYUq
   MqHbhbaWhBz6Zy5rjJkNYDEO4OflRFrCUk0A7kpJlDuTakIV66mpVbvTS
   Ij+bv0uM3TZYqsVpZD8i3uSqUhwy8TAbzuPivaJWo72S1IoRnSZQolVUE
   29dY/G28V3YJVs0lvUciNqq1NRuWVbYz/uu+YMAwvfVVUZVmvWgf8Qemb
   xoKQPMN6MmAOpTEWC6SGK2vWQ2cR1uJ5OYjemSdTTANNoDl/BhB3u1eEz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="260420205"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="260420205"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 05:57:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="621623882"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 08 Apr 2022 05:57:25 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncoB2-0000Gv-E8;
        Fri, 08 Apr 2022 12:57:24 +0000
Date:   Fri, 8 Apr 2022 20:56:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     popcornmix <popcornmix@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Kari Suvanto <karis79@gmail.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Phil Elwell <phil@raspberrypi.org>,
        Malik Olivier Boussejra <malik@boussejra.com>,
        Paul Zimmerman <paulz@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        Michael Zoran <mzoran@crowfest.net>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Jonathan Bell <jonathan@raspberrypi.org>,
        Hui Wang <hui.wang@canonical.com>,
        Zixuan Wang <wangzixuan@sjtu.edu.cn>
Subject: [l1k:smsc95xx_5.17 56/887] arch/arm/include/asm/irqflags.h:182:3:
 error: invalid operand for instruction
Message-ID: <202204082019.m8kwLvwM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   05d68ced287b30f62f18f95b5476135ef669804a
commit: a8197852bb8f1f6804cff9442d426888e97aaed3 [56/887] Add dwc_otg driver
config: arm-randconfig-r013-20220408 (https://download.01.org/0day-ci/archive/20220408/202204082019.m8kwLvwM-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c29a51b3a257908aebc01cd7c4655665db317d66)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/l1k/linux/commit/a8197852bb8f1f6804cff9442d426888e97aaed3
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k smsc95xx_5.17
        git checkout a8197852bb8f1f6804cff9442d426888e97aaed3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/usb/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/usb/core/hub.c:13:
   In file included from include/linux/kernel.h:22:
   In file included from include/linux/bitops.h:33:
   In file included from arch/arm/include/asm/bitops.h:28:
   In file included from include/linux/irqflags.h:16:
>> arch/arm/include/asm/irqflags.h:182:3: error: invalid operand for instruction
                   "    msr    cpsr_c, %0    @ local_irq_restore"
                   ^
   <inline asm>:1:13: note: instantiated into assembly here
               msr    cpsr_c, r0    @ local_irq_restore
                      ^
   1 error generated.
--
   In file included from drivers/usb/core/hcd.c:13:
   In file included from include/linux/module.h:13:
   In file included from include/linux/stat.h:19:
   In file included from include/linux/time.h:6:
   In file included from include/linux/math64.h:6:
   In file included from include/linux/math.h:5:
   In file included from arch/arm/include/asm/div64.h:107:
   In file included from include/asm-generic/div64.h:55:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:33:
   In file included from arch/arm/include/asm/bitops.h:28:
   In file included from include/linux/irqflags.h:16:
>> arch/arm/include/asm/irqflags.h:182:3: error: invalid operand for instruction
                   "    msr    cpsr_c, %0    @ local_irq_restore"
                   ^
   <inline asm>:1:13: note: instantiated into assembly here
               msr    cpsr_c, r1    @ local_irq_restore
                      ^
   In file included from drivers/usb/core/hcd.c:13:
   In file included from include/linux/module.h:13:
   In file included from include/linux/stat.h:19:
   In file included from include/linux/time.h:6:
   In file included from include/linux/math64.h:6:
   In file included from include/linux/math.h:5:
   In file included from arch/arm/include/asm/div64.h:107:
   In file included from include/asm-generic/div64.h:55:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:33:
   In file included from arch/arm/include/asm/bitops.h:28:
   In file included from include/linux/irqflags.h:16:
>> arch/arm/include/asm/irqflags.h:182:3: error: invalid operand for instruction
                   "    msr    cpsr_c, %0    @ local_irq_restore"
                   ^
   <inline asm>:1:13: note: instantiated into assembly here
               msr    cpsr_c, r1    @ local_irq_restore
                      ^
>> <inline asm>:1:13: error: invalid operand for instruction
               msr    cpsr_c, r0    @ local_irq_restore
                      ^
   In file included from drivers/usb/core/hcd.c:13:
   In file included from include/linux/module.h:13:
   In file included from include/linux/stat.h:19:
   In file included from include/linux/time.h:6:
   In file included from include/linux/math64.h:6:
   In file included from include/linux/math.h:5:
   In file included from arch/arm/include/asm/div64.h:107:
   In file included from include/asm-generic/div64.h:55:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:33:
   In file included from arch/arm/include/asm/bitops.h:28:
   In file included from include/linux/irqflags.h:16:
>> arch/arm/include/asm/irqflags.h:182:3: error: invalid operand for instruction
                   "    msr    cpsr_c, %0    @ local_irq_restore"
                   ^
   <inline asm>:1:13: note: instantiated into assembly here
               msr    cpsr_c, r1    @ local_irq_restore
                      ^
   In file included from drivers/usb/core/hcd.c:13:
   In file included from include/linux/module.h:13:
   In file included from include/linux/stat.h:19:
   In file included from include/linux/time.h:6:
   In file included from include/linux/math64.h:6:
   In file included from include/linux/math.h:5:
   In file included from arch/arm/include/asm/div64.h:107:
   In file included from include/asm-generic/div64.h:55:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:33:
   In file included from arch/arm/include/asm/bitops.h:28:
   In file included from include/linux/irqflags.h:16:
>> arch/arm/include/asm/irqflags.h:182:3: error: invalid operand for instruction
                   "    msr    cpsr_c, %0    @ local_irq_restore"
                   ^
   <inline asm>:1:13: note: instantiated into assembly here
               msr    cpsr_c, r1    @ local_irq_restore
                      ^
   In file included from drivers/usb/core/hcd.c:13:
   In file included from include/linux/module.h:13:
   In file included from include/linux/stat.h:19:
   In file included from include/linux/time.h:6:
   In file included from include/linux/math64.h:6:
   In file included from include/linux/math.h:5:
   In file included from arch/arm/include/asm/div64.h:107:
   In file included from include/asm-generic/div64.h:55:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:33:
   In file included from arch/arm/include/asm/bitops.h:28:
   In file included from include/linux/irqflags.h:16:
>> arch/arm/include/asm/irqflags.h:182:3: error: invalid operand for instruction
                   "    msr    cpsr_c, %0    @ local_irq_restore"
                   ^
   <inline asm>:1:13: note: instantiated into assembly here
               msr    cpsr_c, r0    @ local_irq_restore
                      ^
   In file included from drivers/usb/core/hcd.c:13:
   In file included from include/linux/module.h:13:
   In file included from include/linux/stat.h:19:
   In file included from include/linux/time.h:6:
   In file included from include/linux/math64.h:6:
   In file included from include/linux/math.h:5:
   In file included from arch/arm/include/asm/div64.h:107:
   In file included from include/asm-generic/div64.h:55:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:33:
   In file included from arch/arm/include/asm/bitops.h:28:
   In file included from include/linux/irqflags.h:16:
>> arch/arm/include/asm/irqflags.h:182:3: error: invalid operand for instruction
                   "    msr    cpsr_c, %0    @ local_irq_restore"
                   ^
   <inline asm>:1:13: note: instantiated into assembly here
               msr    cpsr_c, r0    @ local_irq_restore
                      ^
   In file included from drivers/usb/core/hcd.c:13:
   In file included from include/linux/module.h:13:
   In file included from include/linux/stat.h:19:
   In file included from include/linux/time.h:6:
   In file included from include/linux/math64.h:6:
   In file included from include/linux/math.h:5:
   In file included from arch/arm/include/asm/div64.h:107:
   In file included from include/asm-generic/div64.h:55:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:33:
   In file included from arch/arm/include/asm/bitops.h:28:
   In file included from include/linux/irqflags.h:16:
>> arch/arm/include/asm/irqflags.h:182:3: error: invalid operand for instruction
                   "    msr    cpsr_c, %0    @ local_irq_restore"
                   ^
   <inline asm>:1:13: note: instantiated into assembly here
               msr    cpsr_c, r0    @ local_irq_restore
                      ^
   In file included from drivers/usb/core/hcd.c:13:
   In file included from include/linux/module.h:13:
   In file included from include/linux/stat.h:19:
   In file included from include/linux/time.h:6:
   In file included from include/linux/math64.h:6:
   In file included from include/linux/math.h:5:
   In file included from arch/arm/include/asm/div64.h:107:
   In file included from include/asm-generic/div64.h:55:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:33:
   In file included from arch/arm/include/asm/bitops.h:28:
   In file included from include/linux/irqflags.h:16:
>> arch/arm/include/asm/irqflags.h:182:3: error: invalid operand for instruction
                   "    msr    cpsr_c, %0    @ local_irq_restore"
                   ^
   <inline asm>:1:13: note: instantiated into assembly here
               msr    cpsr_c, r0    @ local_irq_restore
                      ^
   In file included from drivers/usb/core/hcd.c:13:
   In file included from include/linux/module.h:13:
   In file included from include/linux/stat.h:19:
   In file included from include/linux/time.h:6:
   In file included from include/linux/math64.h:6:
   In file included from include/linux/math.h:5:
   In file included from arch/arm/include/asm/div64.h:107:
   In file included from include/asm-generic/div64.h:55:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:33:
   In file included from arch/arm/include/asm/bitops.h:28:
   In file included from include/linux/irqflags.h:16:
>> arch/arm/include/asm/irqflags.h:182:3: error: invalid operand for instruction
                   "    msr    cpsr_c, %0    @ local_irq_restore"
                   ^
   <inline asm>:1:13: note: instantiated into assembly here
               msr    cpsr_c, r0    @ local_irq_restore
                      ^
   In file included from drivers/usb/core/hcd.c:13:
   In file included from include/linux/module.h:13:
   In file included from include/linux/stat.h:19:
   In file included from include/linux/time.h:6:
   In file included from include/linux/math64.h:6:
   In file included from include/linux/math.h:5:
   In file included from arch/arm/include/asm/div64.h:107:
   In file included from include/asm-generic/div64.h:55:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:33:
   In file included from arch/arm/include/asm/bitops.h:28:
   In file included from include/linux/irqflags.h:16:
>> arch/arm/include/asm/irqflags.h:182:3: error: invalid operand for instruction
                   "    msr    cpsr_c, %0    @ local_irq_restore"
                   ^
   <inline asm>:1:13: note: instantiated into assembly here
               msr    cpsr_c, r0    @ local_irq_restore
                      ^
   In file included from drivers/usb/core/hcd.c:13:
   In file included from include/linux/module.h:13:
   In file included from include/linux/stat.h:19:
   In file included from include/linux/time.h:6:
   In file included from include/linux/math64.h:6:
   In file included from include/linux/math.h:5:
   In file included from arch/arm/include/asm/div64.h:107:
   In file included from include/asm-generic/div64.h:55:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:33:
   In file included from arch/arm/include/asm/bitops.h:28:
   In file included from include/linux/irqflags.h:16:
>> arch/arm/include/asm/irqflags.h:182:3: error: invalid operand for instruction
                   "    msr    cpsr_c, %0    @ local_irq_restore"
                   ^
   <inline asm>:1:13: note: instantiated into assembly here
               msr    cpsr_c, r0    @ local_irq_restore
                      ^
   In file included from drivers/usb/core/hcd.c:13:
   In file included from include/linux/module.h:13:
   In file included from include/linux/stat.h:19:
   In file included from include/linux/time.h:6:
   In file included from include/linux/math64.h:6:
   In file included from include/linux/math.h:5:
   In file included from arch/arm/include/asm/div64.h:107:
   In file included from include/asm-generic/div64.h:55:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:33:
   In file included from arch/arm/include/asm/bitops.h:28:
   In file included from include/linux/irqflags.h:16:
>> arch/arm/include/asm/irqflags.h:182:3: error: invalid operand for instruction
                   "    msr    cpsr_c, %0    @ local_irq_restore"
                   ^
   <inline asm>:1:13: note: instantiated into assembly here
               msr    cpsr_c, r1    @ local_irq_restore
                      ^
   In file included from drivers/usb/core/hcd.c:13:
   In file included from include/linux/module.h:13:
   In file included from include/linux/stat.h:19:
   In file included from include/linux/time.h:6:
   In file included from include/linux/math64.h:6:
   In file included from include/linux/math.h:5:
   In file included from arch/arm/include/asm/div64.h:107:
   In file included from include/asm-generic/div64.h:55:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:33:
   In file included from arch/arm/include/asm/bitops.h:28:
   In file included from include/linux/irqflags.h:16:
>> arch/arm/include/asm/irqflags.h:182:3: error: invalid operand for instruction
                   "    msr    cpsr_c, %0    @ local_irq_restore"
                   ^
   <inline asm>:1:13: note: instantiated into assembly here
               msr    cpsr_c, r0    @ local_irq_restore
                      ^
   In file included from drivers/usb/core/hcd.c:13:
   In file included from include/linux/module.h:13:
   In file included from include/linux/stat.h:19:
   In file included from include/linux/time.h:6:
   In file included from include/linux/math64.h:6:
   In file included from include/linux/math.h:5:
   In file included from arch/arm/include/asm/div64.h:107:
   In file included from include/asm-generic/div64.h:55:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:33:
   In file included from arch/arm/include/asm/bitops.h:28:
   In file included from include/linux/irqflags.h:16:
>> arch/arm/include/asm/irqflags.h:182:3: error: invalid operand for instruction
                   "    msr    cpsr_c, %0    @ local_irq_restore"
                   ^
   <inline asm>:1:13: note: instantiated into assembly here
               msr    cpsr_c, r0    @ local_irq_restore
                      ^
   In file included from drivers/usb/core/hcd.c:13:
   In file included from include/linux/module.h:13:
   In file included from include/linux/stat.h:19:
   In file included from include/linux/time.h:6:
   In file included from include/linux/math64.h:6:
   In file included from include/linux/math.h:5:
   In file included from arch/arm/include/asm/div64.h:107:
   In file included from include/asm-generic/div64.h:55:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:33:
   In file included from arch/arm/include/asm/bitops.h:28:
   In file included from include/linux/irqflags.h:16:
>> arch/arm/include/asm/irqflags.h:182:3: error: invalid operand for instruction
                   "    msr    cpsr_c, %0    @ local_irq_restore"
                   ^
   <inline asm>:1:13: note: instantiated into assembly here
               msr    cpsr_c, r0    @ local_irq_restore
                      ^
   In file included from drivers/usb/core/hcd.c:13:
   In file included from include/linux/module.h:13:
   In file included from include/linux/stat.h:19:
   In file included from include/linux/time.h:6:
   In file included from include/linux/math64.h:6:
   In file included from include/linux/math.h:5:
   In file included from arch/arm/include/asm/div64.h:107:
   In file included from include/asm-generic/div64.h:55:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:33:
   In file included from arch/arm/include/asm/bitops.h:28:
   In file included from include/linux/irqflags.h:16:
>> arch/arm/include/asm/irqflags.h:182:3: error: invalid operand for instruction
                   "    msr    cpsr_c, %0    @ local_irq_restore"
                   ^
   <inline asm>:1:13: note: instantiated into assembly here
               msr    cpsr_c, r0    @ local_irq_restore
                      ^
   In file included from drivers/usb/core/hcd.c:13:
   In file included from include/linux/module.h:13:
   In file included from include/linux/stat.h:19:
   In file included from include/linux/time.h:6:
   In file included from include/linux/math64.h:6:
   In file included from include/linux/math.h:5:
   In file included from arch/arm/include/asm/div64.h:107:
   In file included from include/asm-generic/div64.h:55:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:33:
   In file included from arch/arm/include/asm/bitops.h:28:
   In file included from include/linux/irqflags.h:16:
>> arch/arm/include/asm/irqflags.h:182:3: error: invalid operand for instruction
                   "    msr    cpsr_c, %0    @ local_irq_restore"
                   ^
   <inline asm>:1:13: note: instantiated into assembly here
               msr    cpsr_c, r0    @ local_irq_restore
                      ^
   18 errors generated.
..


vim +182 arch/arm/include/asm/irqflags.h

   164	
   165	/*
   166	 * restore saved IRQ state
   167	 */
   168	#define arch_local_irq_restore arch_local_irq_restore
   169	static inline void arch_local_irq_restore(unsigned long flags)
   170	{
   171		unsigned long temp = 0;
   172		flags &= ~(1 << 6);
   173		asm volatile (
   174			" mrs %0, cpsr"
   175			: "=r" (temp)
   176			:
   177			: "memory", "cc");
   178			/* Preserve FIQ bit */
   179			temp &= (1 << 6);
   180			flags = flags | temp;
   181		asm volatile (
 > 182			"    msr    cpsr_c, %0    @ local_irq_restore"
   183			:
   184			: "r" (flags)
   185			: "memory", "cc");
   186	}
   187	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
