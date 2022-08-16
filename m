Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A53595462
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiHPIC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiHPIB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:01:58 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F313C9EBE
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660627335; x=1692163335;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=K8+ZieLx4LUwarMhkki7W5XlUpQB1fSOMaMTl6ZlIKA=;
  b=mPlncjHx3Wi4JSD+AGSA0nN1aoo6SiJVrnkRmK2i4+R+P/5ZS/ilmGh3
   U3mQSI6XHflolIhMOpHii6EliLiwJS4rd4NJ8zKMJXqlOsVMpnKjWT5QO
   dxGTPgcZEiGIES0DMyz2vDz7pEDvJ41zOucExXXxXQ54F+3rP3gC1lQY3
   dxDhS8aIVEO3ZR0nyJajviwTO3krrLENowzAqdZgOe/sWJQLhnNzIz2/m
   RcSvr3Ii/8RcePn4Xt7/rFWxotr0x6JUM5tmIPphM40oGJSJyZYHu+9hj
   Nd6bVicpZto2R48nMU8bTRrWe2mw+ZkO1dALKzn1RXIqDEesBMioH/SQU
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="293400780"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="293400780"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 22:22:14 -0700
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="583158661"
Received: from rongch2-desk.sh.intel.com (HELO localhost) ([10.239.159.175])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 22:22:13 -0700
Date:   Tue, 16 Aug 2022 13:22:11 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [broonie-misc:arm64-sysreg-gen-4 4/28]
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c:153:50: error: use of
 undeclared identifier 'ID_AA64MMFR0_PARANGE_SHIFT'
Message-ID: <Yvspg7zU0Mb8xyah@rongch2-desk2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git arm64-sysreg-gen-4
head:   36985fd29b63e897332d6d831d3aa03ea8722f3c
commit: e520c3303ffbf18b004d7cc16d60141def9bf675 [4/28] arm64/sysreg: Add _EL1 into ID_AA64MMFR0_EL1 definition names
config: arm64-randconfig-r022-20220815 (https://download.01.org/0day-ci/archive/20220816/202208161156.9HEoSNJb-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project aed5e3bea138ce581d682158eb61c27b3cfdd6ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git/commit/?id=e520c3303ffbf18b004d7cc16d60141def9bf675
        git remote add broonie-misc https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git
        git fetch --no-tags broonie-misc arm64-sysreg-gen-4
        git checkout e520c3303ffbf18b004d7cc16d60141def9bf675
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/iommu/arm/arm-smmu-v3/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c:153:50: error: use of undeclared identifier 'ID_AA64MMFR0_PARANGE_SHIFT'
           par = cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR0_PARANGE_SHIFT);
                                                           ^
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c:428:50: error: use of undeclared identifier 'ID_AA64MMFR0_PARANGE_SHIFT'
           fld = cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR0_PARANGE_SHIFT);
                                                           ^
>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c:434:50: error: use of undeclared identifier 'ID_AA64MMFR0_ASID_SHIFT'
           fld = cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR0_ASID_SHIFT);
                                                           ^
   3 errors generated.


vim +/ID_AA64MMFR0_PARANGE_SHIFT +153 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c

