Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A019E584AC2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 06:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbiG2Ei1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 00:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiG2EiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 00:38:24 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A1574787
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 21:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659069502; x=1690605502;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rhlzq11oLePogUqQtdH7iufaNSrOtnG1PhzJIM+BMNE=;
  b=i1Cj1LBJyGMKv+lFtpr9YQzikplNwg84aVclGskfqrdEAcIVeF4Lwg7M
   7FqjTfi1EMds7N99subjKcza/VHks5aLlm/sWSHd4te2lFsGhEK4x0UO5
   AK3/vEgEu5BgiP41oF5AZ+QIl4vqwoumulmnmqY3/teS8uIF3uI7lAIyh
   oPUDvbBJ3N/BEuiW+8N3U5cbq6bOecrre3AX5HsOadmzCbsg0Oj7r6IQQ
   95+kl+EGvH0j6jZncc1vOimNc69Oo0/HyMNjYa5QF/U+IXOU4F74U9HDq
   grSIDtJTNspvz1RWjH4eLlwKrE9JNqs7VpM7TP+ew4AAulZXQQ2X51PUK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="271729413"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="271729413"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 21:38:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="669147314"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jul 2022 21:38:20 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHHlT-000B6E-32;
        Fri, 29 Jul 2022 04:38:19 +0000
Date:   Fri, 29 Jul 2022 12:38:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manisha Chinthapally <manisha.chinthapally@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Faycal Benmlih <faycal.benmlih@intel.com>
Subject: drivers/platform/x86/socperf/haswellunc_sa.c:203:39: sparse: sparse:
 cast removes address space '__iomem' of expression
Message-ID: <202207291223.XKAecRuS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/mchinth/linux sep_socwatch_linux_5_10
head:   c55df4a2b60fc7c6c4d00fd9f9fb447087833513
commit: 4a8adda8065c4c6944ffedd3025605c845c262a5 SEP/SOCWATCH resolve build errors after rebasing to linux v5.6-rc3
date:   1 year, 10 months ago
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220729/202207291223.XKAecRuS-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/mchinth/linux/commit/4a8adda8065c4c6944ffedd3025605c845c262a5
        git remote add mchinth https://github.com/mchinth/linux
        git fetch --no-tags mchinth sep_socwatch_linux_5_10
        git checkout 4a8adda8065c4c6944ffedd3025605c845c262a5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/platform/x86/socperf/haswellunc_sa.c:203:39: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/platform/x86/socperf/haswellunc_sa.c:395:10: sparse: sparse: Initializer entry defined twice
   drivers/platform/x86/socperf/haswellunc_sa.c:399:10: sparse:   also defined here
--
>> drivers/platform/x86/socperf/soc_uncore.c:756:47: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/platform/x86/socperf/soc_uncore.c:889:10: sparse: sparse: Initializer entry defined twice
   drivers/platform/x86/socperf/soc_uncore.c:893:10: sparse:   also defined here
--
>> drivers/platform/x86/socperf/npk_uncore.c:292:39: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/platform/x86/socperf/npk_uncore.c:492:10: sparse: sparse: Initializer entry defined twice
   drivers/platform/x86/socperf/npk_uncore.c:496:10: sparse:   also defined here
--
>> drivers/platform/x86/socwatch/sw_telem.c:239:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/platform/x86/socwatch/sw_telem.c:242:28: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/platform/x86/socwatch/sw_telem.c:245:58: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/platform/x86/socwatch/sw_telem.c:260:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned long long volatile [usertype] *static [assigned] [toplevel] s_punitInterfaceAddr @@
   drivers/platform/x86/socwatch/sw_telem.c:260:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/platform/x86/socwatch/sw_telem.c:260:25: sparse:     got unsigned long long volatile [usertype] *static [assigned] [toplevel] s_punitInterfaceAddr
   drivers/platform/x86/socwatch/sw_telem.c:264:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned long long volatile [usertype] *static [assigned] [toplevel] s_punitDataAddr @@
   drivers/platform/x86/socwatch/sw_telem.c:264:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/platform/x86/socwatch/sw_telem.c:264:25: sparse:     got unsigned long long volatile [usertype] *static [assigned] [toplevel] s_punitDataAddr
