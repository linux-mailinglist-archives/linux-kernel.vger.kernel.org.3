Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C074577610
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 14:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbiGQMJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 08:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiGQMJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 08:09:33 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EF6165AE
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 05:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658059772; x=1689595772;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FDKDWBtNyRI5wUENO3OUNQbt71J1vF25CHwYuFCVMeo=;
  b=J7SRQRWAexUPSoRP4efabTymiJHVx5tYxuKzhi4dPIiBGhUIJ42bCVPL
   eu9sTbTpqwKAFVIxBDSplVJkrtUPMn+OyCrdtLV5Rvh2Erv5p6l6NI2Fd
   nV8YfnTmw7qjEyD3ZYVYXU733KIbnvp4hCRtTTAWsnKPVFYyupHpweVqy
   tmX3B68Trf9zWGq27JLlV2K4qFADDx4RP9crEGxkLZyA2CjSn3dmc3AZz
   7Bye7DduJi9lU9bw2Th613p/S9n1WtL27sRvVN13sf/9N5saLp7POI0iM
   5U/SpV+vt2XJ9X+XfVQtDAeFyzb8EynisDqf7KKWNI1NeyCWmkBP8Ybkb
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="347743323"
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="347743323"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 05:09:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="924019033"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jul 2022 05:09:30 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oD35V-0003Cy-PW;
        Sun, 17 Jul 2022 12:09:29 +0000
