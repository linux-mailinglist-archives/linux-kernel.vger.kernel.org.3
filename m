Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEF05815C1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239455AbiGZOz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiGZOzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:55:25 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF25658C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658847324; x=1690383324;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wn8e8KCvRzafgXr80WcTByiuKg9S4gxOvsVn+kudM8M=;
  b=UQ5gkYWjRLK+qmyrb42HrrJf9JzPkeVSmcyBTU3jnxQHRONpEXeZbytD
   J6PTqZjTQiobi338vhOns5Ojbs8HISdHOBfdaEmF942qq8iWP/OYUx+OK
   rcNTZv+6lLYjgljNUOKmWEWCTyH85HJW0PfFx2Ed1LO5ZqcwN0W7ajuYP
   Pz9xPBgVxako5WAzCrG7RDNBfa3kjmwM28s2PDQhhkRPlTUCDkJziyg7v
   gnYPRv6yXgYU/kIED2l9IT+FBB7xcjcNxNs/eK1U98r/+pmGuBNYGmuBU
   0cy5F2smStBnC60mQZnZ8twu5ZqSfRreuWgjVKMYS9N37ghZT324WFZ0Z
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="349673713"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="349673713"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 07:55:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="550430803"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 26 Jul 2022 07:55:23 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGLxy-0006z6-0t;
        Tue, 26 Jul 2022 14:55:22 +0000
Date:   Tue, 26 Jul 2022 22:55:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manisha Chinthapally <manisha.chinthapally@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Faycal Benmlih <faycal.benmlih@intel.com>
Subject: drivers/platform/x86/socperf/soc_uncore.c:756:47: sparse: sparse:
 cast removes address space '__iomem' of expression
Message-ID: <202207262235.TSKOSTSL-lkp@intel.com>
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

tree:   https://github.com/mchinth/linux sep_socwatch_linux_5_10
head:   c55df4a2b60fc7c6c4d00fd9f9fb447087833513
commit: 4a8adda8065c4c6944ffedd3025605c845c262a5 SEP/SOCWATCH resolve build errors after rebasing to linux v5.6-rc3
date:   1 year, 10 months ago
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220726/202207262235.TSKOSTSL-lkp@intel.com/config)
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
>> drivers/platform/x86/socperf/soc_uncore.c:756:47: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/platform/x86/socperf/soc_uncore.c:889:10: sparse: sparse: Initializer entry defined twice
   drivers/platform/x86/socperf/soc_uncore.c:893:10: sparse:   also defined here
--
>> drivers/platform/x86/socperf/haswellunc_sa.c:203:39: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/platform/x86/socperf/haswellunc_sa.c:395:10: sparse: sparse: Initializer entry defined twice
   drivers/platform/x86/socperf/haswellunc_sa.c:399:10: sparse:   also defined here
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

vim +/__iomem +756 drivers/platform/x86/socperf/soc_uncore.c

   674	
   675	/* ------------------------------------------------------------------------- */
   676	/*!
   677	 * @fn uncore_Create_Mem()
   678	 *
   679	 * @param    None
   680	 *
   681	 * @return   None     No return needed
   682	 *
   683	 * @brief    Read the counters
   684	 *
   685	 */
   686	static VOID uncore_Create_Mem(U32 memory_size, U64 *trace_buffer)
   687	{
   688		ECB pecb;
   689		DRV_PCI_DEVICE_ENTRY dpden;
   690		U32 bar_name = 0;
   691		DRV_PCI_DEVICE_ENTRY curr_pci_entry = NULL;
   692		U64 mmio_offset = 0;
   693		U32 dev_index = 0;
   694		U32 data_val = 0;
   695		U32 reg_index = 0;
   696		U64 physical_high = 0;
   697		U64 odla_physical_address = 0;
   698	
   699		if (device_uncore == NULL) {
   700			SOCPERF_PRINT_ERROR("ERROR: NULL device_uncore!\n");
   701			return;
   702		}
   703		pecb = (ECB)LWPMU_DEVICE_PMU_register_data(device_uncore)[0];
   704		if (pecb == NULL) {
   705			SOCPERF_PRINT_ERROR("ERROR: null pecb!\n");
   706			return;
   707		}
   708	
   709		if (!trace_buffer) {
   710			return;
   711		}
   712	
   713		ECB_pcidev_entry_list(pecb) = (DRV_PCI_DEVICE_ENTRY)(
   714			(S8 *)pecb + ECB_pcidev_list_offset(pecb));
   715		dpden = ECB_pcidev_entry_list(pecb);
   716	
   717		for (dev_index = 0; dev_index < ECB_num_pci_devices(pecb);
   718		     dev_index++) {
   719			curr_pci_entry = &dpden[dev_index];
   720			bar_name = DRV_PCI_DEVICE_ENTRY_bar_name(curr_pci_entry);
   721			mmio_offset = DRV_PCI_DEVICE_ENTRY_base_offset_for_mmio(
   722				curr_pci_entry);
   723	
   724			if (DRV_PCI_DEVICE_ENTRY_prog_type(curr_pci_entry) ==
   725				    UNC_MEMORY &&
   726			    DRV_PCI_DEVICE_ENTRY_config_type(curr_pci_entry) ==
   727				    UNC_PCICFG &&
   728			    bar_name == UNC_SOCPCI &&
   729			    DRV_PCI_DEVICE_ENTRY_operation(curr_pci_entry) ==
   730				    UNC_OP_WRITE) {
   731				read_From_Register(
   732					DRV_PCI_DEVICE_ENTRY_bus_no(curr_pci_entry),
   733					DRV_PCI_DEVICE_ENTRY_dev_no(curr_pci_entry),
   734					DRV_PCI_DEVICE_ENTRY_func_no(curr_pci_entry),
   735					DRV_PCI_DEVICE_ENTRY_port_id(curr_pci_entry),
   736					SOC_COUNTER_READ_OP_CODE, mmio_offset,
   737					&data_val);
   738				if (reg_index == 1) {
   739					odla_physical_address = data_val;
   740				} else if (reg_index == 2) {
   741					physical_high = data_val;
   742					odla_physical_address = odla_physical_address |
   743								(physical_high << 32);
   744				}
   745				SOCPERF_PRINT_DEBUG(
   746					"op=%d port=%d offset=%x val=%x\n",
   747					DRV_PCI_DEVICE_ENTRY_op_code(curr_pci_entry),
   748					DRV_PCI_DEVICE_ENTRY_port_id(curr_pci_entry),
   749					mmio_offset, data_val);
   750				reg_index++;
   751			}
   752			continue;
   753		}
   754		SOCPERF_PRINT_DEBUG("Physical Address=%llx\n", odla_physical_address);
   755		if (odla_physical_address) {
 > 756			trace_virtual_address = (U64)(UIOP)ioremap_cache(
   757				odla_physical_address, SOC_UNCORE_PAGE_SIZE);
   758			SOCPERF_PRINT_DEBUG("PHY=%llx ODLA VIRTUAL ADDRESS=%llx\n",
   759					    odla_physical_address,
   760					    trace_virtual_address);
   761			if (trace_buffer) {
   762				*trace_buffer = odla_physical_address;
   763			}
   764		}
   765	}
   766	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
