Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA844578093
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 13:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbiGRLTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 07:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiGRLTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 07:19:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B07BC82
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 04:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658143179; x=1689679179;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/nDs+1+nnXjDKJPMklPcxWtaYPQ0yeISiSmIhjHis1g=;
  b=m7Y6azPzxWVc9blKaGk2T6sNIbYyUvlu2NbX43nY1Dj2HakO+Ex5Vzxf
   IP3vITlUsqZFC2kZz741iZPbe32M+CwvezJ2BOh7btyOqoqAfEngf5NU8
   eHzvlLgCzUyEa+jXjk255I7GWrBu+62ETcz7UKF3bb0029kJlo3Fq5WxW
   Uy6svzrKGHv60/plxkcCD72Yhc+s+8gFU91u4mj/lY/Vrcdeq2TWLNa7G
   8kVNqfcNzbdYrY4Qb4o1eterYj8K5ntKzx7s5cxwKnlUznLjNvCfePzju
   RypCYW7pzy30buJoLzHZdNp80p/FUaiFNmyHxtvOg31OahDMrJg30phdV
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="265978191"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="265978191"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 04:19:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="624687008"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 18 Jul 2022 04:19:37 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDOmn-0004IS-8o;
        Mon, 18 Jul 2022 11:19:37 +0000
Date:   Mon, 18 Jul 2022 19:18:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [stffrdhrn:or1k-virt-3 2/6] include/asm-generic/pci.h:28:19: error:
 redefinition of 'pci_proc_domain'
Message-ID: <202207181904.aALhfh7W-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/stffrdhrn/linux.git or1k-virt-3
head:   4b1ece79cac02d6d81af76e47f8e7d493dcd50a0
commit: 4d49a73c20c02f234958a20996263d063f23bc86 [2/6] asm-generic: Add new pci.h and use it
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20220718/202207181904.aALhfh7W-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/stffrdhrn/linux/commit/4d49a73c20c02f234958a20996263d063f23bc86
        git remote add stffrdhrn https://github.com/stffrdhrn/linux.git
        git fetch --no-tags stffrdhrn or1k-virt-3
        git checkout 4d49a73c20c02f234958a20996263d063f23bc86
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/um/include/asm/pci.h:8,
                    from include/linux/pci.h:1910,
                    from drivers/usb/host/pci-quirks.c:14:
>> include/asm-generic/pci.h:28:19: error: redefinition of 'pci_proc_domain'
      28 | static inline int pci_proc_domain(struct pci_bus *bus)
         |                   ^~~~~~~~~~~~~~~
   In file included from drivers/usb/host/pci-quirks.c:14:
   include/linux/pci.h:1706:19: note: previous definition of 'pci_proc_domain' with type 'int(struct pci_bus *)'
    1706 | static inline int pci_proc_domain(struct pci_bus *bus) { return 0; }
         |                   ^~~~~~~~~~~~~~~
--
   In file included from arch/um/include/asm/pci.h:8,
                    from include/linux/pci.h:1910,
                    from drivers/net/ethernet/broadcom/bnxt/bnxt.c:21:
>> include/asm-generic/pci.h:28:19: error: redefinition of 'pci_proc_domain'
      28 | static inline int pci_proc_domain(struct pci_bus *bus)
         |                   ^~~~~~~~~~~~~~~
   In file included from drivers/net/ethernet/broadcom/bnxt/bnxt.c:21:
   include/linux/pci.h:1706:19: note: previous definition of 'pci_proc_domain' with type 'int(struct pci_bus *)'
    1706 | static inline int pci_proc_domain(struct pci_bus *bus) { return 0; }
         |                   ^~~~~~~~~~~~~~~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function 'bnxt_request_irq':
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:9285:16: warning: variable 'j' set but not used [-Wunused-but-set-variable]
    9285 |         int i, j, rc = 0;
         |                ^
--
   In file included from arch/um/include/asm/pci.h:8,
                    from include/linux/pci.h:1910,
                    from drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:52,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:44:
