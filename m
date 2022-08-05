Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE5258AE40
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 18:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240964AbiHEQhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 12:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240791AbiHEQha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 12:37:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F20179681;
        Fri,  5 Aug 2022 09:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659717448; x=1691253448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h+XoiT91vZAlUqfEqVhh9See8InxvMKKYGhctLhARco=;
  b=ahBBkBghFnIvyRRqO9xoM+bEUSnnVtCcGqIZcfXoDxdXJuar7FG4CWAN
   J/qn2iT3OlW55vbnwJKt1cqEdx/muVk000Z48h95itmegLAdyZjJtI1Et
   Ab/eB4mkm4nLO+NCygGNYvCDYFyNkq9JVqaXEnvSpK/vPKNfxUHUip3dg
   P6iZnJw+peojJrE69W5mSPuteCUoaUW8+aB43XhUjf4HKG8he3oOJn9lR
   82pWuU3CIO4Cb3xRKM28Is5g5ftjUvloCm9KjEtZBUKEZ7+GpvTChq30e
   zlqsgFl7ndfbbqRzrqgEWTJduiPv1THfW+NEfQElXVHOMS4OegGMfbAMa
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="277162816"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="277162816"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 09:37:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="554157911"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 05 Aug 2022 09:37:25 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oK0KC-000JYN-2F;
        Fri, 05 Aug 2022 16:37:24 +0000
Date:   Sat, 6 Aug 2022 00:36:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jianmin Lv <lvjianmin@loongson.cn>, lpieralisi@kernel.org,
        robin.murphy@arm.com, guohanjun@huawei.com, sudeep.holla@arm.com,
        rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH V2 2/2] LoongArch: Remove ARCH_HAS_PHYS_TO_DMA
Message-ID: <202208060021.6kjospL6-lkp@intel.com>
References: <1659684674-40612-3-git-send-email-lvjianmin@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1659684674-40612-3-git-send-email-lvjianmin@loongson.cn>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianmin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on linus/master v5.19 next-20220804]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jianmin-Lv/DMA-update-acpi_dma_get_range-to-return-dma-map-regions/20220805-153307
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: loongarch-randconfig-r011-20220805 (https://download.01.org/0day-ci/archive/20220806/202208060021.6kjospL6-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/30f8fbc6b485f30e8533a7848a4ad9a2e1351be8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jianmin-Lv/DMA-update-acpi_dma_get_range-to-return-dma-map-regions/20220805-153307
        git checkout 30f8fbc6b485f30e8533a7848a4ad9a2e1351be8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash arch/loongarch/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/loongarch/kernel/dma.c:8:6: warning: no previous prototype for 'acpi_arch_dma_setup' [-Wmissing-prototypes]
       8 | void acpi_arch_dma_setup(struct device *dev)
         |      ^~~~~~~~~~~~~~~~~~~


vim +/acpi_arch_dma_setup +8 arch/loongarch/kernel/dma.c

     7	
   > 8	void acpi_arch_dma_setup(struct device *dev)
     9	{
    10		int ret;
    11		const struct bus_dma_region *map = NULL;
    12	
    13		ret = acpi_dma_get_range(dev, &map);
    14		if (!ret) {
    15			const struct bus_dma_region *r = map;
    16			u64 mask, dma_start, dma_end = 0;
    17	
    18			/* determine the overall bounds of all dma regions */
    19			for (dma_start = U64_MAX; r->size; r++) {
    20	
    21				/* Take lower and upper limits */
    22				if (r->dma_start < dma_start)
    23					dma_start = r->dma_start;
    24				if (r->dma_start + r->size - 1 > dma_end)
    25					dma_end = r->dma_start + r->size - 1;
    26			}
    27	
    28			if (dma_start >= dma_end) {
    29				dev_dbg(dev, "Invalid DMA regions configuration\n");
    30				return;
    31			}
    32	
    33			mask = DMA_BIT_MASK(ilog2(dma_end) + 1);
    34			dev->bus_dma_limit = dma_end;
    35			dev->dma_range_map = map;
    36			dev->coherent_dma_mask = min(dev->coherent_dma_mask, mask);
    37			*dev->dma_mask = min(*dev->dma_mask, mask);
    38		}
    39	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
