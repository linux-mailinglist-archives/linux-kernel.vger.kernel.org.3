Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A833D4714F8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 18:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhLKRiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 12:38:50 -0500
Received: from mga18.intel.com ([134.134.136.126]:53421 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229531AbhLKRiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 12:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639244330; x=1670780330;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=A/B2eQjtkc/m1I/GZTBTF5k/jS3vko8y2Bhw59I95JU=;
  b=UGApUHsdl89xTP5PEc6HMNJd9u631xPWh7ciy9gdVtNZBRaykGHWJS18
   ur8h1B7uOtIfgWbLv7cftaZ//bTHr/C139myWamZNAxBbsWZdoOXqMPKG
   vZIkuccUhXCQF7AagsvMrWfitzZFQOPFZyuRxm7BKlDRUXuM5pFfYTcMS
   xF7/s7UMi9adlasSn1oVXieH3vfQcaO3GCNwOe8To9u3p+Mh0s3XUrq+Z
   sQdya1qNsKJaT/6geDOx7YXfI/JS2F6NKyZKgDeDYUJqnvWIZkakfmi+g
   vbkQ/mTMKllzHj6aRDSXKQfH+Zi1Mfjc4mRVl/LGtIO7xtp3Gvm4WSnXn
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10195"; a="225412377"
X-IronPort-AV: E=Sophos;i="5.88,198,1635231600"; 
   d="scan'208";a="225412377"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2021 09:38:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,198,1635231600"; 
   d="scan'208";a="481071645"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 11 Dec 2021 09:38:48 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mw6Kd-0004sX-Ax; Sat, 11 Dec 2021 17:38:47 +0000
Date:   Sun, 12 Dec 2021 01:38:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Siddharth Gupta <sidgup@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Gurbir Arora <gurbaror@codeaurora.org>
Subject: drivers/remoteproc/qcom_common.c:126:27: sparse: sparse: restricted
 __le32 degrades to integer
Message-ID: <202112120130.DAViXMnZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6f513529296fd4f696afb4354c46508abe646541
commit: 8ed8485c4f056d488d17a2b56581c86aeb42955d remoteproc: qcom: Add capability to collect minidumps
date:   1 year ago
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20211212/202112120130.DAViXMnZ-lkp@intel.com/config)
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
