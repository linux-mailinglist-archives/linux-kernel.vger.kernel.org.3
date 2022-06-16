Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E1654EBAC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378707AbiFPU5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiFPU5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:57:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974E65FF1F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655413033; x=1686949033;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zGb98EreHsN25CXV/01rJqWNIbdOu/CzDE/l/VN7VXo=;
  b=JwyJ5Bim5XlEFW1h5oKHHWy5PZ+en3+zCkWGzlhBh5RC++DRTeVsbCtG
   1m5Sbc2IE0eYFjwx1bDTwKpv28gwTCVST0BGM+mN3a7bQ+/UoNXpoVsoI
   T3UXSLBODpASawQTQBrKA4S5AHzaCQtYAIDUwxoeFu225SbDy/7q+fcrp
   XLN9zpfcy4wtyNsI+JJ/Kk+2CJofOxSm5aQR+VW2MiWfQd7SmpuybSxLM
   OD/tqvCYXMAxl1vYQ1jOd/oW5Pi8SWw+VVfqUsAKWKuWoTlZVi8NDhZcL
   zuHUHbzOiYZzMIatO09/tAzVoxcJDqeeNgAfHmfvwO37Et2q8/SGM5yDz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="343310876"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="343310876"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 13:57:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="831731727"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jun 2022 13:56:16 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1wXG-000Om1-LC;
        Thu, 16 Jun 2022 20:56:14 +0000
Date:   Fri, 17 Jun 2022 04:55:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: [jkirsher-next-queue:master 1/5] ld.lld: error: undefined symbol:
 qcom_smem_get
Message-ID: <202206170405.fqVbBgOE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git master
head:   5dcb50c009c9f8ec1cfca6a81a05c0060a5bbf68
commit: 9ec092d2feb69045dd289845024301fb91c064ee [1/5] net: ethernet: stmmac: add missing sgmii configure for ipq806x
config: riscv-randconfig-r042-20220616 (https://download.01.org/0day-ci/archive/20220617/202206170405.fqVbBgOE-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f0e608de27b3d568000046eebf3712ab542979d6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git/commit/?id=9ec092d2feb69045dd289845024301fb91c064ee
        git remote add jkirsher-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
        git fetch --no-tags jkirsher-next-queue master
        git checkout 9ec092d2feb69045dd289845024301fb91c064ee
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: qcom_smem_get
   >>> referenced by socinfo.c
   >>>               soc/qcom/socinfo.o:(qcom_socinfo_probe) in archive drivers/built-in.a
   >>> referenced by socinfo.c
   >>>               soc/qcom/socinfo.o:(qcom_socinfo_probe) in archive drivers/built-in.a

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for QCOM_SOCINFO
   Depends on QCOM_SMEM
   Selected by
   - DWMAC_IPQ806X && NETDEVICES && ETHERNET && NET_VENDOR_STMICRO && STMMAC_ETH && STMMAC_PLATFORM && OF && (ARCH_QCOM || COMPILE_TEST

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
