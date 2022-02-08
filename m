Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE6F4ACDA0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245430AbiBHBIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343987AbiBHATG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 19:19:06 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88D3C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 16:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644279545; x=1675815545;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=i8R9YZU3S5hEJOPGPGTC53lDc/XEFw1pX6rWDP00jAc=;
  b=oKWuB+Pq2jP5OCY13vDNFWwsnS/JZ6nXMZDrWdb3R7R4iSqOKPNaII0r
   B79PLXdr/Cm/x+O4ZutS1C0C3hBKqASGKqm//TMok+KnX9Nm/vUV50rTt
   u8O5kOwjrZT7uUyqXNzMBW3GBeQbY2RtrKocunlWxDTRSslkvFSum5F+A
   mYwN54CDTXo920c/G2rnP7B4z2F/PaZjXlHPe67h62YXIfHK1sRlRYOfv
   l9AKalAWi14yHM5ZBVBanaVIIARp4i0pYvouzWUy7FjFHKtxkgu4LkuZD
   0cMN+2YgxU0N0K1iMel/6/Ik0BpPfG/d2/iF39CC94eliefDCjRVXKVTr
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="236242112"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="236242112"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 16:19:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="700653990"
Received: from lkp-server01.sh.intel.com (HELO 9dd77a123018) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 07 Feb 2022 16:19:03 -0800
Received: from kbuild by 9dd77a123018 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHEDm-00018J-DE; Tue, 08 Feb 2022 00:19:02 +0000
Date:   Tue, 8 Feb 2022 08:18:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Liu Shaohua <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>
Subject: [csky-linux:riscv_compat_v6_sv48_xtpbmt 22/22] undefined reference
 to `apply_errata_setup_vm'
Message-ID: <202202080846.OG4uNAjt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/c-sky/csky-linux riscv_compat_v6_sv48_xtpbmt
head:   98b224ea2674b7419071fbc465e0da23d034c178
commit: 98b224ea2674b7419071fbc465e0da23d034c178 [22/22] riscv: errata: pgtable: Add custom Svpbmt supported for Allwinner D1
config: riscv-buildonly-randconfig-r001-20220207 (https://download.01.org/0day-ci/archive/20220208/202202080846.OG4uNAjt-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/c-sky/csky-linux/commit/98b224ea2674b7419071fbc465e0da23d034c178
        git remote add csky-linux https://github.com/c-sky/csky-linux
        git fetch --no-tags csky-linux riscv_compat_v6_sv48_xtpbmt
        git checkout 98b224ea2674b7419071fbc465e0da23d034c178
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv32-linux-ld: arch/riscv/mm/init.o: in function `setup_vm':
>> (.init.text+0x28c): undefined reference to `apply_errata_setup_vm'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
