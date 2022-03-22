Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE364E483B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 22:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiCVVXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 17:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiCVVXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 17:23:03 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F609F19
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 14:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647984094; x=1679520094;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=L0f0HWehPrKUrvTTJMdAKx30qgSsyjqAC42Rho0AKhQ=;
  b=hMhk8i6e41uD7kxADuDsdz2fAPDDJFkDzIlwp1UKS5aNXCHepEblNIZ+
   pxZ1KZ8ijD2FC7+vGXMb0Av7O8oH1h+Pv7+dZhNXEwR4fxQF6UcrKMROz
   4CpY92FLvuKq9cfS1US+b6rjs3x9BmewQTzydR8ivxsTvaQxvVGgwEJMl
   HcEriuhwJSnRgHZoMPAcz6x4Aw7LHHThfl1WuWwqdzKRc+BY3wU6SrgCi
   zC0koB1GAAsjjYh5NMjOp1hbHb5k5qHWqSNjyGrOuTgCGtMeYAKtdS2cR
   9ZPsnLpBdIcBa4SkthR4EbxOuzqmPIUUECAS785C/c4KdKQ2tTkr8W3FS
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="256774672"
X-IronPort-AV: E=Sophos;i="5.90,202,1643702400"; 
   d="scan'208";a="256774672"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 14:21:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,202,1643702400"; 
   d="scan'208";a="543899446"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 22 Mar 2022 14:21:32 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWlwZ-000JIi-MC; Tue, 22 Mar 2022 21:21:31 +0000
Date:   Wed, 23 Mar 2022 05:21:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [bvanassche:ufs-for-next 318/322]
 drivers/scsi/ufs/ufs-qcom.h:135:19: error: implicit declaration of function
 'ufshcd_readl'