>> drivers/platform/x86/socwatch/sw_telem.c:268:54: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned long long volatile [usertype] *ssram_virt_addr @@
   drivers/platform/x86/socwatch/sw_telem.c:268:54: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/platform/x86/socwatch/sw_telem.c:268:54: sparse:     got unsigned long long volatile [usertype] *ssram_virt_addr
   drivers/platform/x86/socwatch/sw_telem.c:280:28: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/platform/x86/socwatch/sw_telem.c:283:28: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/platform/x86/socwatch/sw_telem.c:286:29: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/platform/x86/socwatch/sw_telem.c:289:29: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/platform/x86/socwatch/sw_telem.c:292:56: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/platform/x86/socwatch/sw_telem.c:307:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned long long volatile [usertype] *static [assigned] [toplevel] s_pmcIPCCmdAddr @@
   drivers/platform/x86/socwatch/sw_telem.c:307:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/platform/x86/socwatch/sw_telem.c:307:25: sparse:     got unsigned long long volatile [usertype] *static [assigned] [toplevel] s_pmcIPCCmdAddr
   drivers/platform/x86/socwatch/sw_telem.c:311:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned long long volatile [usertype] *static [assigned] [toplevel] s_pmcIPCStsAddr @@
   drivers/platform/x86/socwatch/sw_telem.c:311:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/platform/x86/socwatch/sw_telem.c:311:25: sparse:     got unsigned long long volatile [usertype] *static [assigned] [toplevel] s_pmcIPCStsAddr
   drivers/platform/x86/socwatch/sw_telem.c:315:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned long long volatile [usertype] *static [assigned] [toplevel] s_pmcIPCWBufAddr @@
   drivers/platform/x86/socwatch/sw_telem.c:315:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/platform/x86/socwatch/sw_telem.c:315:25: sparse:     got unsigned long long volatile [usertype] *static [assigned] [toplevel] s_pmcIPCWBufAddr
   drivers/platform/x86/socwatch/sw_telem.c:319:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned long long volatile [usertype] *static [assigned] [toplevel] s_pmcIPCRBufAddr @@
   drivers/platform/x86/socwatch/sw_telem.c:319:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/platform/x86/socwatch/sw_telem.c:319:25: sparse:     got unsigned long long volatile [usertype] *static [assigned] [toplevel] s_pmcIPCRBufAddr
   drivers/platform/x86/socwatch/sw_telem.c:323:52: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned long long volatile [usertype] *ssram_virt_addr @@
   drivers/platform/x86/socwatch/sw_telem.c:323:52: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/platform/x86/socwatch/sw_telem.c:323:52: sparse:     got unsigned long long volatile [usertype] *ssram_virt_addr
>> drivers/platform/x86/socwatch/sw_telem.c:671:5: sparse: sparse: symbol 'read_telem' was not declared. Should it be static?
--
>> drivers/platform/x86/socwatch/sw_trace_notifier_provider.c:1634:67: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int flags @@     got restricted gfp_t @@
   drivers/platform/x86/socwatch/sw_trace_notifier_provider.c:1634:67: sparse:     expected unsigned int flags
   drivers/platform/x86/socwatch/sw_trace_notifier_provider.c:1634:67: sparse:     got restricted gfp_t

