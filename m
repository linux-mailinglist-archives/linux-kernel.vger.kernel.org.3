Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C104E61F7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 11:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349605AbiCXKt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 06:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349600AbiCXKtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 06:49:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187C2167F5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 03:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648118902; x=1679654902;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=u9F9D8i/tzjdTmLWMV559ebjc7u48vQi0qLmQzFbjMg=;
  b=TjW6Fe0UPNsLhDHV1mYOMU+0klaWFbvRKZdb+KV4ojKtqftp4t2k4DON
   c+BCg9N5JFaopSbm0vReP0anyI/vwGbOVcAC1n9pUxTA4/SWJDW4Z0iip
   vXvY6B5wpzb6TM0hpxQPllxWa1KEHULXHRaRjs5d9vcEbk+EHdW6IOnPQ
   LY7m8bSkL+lHDAJan3C4AmPuGvBWtrdLKOoU/JJicp5jS9nu+ym/zwzx5
   ln5Olnv6tskS9rRfMJIGpZd7gjFNOVFX5uc08torRB45TJQSaa/mXsAHa
   53DBJubgfEk8ihNS8D9EVs5HSuLxERcs4cmh0sMX1TeDolO/45P1dR/y+
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="258532578"
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400"; 
   d="scan'208";a="258532578"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 03:48:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400"; 
   d="scan'208";a="544592982"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 24 Mar 2022 03:48:20 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXL0t-000Kzc-IR; Thu, 24 Mar 2022 10:48:19 +0000
Date:   Thu, 24 Mar 2022 18:48:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [bvanassche:ufs-for-next 324/324]
 drivers/scsi/ufs-drivers/ufs-qcom-ice.c:156:9: error: implicit declaration
 of function 'udelay'
Message-ID: <202203241820.7HZPRpGx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

First bad commit (maybe != root cause):

tree:   https://github.com/bvanassche/linux ufs-for-next
head:   b93e987f91a0c037fc4357107f5144110cd84d08
commit: b93e987f91a0c037fc4357107f5144110cd84d08 [324/324] scsi: ufs: Split the drivers/scsi/ufs directory
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220324/202203241820.7HZPRpGx-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/bvanassche/linux/commit/b93e987f91a0c037fc4357107f5144110cd84d08
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche ufs-for-next
        git checkout b93e987f91a0c037fc4357107f5144110cd84d08
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/scsi/ufs-drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/scsi/ufs-drivers/ufs-qcom-ice.c: In function 'qcom_ice_optimization_enable':
>> drivers/scsi/ufs-drivers/ufs-qcom-ice.c:156:9: error: implicit declaration of function 'udelay' [-Werror=implicit-function-declaration]
     156 |         udelay(5);
         |         ^~~~~~
   drivers/scsi/ufs-drivers/ufs-qcom-ice.c: In function 'ufs_qcom_ice_program_key':
>> drivers/scsi/ufs-drivers/ufs-qcom-ice.c:221:18: error: 'struct ufs_hba' has no member named 'crypto_cap_array'
     221 |         cap = hba->crypto_cap_array[cfg->crypto_cap_idx];
         |                  ^~
   cc1: some warnings being treated as errors


vim +/udelay +156 drivers/scsi/ufs-drivers/ufs-qcom-ice.c

df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  147  
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  148  static void qcom_ice_optimization_enable(struct ufs_qcom_host *host)
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  149  {
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  150  	u32 regval;
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  151  
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  152  	/* ICE Optimizations Enable Sequence */
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  153  	regval = qcom_ice_readl(host, QCOM_ICE_REG_ADVANCED_CONTROL);
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  154  	regval |= 0xD807100;
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  155  	/* ICE HPG requires delay before writing */
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10 @156  	udelay(5);
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  157  	qcom_ice_writel(host, regval, QCOM_ICE_REG_ADVANCED_CONTROL);
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  158  	udelay(5);
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  159  }
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  160  
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  161  int ufs_qcom_ice_enable(struct ufs_qcom_host *host)
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  162  {
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  163  	if (!(host->hba->caps & UFSHCD_CAP_CRYPTO))
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  164  		return 0;
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  165  	qcom_ice_low_power_mode_enable(host);
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  166  	qcom_ice_optimization_enable(host);
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  167  	return ufs_qcom_ice_resume(host);
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  168  }
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  169  
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  170  /* Poll until all BIST bits are reset */
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  171  static int qcom_ice_wait_bist_status(struct ufs_qcom_host *host)
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  172  {
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  173  	int count;
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  174  	u32 reg;
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  175  
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  176  	for (count = 0; count < 100; count++) {
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  177  		reg = qcom_ice_readl(host, QCOM_ICE_REG_BIST_STATUS);
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  178  		if (!(reg & QCOM_ICE_BIST_STATUS_MASK))
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  179  			break;
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  180  		udelay(50);
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  181  	}
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  182  	if (reg)
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  183  		return -ETIMEDOUT;
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  184  	return 0;
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  185  }
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  186  
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  187  int ufs_qcom_ice_resume(struct ufs_qcom_host *host)
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  188  {
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  189  	int err;
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  190  
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  191  	if (!(host->hba->caps & UFSHCD_CAP_CRYPTO))
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  192  		return 0;
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  193  
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  194  	err = qcom_ice_wait_bist_status(host);
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  195  	if (err) {
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  196  		dev_err(host->hba->dev, "BIST status error (%d)\n", err);
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  197  		return err;
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  198  	}
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  199  	return 0;
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  200  }
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  201  
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  202  /*
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  203   * Program a key into a QC ICE keyslot, or evict a keyslot.  QC ICE requires
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  204   * vendor-specific SCM calls for this; it doesn't support the standard way.
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  205   */
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  206  int ufs_qcom_ice_program_key(struct ufs_hba *hba,
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  207  			     const union ufs_crypto_cfg_entry *cfg, int slot)
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  208  {
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  209  	union ufs_crypto_cap_entry cap;
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  210  	union {
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  211  		u8 bytes[AES_256_XTS_KEY_SIZE];
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  212  		u32 words[AES_256_XTS_KEY_SIZE / sizeof(u32)];
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  213  	} key;
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  214  	int i;
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  215  	int err;
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  216  
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  217  	if (!(cfg->config_enable & UFS_CRYPTO_CONFIGURATION_ENABLE))
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  218  		return qcom_scm_ice_invalidate_key(slot);
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  219  
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10  220  	/* Only AES-256-XTS has been tested so far. */
df4ec2fa7a4dc2 drivers/scsi/ufs/ufs-qcom-ice.c Eric Biggers 2020-07-10 @221  	cap = hba->crypto_cap_array[cfg->crypto_cap_idx];

:::::: The code at line 156 was first introduced by commit
:::::: df4ec2fa7a4dc20bed62a407f77b5c57f1afbbc8 scsi: ufs-qcom: Add Inline Crypto Engine support

:::::: TO: Eric Biggers <ebiggers@google.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
