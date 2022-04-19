Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667FB5061DB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343977AbiDSB4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 21:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343930AbiDSB4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 21:56:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B2127CCE
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 18:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650333210; x=1681869210;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=onaBKRMk1DhTJ8zWoTq8KheY5mYtnuJ8MW026J5UGO0=;
  b=EtRZPiLH9jKIdwchRiX4n5fNlzLd0kYQqJrPb4aYcP3KWJBGSwkJu3gK
   WYucXk3uSVPmW9ADtAeWiNF1j5DYoyWZqd/j0zepsD+Qq0vTw4HxXneZg
   kXBhhjqxGX1QKqqnfdBc+VlyykTWbsalR628Uqugu9bcDZ+d8zHe9Z0x4
   amUj+u0pCHIJ+E3kQxdSo8fN+UecyRHwiJTNeGnPi4O5jED/vmyWd7g6W
   k3B+B0fpqdcsbLqleMWUgVqVzEER8zx0yA5XUpjPmJHzhBdrf99aL+3Z5
   yTIkpQs4EBB/7Gi3TPXX/PlQzOZyR+8jy5c5pYZ4+uEpd8Lmy9lHGBJxh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="263826114"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="263826114"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 18:53:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="509953429"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Apr 2022 18:53:11 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngd3H-0005BM-60;
        Tue, 19 Apr 2022 01:53:11 +0000
Date:   Tue, 19 Apr 2022 09:53:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1645/2356]
 drivers/thermal/intel/intel_hfi.c:401:25: warning: incompatible integer to
 pointer conversion assigning to 'void *' from 'int'
