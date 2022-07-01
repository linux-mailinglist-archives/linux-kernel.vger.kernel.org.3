Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C48562A22
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 06:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbiGAEFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 00:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbiGAEEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 00:04:48 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F28158FED
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 21:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656648265; x=1688184265;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=N3pvokvMH92I8+53HfMkTQ9+k3C9B6WGw6+M5M0MdWQ=;
  b=a439xcqyfdPUizreUwvYBjjyLmMTwMnvJH+O2AgCmtvdqZjIxunCT0rM
   oO/15dtP5WGFBdJjPb0yWel5pYMaFMEesFMY2nUnB1MYIZaTqfeRu8ij5
   C5hTXEC3K8wdj0r/YnBeEHFxg7xv3P1XCzACgvhSwHUDcUmfq4uRoLe7P
   Dyj7lv6sEo5enpsH8i3RZMFmCKnA2bGlZpX0PccBKUcxq8LdRaPEJYwsm
   4gmr2Qt7IcERRfRK+vbpkyhL9l9275E7CHwVsOUUWfFZ6leUbcN/mJO3w
   GuNNU39PXeToCGdDdGFEpxf7u38JC0czUcorWAKAFc/dR8YlmHsfjQ4Tv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="368862612"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="368862612"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 21:04:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="694342604"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 30 Jun 2022 21:04:23 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o77tH-000DW3-BD;
        Fri, 01 Jul 2022 04:04:23 +0000
Date:   Fri, 1 Jul 2022 12:04:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ogabbay:habanalabs-next 52/61]
 drivers/misc/habanalabs/gaudi2/gaudi2.c:1821: undefined reference to
 `__udivdi3'
Message-ID: <202207011105.yOohE2qe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git habanalabs-next
head:   5e0af3d63d4c6ac96a1190a5c888796a6b599f83
commit: 349d6e1f6e46812a35bf57c9917cccbb31ba5a1a [52/61] habanalabs: add gaudi2 asic-specific code
config: m68k-randconfig-r021-20220629 (https://download.01.org/0day-ci/archive/20220701/202207011105.yOohE2qe-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/commit/?id=349d6e1f6e46812a35bf57c9917cccbb31ba5a1a
        git remote add ogabbay https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
        git fetch --no-tags ogabbay habanalabs-next
        git checkout 349d6e1f6e46812a35bf57c9917cccbb31ba5a1a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/misc/habanalabs/gaudi2/gaudi2.o: in function `gaudi2_set_dram_properties':
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:1821: undefined reference to `__udivdi3'


vim +1821 drivers/misc/habanalabs/gaudi2/gaudi2.c

  1774	
  1775	static int gaudi2_set_dram_properties(struct hl_device *hdev)
  1776	{
  1777		struct asic_fixed_properties *prop = &hdev->asic_prop;
  1778		u32 basic_hbm_page_size;
  1779		int rc;
  1780	
  1781		rc = set_number_of_functional_hbms(hdev);
  1782		if (rc)
  1783			return -EINVAL;
  1784	
  1785		/*
  1786		 * Due to HW bug in which TLB size is x16 smaller than expected we use a workaround
  1787		 * in which we are using x16 bigger page size to be able to populate the entire
  1788		 * HBM mappings in the TLB
  1789		 */
  1790		basic_hbm_page_size = prop->num_functional_hbms * SZ_8M;
  1791		prop->dram_page_size = GAUDI2_COMPENSATE_TLB_PAGE_SIZE_FACTOR * basic_hbm_page_size;
  1792		prop->device_mem_alloc_default_page_size = prop->dram_page_size;
  1793		prop->dram_size = prop->num_functional_hbms * SZ_16G;
  1794		prop->dram_base_address = DRAM_PHYS_BASE;
  1795		prop->dram_end_address = prop->dram_base_address + prop->dram_size;
  1796		prop->dram_supports_virtual_memory = true;
  1797	
  1798		prop->dram_user_base_address = DRAM_PHYS_BASE + prop->dram_page_size;
  1799		prop->dram_hints_align_mask = ~GAUDI2_HBM_MMU_SCRM_ADDRESS_MASK;
  1800		prop->hints_dram_reserved_va_range.start_addr = RESERVED_VA_RANGE_FOR_ARC_ON_HBM_START;
  1801		prop->hints_dram_reserved_va_range.end_addr = RESERVED_VA_RANGE_FOR_ARC_ON_HBM_END;
  1802	
  1803		/* since DRAM page size differs from dmmu page size we need to allocate
  1804		 * DRAM memory in units of dram_page size and mapping this memory in
  1805		 * units of DMMU page size. we overcome this size mismatch using a
  1806		 * scarmbling routine which takes a DRAM page and converts it to a DMMU
  1807		 * page.
  1808		 * We therefore:
  1809		 * 1. partition the virtual address space to DRAM-page (whole) pages.
  1810		 *    (suppose we get n such pages)
  1811		 * 2. limit the amount of virtual address space we got from 1 above to
  1812		 *    a multiple of 64M as we don't want the scrambled address to cross
  1813		 *    the DRAM virtual address space.
  1814		 *    ( m = (n * DRAM_page_size) / DMMU_page_size).
  1815		 * 3. determine the and address accordingly
  1816		 *    end_addr = start_addr + m * 48M
  1817		 *
  1818		 *    the DRAM address MSBs (63:48) are not part of the roundup calculation
  1819		 */
  1820		prop->dmmu.start_addr = prop->dram_base_address +
> 1821				roundup(prop->dram_size, prop->dram_page_size);
  1822	
  1823		prop->dmmu.end_addr = prop->dmmu.start_addr + prop->dram_page_size *
  1824				div_u64((VA_HBM_SPACE_END - prop->dmmu.start_addr), prop->dmmu.page_size);
  1825	
  1826		return 0;
  1827	}
  1828	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
