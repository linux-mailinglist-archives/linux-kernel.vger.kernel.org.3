Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A43B50CFB4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 07:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238209AbiDXFFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 01:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbiDXFFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 01:05:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942132DD54
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 22:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650776569; x=1682312569;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FbJk0e1YcG3N4SedReLbGVCJLxAcNQJS3flDdSjg63c=;
  b=OJZP01SCV1hmn8oGQfqV5jwnHQTjF4Mr06bmftYMOkYVM/GEW+p5PmKy
   rcalSOz3rHqmTV463eUecSrE9e8noQT1RCsBpjb5UGJhEFn5/BaRU6g7e
   PW6cGFvW6oQihsm/k1FkKuEcfwpTiz9gFNDIu1pecs6BtjxZ+b8K++xXZ
   +J49Sup/dx41ycNuswmy65ucGYVTlii1BY/HpHMqG04X00Sr6Sic6G9mz
   0h5o83SCAqvFwa+4CXFbrjIlBsxLenHmxxTtnwiHmOielvOG6BNuo25IF
   6Y1vzKWJH0ELBjT3ej7NCje1pZogWwGqWwgjJD0UsKfnHqhdtY3F4zLU4
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="327919444"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="327919444"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 22:02:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="512138234"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 Apr 2022 22:02:47 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niUOT-00012f-05;
        Sun, 24 Apr 2022 05:02:45 +0000
Date:   Sun, 24 Apr 2022 13:01:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [esmil:visionfive 51/56] ERROR: modpost: "arch_setup_dma_ops"
 [drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.ko] undefined!
Message-ID: <202204241344.uijelyM7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   0729a282564fe3940277937536b1e67f98885c49
commit: a464549640391f3d92e8288e52a324b22380b200 [51/56] RISC-V: Support non-coherent DMA operations
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20220424/202204241344.uijelyM7-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/a464549640391f3d92e8288e52a324b22380b200
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout a464549640391f3d92e8288e52a324b22380b200
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: missing MODULE_LICENSE() in drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.o
>> ERROR: modpost: "arch_setup_dma_ops" [drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