Message-ID: <202204190947.AY5XKXTY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   af93551cf39027d176f30b9beafc60a4c130998a
commit: 96618ccf069eedafdb527ebc33c48b30b348a406 [1645/2356] headers/deps: mm: Remove the <linux/gfp_api.h> header from <linux/gfp.h>
config: x86_64-randconfig-a012-20220418 (https://download.01.org/0day-ci/archive/20220419/202204190947.AY5XKXTY-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 429cbac0390654f90bba18a41799464adf31a5ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=96618ccf069eedafdb527ebc33c48b30b348a406
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 96618ccf069eedafdb527ebc33c48b30b348a406
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/ drivers/block/aoe/ drivers/bus/mhi/host/ drivers/gpu/drm/i915/gvt/ drivers/gpu/drm/tiny/ drivers/hwmon/ drivers/iio/dac/ drivers/misc/ drivers/platform/x86/ drivers/power/supply/ drivers/spi/ drivers/thermal/intel/ lib/crypto/ net/mctp/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/thermal/intel/intel_hfi.c:401:27: error: implicit declaration of function 'alloc_pages_exact' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           hfi_instance->hw_table = alloc_pages_exact(hfi_features.nr_table_pages,
                                    ^
>> drivers/thermal/intel/intel_hfi.c:401:25: warning: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
           hfi_instance->hw_table = alloc_pages_exact(hfi_features.nr_table_pages,
                                  ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/thermal/intel/intel_hfi.c:448:2: error: implicit declaration of function 'free_pages_exact' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           free_pages_exact(hfi_instance->hw_table, hfi_features.nr_table_pages);
           ^
   drivers/thermal/intel/intel_hfi.c:448:2: note: did you mean 'alloc_pages_exact'?
   drivers/thermal/intel/intel_hfi.c:401:27: note: 'alloc_pages_exact' declared here
           hfi_instance->hw_table = alloc_pages_exact(hfi_features.nr_table_pages,
                                    ^
   1 warning and 2 errors generated.


vim +401 drivers/thermal/intel/intel_hfi.c

2d74e6319abe27 Ricardo Neri 2022-01-27  343  
2d74e6319abe27 Ricardo Neri 2022-01-27  344  /**
2d74e6319abe27 Ricardo Neri 2022-01-27  345   * intel_hfi_online() - Enable HFI on @cpu
2d74e6319abe27 Ricardo Neri 2022-01-27  346   * @cpu:	CPU in which the HFI will be enabled
2d74e6319abe27 Ricardo Neri 2022-01-27  347   *
2d74e6319abe27 Ricardo Neri 2022-01-27  348   * Enable the HFI to be used in @cpu. The HFI is enabled at the die/package
2d74e6319abe27 Ricardo Neri 2022-01-27  349   * level. The first CPU in the die/package to come online does the full HFI
2d74e6319abe27 Ricardo Neri 2022-01-27  350   * initialization. Subsequent CPUs will just link themselves to the HFI
2d74e6319abe27 Ricardo Neri 2022-01-27  351   * instance of their die/package.
2d74e6319abe27 Ricardo Neri 2022-01-27  352   *
2d74e6319abe27 Ricardo Neri 2022-01-27  353   * This function is called before enabling the thermal vector in the local APIC
2d74e6319abe27 Ricardo Neri 2022-01-27  354   * in order to ensure that @cpu has an associated HFI instance when it receives
2d74e6319abe27 Ricardo Neri 2022-01-27  355   * an HFI event.
2d74e6319abe27 Ricardo Neri 2022-01-27  356   */
2d74e6319abe27 Ricardo Neri 2022-01-27  357  void intel_hfi_online(unsigned int cpu)
2d74e6319abe27 Ricardo Neri 2022-01-27  358  {
2d74e6319abe27 Ricardo Neri 2022-01-27  359  	struct hfi_instance *hfi_instance;
2d74e6319abe27 Ricardo Neri 2022-01-27  360  	struct hfi_cpu_info *info;
2d74e6319abe27 Ricardo Neri 2022-01-27  361  	phys_addr_t hw_table_pa;
2d74e6319abe27 Ricardo Neri 2022-01-27  362  	u64 msr_val;
2d74e6319abe27 Ricardo Neri 2022-01-27  363  	u16 die_id;
2d74e6319abe27 Ricardo Neri 2022-01-27  364  
2d74e6319abe27 Ricardo Neri 2022-01-27  365  	/* Nothing to do if hfi_instances are missing. */
2d74e6319abe27 Ricardo Neri 2022-01-27  366  	if (!hfi_instances)
2d74e6319abe27 Ricardo Neri 2022-01-27  367  		return;
2d74e6319abe27 Ricardo Neri 2022-01-27  368  
2d74e6319abe27 Ricardo Neri 2022-01-27  369  	/*
2d74e6319abe27 Ricardo Neri 2022-01-27  370  	 * Link @cpu to the HFI instance of its package/die. It does not
2d74e6319abe27 Ricardo Neri 2022-01-27  371  	 * matter whether the instance has been initialized.
2d74e6319abe27 Ricardo Neri 2022-01-27  372  	 */
2d74e6319abe27 Ricardo Neri 2022-01-27  373  	info = &per_cpu(hfi_cpu_info, cpu);
2d74e6319abe27 Ricardo Neri 2022-01-27  374  	die_id = topology_logical_die_id(cpu);
2d74e6319abe27 Ricardo Neri 2022-01-27  375  	hfi_instance = info->hfi_instance;
2d74e6319abe27 Ricardo Neri 2022-01-27  376  	if (!hfi_instance) {
2d74e6319abe27 Ricardo Neri 2022-01-27  377  		if (die_id < 0 || die_id >= max_hfi_instances)
2d74e6319abe27 Ricardo Neri 2022-01-27  378  			return;
2d74e6319abe27 Ricardo Neri 2022-01-27  379  
2d74e6319abe27 Ricardo Neri 2022-01-27  380  		hfi_instance = &hfi_instances[die_id];
2d74e6319abe27 Ricardo Neri 2022-01-27  381  		info->hfi_instance = hfi_instance;
2d74e6319abe27 Ricardo Neri 2022-01-27  382  	}
2d74e6319abe27 Ricardo Neri 2022-01-27  383  
2d74e6319abe27 Ricardo Neri 2022-01-27  384  	init_hfi_cpu_index(info);
2d74e6319abe27 Ricardo Neri 2022-01-27  385  
2d74e6319abe27 Ricardo Neri 2022-01-27  386  	/*
2d74e6319abe27 Ricardo Neri 2022-01-27  387  	 * Now check if the HFI instance of the package/die of @cpu has been
2d74e6319abe27 Ricardo Neri 2022-01-27  388  	 * initialized (by checking its header). In such case, all we have to
2d74e6319abe27 Ricardo Neri 2022-01-27  389  	 * do is to add @cpu to this instance's cpumask.
2d74e6319abe27 Ricardo Neri 2022-01-27  390  	 */
2d74e6319abe27 Ricardo Neri 2022-01-27  391  	mutex_lock(&hfi_instance_lock);
2d74e6319abe27 Ricardo Neri 2022-01-27  392  	if (hfi_instance->hdr) {
2d74e6319abe27 Ricardo Neri 2022-01-27  393  		cpumask_set_cpu(cpu, hfi_instance->cpus);
2d74e6319abe27 Ricardo Neri 2022-01-27  394  		goto unlock;
2d74e6319abe27 Ricardo Neri 2022-01-27  395  	}
2d74e6319abe27 Ricardo Neri 2022-01-27  396  
2d74e6319abe27 Ricardo Neri 2022-01-27  397  	/*
2d74e6319abe27 Ricardo Neri 2022-01-27  398  	 * Hardware is programmed with the physical address of the first page
2d74e6319abe27 Ricardo Neri 2022-01-27  399  	 * frame of the table. Hence, the allocated memory must be page-aligned.
2d74e6319abe27 Ricardo Neri 2022-01-27  400  	 */
2d74e6319abe27 Ricardo Neri 2022-01-27 @401  	hfi_instance->hw_table = alloc_pages_exact(hfi_features.nr_table_pages,
2d74e6319abe27 Ricardo Neri 2022-01-27  402  						   GFP_KERNEL | __GFP_ZERO);
2d74e6319abe27 Ricardo Neri 2022-01-27  403  	if (!hfi_instance->hw_table)
2d74e6319abe27 Ricardo Neri 2022-01-27  404  		goto unlock;
2d74e6319abe27 Ricardo Neri 2022-01-27  405  
2d74e6319abe27 Ricardo Neri 2022-01-27  406  	hw_table_pa = virt_to_phys(hfi_instance->hw_table);
2d74e6319abe27 Ricardo Neri 2022-01-27  407  
2d74e6319abe27 Ricardo Neri 2022-01-27  408  	/*
2d74e6319abe27 Ricardo Neri 2022-01-27  409  	 * Allocate memory to keep a local copy of the table that
2d74e6319abe27 Ricardo Neri 2022-01-27  410  	 * hardware generates.
2d74e6319abe27 Ricardo Neri 2022-01-27  411  	 */
2d74e6319abe27 Ricardo Neri 2022-01-27  412  	hfi_instance->local_table = kzalloc(hfi_features.nr_table_pages << PAGE_SHIFT,
2d74e6319abe27 Ricardo Neri 2022-01-27  413  					    GFP_KERNEL);
2d74e6319abe27 Ricardo Neri 2022-01-27  414  	if (!hfi_instance->local_table)
2d74e6319abe27 Ricardo Neri 2022-01-27  415  		goto free_hw_table;
2d74e6319abe27 Ricardo Neri 2022-01-27  416  
2d74e6319abe27 Ricardo Neri 2022-01-27  417  	/*
2d74e6319abe27 Ricardo Neri 2022-01-27  418  	 * Program the address of the feedback table of this die/package. On
2d74e6319abe27 Ricardo Neri 2022-01-27  419  	 * some processors, hardware remembers the old address of the HFI table
2d74e6319abe27 Ricardo Neri 2022-01-27  420  	 * even after having been reprogrammed and re-enabled. Thus, do not free
2d74e6319abe27 Ricardo Neri 2022-01-27  421  	 * the pages allocated for the table or reprogram the hardware with a
2d74e6319abe27 Ricardo Neri 2022-01-27  422  	 * new base address. Namely, program the hardware only once.
2d74e6319abe27 Ricardo Neri 2022-01-27  423  	 */
2d74e6319abe27 Ricardo Neri 2022-01-27  424  	msr_val = hw_table_pa | HW_FEEDBACK_PTR_VALID_BIT;
2d74e6319abe27 Ricardo Neri 2022-01-27  425  	wrmsrl(MSR_IA32_HW_FEEDBACK_PTR, msr_val);
2d74e6319abe27 Ricardo Neri 2022-01-27  426  
2d74e6319abe27 Ricardo Neri 2022-01-27  427  	init_hfi_instance(hfi_instance);
2d74e6319abe27 Ricardo Neri 2022-01-27  428  
ab09b0744a9944 Ricardo Neri 2022-01-27  429  	INIT_DELAYED_WORK(&hfi_instance->update_work, hfi_update_work_fn);
ab09b0744a9944 Ricardo Neri 2022-01-27  430  	raw_spin_lock_init(&hfi_instance->table_lock);
ab09b0744a9944 Ricardo Neri 2022-01-27  431  	raw_spin_lock_init(&hfi_instance->event_lock);
ab09b0744a9944 Ricardo Neri 2022-01-27  432  
2d74e6319abe27 Ricardo Neri 2022-01-27  433  	cpumask_set_cpu(cpu, hfi_instance->cpus);
2d74e6319abe27 Ricardo Neri 2022-01-27  434  
ab09b0744a9944 Ricardo Neri 2022-01-27  435  	/*
ab09b0744a9944 Ricardo Neri 2022-01-27  436  	 * Enable the hardware feedback interface and never disable it. See
ab09b0744a9944 Ricardo Neri 2022-01-27  437  	 * comment on programming the address of the table.
ab09b0744a9944 Ricardo Neri 2022-01-27  438  	 */
ab09b0744a9944 Ricardo Neri 2022-01-27  439  	rdmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
ab09b0744a9944 Ricardo Neri 2022-01-27  440  	msr_val |= HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT;
ab09b0744a9944 Ricardo Neri 2022-01-27  441  	wrmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
ab09b0744a9944 Ricardo Neri 2022-01-27  442  
2d74e6319abe27 Ricardo Neri 2022-01-27  443  unlock:
2d74e6319abe27 Ricardo Neri 2022-01-27  444  	mutex_unlock(&hfi_instance_lock);
2d74e6319abe27 Ricardo Neri 2022-01-27  445  	return;
2d74e6319abe27 Ricardo Neri 2022-01-27  446  
2d74e6319abe27 Ricardo Neri 2022-01-27  447  free_hw_table:
2d74e6319abe27 Ricardo Neri 2022-01-27  448  	free_pages_exact(hfi_instance->hw_table, hfi_features.nr_table_pages);
2d74e6319abe27 Ricardo Neri 2022-01-27  449  	goto unlock;
2d74e6319abe27 Ricardo Neri 2022-01-27  450  }
2d74e6319abe27 Ricardo Neri 2022-01-27  451  

:::::: The code at line 401 was first introduced by commit
:::::: 2d74e6319abe278981e79166b6c2d0c3ed39b1ae thermal: intel: hfi: Handle CPU hotplug events

:::::: TO: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
