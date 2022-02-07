Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D235E4ABEE0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448057AbiBGNKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387706AbiBGMpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 07:45:30 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F8CC0401F3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 04:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644237926; x=1675773926;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BFLLIMligc7LnrDeDla/jrh0cC9WCj+osQ4TGk1JTzg=;
  b=DdorTX/190Blu3bzIjH6Qt4M2gCRPcNmANbyljRQ2uI6f7zqOvdJ6Cd5
   b+k+2+sogJpBa2xsFukXDhvQ9XzLLSW7iOyjI3VzFRTNRmHe4YxBWtZ3B
   zDlGx/7vx9rV8WEa1QIGW3ggN9yCwlEGvYzp51Mub/cDAw+GHtjoHPNaB
   zvj7AviUsjMwNFmos/3oBRF3cREUK+nU9MhcwzcgibbKxFBPpyHMB0qKs
   3ea1xazaCTZhtWdUzMN9dzAXO3gyZkP98QGBZ81cIbC2YK2IEDU4bSfkC
   bNa2RMqw7o+4U+yzNwRFQd+XkYB1ssmE/lWBnbFnK0B2zMcMwk1J3JYPt
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="232271285"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="232271285"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 04:45:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="525121420"
Received: from lkp-server01.sh.intel.com (HELO 9dd77a123018) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 07 Feb 2022 04:45:24 -0800
Received: from kbuild by 9dd77a123018 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nH3OV-0000Wu-Oq; Mon, 07 Feb 2022 12:45:23 +0000
Date:   Mon, 7 Feb 2022 20:44:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Liu Shaohua <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>
Subject: [csky-linux:riscv_compat_v6_sv48_xtpbmt 22/22] errata.c:undefined
 reference to `protection_map'
Message-ID: <202202072027.HVj3XQyw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/c-sky/csky-linux riscv_compat_v6_sv48_xtpbmt
head:   660358cf7b5b9fda72e619f37efe4c68af19dccb
commit: 660358cf7b5b9fda72e619f37efe4c68af19dccb [22/22] riscv: errata: pgtable: Add custom Svpbmt supported for Allwinner D1
config: riscv-nommu_virt_defconfig (https://download.01.org/0day-ci/archive/20220207/202202072027.HVj3XQyw-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/c-sky/csky-linux/commit/660358cf7b5b9fda72e619f37efe4c68af19dccb
        git remote add csky-linux https://github.com/c-sky/csky-linux
        git fetch --no-tags csky-linux riscv_compat_v6_sv48_xtpbmt
        git checkout 660358cf7b5b9fda72e619f37efe4c68af19dccb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv64-linux-ld: arch/riscv/errata/thead/errata.o: in function `.L0 ':
>> errata.c:(.init.text+0x28): undefined reference to `protection_map'
>> riscv64-linux-ld: errata.c:(.init.text+0x30): undefined reference to `protection_map'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