Date:   Sun, 17 Jul 2022 20:08:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Deepak Kumar Singh <quic_deesin@quicinc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: drivers/soc/qcom/smem.c:1056:31: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202207172054.sqcBnbbg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   972a278fe60c361eb8f37619f562f092e8786d7c
commit: 20bb6c9de1b7e13f11d2ffe73686f4449c426807 soc: qcom: smem: map only partitions used by local HOST
date:   3 months ago
config: mips-randconfig-s053-20220717 (https://download.01.org/0day-ci/archive/20220717/202207172054.sqcBnbbg-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=20bb6c9de1b7e13f11d2ffe73686f4449c426807
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 20bb6c9de1b7e13f11d2ffe73686f4449c426807
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash drivers/soc/qcom/ lib/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/soc/qcom/smem.c:422:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_header *header @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:422:16: sparse:     expected struct smem_header *header
   drivers/soc/qcom/smem.c:422:16: sparse:     got void [noderef] __iomem *virt_base
   drivers/soc/qcom/smem.c:507:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_header *header @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:507:16: sparse:     expected struct smem_header *header
   drivers/soc/qcom/smem.c:507:16: sparse:     got void [noderef] __iomem *virt_base
   drivers/soc/qcom/smem.c:520:50: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   drivers/soc/qcom/smem.c:520:50: sparse:     expected void *
   drivers/soc/qcom/smem.c:520:50: sparse:     got void [noderef] __iomem *
   drivers/soc/qcom/smem.c:648:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_partition_header *phdr @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:648:22: sparse:     expected struct smem_partition_header *phdr
   drivers/soc/qcom/smem.c:648:22: sparse:     got void [noderef] __iomem *virt_base
   drivers/soc/qcom/smem.c:653:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_partition_header *phdr @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:653:22: sparse:     expected struct smem_partition_header *phdr
   drivers/soc/qcom/smem.c:653:22: sparse:     got void [noderef] __iomem *virt_base
   drivers/soc/qcom/smem.c:657:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_header *header @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:657:24: sparse:     expected struct smem_header *header
   drivers/soc/qcom/smem.c:657:24: sparse:     got void [noderef] __iomem *virt_base
   drivers/soc/qcom/smem.c:667:30: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/soc/qcom/smem.c:667:30: sparse:    void *
   drivers/soc/qcom/smem.c:667:30: sparse:    void [noderef] __iomem *
   drivers/soc/qcom/smem.c:688:36: sparse: sparse: subtraction of different types can't work (different address spaces)
   drivers/soc/qcom/smem.c:697:28: sparse: sparse: subtraction of different types can't work (different address spaces)
   drivers/soc/qcom/smem.c:706:36: sparse: sparse: subtraction of different types can't work (different address spaces)
   drivers/soc/qcom/smem.c:721:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_header *header @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:721:16: sparse:     expected struct smem_header *header
   drivers/soc/qcom/smem.c:721:16: sparse:     got void [noderef] __iomem *virt_base
   drivers/soc/qcom/smem.c:754:57: sparse: sparse: restricted __le32 degrades to integer
   drivers/soc/qcom/smem.c:775:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_partition_header *header @@     got void [noderef] __iomem * @@
   drivers/soc/qcom/smem.c:775:16: sparse:     expected struct smem_partition_header *header
   drivers/soc/qcom/smem.c:775:16: sparse:     got void [noderef] __iomem *
   drivers/soc/qcom/smem.c:926:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_ptable *ptable @@     got void [noderef] __iomem * @@
   drivers/soc/qcom/smem.c:926:22: sparse:     expected struct smem_ptable *ptable
   drivers/soc/qcom/smem.c:926:22: sparse:     got void [noderef] __iomem *
   drivers/soc/qcom/smem.c:1035:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_header *header @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:1035:16: sparse:     expected struct smem_header *header
   drivers/soc/qcom/smem.c:1035:16: sparse:     got void [noderef] __iomem *virt_base
>> drivers/soc/qcom/smem.c:1056:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got restricted __le32 * @@
   drivers/soc/qcom/smem.c:1056:31: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/soc/qcom/smem.c:1056:31: sparse:     got restricted __le32 *
   drivers/soc/qcom/smem.c:1056:67: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got restricted __le32 * @@
   drivers/soc/qcom/smem.c:1056:67: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/soc/qcom/smem.c:1056:67: sparse:     got restricted __le32 *

vim +1056 drivers/soc/qcom/smem.c

   973	
   974	static int qcom_smem_probe(struct platform_device *pdev)
   975	{
   976		struct smem_header *header;
   977		struct reserved_mem *rmem;
   978		struct qcom_smem *smem;
   979		unsigned long flags;
   980		size_t array_size;
   981		int num_regions;
   982		int hwlock_id;
   983		u32 version;
   984		u32 size;
   985		int ret;
   986		int i;
   987	
   988		num_regions = 1;
   989		if (of_find_property(pdev->dev.of_node, "qcom,rpm-msg-ram", NULL))
   990			num_regions++;
   991	
   992		array_size = num_regions * sizeof(struct smem_region);
   993		smem = devm_kzalloc(&pdev->dev, sizeof(*smem) + array_size, GFP_KERNEL);
   994		if (!smem)
   995			return -ENOMEM;
   996	
   997		smem->dev = &pdev->dev;
   998		smem->num_regions = num_regions;
   999	
  1000		rmem = of_reserved_mem_lookup(pdev->dev.of_node);
  1001		if (rmem) {
  1002			smem->regions[0].aux_base = rmem->base;
  1003			smem->regions[0].size = rmem->size;
  1004		} else {
  1005			/*
  1006			 * Fall back to the memory-region reference, if we're not a
  1007			 * reserved-memory node.
  1008			 */
  1009			ret = qcom_smem_resolve_mem(smem, "memory-region", &smem->regions[0]);
  1010			if (ret)
  1011				return ret;
  1012		}
  1013	
  1014		if (num_regions > 1) {
  1015			ret = qcom_smem_resolve_mem(smem, "qcom,rpm-msg-ram", &smem->regions[1]);
  1016			if (ret)
  1017				return ret;
  1018		}
  1019	
  1020	
  1021		ret = qcom_smem_map_toc(smem, &smem->regions[0]);
  1022		if (ret)
  1023			return ret;
  1024	
  1025		for (i = 1; i < num_regions; i++) {
  1026			smem->regions[i].virt_base = devm_ioremap_wc(&pdev->dev,
  1027								     smem->regions[i].aux_base,
  1028								     smem->regions[i].size);
  1029			if (!smem->regions[i].virt_base) {
  1030				dev_err(&pdev->dev, "failed to remap %pa\n", &smem->regions[i].aux_base);
  1031				return -ENOMEM;
  1032			}
  1033		}
  1034	
  1035		header = smem->regions[0].virt_base;
  1036		if (le32_to_cpu(header->initialized) != 1 ||
  1037		    le32_to_cpu(header->reserved)) {
  1038			dev_err(&pdev->dev, "SMEM is not initialized by SBL\n");
  1039			return -EINVAL;
  1040		}
  1041	
  1042		hwlock_id = of_hwspin_lock_get_id(pdev->dev.of_node, 0);
  1043		if (hwlock_id < 0) {
  1044			if (hwlock_id != -EPROBE_DEFER)
  1045				dev_err(&pdev->dev, "failed to retrieve hwlock\n");
  1046			return hwlock_id;
  1047		}
  1048	
  1049		smem->hwlock = hwspin_lock_request_specific(hwlock_id);
  1050		if (!smem->hwlock)
  1051			return -ENXIO;
  1052	
  1053		ret = hwspin_lock_timeout_irqsave(smem->hwlock, HWSPINLOCK_TIMEOUT, &flags);
  1054		if (ret)
  1055			return ret;
> 1056		size = readl_relaxed(&header->available) + readl_relaxed(&header->free_offset);
  1057		hwspin_unlock_irqrestore(smem->hwlock, &flags);
  1058	
  1059		version = qcom_smem_get_sbl_version(smem);
  1060		/*
  1061		 * smem header mapping is required only in heap version scheme, so unmap
  1062		 * it here. It will be remapped in qcom_smem_map_global() when whole
  1063		 * partition is mapped again.
  1064		 */
  1065		devm_iounmap(smem->dev, smem->regions[0].virt_base);
  1066		switch (version >> 16) {
  1067		case SMEM_GLOBAL_PART_VERSION:
  1068			ret = qcom_smem_set_global_partition(smem);
  1069			if (ret < 0)
  1070				return ret;
  1071			smem->item_count = qcom_smem_get_item_count(smem);
  1072			break;
  1073		case SMEM_GLOBAL_HEAP_VERSION:
  1074			qcom_smem_map_global(smem, size);
  1075			smem->item_count = SMEM_ITEM_COUNT;
  1076			break;
  1077		default:
  1078			dev_err(&pdev->dev, "Unsupported SMEM version 0x%x\n", version);
  1079			return -EINVAL;
  1080		}
  1081	
  1082		BUILD_BUG_ON(SMEM_HOST_APPS >= SMEM_HOST_COUNT);
  1083		ret = qcom_smem_enumerate_partitions(smem, SMEM_HOST_APPS);
  1084		if (ret < 0 && ret != -ENOENT)
  1085			return ret;
  1086	
  1087		__smem = smem;
  1088	
  1089		smem->socinfo = platform_device_register_data(&pdev->dev, "qcom-socinfo",
  1090							      PLATFORM_DEVID_NONE, NULL,
  1091							      0);
  1092		if (IS_ERR(smem->socinfo))
  1093			dev_dbg(&pdev->dev, "failed to register socinfo device\n");
  1094	
  1095		return 0;
  1096	}
  1097	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
