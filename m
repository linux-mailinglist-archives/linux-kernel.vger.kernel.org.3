Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5D8585F51
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 16:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237126AbiGaOvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 10:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiGaOvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 10:51:02 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179BE6261
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 07:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659279061; x=1690815061;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sOL0AJcJcFwSCQy+DP16oX7RS399Ed5f4pWBxXtz67g=;
  b=f5cw7VgTwpEag9pFRlogw906Q9ll0n2c/8n2lpOL1H5+udUd9uGHR3ee
   uRD5HFWHAlWBFcmnnCOfwf/ytp37qcJHx5DWoSpWakxBA8CpqLFhfJ4Uh
   ptxEfhk7eJQM+EiUM7WqiaxGKRHFgfn4F2QbtB9TCep04DZtaYPtCoxVc
   3LCJOVtZ+iYrVigA6pAaYJS7wE34p78QEttoEkVWymZdo2QVeqyUDEnKv
   3tzc5xSZYpHkuJqSB5oF9pOYJgb9wGMv5veCf1HrsBQ4rvI11HspgoMKc
   57Bqa+LpnBKUExxGaGGpdAKOoKa7GKZsqid9ORpwPfjOzm/pLs6snUf1C
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="350708283"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="350708283"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 07:51:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="634626701"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 31 Jul 2022 07:50:59 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIAHS-000ED9-2E;
        Sun, 31 Jul 2022 14:50:58 +0000