vim +/__iomem +203 drivers/platform/x86/socperf/haswellunc_sa.c

    71	
    72	/*!
    73	 * @fn          static VOID hswunc_sa_Write_PMU(VOID*)
    74	 *
    75	 * @brief       Initial write of PMU registers
    76	 *              Walk through the entries and write the value of the register accordingly.
    77	 *              When current_group = 0, then this is the first time this routine is called,
    78	 *
    79	 * @param       param - device index
    80	 *
    81	 * @return      None
    82	 *
    83	 * <I>Special Notes:</I>
    84	 */
    85	static VOID hswunc_sa_Write_PMU(VOID *param)
    86	{
    87		U32 dev_idx = *((U32 *)param);
    88		U32 cur_grp = LWPMU_DEVICE_cur_group(device_uncore);
    89		ECB pecb = LWPMU_DEVICE_PMU_register_data(device_uncore)[cur_grp];
    90		DRV_PCI_DEVICE_ENTRY dpden;
    91		U32 pci_address;
    92		U32 bar_lo;
    93		U64 bar_hi;
    94		U64 final_bar;
    95		U64 physical_address;
    96		U32 dev_index = 0;
    97		S32 bar_list[HSWUNC_SA_MAX_PCI_DEVICES];
    98		U32 bar_index = 0;
    99		U64 gdxc_bar = 0;
   100		U32 map_size = 0;
   101		U64 virtual_address = 0;
   102		U64 mmio_offset = 0;
   103		U32 bar_name = 0;
   104		DRV_PCI_DEVICE_ENTRY curr_pci_entry = NULL;
   105		U32 next_bar_offset = 0;
   106		U32 i = 0;
   107	
   108		for (dev_index = 0; dev_index < HSWUNC_SA_MAX_PCI_DEVICES;
   109		     dev_index++) {
   110			bar_list[dev_index] = -1;
   111		}
   112	
   113		device_id = dev_idx;
   114		// initialize the CHAP per-counter overflow numbers
   115		for (i = 0; i < HSWUNC_SA_MAX_COUNTERS; i++) {
   116			counter_overflow[i] = 0;
   117			socperf_pcb[0].last_uncore_count[i] = 0;
   118		}
   119	
   120		ECB_pcidev_entry_list(pecb) = (DRV_PCI_DEVICE_ENTRY)(
   121			(S8 *)pecb + ECB_pcidev_list_offset(pecb));
   122		dpden = ECB_pcidev_entry_list(pecb);
   123	
   124		if (counter_virtual_address) {
   125			for (i = 0; i < ECB_num_entries(pecb); i++) {
   126				writel(HSWUNC_SA_CHAP_STOP,
   127				       (void __iomem *)(((char *)(UIOP)counter_virtual_address) +
   128					       HSWUNC_SA_CHAP_CTRL_REG_OFFSET +
   129					       i * 0x10));
   130			}
   131		}
   132	
   133		for (dev_index = 0; dev_index < ECB_num_pci_devices(pecb);
   134		     dev_index++) {
   135			curr_pci_entry = &dpden[dev_index];
   136			mmio_offset = DRV_PCI_DEVICE_ENTRY_base_offset_for_mmio(
   137				curr_pci_entry);
   138			bar_name = DRV_PCI_DEVICE_ENTRY_bar_name(curr_pci_entry);
   139			if (DRV_PCI_DEVICE_ENTRY_config_type(curr_pci_entry) ==
   140			    UNC_PCICFG) {
   141				pci_address = FORM_PCI_ADDR(
   142					DRV_PCI_DEVICE_ENTRY_bus_no(curr_pci_entry),
   143					DRV_PCI_DEVICE_ENTRY_dev_no(curr_pci_entry),
   144					DRV_PCI_DEVICE_ENTRY_func_no(curr_pci_entry),
   145					mmio_offset);
   146				SOCPERF_PCI_Write_Ulong(
   147					pci_address,
   148					DRV_PCI_DEVICE_ENTRY_value(curr_pci_entry));
   149				continue;
   150			}
   151			// UNC_MMIO programming
   152			if (bar_list[bar_name] != -1) {
   153				bar_index = bar_list[bar_name];
   154				virtual_address = DRV_PCI_DEVICE_ENTRY_virtual_address(
   155					&dpden[bar_index]);
   156				DRV_PCI_DEVICE_ENTRY_virtual_address(curr_pci_entry) =
   157					DRV_PCI_DEVICE_ENTRY_virtual_address(
   158						&dpden[bar_index]);
   159				writel(DRV_PCI_DEVICE_ENTRY_value(curr_pci_entry),
   160				       (void __iomem *)(((char *)(UIOP)virtual_address) +
   161					       mmio_offset));
   162				continue;
   163			}
   164			if (bar_name == UNC_GDXCBAR) {
   165				DRV_PCI_DEVICE_ENTRY_bar_address(curr_pci_entry) =
   166					gdxc_bar;
   167			} else {
   168				pci_address = FORM_PCI_ADDR(
   169					DRV_PCI_DEVICE_ENTRY_bus_no(curr_pci_entry),
   170					DRV_PCI_DEVICE_ENTRY_dev_no(curr_pci_entry),
   171					DRV_PCI_DEVICE_ENTRY_func_no(curr_pci_entry),
   172					DRV_PCI_DEVICE_ENTRY_bar_offset(
   173						curr_pci_entry));
   174				bar_lo = SOCPERF_PCI_Read_Ulong(pci_address);
   175				next_bar_offset = DRV_PCI_DEVICE_ENTRY_bar_offset(
   176							  curr_pci_entry) +
   177						  HSWUNC_SA_NEXT_ADDR_OFFSET;
   178				pci_address = FORM_PCI_ADDR(
   179					DRV_PCI_DEVICE_ENTRY_bus_no(curr_pci_entry),
   180					DRV_PCI_DEVICE_ENTRY_dev_no(curr_pci_entry),
   181					DRV_PCI_DEVICE_ENTRY_func_no(curr_pci_entry),
   182					next_bar_offset);
   183				bar_hi = SOCPERF_PCI_Read_Ulong(pci_address);
   184				final_bar =
   185					(bar_hi << HSWUNC_SA_BAR_ADDR_SHIFT) | bar_lo;
   186				final_bar &= HSWUNC_SA_BAR_ADDR_MASK;
   187	
   188				DRV_PCI_DEVICE_ENTRY_bar_address(curr_pci_entry) =
   189					final_bar;
   190			}
   191			physical_address =
   192				DRV_PCI_DEVICE_ENTRY_bar_address(curr_pci_entry);
   193	
   194			if (physical_address) {
   195				if (bar_name == UNC_MCHBAR) {
   196					map_size = HSWUNC_SA_MCHBAR_MMIO_PAGE_SIZE;
   197				} else if (bar_name == UNC_PCIEXBAR) {
   198					map_size = HSWUNC_SA_PCIEXBAR_MMIO_PAGE_SIZE;
   199				} else {
   200					map_size = HSWUNC_SA_OTHER_BAR_MMIO_PAGE_SIZE;
   201				}
   202				DRV_PCI_DEVICE_ENTRY_virtual_address(curr_pci_entry) =
 > 203					(U64)(UIOP)ioremap_cache(physical_address,
   204								   map_size);
   205				virtual_address = DRV_PCI_DEVICE_ENTRY_virtual_address(
   206					curr_pci_entry);
   207	
   208				if (!gdxc_bar && bar_name == UNC_MCHBAR) {
   209					bar_lo = readl(
   210						(void __iomem *)((char *)(UIOP)virtual_address +
   211							HSWUNC_SA_GDXCBAR_OFFSET_LO));
   212					bar_hi = readl(
   213						(void __iomem *)((char *)(UIOP)virtual_address +
   214							HSWUNC_SA_GDXCBAR_OFFSET_HI));
   215					gdxc_bar =
   216						(bar_hi << HSWUNC_SA_BAR_ADDR_SHIFT) |
   217						bar_lo;
   218					gdxc_bar = gdxc_bar & HSWUNC_SA_GDXCBAR_MASK;
   219				}
   220				writel((U32)DRV_PCI_DEVICE_ENTRY_value(curr_pci_entry),
   221				       (void __iomem *)(((char *)(UIOP)virtual_address) +
   222					       mmio_offset));
   223				bar_list[bar_name] = dev_index;
   224				if (counter_virtual_address == 0 &&
   225				    bar_name == UNC_CHAPADR) {
   226					counter_virtual_address = virtual_address;
   227				}
   228			}
   229		}
   230	}
   231	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