Message-ID: <202203230504.dpKCeXdj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux ufs-for-next
head:   8fa6e7568ac59ecefa91caa1ac6a39d87ee280d5
commit: 88b7805e9ca963d3844133baf17e5281d28ecbea [318/322] scsi: ufs: Remove unnecessary ufshcd-crypto.h include directives
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220323/202203230504.dpKCeXdj-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/bvanassche/linux/commit/88b7805e9ca963d3844133baf17e5281d28ecbea
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche ufs-for-next
        git checkout 88b7805e9ca963d3844133baf17e5281d28ecbea
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/scsi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from drivers/scsi/ufs/ufs-qcom-ice.c:12:
>> drivers/scsi/ufs/ufs-qcom.h:132:41: warning: 'struct ufs_hba' declared inside parameter list will not be visible outside of this definition or declaration
     132 | ufs_qcom_get_controller_revision(struct ufs_hba *hba,
         |                                         ^~~~~~~
   drivers/scsi/ufs/ufs-qcom.h: In function 'ufs_qcom_get_controller_revision':
>> drivers/scsi/ufs/ufs-qcom.h:135:19: error: implicit declaration of function 'ufshcd_readl' [-Werror=implicit-function-declaration]
     135 |         u32 ver = ufshcd_readl(hba, REG_UFS_HW_VERSION);
         |                   ^~~~~~~~~~~~
   drivers/scsi/ufs/ufs-qcom.h: At top level:
   drivers/scsi/ufs/ufs-qcom.h:142:49: warning: 'struct ufs_hba' declared inside parameter list will not be visible outside of this definition or declaration
     142 | static inline void ufs_qcom_assert_reset(struct ufs_hba *hba)
         |                                                 ^~~~~~~
   drivers/scsi/ufs/ufs-qcom.h: In function 'ufs_qcom_assert_reset':
>> drivers/scsi/ufs/ufs-qcom.h:144:9: error: implicit declaration of function 'ufshcd_rmwl' [-Werror=implicit-function-declaration]
     144 |         ufshcd_rmwl(hba, MASK_UFS_PHY_SOFT_RESET,
         |         ^~~~~~~~~~~
   drivers/scsi/ufs/ufs-qcom.h: At top level:
   drivers/scsi/ufs/ufs-qcom.h:154:51: warning: 'struct ufs_hba' declared inside parameter list will not be visible outside of this definition or declaration
     154 | static inline void ufs_qcom_deassert_reset(struct ufs_hba *hba)
         |                                                   ^~~~~~~
>> drivers/scsi/ufs/ufs-qcom.h:198:34: error: field 'dev_req_params' has incomplete type
     198 |         struct ufs_pa_layer_attr dev_req_params;
         |                                  ^~~~~~~~~~~~~~
>> drivers/scsi/ufs/ufs-qcom.h:252:42: warning: 'union ufs_crypto_cfg_entry' declared inside parameter list will not be visible outside of this definition or declaration
     252 |                              const union ufs_crypto_cfg_entry *cfg, int slot);
         |                                          ^~~~~~~~~~~~~~~~~~~~
   drivers/scsi/ufs/ufs-qcom-ice.c: In function 'qcom_ice_supported':
>> drivers/scsi/ufs/ufs-qcom-ice.c:67:39: error: invalid use of undefined type 'struct ufs_hba'
      67 |         struct device *dev = host->hba->dev;
         |                                       ^~
>> drivers/scsi/ufs/ufs-qcom-ice.c:63:9: error: implicit declaration of function 'readl' [-Werror=implicit-function-declaration]
      63 |         readl((host)->ice_mmio + (reg))
         |         ^~~~~
   drivers/scsi/ufs/ufs-qcom-ice.c:68:22: note: in expansion of macro 'qcom_ice_readl'
      68 |         u32 regval = qcom_ice_readl(host, QCOM_ICE_REG_VERSION);
         |                      ^~~~~~~~~~~~~~
   drivers/scsi/ufs/ufs-qcom-ice.c: In function 'ufs_qcom_ice_init':
   drivers/scsi/ufs/ufs-qcom-ice.c:97:33: error: invalid use of undefined type 'struct ufs_hba'
      97 |         struct device *dev = hba->dev;
         |                                 ^~
>> drivers/scsi/ufs/ufs-qcom-ice.c:102:33: error: 'REG_CONTROLLER_CAPABILITIES' undeclared (first use in this function)
     102 |         if (!(ufshcd_readl(hba, REG_CONTROLLER_CAPABILITIES) &
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/ufs/ufs-qcom-ice.c:102:33: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/scsi/ufs/ufs-qcom-ice.c:103:15: error: 'MASK_CRYPTO_SUPPORT' undeclared (first use in this function)
     103 |               MASK_CRYPTO_SUPPORT))
         |               ^~~~~~~~~~~~~~~~~~~
   drivers/scsi/ufs/ufs-qcom-ice.c:131:12: error: invalid use of undefined type 'struct ufs_hba'
     131 |         hba->caps &= ~UFSHCD_CAP_CRYPTO;
         |            ^~
>> drivers/scsi/ufs/ufs-qcom-ice.c:131:23: error: 'UFSHCD_CAP_CRYPTO' undeclared (first use in this function)
     131 |         hba->caps &= ~UFSHCD_CAP_CRYPTO;
         |                       ^~~~~~~~~~~~~~~~~
   drivers/scsi/ufs/ufs-qcom-ice.c: In function 'qcom_ice_low_power_mode_enable':
>> drivers/scsi/ufs/ufs-qcom-ice.c:61:9: error: implicit declaration of function 'writel' [-Werror=implicit-function-declaration]
      61 |         writel((val), (host)->ice_mmio + (reg))
         |         ^~~~~~
   drivers/scsi/ufs/ufs-qcom-ice.c:145:9: note: in expansion of macro 'qcom_ice_writel'
     145 |         qcom_ice_writel(host, regval, QCOM_ICE_REG_ADVANCED_CONTROL);
         |         ^~~~~~~~~~~~~~~
   drivers/scsi/ufs/ufs-qcom-ice.c: In function 'qcom_ice_optimization_enable':
>> drivers/scsi/ufs/ufs-qcom-ice.c:156:9: error: implicit declaration of function 'udelay' [-Werror=implicit-function-declaration]
     156 |         udelay(5);
         |         ^~~~~~
   drivers/scsi/ufs/ufs-qcom-ice.c: In function 'ufs_qcom_ice_enable':
   drivers/scsi/ufs/ufs-qcom-ice.c:163:24: error: invalid use of undefined type 'struct ufs_hba'
     163 |         if (!(host->hba->caps & UFSHCD_CAP_CRYPTO))
         |                        ^~
   drivers/scsi/ufs/ufs-qcom-ice.c:163:33: error: 'UFSHCD_CAP_CRYPTO' undeclared (first use in this function)
     163 |         if (!(host->hba->caps & UFSHCD_CAP_CRYPTO))
         |                                 ^~~~~~~~~~~~~~~~~
   drivers/scsi/ufs/ufs-qcom-ice.c: In function 'ufs_qcom_ice_resume':
   drivers/scsi/ufs/ufs-qcom-ice.c:191:24: error: invalid use of undefined type 'struct ufs_hba'
     191 |         if (!(host->hba->caps & UFSHCD_CAP_CRYPTO))
         |                        ^~
   drivers/scsi/ufs/ufs-qcom-ice.c:191:33: error: 'UFSHCD_CAP_CRYPTO' undeclared (first use in this function)
     191 |         if (!(host->hba->caps & UFSHCD_CAP_CRYPTO))
         |                                 ^~~~~~~~~~~~~~~~~
   In file included from include/linux/device.h:15,
                    from include/linux/platform_device.h:13,
                    from drivers/scsi/ufs/ufs-qcom-ice.c:9:
   drivers/scsi/ufs/ufs-qcom-ice.c:196:34: error: invalid use of undefined type 'struct ufs_hba'
     196 |                 dev_err(host->hba->dev, "BIST status error (%d)\n", err);
         |                                  ^~
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/scsi/ufs/ufs-qcom-ice.c:196:17: note: in expansion of macro 'dev_err'
     196 |                 dev_err(host->hba->dev, "BIST status error (%d)\n", err);
         |                 ^~~~~~~
   drivers/scsi/ufs/ufs-qcom-ice.c: At top level:
>> drivers/scsi/ufs/ufs-qcom-ice.c:207:42: warning: 'union ufs_crypto_cfg_entry' declared inside parameter list will not be visible outside of this definition or declaration
     207 |                              const union ufs_crypto_cfg_entry *cfg, int slot)
         |                                          ^~~~~~~~~~~~~~~~~~~~
