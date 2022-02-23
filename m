Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5984C14EF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 15:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241317AbiBWOBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 09:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237644AbiBWOBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 09:01:36 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C6EB0D3E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 06:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645624865; x=1677160865;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=g/qSSnpLUbfFX9a8BtfSTz8AVBbrGO9SgUmwHWt9iN4=;
  b=LaSrKgXtFMQXTHnFIDy33GIL8xlJtnVeqIeszFqR98UHriWdeK1bOAom
   VEpRsJK8fJA0bvl5KlJGJSXXVJDYVmTsmz5OpwMWFERVtmJtnKO9hpcAt
   vHNWweZRSXcg5LKC8KP4pP7wb0GpaAmeCAdC9vAGyc8j49MJx6kkIAZTY
   OsqI9A/5MzTlnAZc9FXKmQiQttKGX7ifX+4RaHQNU2+B2sVzoL30f2bHs
   iQqv6Iu9ausFSE8vPhil080iOnVof6g9UxASxDbQ2nHyxlyhHM5fqNmUd
   uAQaJy1suRB5jd5MV/9JimD43eSGGG3VZ0FXGF/J9Ze1eU3Gnlkfede1n
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="312683688"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="312683688"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 06:00:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="543322353"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 23 Feb 2022 06:00:34 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMsC1-0001WJ-Vw; Wed, 23 Feb 2022 14:00:34 +0000
Date:   Wed, 23 Feb 2022 22:00:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [lee-mfd:for-mfd-next 21/25] drivers/mfd/sprd-sc27xx-spi.c:255:35:
 error: redefinition of 'sprd_pmic_spi_ids'
Message-ID: <202202232155.xqGC3omU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
head:   557bf686f1c6f8825ae44db732d42a60ad3b1437
commit: 6fc90b92e9c7ef3488e3ff7b6fa71f51a5272019 [21/25] mfd: sprd: Add SPI device ID table
config: riscv-randconfig-r042-20220221 (https://download.01.org/0day-ci/archive/20220223/202202232155.xqGC3omU-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/commit/?id=6fc90b92e9c7ef3488e3ff7b6fa71f51a5272019
        git remote add lee-mfd https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git
        git fetch --no-tags lee-mfd for-mfd-next
        git checkout 6fc90b92e9c7ef3488e3ff7b6fa71f51a5272019
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/mfd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/mfd/sprd-sc27xx-spi.c:255:35: error: redefinition of 'sprd_pmic_spi_ids'
   static const struct spi_device_id sprd_pmic_spi_ids[] = {
                                     ^
   drivers/mfd/sprd-sc27xx-spi.c:242:35: note: previous definition is here
   static const struct spi_device_id sprd_pmic_spi_ids[] = {
                                     ^
   1 error generated.


vim +/sprd_pmic_spi_ids +255 drivers/mfd/sprd-sc27xx-spi.c

25ca4ae43466a4 Baolin Wang 2017-11-01  254  
c5c7f067710705 Mark Brown  2021-09-24 @255  static const struct spi_device_id sprd_pmic_spi_ids[] = {
c5c7f067710705 Mark Brown  2021-09-24  256  	{ .name = "sc2731", .driver_data = (unsigned long)&sc2731_data },
c5c7f067710705 Mark Brown  2021-09-24  257  	{},
c5c7f067710705 Mark Brown  2021-09-24  258  };
c5c7f067710705 Mark Brown  2021-09-24  259  MODULE_DEVICE_TABLE(spi, sprd_pmic_spi_ids);
c5c7f067710705 Mark Brown  2021-09-24  260  

:::::: The code at line 255 was first introduced by commit
:::::: c5c7f0677107052060037583b9c8c15d818afb04 mfd: sprd: Add SPI device ID table

:::::: TO: Mark Brown <broonie@kernel.org>
:::::: CC: Lee Jones <lee.jones@linaro.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
