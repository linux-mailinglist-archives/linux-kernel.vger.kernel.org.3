Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2840C47C90D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 23:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbhLUWGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 17:06:22 -0500
Received: from mga18.intel.com ([134.134.136.126]:19672 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232718AbhLUWGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 17:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640124381; x=1671660381;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KPZ4mv0LVqKp4kq8Y50o8kISDEDGH4UHveq/86WrLV8=;
  b=K2u5BQLz80HpcVuvrKw+wnfCb68VSKkWc1wE6LenEh/RKit7RleNROw2
   3i/3Shd3IkhOExbk8q8xGxlH3gZIc4SRj2o57ykxg8mhliOGdup0sEAEb
   M5WCIx5El5ZAbsjy38U+tepAB5+A3LDpAXybt1NJuF5WQ+VRv1OhUswcM
   jfnkablYxSBDMmkUNRlnc/O9zuSaipbFt/bpa+WsxV2VmRjt4k1x44s7u
   Df2DBPUEqKjKc5O8AOcrT5B0ppRnWMgYSaOvOnPbh0qvSfHfdab5SyGLX
   RiwXljP3O8mEakTSRTcluUDefvnRK/sqWVi2GT5MNFWTbutxBPN0ThNQg
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="227350998"
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="227350998"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 14:06:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="684808314"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 21 Dec 2021 14:06:18 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mznH0-0009aV-7f; Tue, 21 Dec 2021 22:06:18 +0000
Date:   Wed, 22 Dec 2021 06:06:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Siddharth Gupta <sidgup@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Gurbir Arora <gurbaror@codeaurora.org>
Subject: drivers/remoteproc/qcom_common.c:126:27: sparse: sparse: restricted
 __le32 degrades to integer
Message-ID: <202112220526.KTdwXzJq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6e0567b7305209c2d689ce57180a63d8dc657ad8
commit: 8ed8485c4f056d488d17a2b56581c86aeb42955d remoteproc: qcom: Add capability to collect minidumps
date:   1 year ago
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20211222/202112220526.KTdwXzJq-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8ed8485c4f056d488d17a2b56581c86aeb42955d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8ed8485c4f056d488d17a2b56581c86aeb42955d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mach-imx/ arch/arm/mach-mvebu/ arch/arm/mach-rockchip/ arch/arm/mach-socfpga/ arch/arm/mach-tegra/ drivers/dma/ drivers/edac/ drivers/gpu/drm/msm/ drivers/gpu/drm/tegra/ drivers/interconnect/qcom/ drivers/irqchip/ drivers/mtd/nand/onenand/ drivers/net/ethernet/mediatek/ drivers/net/vmxnet3/ drivers/net/wireless/mediatek/mt76/mt7915/ drivers/remoteproc/ drivers/scsi/bnx2fc/ drivers/scsi/lpfc/ drivers/soc/bcm/brcmstb/pm/ drivers/staging/ fs/proc/ net/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/remoteproc/qcom_common.c:126:27: sparse: sparse: restricted __le32 degrades to integer
>> drivers/remoteproc/qcom_common.c:133:32: sparse: sparse: cast to restricted __le32
>> drivers/remoteproc/qcom_common.c:133:32: sparse: sparse: cast from restricted __le64
>> drivers/remoteproc/qcom_common.c:133:32: sparse: sparse: cast to restricted __le32
>> drivers/remoteproc/qcom_common.c:133:32: sparse: sparse: cast from restricted __le64
>> drivers/remoteproc/qcom_common.c:133:32: sparse: sparse: cast to restricted __le32
>> drivers/remoteproc/qcom_common.c:133:32: sparse: sparse: cast from restricted __le64
>> drivers/remoteproc/qcom_common.c:133:32: sparse: sparse: cast to restricted __le32
>> drivers/remoteproc/qcom_common.c:133:32: sparse: sparse: cast from restricted __le64
>> drivers/remoteproc/qcom_common.c:133:32: sparse: sparse: cast to restricted __le32
>> drivers/remoteproc/qcom_common.c:133:32: sparse: sparse: cast from restricted __le64
>> drivers/remoteproc/qcom_common.c:133:32: sparse: sparse: cast to restricted __le32
>> drivers/remoteproc/qcom_common.c:133:32: sparse: sparse: cast from restricted __le64

vim +126 drivers/remoteproc/qcom_common.c

   103	
   104	static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsystem *subsystem)
   105	{
   106		struct minidump_region __iomem *ptr;
   107		struct minidump_region region;
   108		int seg_cnt, i;
   109		dma_addr_t da;
   110		size_t size;
   111		char *name;
   112	
   113		if (WARN_ON(!list_empty(&rproc->dump_segments))) {
   114			dev_err(&rproc->dev, "dump segment list already populated\n");
   115			return -EUCLEAN;
   116		}
   117	
   118		seg_cnt = le32_to_cpu(subsystem->region_count);
   119		ptr = ioremap((unsigned long)le64_to_cpu(subsystem->regions_baseptr),
   120			      seg_cnt * sizeof(struct minidump_region));
   121		if (!ptr)
   122			return -EFAULT;
   123	
   124		for (i = 0; i < seg_cnt; i++) {
   125			memcpy_fromio(&region, ptr + i, sizeof(region));
 > 126			if (region.valid == MD_REGION_VALID) {
   127				name = kstrdup(region.name, GFP_KERNEL);
   128				if (!name) {
   129					iounmap(ptr);
   130					return -ENOMEM;
   131				}
   132				da = le64_to_cpu(region.address);
 > 133				size = le32_to_cpu(region.size);
   134				rproc_coredump_add_custom_segment(rproc, da, size, NULL, name);
   135			}
   136		}
   137	
   138		iounmap(ptr);
   139		return 0;
   140	}
   141	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