>> drivers/scsi/ufs/ufs-qcom-ice.c:206:5: error: conflicting types for 'ufs_qcom_ice_program_key'; have 'int(struct ufs_hba *, const union ufs_crypto_cfg_entry *, int)'
     206 | int ufs_qcom_ice_program_key(struct ufs_hba *hba,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/scsi/ufs/ufs-qcom-ice.c:12:
   drivers/scsi/ufs/ufs-qcom.h:251:5: note: previous declaration of 'ufs_qcom_ice_program_key' with type 'int(struct ufs_hba *, const union ufs_crypto_cfg_entry *, int)'
     251 | int ufs_qcom_ice_program_key(struct ufs_hba *hba,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/ufs/ufs-qcom-ice.c: In function 'ufs_qcom_ice_program_key':
>> drivers/scsi/ufs/ufs-qcom-ice.c:209:36: error: storage size of 'cap' isn't known
     209 |         union ufs_crypto_cap_entry cap;
         |                                    ^~~
>> drivers/scsi/ufs/ufs-qcom-ice.c:217:18: error: invalid use of undefined type 'const union ufs_crypto_cfg_entry'
     217 |         if (!(cfg->config_enable & UFS_CRYPTO_CONFIGURATION_ENABLE))
         |                  ^~
>> drivers/scsi/ufs/ufs-qcom-ice.c:217:36: error: 'UFS_CRYPTO_CONFIGURATION_ENABLE' undeclared (first use in this function)
     217 |         if (!(cfg->config_enable & UFS_CRYPTO_CONFIGURATION_ENABLE))
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/ufs/ufs-qcom-ice.c:221:18: error: invalid use of undefined type 'struct ufs_hba'
     221 |         cap = hba->crypto_cap_array[cfg->crypto_cap_idx];
         |                  ^~
   drivers/scsi/ufs/ufs-qcom-ice.c:221:40: error: invalid use of undefined type 'const union ufs_crypto_cfg_entry'
     221 |         cap = hba->crypto_cap_array[cfg->crypto_cap_idx];
         |                                        ^~
>> drivers/scsi/ufs/ufs-qcom-ice.c:222:33: error: 'UFS_CRYPTO_ALG_AES_XTS' undeclared (first use in this function)
     222 |         if (cap.algorithm_id != UFS_CRYPTO_ALG_AES_XTS ||
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/scsi/ufs/ufs-qcom-ice.c:223:29: error: 'UFS_CRYPTO_KEY_SIZE_256' undeclared (first use in this function)
     223 |             cap.key_size != UFS_CRYPTO_KEY_SIZE_256) {
         |                             ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/device.h:15,
                    from include/linux/platform_device.h:13,
                    from drivers/scsi/ufs/ufs-qcom-ice.c:9:
   drivers/scsi/ufs/ufs-qcom-ice.c:224:40: error: invalid use of undefined type 'struct ufs_hba'
     224 |                 dev_err_ratelimited(hba->dev,
         |                                        ^~
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   include/linux/dev_printk.h:208:17: note: in expansion of macro 'dev_err'
     208 |                 dev_level(dev, fmt, ##__VA_ARGS__);                     \
         |                 ^~~~~~~~~
   include/linux/dev_printk.h:218:9: note: in expansion of macro 'dev_level_ratelimited'
     218 |         dev_level_ratelimited(dev_err, dev, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/ufs/ufs-qcom-ice.c:224:17: note: in expansion of macro 'dev_err_ratelimited'
     224 |                 dev_err_ratelimited(hba->dev,
         |                 ^~~~~~~~~~~~~~~~~~~
   drivers/scsi/ufs/ufs-qcom-ice.c:230:30: error: invalid use of undefined type 'const union ufs_crypto_cfg_entry'
     230 |         memcpy(key.bytes, cfg->crypto_key, AES_256_XTS_KEY_SIZE);
         |                              ^~
   drivers/scsi/ufs/ufs-qcom-ice.c:241:39: error: invalid use of undefined type 'const union ufs_crypto_cfg_entry'
     241 |                                    cfg->data_unit_size);
         |                                       ^~
   drivers/scsi/ufs/ufs-qcom-ice.c:209:36: warning: unused variable 'cap' [-Wunused-variable]
     209 |         union ufs_crypto_cap_entry cap;
         |                                    ^~~
   cc1: some warnings being treated as errors


vim +/ufshcd_readl +135 drivers/scsi/ufs/ufs-qcom.h

f06fcc7155dcbc Yaniv Gardi     2015-10-28  130  
81c0fc51b7a790 Yaniv Gardi     2015-01-15  131  static inline void
81c0fc51b7a790 Yaniv Gardi     2015-01-15 @132  ufs_qcom_get_controller_revision(struct ufs_hba *hba,
81c0fc51b7a790 Yaniv Gardi     2015-01-15  133  				 u8 *major, u16 *minor, u16 *step)
81c0fc51b7a790 Yaniv Gardi     2015-01-15  134  {
81c0fc51b7a790 Yaniv Gardi     2015-01-15 @135  	u32 ver = ufshcd_readl(hba, REG_UFS_HW_VERSION);
81c0fc51b7a790 Yaniv Gardi     2015-01-15  136  
81c0fc51b7a790 Yaniv Gardi     2015-01-15  137  	*major = (ver & UFS_HW_VER_MAJOR_MASK) >> UFS_HW_VER_MAJOR_SHFT;
81c0fc51b7a790 Yaniv Gardi     2015-01-15  138  	*minor = (ver & UFS_HW_VER_MINOR_MASK) >> UFS_HW_VER_MINOR_SHFT;
81c0fc51b7a790 Yaniv Gardi     2015-01-15  139  	*step = (ver & UFS_HW_VER_STEP_MASK) >> UFS_HW_VER_STEP_SHFT;
81c0fc51b7a790 Yaniv Gardi     2015-01-15  140  };
81c0fc51b7a790 Yaniv Gardi     2015-01-15  141  
81c0fc51b7a790 Yaniv Gardi     2015-01-15  142  static inline void ufs_qcom_assert_reset(struct ufs_hba *hba)
81c0fc51b7a790 Yaniv Gardi     2015-01-15  143  {
81c0fc51b7a790 Yaniv Gardi     2015-01-15 @144  	ufshcd_rmwl(hba, MASK_UFS_PHY_SOFT_RESET,
81c0fc51b7a790 Yaniv Gardi     2015-01-15  145  			1 << OFFSET_UFS_PHY_SOFT_RESET, REG_UFS_CFG1);
81c0fc51b7a790 Yaniv Gardi     2015-01-15  146  
81c0fc51b7a790 Yaniv Gardi     2015-01-15  147  	/*
81c0fc51b7a790 Yaniv Gardi     2015-01-15  148  	 * Make sure assertion of ufs phy reset is written to
81c0fc51b7a790 Yaniv Gardi     2015-01-15  149  	 * register before returning
81c0fc51b7a790 Yaniv Gardi     2015-01-15  150  	 */
81c0fc51b7a790 Yaniv Gardi     2015-01-15  151  	mb();
81c0fc51b7a790 Yaniv Gardi     2015-01-15  152  }
81c0fc51b7a790 Yaniv Gardi     2015-01-15  153  
81c0fc51b7a790 Yaniv Gardi     2015-01-15  154  static inline void ufs_qcom_deassert_reset(struct ufs_hba *hba)
81c0fc51b7a790 Yaniv Gardi     2015-01-15  155  {
81c0fc51b7a790 Yaniv Gardi     2015-01-15  156  	ufshcd_rmwl(hba, MASK_UFS_PHY_SOFT_RESET,
81c0fc51b7a790 Yaniv Gardi     2015-01-15  157  			0 << OFFSET_UFS_PHY_SOFT_RESET, REG_UFS_CFG1);
81c0fc51b7a790 Yaniv Gardi     2015-01-15  158  
81c0fc51b7a790 Yaniv Gardi     2015-01-15  159  	/*
81c0fc51b7a790 Yaniv Gardi     2015-01-15  160  	 * Make sure de-assertion of ufs phy reset is written to
81c0fc51b7a790 Yaniv Gardi     2015-01-15  161  	 * register before returning
81c0fc51b7a790 Yaniv Gardi     2015-01-15  162  	 */
81c0fc51b7a790 Yaniv Gardi     2015-01-15  163  	mb();
81c0fc51b7a790 Yaniv Gardi     2015-01-15  164  }
81c0fc51b7a790 Yaniv Gardi     2015-01-15  165  
bfdbe8ba21291c Yaniv Gardi     2015-03-31  166  /* Host controller hardware version: major.minor.step */
bfdbe8ba21291c Yaniv Gardi     2015-03-31  167  struct ufs_hw_version {
bfdbe8ba21291c Yaniv Gardi     2015-03-31  168  	u16 step;
bfdbe8ba21291c Yaniv Gardi     2015-03-31  169  	u16 minor;
bfdbe8ba21291c Yaniv Gardi     2015-03-31  170  	u8 major;
bfdbe8ba21291c Yaniv Gardi     2015-03-31  171  };
cad2e03d860779 Yaniv Gardi     2015-03-31  172  
6e3fd44d7b7638 Yaniv Gardi     2015-10-28  173  struct ufs_qcom_testbus {
6e3fd44d7b7638 Yaniv Gardi     2015-10-28  174  	u8 select_major;
6e3fd44d7b7638 Yaniv Gardi     2015-10-28  175  	u8 select_minor;
6e3fd44d7b7638 Yaniv Gardi     2015-10-28  176  };
6e3fd44d7b7638 Yaniv Gardi     2015-10-28  177  
b8416b2fedbf1c Bjorn Andersson 2019-08-28  178  struct gpio_desc;
b8416b2fedbf1c Bjorn Andersson 2019-08-28  179  
6e3fd44d7b7638 Yaniv Gardi     2015-10-28  180  struct ufs_qcom_host {
cad2e03d860779 Yaniv Gardi     2015-03-31  181  	/*
cad2e03d860779 Yaniv Gardi     2015-03-31  182  	 * Set this capability if host controller supports the QUniPro mode
cad2e03d860779 Yaniv Gardi     2015-03-31  183  	 * and if driver wants the Host controller to operate in QUniPro mode.
cad2e03d860779 Yaniv Gardi     2015-03-31  184  	 * Note: By default this capability will be kept enabled if host
cad2e03d860779 Yaniv Gardi     2015-03-31  185  	 * controller supports the QUniPro mode.
cad2e03d860779 Yaniv Gardi     2015-03-31  186  	 */
7e014efdc0b11c Alim Akhtar     2017-10-03  187  	#define UFS_QCOM_CAP_QUNIPRO	0x1
f06fcc7155dcbc Yaniv Gardi     2015-10-28  188  
f06fcc7155dcbc Yaniv Gardi     2015-10-28  189  	/*
f06fcc7155dcbc Yaniv Gardi     2015-10-28  190  	 * Set this capability if host controller can retain the secure
f06fcc7155dcbc Yaniv Gardi     2015-10-28  191  	 * configuration even after UFS controller core power collapse.
f06fcc7155dcbc Yaniv Gardi     2015-10-28  192  	 */
7e014efdc0b11c Alim Akhtar     2017-10-03  193  	#define UFS_QCOM_CAP_RETAIN_SEC_CFG_AFTER_PWR_COLLAPSE	0x2
cad2e03d860779 Yaniv Gardi     2015-03-31  194  	u32 caps;
cad2e03d860779 Yaniv Gardi     2015-03-31  195  
81c0fc51b7a790 Yaniv Gardi     2015-01-15  196  	struct phy *generic_phy;
81c0fc51b7a790 Yaniv Gardi     2015-01-15  197  	struct ufs_hba *hba;
81c0fc51b7a790 Yaniv Gardi     2015-01-15 @198  	struct ufs_pa_layer_attr dev_req_params;
81c0fc51b7a790 Yaniv Gardi     2015-01-15  199  	struct clk *rx_l0_sync_clk;
81c0fc51b7a790 Yaniv Gardi     2015-01-15  200  	struct clk *tx_l0_sync_clk;
81c0fc51b7a790 Yaniv Gardi     2015-01-15  201  	struct clk *rx_l1_sync_clk;
81c0fc51b7a790 Yaniv Gardi     2015-01-15  202  	struct clk *tx_l1_sync_clk;
81c0fc51b7a790 Yaniv Gardi     2015-01-15  203  	bool is_lane_clks_enabled;
bfdbe8ba21291c Yaniv Gardi     2015-03-31  204  
f06fcc7155dcbc Yaniv Gardi     2015-10-28  205  	void __iomem *dev_ref_clk_ctrl_mmio;
f06fcc7155dcbc Yaniv Gardi     2015-10-28  206  	bool is_dev_ref_clk_enabled;
bfdbe8ba21291c Yaniv Gardi     2015-03-31  207  	struct ufs_hw_version hw_ver;
df4ec2fa7a4dc2 Eric Biggers    2020-07-10  208  #ifdef CONFIG_SCSI_UFS_CRYPTO
df4ec2fa7a4dc2 Eric Biggers    2020-07-10  209  	void __iomem *ice_mmio;
df4ec2fa7a4dc2 Eric Biggers    2020-07-10  210  #endif
f06fcc7155dcbc Yaniv Gardi     2015-10-28  211  
f06fcc7155dcbc Yaniv Gardi     2015-10-28  212  	u32 dev_ref_clk_en_mask;
f06fcc7155dcbc Yaniv Gardi     2015-10-28  213  
6e3fd44d7b7638 Yaniv Gardi     2015-10-28  214  	/* Bitmask for enabling debug prints */
6e3fd44d7b7638 Yaniv Gardi     2015-10-28  215  	u32 dbg_print_en;
6e3fd44d7b7638 Yaniv Gardi     2015-10-28  216  	struct ufs_qcom_testbus testbus;
12fd5f250db2ad Evan Green      2019-03-21  217  
870b1279c7a034 Can Guo         2019-11-14  218  	/* Reset control of HCI */
870b1279c7a034 Can Guo         2019-11-14  219  	struct reset_control *core_reset;
12fd5f250db2ad Evan Green      2019-03-21  220  	struct reset_controller_dev rcdev;
b8416b2fedbf1c Bjorn Andersson 2019-08-28  221  
b8416b2fedbf1c Bjorn Andersson 2019-08-28  222  	struct gpio_desc *device_reset;
81c0fc51b7a790 Yaniv Gardi     2015-01-15  223  };
81c0fc51b7a790 Yaniv Gardi     2015-01-15  224  
eba5ed3539071b Yaniv Gardi     2016-03-10  225  static inline u32
eba5ed3539071b Yaniv Gardi     2016-03-10  226  ufs_qcom_get_debug_reg_offset(struct ufs_qcom_host *host, u32 reg)
eba5ed3539071b Yaniv Gardi     2016-03-10  227  {
eba5ed3539071b Yaniv Gardi     2016-03-10  228  	if (host->hw_ver.major <= 0x02)
eba5ed3539071b Yaniv Gardi     2016-03-10  229  		return UFS_CNTLR_2_x_x_VEN_REGS_OFFSET(reg);
eba5ed3539071b Yaniv Gardi     2016-03-10  230  
eba5ed3539071b Yaniv Gardi     2016-03-10  231  	return UFS_CNTLR_3_x_x_VEN_REGS_OFFSET(reg);
eba5ed3539071b Yaniv Gardi     2016-03-10  232  };
eba5ed3539071b Yaniv Gardi     2016-03-10  233  
81c0fc51b7a790 Yaniv Gardi     2015-01-15  234  #define ufs_qcom_is_link_off(hba) ufshcd_is_link_off(hba)
81c0fc51b7a790 Yaniv Gardi     2015-01-15  235  #define ufs_qcom_is_link_active(hba) ufshcd_is_link_active(hba)
81c0fc51b7a790 Yaniv Gardi     2015-01-15  236  #define ufs_qcom_is_link_hibern8(hba) ufshcd_is_link_hibern8(hba)
81c0fc51b7a790 Yaniv Gardi     2015-01-15  237  
6e3fd44d7b7638 Yaniv Gardi     2015-10-28  238  int ufs_qcom_testbus_config(struct ufs_qcom_host *host);
6e3fd44d7b7638 Yaniv Gardi     2015-10-28  239  
cad2e03d860779 Yaniv Gardi     2015-03-31  240  static inline bool ufs_qcom_cap_qunipro(struct ufs_qcom_host *host)
cad2e03d860779 Yaniv Gardi     2015-03-31  241  {
f6f56bf5db2b1c Bart Van Assche 2021-12-06  242  	return host->caps & UFS_QCOM_CAP_QUNIPRO;
cad2e03d860779 Yaniv Gardi     2015-03-31  243  }
cad2e03d860779 Yaniv Gardi     2015-03-31  244  
df4ec2fa7a4dc2 Eric Biggers    2020-07-10  245  /* ufs-qcom-ice.c */
df4ec2fa7a4dc2 Eric Biggers    2020-07-10  246  
df4ec2fa7a4dc2 Eric Biggers    2020-07-10  247  #ifdef CONFIG_SCSI_UFS_CRYPTO
df4ec2fa7a4dc2 Eric Biggers    2020-07-10  248  int ufs_qcom_ice_init(struct ufs_qcom_host *host);
df4ec2fa7a4dc2 Eric Biggers    2020-07-10  249  int ufs_qcom_ice_enable(struct ufs_qcom_host *host);
df4ec2fa7a4dc2 Eric Biggers    2020-07-10  250  int ufs_qcom_ice_resume(struct ufs_qcom_host *host);
df4ec2fa7a4dc2 Eric Biggers    2020-07-10  251  int ufs_qcom_ice_program_key(struct ufs_hba *hba,
df4ec2fa7a4dc2 Eric Biggers    2020-07-10 @252  			     const union ufs_crypto_cfg_entry *cfg, int slot);
df4ec2fa7a4dc2 Eric Biggers    2020-07-10  253  #else
df4ec2fa7a4dc2 Eric Biggers    2020-07-10  254  static inline int ufs_qcom_ice_init(struct ufs_qcom_host *host)
df4ec2fa7a4dc2 Eric Biggers    2020-07-10  255  {
df4ec2fa7a4dc2 Eric Biggers    2020-07-10  256  	return 0;
df4ec2fa7a4dc2 Eric Biggers    2020-07-10  257  }
df4ec2fa7a4dc2 Eric Biggers    2020-07-10  258  static inline int ufs_qcom_ice_enable(struct ufs_qcom_host *host)
df4ec2fa7a4dc2 Eric Biggers    2020-07-10  259  {
df4ec2fa7a4dc2 Eric Biggers    2020-07-10  260  	return 0;
df4ec2fa7a4dc2 Eric Biggers    2020-07-10  261  }
df4ec2fa7a4dc2 Eric Biggers    2020-07-10  262  static inline int ufs_qcom_ice_resume(struct ufs_qcom_host *host)
df4ec2fa7a4dc2 Eric Biggers    2020-07-10  263  {
df4ec2fa7a4dc2 Eric Biggers    2020-07-10  264  	return 0;
df4ec2fa7a4dc2 Eric Biggers    2020-07-10  265  }
df4ec2fa7a4dc2 Eric Biggers    2020-07-10  266  #define ufs_qcom_ice_program_key NULL
df4ec2fa7a4dc2 Eric Biggers    2020-07-10  267  #endif /* !CONFIG_SCSI_UFS_CRYPTO */
df4ec2fa7a4dc2 Eric Biggers    2020-07-10  268  

:::::: The code at line 135 was first introduced by commit
:::::: 81c0fc51b7a790ebe05a35de2c9176bd2f5bfe46 ufs-qcom: add support for Qualcomm Technologies Inc platforms

:::::: TO: Yaniv Gardi <ygardi@codeaurora.org>
:::::: CC: Christoph Hellwig <hch@lst.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