>> include/asm-generic/pci.h:28:19: error: redefinition of 'pci_proc_domain'
      28 | static inline int pci_proc_domain(struct pci_bus *bus)
         |                   ^~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:52,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:44:
   include/linux/pci.h:1706:19: note: previous definition of 'pci_proc_domain' with type 'int(struct pci_bus *)'
    1706 | static inline int pci_proc_domain(struct pci_bus *bus) { return 0; }
         |                   ^~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/link_enc_cfg.h:33,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:32:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:133:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     133 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:130:17: warning: 'DP_SINK_BRANCH_DEV_NAME_7580' defined but not used [-Wunused-const-variable=]
     130 | static const u8 DP_SINK_BRANCH_DEV_NAME_7580[] = "7580\x80u";
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:128:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     128 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:127:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     127 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from arch/um/include/asm/pci.h:8,
                    from include/linux/pci.h:1910,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu.h:52,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:25:
>> include/asm-generic/pci.h:28:19: error: redefinition of 'pci_proc_domain'
      28 | static inline int pci_proc_domain(struct pci_bus *bus)
         |                   ^~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/amdgpu.h:52,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:25:
   include/linux/pci.h:1706:19: note: previous definition of 'pci_proc_domain' with type 'int(struct pci_bus *)'
    1706 | static inline int pci_proc_domain(struct pci_bus *bus) { return 0; }
         |                   ^~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c: In function 'amdgpu_mes_ctx_alloc_meta_data':
   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:959:13: warning: variable 'r' set but not used [-Wunused-but-set-variable]
     959 |         int r;
         |             ^
--
   In file included from arch/um/include/asm/pci.h:8,
                    from include/linux/pci.h:1910,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu.h:52,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c:28:
>> include/asm-generic/pci.h:28:19: error: redefinition of 'pci_proc_domain'
      28 | static inline int pci_proc_domain(struct pci_bus *bus)
         |                   ^~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/amdgpu.h:52,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c:28:
   include/linux/pci.h:1706:19: note: previous definition of 'pci_proc_domain' with type 'int(struct pci_bus *)'
    1706 | static inline int pci_proc_domain(struct pci_bus *bus) { return 0; }
         |                   ^~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c:129:6: warning: no previous prototype for 'amdgpu_ucode_print_imu_hdr' [-Wmissing-prototypes]
     129 | void amdgpu_ucode_print_imu_hdr(const struct common_firmware_header *hdr)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from arch/um/include/asm/pci.h:8,
                    from include/linux/pci.h:1910,
                    from drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:26:
>> include/asm-generic/pci.h:28:19: error: redefinition of 'pci_proc_domain'
      28 | static inline int pci_proc_domain(struct pci_bus *bus)
         |                   ^~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:26:
   include/linux/pci.h:1706:19: note: previous definition of 'pci_proc_domain' with type 'int(struct pci_bus *)'
    1706 | static inline int pci_proc_domain(struct pci_bus *bus) { return 0; }
         |                   ^~~~~~~~~~~~~~~
   In file included from arch/x86/um/asm/processor.h:41,
                    from include/linux/mutex.h:19,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/pci.h:35,
                    from drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:26:
   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c: In function 'kfd_cpumask_to_apic_id':
   arch/um/include/asm/processor-generic.h:103:19: error: called object is not a function or function pointer
     103 | #define cpu_data (&boot_cpu_data)
         |                  ~^~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1610:16: note: in expansion of macro 'cpu_data'
    1610 |         return cpu_data(first_cpu_of_numa_node).apicid;
         |                ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1614:1: error: control reaches end of non-void function [-Werror=return-type]
    1614 | }
         | ^
   cc1: some warnings being treated as errors
--
   In file included from arch/um/include/asm/pci.h:8,
                    from include/linux/pci.h:1910,
                    from drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:24:
