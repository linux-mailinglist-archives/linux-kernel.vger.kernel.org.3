Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE9D597AC4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 02:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241972AbiHRAsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 20:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbiHRAsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 20:48:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3855F10C
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 17:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660783732; x=1692319732;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=34rzyG6fA/I4w7aOxR4DKRYPL9bn0W46XoUQeJYg3Dg=;
  b=Sngi3P4lmndnDqmcgRv0YHk/5Jmh4Bbvi5Bt+MHfN+5COmbNc4hCQqb8
   6RBBKq35WSrx0YJ5cPdXW993FXrvhV6iggimwWMEL7ibG9WYOYUb8zWH+
   m+VAQoMgxLYg0LtAEH29PLcP8+ivgD7r4AeElCVHT24I8HDn4RDwDEHSV
   NXWVjho9zgcvhhanCeDMsR6yOyN8dGhy1cOeyvBdtBGL5dRsFJWe68CYr
   DjiqqdJg8whBWWgrdDp47jN2nZC6cm3J/+VoSyIKncRmffjnmBC0escQX
   6eJ3IsANuUqrYOi0qsVu6VZh11FFfZfulscDs57/ypLzeAA0pMj9N9Mg0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="292633515"
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="292633515"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 17:48:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="710761607"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 17 Aug 2022 17:48:51 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOTiM-0001XG-1k;
        Thu, 18 Aug 2022 00:48:50 +0000
Date:   Thu, 18 Aug 2022 08:48:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_aia_v1 9/21] ld.lld: error: undefined symbol:
 ipi_mux_create
Message-ID: <202208180836.hCTy6TA1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_aia_v1
head:   36cb4e5ba395f2438224c82ed1b2e8f816eff45b
commit: 9d1529228e6447d48c54a07ba627b114319eb13a [9/21] RISC-V: Treat IPIs as normal Linux IRQs
config: riscv-randconfig-r004-20220818 (https://download.01.org/0day-ci/archive/20220818/202208180836.hCTy6TA1-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project aed5e3bea138ce581d682158eb61c27b3cfdd6ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/avpatel/linux/commit/9d1529228e6447d48c54a07ba627b114319eb13a
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_aia_v1
        git checkout 9d1529228e6447d48c54a07ba627b114319eb13a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: ipi_mux_create
   >>> referenced by timer-clint.c:169 (drivers/clocksource/timer-clint.c:169)
   >>>               clocksource/timer-clint.o:(clint_timer_init_dt) in archive drivers/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
