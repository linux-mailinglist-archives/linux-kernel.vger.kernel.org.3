Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0E146A4F0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347631AbhLFS4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:56:10 -0500
Received: from mga11.intel.com ([192.55.52.93]:51387 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347579AbhLFS4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:56:09 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="234895231"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="234895231"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 10:52:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="461949271"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 06 Dec 2021 10:52:16 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muJ5z-000LbH-Ki; Mon, 06 Dec 2021 18:52:15 +0000
Date:   Tue, 7 Dec 2021 02:51:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Wei Liu <wei.liu@kernel.org>
Subject: drivers/hv/hv_common.c:61:21: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202112070246.YIlvG9Cj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1
commit: afca4d95dd7d7936d46a0ff02169cc40f534a6a3 Drivers: hv: Make portions of Hyper-V init code be arch neutral
date:   5 months ago
config: x86_64-randconfig-s022-20211206 (https://download.01.org/0day-ci/archive/20211207/202112070246.YIlvG9Cj-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=afca4d95dd7d7936d46a0ff02169cc40f534a6a3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout afca4d95dd7d7936d46a0ff02169cc40f534a6a3
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/hv/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/hv/hv_common.c:61:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __percpu *__pdata @@     got void [noderef] __percpu **[addressable] [toplevel] hyperv_pcpu_output_arg @@
   drivers/hv/hv_common.c:61:21: sparse:     expected void [noderef] __percpu *__pdata
   drivers/hv/hv_common.c:61:21: sparse:     got void [noderef] __percpu **[addressable] [toplevel] hyperv_pcpu_output_arg
>> drivers/hv/hv_common.c:64:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __percpu *__pdata @@     got void [noderef] __percpu **[addressable] [toplevel] hyperv_pcpu_input_arg @@
   drivers/hv/hv_common.c:64:21: sparse:     expected void [noderef] __percpu *__pdata
   drivers/hv/hv_common.c:64:21: sparse:     got void [noderef] __percpu **[addressable] [toplevel] hyperv_pcpu_input_arg
>> drivers/hv/hv_common.c:78:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __percpu **[addressable] [assigned] [toplevel] hyperv_pcpu_input_arg @@     got void *[noderef] __percpu * @@
   drivers/hv/hv_common.c:78:31: sparse:     expected void [noderef] __percpu **[addressable] [assigned] [toplevel] hyperv_pcpu_input_arg
   drivers/hv/hv_common.c:78:31: sparse:     got void *[noderef] __percpu *
>> drivers/hv/hv_common.c:83:40: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __percpu **[addressable] [assigned] [toplevel] hyperv_pcpu_output_arg @@     got void *[noderef] __percpu * @@
   drivers/hv/hv_common.c:83:40: sparse:     expected void [noderef] __percpu **[addressable] [assigned] [toplevel] hyperv_pcpu_output_arg
   drivers/hv/hv_common.c:83:40: sparse:     got void *[noderef] __percpu *
   drivers/hv/hv_common.c:116:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu ** @@
   drivers/hv/hv_common.c:116:29: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/hv/hv_common.c:116:29: sparse:     got void [noderef] __percpu **
   drivers/hv/hv_common.c:122:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu ** @@
   drivers/hv/hv_common.c:122:38: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/hv/hv_common.c:122:38: sparse:     got void [noderef] __percpu **
   drivers/hv/hv_common.c:144:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu ** @@
   drivers/hv/hv_common.c:144:29: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/hv/hv_common.c:144:29: sparse:     got void [noderef] __percpu **
   drivers/hv/hv_common.c:149:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu ** @@
   drivers/hv/hv_common.c:149:38: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/hv/hv_common.c:149:38: sparse:     got void [noderef] __percpu **

vim +61 drivers/hv/hv_common.c

    49	
    50	/*
    51	 * Hyper-V specific initialization and shutdown code that is
    52	 * common across all architectures.  Called from architecture
    53	 * specific initialization functions.
    54	 */
    55	
    56	void __init hv_common_free(void)
    57	{
    58		kfree(hv_vp_index);
    59		hv_vp_index = NULL;
    60	
  > 61		free_percpu(hyperv_pcpu_output_arg);
    62		hyperv_pcpu_output_arg = NULL;
    63	
  > 64		free_percpu(hyperv_pcpu_input_arg);
    65		hyperv_pcpu_input_arg = NULL;
    66	}
    67	
    68	int __init hv_common_init(void)
    69	{
    70		int i;
    71	
    72		/*
    73		 * Allocate the per-CPU state for the hypercall input arg.
    74		 * If this allocation fails, we will not be able to setup
    75		 * (per-CPU) hypercall input page and thus this failure is
    76		 * fatal on Hyper-V.
    77		 */
  > 78		hyperv_pcpu_input_arg = alloc_percpu(void  *);
    79		BUG_ON(!hyperv_pcpu_input_arg);
    80	
    81		/* Allocate the per-CPU state for output arg for root */
    82		if (hv_root_partition) {
  > 83			hyperv_pcpu_output_arg = alloc_percpu(void *);
    84			BUG_ON(!hyperv_pcpu_output_arg);
    85		}
    86	
    87		hv_vp_index = kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index),
    88					    GFP_KERNEL);
    89		if (!hv_vp_index) {
    90			hv_common_free();
    91			return -ENOMEM;
    92		}
    93	
    94		for (i = 0; i < num_possible_cpus(); i++)
    95			hv_vp_index[i] = VP_INVAL;
    96	
    97		return 0;
    98	}
    99	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
