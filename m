Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627294F06AA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 01:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiDBXXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 19:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiDBXXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 19:23:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D0C3A2
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 16:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648941670; x=1680477670;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TSxaV4arXDY3Am7fyfPZpWYiHspQXhewWl6DbqCG8BE=;
  b=ZTrSMIQmYnFwdbpBM+zXHi0XcuLnx6g8AVmYYy++BYn/cPhAKkugxAWv
   3bVH+Cnr22eVuez5MbdGnbNOmtQS8QeajuChcdFZ3zfeHMDB1/vb4qwnO
   adxCO7KGsiIDTIlcgSh2S0nxDpUTwDsOU2jvuQI/zdpqtqGU/r/pSA/xX
   uJyIagM1I8bMky9ercbgOqZllI0BK57Js9dhG1frNa3g+0h1EOejR65eg
   LOZN5pYis8bZMsd1CSwnQ82ojFOkU7nLdkdEtx0joDgxSTQqLxMsTCdIT
   mjZxOToKs4+16yxkLaKw6ik+nmyYtoDqdzChFmBixH2WESZNErme/FTzS
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10305"; a="240280133"
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="240280133"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 16:21:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="721264986"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 02 Apr 2022 16:21:09 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nan3M-0000Wf-Dl;
        Sat, 02 Apr 2022 23:21:08 +0000
Date:   Sun, 3 Apr 2022 07:20:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Divya Koppera <Divya.Koppera@microchip.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: ld.lld: error: undefined symbol: ptp_clock_register
Message-ID: <202204030755.3o6LEkHq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Divya,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   88e6c0207623874922712e162e25d9dafd39661e
commit: ece19502834d84ece2e056db28257ca2aa6e4d48 net: phy: micrel: 1588 support for LAN8814 phy
date:   4 weeks ago
config: riscv-randconfig-r006-20220402 (https://download.01.org/0day-ci/archive/20220403/202204030755.3o6LEkHq-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ece19502834d84ece2e056db28257ca2aa6e4d48
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ece19502834d84ece2e056db28257ca2aa6e4d48
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: ptp_clock_register
   >>> referenced by micrel.c
   >>> net/phy/micrel.o:(lan8814_probe) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: ptp_clock_index
   >>> referenced by micrel.c
   >>> net/phy/micrel.o:(lan8814_ts_info) in archive drivers/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