>> include/asm-generic/pci.h:28:19: error: redefinition of 'pci_proc_domain'
      28 | static inline int pci_proc_domain(struct pci_bus *bus)
         |                   ^~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:24:
   include/linux/pci.h:1706:19: note: previous definition of 'pci_proc_domain' with type 'int(struct pci_bus *)'
    1706 | static inline int pci_proc_domain(struct pci_bus *bus) { return 0; }
         |                   ^~~~~~~~~~~~~~~
   In file included from arch/x86/um/asm/processor.h:41,
                    from include/linux/mutex.h:19,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/pci.h:35,
                    from drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:24:
   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c: In function 'kfd_fill_iolink_info_for_cpu':
   arch/um/include/asm/processor-generic.h:103:19: error: called object is not a function or function pointer
     103 | #define cpu_data (&boot_cpu_data)
         |                  ~^~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:1777:34: note: in expansion of macro 'cpu_data'
    1777 |         struct cpuinfo_x86 *c = &cpu_data(0);
         |                                  ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:1780:14: error: invalid use of undefined type 'struct cpuinfo_x86'
    1780 |         if (c->x86_vendor == X86_VENDOR_AMD)
         |              ^~
   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:1780:30: error: 'X86_VENDOR_AMD' undeclared (first use in this function); did you mean 'X86_VENDOR_ANY'?
    1780 |         if (c->x86_vendor == X86_VENDOR_AMD)
         |                              ^~~~~~~~~~~~~~
         |                              X86_VENDOR_ANY
   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:1780:30: note: each undeclared identifier is reported only once for each function it appears in
--
   In file included from arch/um/include/asm/pci.h:8,
                    from include/linux/pci.h:1910,
                    from drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:27:
>> include/asm-generic/pci.h:28:19: error: redefinition of 'pci_proc_domain'
      28 | static inline int pci_proc_domain(struct pci_bus *bus)
         |                   ^~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:27:
   include/linux/pci.h:1706:19: note: previous definition of 'pci_proc_domain' with type 'int(struct pci_bus *)'
    1706 | static inline int pci_proc_domain(struct pci_bus *bus) { return 0; }
         |                   ^~~~~~~~~~~~~~~
   In file included from arch/x86/um/asm/processor.h:41,
                    from include/linux/spinlock_up.h:8,
                    from include/linux/spinlock.h:95,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from drivers/gpu/drm/amd/amdgpu/../pm/powerplay/inc/pp_debug.h:35,
                    from drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:23:
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c: In function 'intel_core_rkl_chk':
   arch/um/include/asm/processor-generic.h:103:19: error: called object is not a function or function pointer
     103 | #define cpu_data (&boot_cpu_data)
         |                  ~^~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:1742:34: note: in expansion of macro 'cpu_data'
    1742 |         struct cpuinfo_x86 *c = &cpu_data(0);
         |                                  ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:1744:18: error: invalid use of undefined type 'struct cpuinfo_x86'
    1744 |         return (c->x86 == 6 && c->x86_model == INTEL_FAM6_ROCKETLAKE);
         |                  ^~
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:1744:33: error: invalid use of undefined type 'struct cpuinfo_x86'
    1744 |         return (c->x86 == 6 && c->x86_model == INTEL_FAM6_ROCKETLAKE);
         |                                 ^~
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:1748:1: error: control reaches end of non-void function [-Werror=return-type]
    1748 | }
         | ^
   cc1: some warnings being treated as errors
--
   In file included from arch/um/include/asm/pci.h:8,
                    from include/linux/pci.h:1910,
                    from drivers/char/applicom.c:32:
>> include/asm-generic/pci.h:28:19: error: redefinition of 'pci_proc_domain'
      28 | static inline int pci_proc_domain(struct pci_bus *bus)
         |                   ^~~~~~~~~~~~~~~
   In file included from drivers/char/applicom.c:32:
   include/linux/pci.h:1706:19: note: previous definition of 'pci_proc_domain' with type 'int(struct pci_bus *)'
    1706 | static inline int pci_proc_domain(struct pci_bus *bus) { return 0; }
         |                   ^~~~~~~~~~~~~~~
   drivers/char/applicom.c: In function 'ac_register_board':
   drivers/char/applicom.c:131:32: warning: variable 'byte_reset_it' set but not used [-Wunused-but-set-variable]
     131 |         volatile unsigned char byte_reset_it;
         |                                ^~~~~~~~~~~~~
   drivers/char/applicom.c: In function 'ac_read':
   drivers/char/applicom.c:540:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     540 |         int ret = 0;
         |             ^~~
   drivers/char/applicom.c: In function 'ac_ioctl':
   drivers/char/applicom.c:703:32: warning: variable 'byte_reset_it' set but not used [-Wunused-but-set-variable]
     703 |         volatile unsigned char byte_reset_it;
         |                                ^~~~~~~~~~~~~