Date:   Sun, 31 Jul 2022 22:50:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/firmware/meson/meson_sm.c:206:9: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202207312255.bPrNIfCh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6a010258447d386186ca10cd374d888ac66ffe1a
commit: f68f2ff91512c199ec24883001245912afc17873 fortify: Detect struct member overflows in memcpy() at compile-time
date:   6 months ago
config: arm64-randconfig-s031-20220731 (https://download.01.org/0day-ci/archive/20220731/202207312255.bPrNIfCh-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f68f2ff91512c199ec24883001245912afc17873
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f68f2ff91512c199ec24883001245912afc17873
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/ drivers/firmware/meson/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   drivers/firmware/meson/meson_sm.c:85:24: sparse: sparse: Using plain integer as NULL pointer
   drivers/firmware/meson/meson_sm.c:170:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *sm_shmem_out_base @@
   drivers/firmware/meson/meson_sm.c:170:17: sparse:     expected void const *
   drivers/firmware/meson/meson_sm.c:170:17: sparse:     got void [noderef] __iomem *sm_shmem_out_base
   drivers/firmware/meson/meson_sm.c:170:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *sm_shmem_out_base @@
   drivers/firmware/meson/meson_sm.c:170:17: sparse:     expected void const *
   drivers/firmware/meson/meson_sm.c:170:17: sparse:     got void [noderef] __iomem *sm_shmem_out_base
   drivers/firmware/meson/meson_sm.c:170:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *sm_shmem_out_base @@
   drivers/firmware/meson/meson_sm.c:170:17: sparse:     expected void const *
   drivers/firmware/meson/meson_sm.c:170:17: sparse:     got void [noderef] __iomem *sm_shmem_out_base
>> drivers/firmware/meson/meson_sm.c:206:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *sm_shmem_in_base @@
   drivers/firmware/meson/meson_sm.c:206:9: sparse:     expected void const *
   drivers/firmware/meson/meson_sm.c:206:9: sparse:     got void [noderef] __iomem *sm_shmem_in_base
>> drivers/firmware/meson/meson_sm.c:206:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *sm_shmem_in_base @@
   drivers/firmware/meson/meson_sm.c:206:9: sparse:     expected void const *
   drivers/firmware/meson/meson_sm.c:206:9: sparse:     got void [noderef] __iomem *sm_shmem_in_base
   drivers/firmware/meson/meson_sm.c:206:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *sm_shmem_in_base @@
   drivers/firmware/meson/meson_sm.c:206:9: sparse:     expected void *
   drivers/firmware/meson/meson_sm.c:206:9: sparse:     got void [noderef] __iomem *sm_shmem_in_base

vim +206 drivers/firmware/meson/meson_sm.c

2c4ddb215521d5 Carlo Caione 2016-08-27  175  
2c4ddb215521d5 Carlo Caione 2016-08-27  176  /**
2c4ddb215521d5 Carlo Caione 2016-08-27  177   * meson_sm_call_write - send data to secure-monitor
2c4ddb215521d5 Carlo Caione 2016-08-27  178   *
8cde3c2153e8f5 Carlo Caione 2019-07-31  179   * @fw:		Pointer to secure-monitor firmware
2c4ddb215521d5 Carlo Caione 2016-08-27  180   * @buffer:	Buffer containing data to send
2c4ddb215521d5 Carlo Caione 2016-08-27  181   * @size:	Size of the data to send
2c4ddb215521d5 Carlo Caione 2016-08-27  182   * @cmd_index:	Index of the SMC32 function ID
2c4ddb215521d5 Carlo Caione 2016-08-27  183   * @arg0:	SMC32 Argument 0
2c4ddb215521d5 Carlo Caione 2016-08-27  184   * @arg1:	SMC32 Argument 1
2c4ddb215521d5 Carlo Caione 2016-08-27  185   * @arg2:	SMC32 Argument 2
2c4ddb215521d5 Carlo Caione 2016-08-27  186   * @arg3:	SMC32 Argument 3
2c4ddb215521d5 Carlo Caione 2016-08-27  187   * @arg4:	SMC32 Argument 4
2c4ddb215521d5 Carlo Caione 2016-08-27  188   *
2c4ddb215521d5 Carlo Caione 2016-08-27  189   * Return:	size of sent data on success, a negative value on error
2c4ddb215521d5 Carlo Caione 2016-08-27  190   */
8cde3c2153e8f5 Carlo Caione 2019-07-31  191  int meson_sm_call_write(struct meson_sm_firmware *fw, void *buffer,
8cde3c2153e8f5 Carlo Caione 2019-07-31  192  			unsigned int size, unsigned int cmd_index, u32 arg0,
8cde3c2153e8f5 Carlo Caione 2019-07-31  193  			u32 arg1, u32 arg2, u32 arg3, u32 arg4)
2c4ddb215521d5 Carlo Caione 2016-08-27  194  {
2c4ddb215521d5 Carlo Caione 2016-08-27  195  	u32 written;
2c4ddb215521d5 Carlo Caione 2016-08-27  196  
8cde3c2153e8f5 Carlo Caione 2019-07-31  197  	if (!fw->chip)
2c4ddb215521d5 Carlo Caione 2016-08-27  198  		return -ENOENT;
2c4ddb215521d5 Carlo Caione 2016-08-27  199  
8cde3c2153e8f5 Carlo Caione 2019-07-31  200  	if (size > fw->chip->shmem_size)
2c4ddb215521d5 Carlo Caione 2016-08-27  201  		return -EINVAL;
2c4ddb215521d5 Carlo Caione 2016-08-27  202  
8cde3c2153e8f5 Carlo Caione 2019-07-31  203  	if (!fw->chip->cmd_shmem_in_base)
2c4ddb215521d5 Carlo Caione 2016-08-27  204  		return -EINVAL;
2c4ddb215521d5 Carlo Caione 2016-08-27  205  
8cde3c2153e8f5 Carlo Caione 2019-07-31 @206  	memcpy(fw->sm_shmem_in_base, buffer, size);
2c4ddb215521d5 Carlo Caione 2016-08-27  207  
8cde3c2153e8f5 Carlo Caione 2019-07-31  208  	if (meson_sm_call(fw, cmd_index, &written, arg0, arg1, arg2, arg3, arg4) < 0)
2c4ddb215521d5 Carlo Caione 2016-08-27  209  		return -EINVAL;
2c4ddb215521d5 Carlo Caione 2016-08-27  210  
2c4ddb215521d5 Carlo Caione 2016-08-27  211  	if (!written)
2c4ddb215521d5 Carlo Caione 2016-08-27  212  		return -EINVAL;
2c4ddb215521d5 Carlo Caione 2016-08-27  213  
2c4ddb215521d5 Carlo Caione 2016-08-27  214  	return written;
2c4ddb215521d5 Carlo Caione 2016-08-27  215  }
2c4ddb215521d5 Carlo Caione 2016-08-27  216  EXPORT_SYMBOL(meson_sm_call_write);
2c4ddb215521d5 Carlo Caione 2016-08-27  217  

:::::: The code at line 206 was first introduced by commit
:::::: 8cde3c2153e8f57be884c0e73f18bc4de150e870 firmware: meson_sm: Rework driver as a proper platform driver

:::::: TO: Carlo Caione <ccaione@baylibre.com>
:::::: CC: Kevin Hilman <khilman@baylibre.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