3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18   91  
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18   92  static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18   93  {
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18   94  	u16 asid;
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18   95  	int err = 0;
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18   96  	u64 tcr, par, reg;
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18   97  	struct arm_smmu_ctx_desc *cd;
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18   98  	struct arm_smmu_ctx_desc *ret = NULL;
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18   99  
cbd23144f7662b Jean-Philippe Brucker 2022-04-26  100  	/* Don't free the mm until we release the ASID */
cbd23144f7662b Jean-Philippe Brucker 2022-04-26  101  	mmgrab(mm);
cbd23144f7662b Jean-Philippe Brucker 2022-04-26  102  
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  103  	asid = arm64_mm_context_get(mm);
cbd23144f7662b Jean-Philippe Brucker 2022-04-26  104  	if (!asid) {
cbd23144f7662b Jean-Philippe Brucker 2022-04-26  105  		err = -ESRCH;
cbd23144f7662b Jean-Philippe Brucker 2022-04-26  106  		goto out_drop_mm;
cbd23144f7662b Jean-Philippe Brucker 2022-04-26  107  	}
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  108  
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  109  	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  110  	if (!cd) {
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  111  		err = -ENOMEM;
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  112  		goto out_put_context;
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  113  	}
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  114  
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  115  	refcount_set(&cd->refs, 1);
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  116  
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  117  	mutex_lock(&arm_smmu_asid_lock);
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  118  	ret = arm_smmu_share_asid(mm, asid);
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  119  	if (ret) {
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  120  		mutex_unlock(&arm_smmu_asid_lock);
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  121  		goto out_free_cd;
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  122  	}
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  123  
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  124  	err = xa_insert(&arm_smmu_asid_xa, asid, cd, GFP_KERNEL);
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  125  	mutex_unlock(&arm_smmu_asid_lock);
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  126  
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  127  	if (err)
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  128  		goto out_free_asid;
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  129  
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  130  	tcr = FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, 64ULL - vabits_actual) |
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  131  	      FIELD_PREP(CTXDESC_CD_0_TCR_IRGN0, ARM_LPAE_TCR_RGN_WBWA) |
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  132  	      FIELD_PREP(CTXDESC_CD_0_TCR_ORGN0, ARM_LPAE_TCR_RGN_WBWA) |
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  133  	      FIELD_PREP(CTXDESC_CD_0_TCR_SH0, ARM_LPAE_TCR_SH_IS) |
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  134  	      CTXDESC_CD_0_TCR_EPD1 | CTXDESC_CD_0_AA64;
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  135  
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  136  	switch (PAGE_SIZE) {
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  137  	case SZ_4K:
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  138  		tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0, ARM_LPAE_TCR_TG0_4K);
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  139  		break;
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  140  	case SZ_16K:
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  141  		tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0, ARM_LPAE_TCR_TG0_16K);
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  142  		break;
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  143  	case SZ_64K:
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  144  		tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0, ARM_LPAE_TCR_TG0_64K);
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  145  		break;
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  146  	default:
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  147  		WARN_ON(1);
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  148  		err = -EINVAL;
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  149  		goto out_free_asid;
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  150  	}
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  151  
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  152  	reg = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18 @153  	par = cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR0_PARANGE_SHIFT);
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  154  	tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_IPS, par);
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  155  
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  156  	cd->ttbr = virt_to_phys(mm->pgd);
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  157  	cd->tcr = tcr;
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  158  	/*
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  159  	 * MAIR value is pretty much constant and global, so we can just get it
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  160  	 * from the current CPU register
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  161  	 */
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  162  	cd->mair = read_sysreg(mair_el1);
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  163  	cd->asid = asid;
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  164  	cd->mm = mm;
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  165  
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  166  	return cd;
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  167  
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  168  out_free_asid:
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  169  	arm_smmu_free_asid(cd);
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  170  out_free_cd:
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  171  	kfree(cd);
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  172  out_put_context:
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  173  	arm64_mm_context_put(mm);
cbd23144f7662b Jean-Philippe Brucker 2022-04-26  174  out_drop_mm:
cbd23144f7662b Jean-Philippe Brucker 2022-04-26  175  	mmdrop(mm);
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  176  	return err < 0 ? ERR_PTR(err) : ret;
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  177  }
3f1ce8e85ee06d Jean-Philippe Brucker 2020-09-18  178  

:::::: The code at line 153 was first introduced by commit
:::::: 3f1ce8e85ee06dbe6a8b2e037e9b35f6b32e9ab3 iommu/arm-smmu-v3: Share process page tables

:::::: TO: Jean-Philippe Brucker <jean-philippe@linaro.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
