Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E39153D83E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239847AbiFDTFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239886AbiFDTFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:05:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72362637B
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654369499; x=1685905499;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YyXlSuWYJcOTzhgL4WtA5lHNgtBC1ctV5Bn/7IowfIQ=;
  b=ZHIu1Sp3hphaNaMRoEjFKVECt1NDkvA8TRRaSBnNBFdMqzT3/DzPRi6I
   m2RdgQL408ypwXdGWLZ2/OvDhy2nY8JZDCEK4IC9VaGVmoUL8kkXdnw/g
   9yQ3NiEwbc/eHUbSwYwvNrvM/jUOeWWcGn+biFSR+lO5R9TqWOKbvyITv
   N91/e/tapvGpE5NvP6RRokiSLaNpqSeWPHfPjEnNZZte/0I34bsTxvIPu
   fvlHmx0FOm8JHvUg3RgW7GE1Ia1NEIN6YbVHRlJI2/oAhAnP2MNsNmWgL
   bGa8nvd0xwikq1AZl2vhO2exE6SZuLyOM0rZhoX6Y7QsUC2rJCNfVP6cv
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="362831300"
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="362831300"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 12:04:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="564267972"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 04 Jun 2022 12:04:50 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxZ4r-000B8t-WA;
        Sat, 04 Jun 2022 19:04:49 +0000
