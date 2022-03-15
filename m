Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA824D94C6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 07:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345272AbiCOGpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 02:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiCOGpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 02:45:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F48713E8C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 23:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647326644; x=1678862644;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jR3MJL4gXTNQ576BRDKhPzca3lSZ3JltBv9pfDAGOa0=;
  b=Unw28t3IzJUJ1DLPnF+j5Wm4kVy8R9i3er3qInT5upRZUFZzMI/6WZs7
   Hggs37P+ww2ouKzMBN5tVowJoek16DJ6WuxP2fTXff1GFXzWVKAilos3c
   BTwfVQU3T4HkxdLuJDi3WbNOS/DHi0O5QvTnlQVLC+1+FM5UF1eKg+lYx
   l1d0UjxDA0ZVNahPiyh9FVpFvceWuU1/XtW0I+9bNrH0cWYBQm5xaMth7
   XjVNtMWWG3JG0rec+7cSZrutFse+g800XLP7PJnsU9U5ebAk9syccpccV
   tCXe/6M2QquWAW5wcPUWolEgZWd8Zzt1hJn3u8NYo0oWwpcd73mg9sM2y
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="236831771"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="236831771"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 23:44:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="497907733"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 14 Mar 2022 23:43:57 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nU0uS-000Aeg-OU; Tue, 15 Mar 2022 06:43:56 +0000
Date:   Tue, 15 Mar 2022 14:43:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [esmil:visionfive 58/61] ERROR: modpost: "arch_setup_dma_ops"
 [drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.ko] undefined!
Message-ID: <202203151435.QVWE4rZm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   ab93b1bae004d1d7f4c795e15ea6ed6478d2789c
commit: 934d9f79bd88d515916fc39f0fa0c4c5d3e6d5ed [58/61] RISC-V: Support non-coherent DMA operations
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20220315/202203151435.QVWE4rZm-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/934d9f79bd88d515916fc39f0fa0c4c5d3e6d5ed
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 934d9f79bd88d515916fc39f0fa0c4c5d3e6d5ed
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: missing MODULE_LICENSE() in drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.o
>> ERROR: modpost: "arch_setup_dma_ops" [drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.ko] undefined!

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
