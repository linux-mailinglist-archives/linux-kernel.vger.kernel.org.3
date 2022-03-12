Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F904D6F9F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 16:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiCLPLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 10:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiCLPLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 10:11:39 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFE271EC8
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 07:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647097833; x=1678633833;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QwnU73SKGxv90bFeR3kPYdo+JxFder4HzAABlCz+DZY=;
  b=n4k2VxL4b3xPZhmZ45/cHN+5FerNDqylq6vg6wtNV+ZQAKrYO1IG0BSG
   BBp64UDsA+2dsoHUML3nX24bPjJ5wF6R9se+WxNskkDUymATtikrsz11D
   Q1ZCcS3NZ+B2V9cTifJrIJYnHGfpx+rR9jaYh5M+7q8nzH2UxcEsnnfO3
   I1j8RV0G5Q/c1Ow3cEBFxUqEh1apEP7s8nL765tWOx5GJEvxuc4Ij/ARI
   VcVJgng29fzqj3ln2EFi3VJiKVwDkqXE1OcQWA/smJsOys/xbGOvT1DWt
   dvs2UnkDfZDQ/cUcwzTWjelkzpKnKGGGjzh1y4mXw++Ws+UskT12DL/fV
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="254629217"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="254629217"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 07:10:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="645279576"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 12 Mar 2022 07:10:31 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nT3O2-0007zI-CW; Sat, 12 Mar 2022 15:10:30 +0000
Date:   Sat, 12 Mar 2022 23:09:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Siddharth Gupta <sidgup@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Gurbir Arora <gurbaror@codeaurora.org>
Subject: drivers/remoteproc/qcom_common.c:126:27: sparse: sparse: restricted
 __le32 degrades to integer
Message-ID: <202203122312.Oo7An9yZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   68453767131a5deec1e8f9ac92a9042f929e585d
commit: 8ed8485c4f056d488d17a2b56581c86aeb42955d remoteproc: qcom: Add capability to collect minidumps
date:   1 year, 3 months ago
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220312/202203122312.Oo7An9yZ-lkp@intel.com/config)
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
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
