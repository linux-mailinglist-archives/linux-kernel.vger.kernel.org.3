Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA6558F556
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 02:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbiHKArS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 20:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiHKArQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 20:47:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6314B844E0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 17:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660178835; x=1691714835;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ju95KaN+qDEt9VU7HhkQUzAJwc8PDTZjdgYgs0GMPAw=;
  b=aTapBm9CLR41JgN+h+NFwODsKXbypQNCx/eercl8WlxEtIzoErW+C85b
   H5JCf4DGb43KFJnQ8Pd0N7P+/yZsqYp657OozTvMArSanVvHDwusXX4Qe
   h034MgLB8bm9W6RfJj+RHw5z2HQib0Pf/EpJghBtiEvqh2rhreYJAPLdV
   3/7sOmEQO4EZo4ZugIHmyBuKntjVFAssJyZR5PE4pc38duIRDliuL2wAn
   LOsPHD5mSYqOFP7WCLqAxbblUUsJ0Tl+rqg67rp+OZXl4azFa3bT6OW9B
   AfND41wCtaWQmataNXrA2PgXiH4NvXiCi01Pd/tDI29pTZRn463zUqln8
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="292484041"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="292484041"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 17:47:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="581455141"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 10 Aug 2022 17:47:13 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLwLw-0000v5-2s;
        Thu, 11 Aug 2022 00:47:12 +0000
Date:   Thu, 11 Aug 2022 08:46:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bharat Uppal <bharat.uppal@samsung.com>
Subject: drivers/ufs/host/ufs-exynos.c:1721:28: sparse: sparse: symbol
 'fsd_ufs_drvs' was not declared. Should it be static?
Message-ID: <202208110805.AosH3J3i-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aeb6e6ac18c73ec287b3b1e2c913520699358c13
commit: 216f74e8059aa305a993da1c2d6e3ba2117979fa scsi: ufs: host: ufs-exynos: Add support for FSD UFS HCI
date:   8 weeks ago
config: microblaze-randconfig-s052-20220810 (https://download.01.org/0day-ci/archive/20220811/202208110805.AosH3J3i-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=216f74e8059aa305a993da1c2d6e3ba2117979fa
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 216f74e8059aa305a993da1c2d6e3ba2117979fa
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/scsi/qla2xxx/ drivers/ufs/host/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/ufs/host/ufs-exynos.c:1721:28: sparse: sparse: symbol 'fsd_ufs_drvs' was not declared. Should it be static?

vim +/fsd_ufs_drvs +1721 drivers/ufs/host/ufs-exynos.c

  1713	
  1714	struct exynos_ufs_drv_data fsd_ufs_drvs = {
  1715		.uic_attr               = &fsd_uic_attr,
  1716		.quirks                 = UFSHCD_QUIRK_PRDT_BYTE_GRAN |
  1717					  UFSHCI_QUIRK_BROKEN_REQ_LIST_CLR |
  1718					  UFSHCD_QUIRK_BROKEN_OCS_FATAL_ERROR |
  1719					  UFSHCD_QUIRK_SKIP_DEF_UNIPRO_TIMEOUT_SETTING |
  1720					  UFSHCI_QUIRK_SKIP_RESET_INTR_AGGR,
> 1721		.opts                   = EXYNOS_UFS_OPT_HAS_APB_CLK_CTRL |
  1722					  EXYNOS_UFS_OPT_BROKEN_AUTO_CLK_CTRL |
  1723					  EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR |
  1724					  EXYNOS_UFS_OPT_BROKEN_RX_SEL_IDX,
  1725		.pre_link               = fsd_ufs_pre_link,
  1726		.post_link              = fsd_ufs_post_link,
  1727		.pre_pwr_change         = fsd_ufs_pre_pwr_change,
  1728	};
  1729	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