Date:   Sun, 5 Jun 2022 03:04:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/remoteproc/ti_k3_r5_remoteproc.c:437:9: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202206050216.eT3Asw30-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   032dcf09e2bf7c822be25b4abef7a6c913870d98
commit: 28e77cc1c0686621a4d416f599cee5ab369daa0a fortify: Detect struct member overflows in memset() at compile-time
date:   4 months ago
config: arm64-randconfig-s032-20220605 (https://download.01.org/0day-ci/archive/20220605/202206050216.eT3Asw30-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=28e77cc1c0686621a4d416f599cee5ab369daa0a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 28e77cc1c0686621a4d416f599cee5ab369daa0a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/remoteproc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/remoteproc/ti_k3_r5_remoteproc.c:437:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *cpu_addr @@
   drivers/remoteproc/ti_k3_r5_remoteproc.c:437:9: sparse:     expected void const *
   drivers/remoteproc/ti_k3_r5_remoteproc.c:437:9: sparse:     got void [noderef] __iomem *cpu_addr
>> drivers/remoteproc/ti_k3_r5_remoteproc.c:437:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *cpu_addr @@
   drivers/remoteproc/ti_k3_r5_remoteproc.c:437:9: sparse:     expected void const *
   drivers/remoteproc/ti_k3_r5_remoteproc.c:437:9: sparse:     got void [noderef] __iomem *cpu_addr
   drivers/remoteproc/ti_k3_r5_remoteproc.c:437:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *cpu_addr @@
   drivers/remoteproc/ti_k3_r5_remoteproc.c:437:9: sparse:     expected void *
   drivers/remoteproc/ti_k3_r5_remoteproc.c:437:9: sparse:     got void [noderef] __iomem *cpu_addr
   drivers/remoteproc/ti_k3_r5_remoteproc.c:440:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *cpu_addr @@
   drivers/remoteproc/ti_k3_r5_remoteproc.c:440:9: sparse:     expected void const *
   drivers/remoteproc/ti_k3_r5_remoteproc.c:440:9: sparse:     got void [noderef] __iomem *cpu_addr
   drivers/remoteproc/ti_k3_r5_remoteproc.c:440:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *cpu_addr @@
   drivers/remoteproc/ti_k3_r5_remoteproc.c:440:9: sparse:     expected void const *
   drivers/remoteproc/ti_k3_r5_remoteproc.c:440:9: sparse:     got void [noderef] __iomem *cpu_addr
   drivers/remoteproc/ti_k3_r5_remoteproc.c:440:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *cpu_addr @@
   drivers/remoteproc/ti_k3_r5_remoteproc.c:440:9: sparse:     expected void *
   drivers/remoteproc/ti_k3_r5_remoteproc.c:440:9: sparse:     got void [noderef] __iomem *cpu_addr

vim +437 drivers/remoteproc/ti_k3_r5_remoteproc.c

6dedbd1d544389 Suman Anna 2020-10-02  378  
6dedbd1d544389 Suman Anna 2020-10-02  379  /*
6dedbd1d544389 Suman Anna 2020-10-02  380   * The R5F cores have controls for both a reset and a halt/run. The code
6dedbd1d544389 Suman Anna 2020-10-02  381   * execution from DDR requires the initial boot-strapping code to be run
6dedbd1d544389 Suman Anna 2020-10-02  382   * from the internal TCMs. This function is used to release the resets on
6dedbd1d544389 Suman Anna 2020-10-02  383   * applicable cores to allow loading into the TCMs. The .prepare() ops is
6dedbd1d544389 Suman Anna 2020-10-02  384   * invoked by remoteproc core before any firmware loading, and is followed
6dedbd1d544389 Suman Anna 2020-10-02  385   * by the .start() ops after loading to actually let the R5 cores run.
ee99ee7c929c3e Suman Anna 2021-03-27  386   *
ee99ee7c929c3e Suman Anna 2021-03-27  387   * The Single-CPU mode on applicable SoCs (eg: AM64x) only uses Core0 to
ee99ee7c929c3e Suman Anna 2021-03-27  388   * execute code, but combines the TCMs from both cores. The resets for both
ee99ee7c929c3e Suman Anna 2021-03-27  389   * cores need to be released to make this possible, as the TCMs are in general
ee99ee7c929c3e Suman Anna 2021-03-27  390   * private to each core. Only Core0 needs to be unhalted for running the
ee99ee7c929c3e Suman Anna 2021-03-27  391   * cluster in this mode. The function uses the same reset logic as LockStep
ee99ee7c929c3e Suman Anna 2021-03-27  392   * mode for this (though the behavior is agnostic of the reset release order).
6dedbd1d544389 Suman Anna 2020-10-02  393   */
6dedbd1d544389 Suman Anna 2020-10-02  394  static int k3_r5_rproc_prepare(struct rproc *rproc)
6dedbd1d544389 Suman Anna 2020-10-02  395  {
6dedbd1d544389 Suman Anna 2020-10-02  396  	struct k3_r5_rproc *kproc = rproc->priv;
6dedbd1d544389 Suman Anna 2020-10-02  397  	struct k3_r5_cluster *cluster = kproc->cluster;
6dedbd1d544389 Suman Anna 2020-10-02  398  	struct k3_r5_core *core = kproc->core;
6dedbd1d544389 Suman Anna 2020-10-02  399  	struct device *dev = kproc->dev;
7508ea19b20da8 Suman Anna 2020-11-18  400  	u32 ctrl = 0, cfg = 0, stat = 0;
7508ea19b20da8 Suman Anna 2020-11-18  401  	u64 boot_vec = 0;
7508ea19b20da8 Suman Anna 2020-11-18  402  	bool mem_init_dis;
6dedbd1d544389 Suman Anna 2020-10-02  403  	int ret;
6dedbd1d544389 Suman Anna 2020-10-02  404  
7508ea19b20da8 Suman Anna 2020-11-18  405  	ret = ti_sci_proc_get_status(core->tsp, &boot_vec, &cfg, &ctrl, &stat);
7508ea19b20da8 Suman Anna 2020-11-18  406  	if (ret < 0)
7508ea19b20da8 Suman Anna 2020-11-18  407  		return ret;
7508ea19b20da8 Suman Anna 2020-11-18  408  	mem_init_dis = !!(cfg & PROC_BOOT_CFG_FLAG_R5_MEM_INIT_DIS);
7508ea19b20da8 Suman Anna 2020-11-18  409  
ee99ee7c929c3e Suman Anna 2021-03-27  410  	/* Re-use LockStep-mode reset logic for Single-CPU mode */
ee99ee7c929c3e Suman Anna 2021-03-27  411  	ret = (cluster->mode == CLUSTER_MODE_LOCKSTEP ||
ee99ee7c929c3e Suman Anna 2021-03-27  412  	       cluster->mode == CLUSTER_MODE_SINGLECPU) ?
6dedbd1d544389 Suman Anna 2020-10-02  413  		k3_r5_lockstep_release(cluster) : k3_r5_split_release(core);
34f2653686fecc Suman Anna 2020-10-02  414  	if (ret) {
6dedbd1d544389 Suman Anna 2020-10-02  415  		dev_err(dev, "unable to enable cores for TCM loading, ret = %d\n",
6dedbd1d544389 Suman Anna 2020-10-02  416  			ret);
6dedbd1d544389 Suman Anna 2020-10-02  417  		return ret;
6dedbd1d544389 Suman Anna 2020-10-02  418  	}
6dedbd1d544389 Suman Anna 2020-10-02  419  
7508ea19b20da8 Suman Anna 2020-11-18  420  	/*
7508ea19b20da8 Suman Anna 2020-11-18  421  	 * Newer IP revisions like on J7200 SoCs support h/w auto-initialization
7508ea19b20da8 Suman Anna 2020-11-18  422  	 * of TCMs, so there is no need to perform the s/w memzero. This bit is
7508ea19b20da8 Suman Anna 2020-11-18  423  	 * configurable through System Firmware, the default value does perform
7508ea19b20da8 Suman Anna 2020-11-18  424  	 * auto-init, but account for it in case it is disabled
7508ea19b20da8 Suman Anna 2020-11-18  425  	 */
7508ea19b20da8 Suman Anna 2020-11-18  426  	if (cluster->soc_data->tcm_ecc_autoinit && !mem_init_dis) {
7508ea19b20da8 Suman Anna 2020-11-18  427  		dev_dbg(dev, "leveraging h/w init for TCM memories\n");
7508ea19b20da8 Suman Anna 2020-11-18  428  		return 0;
7508ea19b20da8 Suman Anna 2020-11-18  429  	}
7508ea19b20da8 Suman Anna 2020-11-18  430  
34f2653686fecc Suman Anna 2020-10-02  431  	/*
34f2653686fecc Suman Anna 2020-10-02  432  	 * Zero out both TCMs unconditionally (access from v8 Arm core is not
34f2653686fecc Suman Anna 2020-10-02  433  	 * affected by ATCM & BTCM enable configuration values) so that ECC
34f2653686fecc Suman Anna 2020-10-02  434  	 * can be effective on all TCM addresses.
34f2653686fecc Suman Anna 2020-10-02  435  	 */
34f2653686fecc Suman Anna 2020-10-02  436  	dev_dbg(dev, "zeroing out ATCM memory\n");
34f2653686fecc Suman Anna 2020-10-02 @437  	memset(core->mem[0].cpu_addr, 0x00, core->mem[0].size);
34f2653686fecc Suman Anna 2020-10-02  438  
34f2653686fecc Suman Anna 2020-10-02  439  	dev_dbg(dev, "zeroing out BTCM memory\n");
34f2653686fecc Suman Anna 2020-10-02  440  	memset(core->mem[1].cpu_addr, 0x00, core->mem[1].size);
34f2653686fecc Suman Anna 2020-10-02  441  
34f2653686fecc Suman Anna 2020-10-02  442  	return 0;
34f2653686fecc Suman Anna 2020-10-02  443  }
34f2653686fecc Suman Anna 2020-10-02  444  

:::::: The code at line 437 was first introduced by commit
:::::: 34f2653686fecc9bd5a4ee16724768c72953fb57 remoteproc: k3-r5: Initialize TCM memories for ECC

:::::: TO: Suman Anna <s-anna@ti.com>
:::::: CC: Bjorn Andersson <bjorn.andersson@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