--
   In file included from arch/um/include/asm/pci.h:8,
                    from include/linux/pci.h:1910,
                    from drivers/net/wireless/marvell/mwifiex/pcie.h:26,
                    from drivers/net/wireless/marvell/mwifiex/main.h:57,
                    from drivers/net/wireless/marvell/mwifiex/pcie.c:27:
>> include/asm-generic/pci.h:28:19: error: redefinition of 'pci_proc_domain'
      28 | static inline int pci_proc_domain(struct pci_bus *bus)
         |                   ^~~~~~~~~~~~~~~
   In file included from drivers/net/wireless/marvell/mwifiex/pcie.h:26,
                    from drivers/net/wireless/marvell/mwifiex/main.h:57,
                    from drivers/net/wireless/marvell/mwifiex/pcie.c:27:
   include/linux/pci.h:1706:19: note: previous definition of 'pci_proc_domain' with type 'int(struct pci_bus *)'
    1706 | static inline int pci_proc_domain(struct pci_bus *bus) { return 0; }
         |                   ^~~~~~~~~~~~~~~
   drivers/net/wireless/marvell/mwifiex/pcie.c: In function 'mwifiex_pm_wakeup_card':
   drivers/net/wireless/marvell/mwifiex/pcie.c:659:13: warning: variable 'retval' set but not used [-Wunused-but-set-variable]
     659 |         int retval;
         |             ^~~~~~
--
   In file included from arch/um/include/asm/pci.h:8,
                    from include/linux/pci.h:1910,
                    from drivers/net/wireless/intel/iwlwifi/iwl-devtrace-io.h:12,
                    from drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h:89,
                    from drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c:15:
>> include/asm-generic/pci.h:28:19: error: redefinition of 'pci_proc_domain'
      28 | static inline int pci_proc_domain(struct pci_bus *bus)
         |                   ^~~~~~~~~~~~~~~
   In file included from drivers/net/wireless/intel/iwlwifi/iwl-devtrace-io.h:12,
                    from drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h:89,
                    from drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c:15:
   include/linux/pci.h:1706:19: note: previous definition of 'pci_proc_domain' with type 'int(struct pci_bus *)'
    1706 | static inline int pci_proc_domain(struct pci_bus *bus) { return 0; }
         |                   ^~~~~~~~~~~~~~~
   In file included from include/trace/define_trace.h:102,
                    from drivers/net/wireless/intel/iwlwifi/iwl-devtrace-msg.h:75,
                    from drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h:91,
                    from drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c:15:
   drivers/net/wireless/intel/iwlwifi/./iwl-devtrace-msg.h: In function 'trace_event_raw_event_iwlwifi_dbg':
   include/trace/trace_events.h:386:16: warning: function 'trace_event_raw_event_iwlwifi_dbg' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     386 |         struct trace_event_raw_##call *entry;                           \
         |                ^~~~~~~~~~~~~~~~
   include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/./iwl-devtrace-msg.h:51:1: note: in expansion of macro 'TRACE_EVENT'
      51 | TRACE_EVENT(iwlwifi_dbg,
         | ^~~~~~~~~~~
..


vim +/pci_proc_domain +28 include/asm-generic/pci.h

    27	
  > 28	static inline int pci_proc_domain(struct pci_bus *bus)
    29	{
    30		/* always show the domain in /proc */
    31		return 1;
    32	}
    33	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
