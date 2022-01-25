Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B9C49BBF3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 20:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiAYTR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 14:17:27 -0500
Received: from mga01.intel.com ([192.55.52.88]:3854 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229719AbiAYTRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 14:17:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643138239; x=1674674239;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mFPXaj3o5hlXV//p9wc7/fBnnLTPAv43cb94T+0lEQs=;
  b=VskoO6edoErAupSXhCBzkSmc9m3mKm2Y49qxuX521kyhVLcj2+L0TBHh
   7uedfdXfWKQXiFiqvQnH9ni0yt3rgophuzOcMXEKzdQ1uVl+StPoGYEUn
   1LKdp/QhyIdiLUs7Z3rXExILSTXN5wfqYFf4u2HTWlpuzl9g/RrvsaPAM
   Hp2J6o4etsZBOy0d/aCFAxAUnz9e09mB8r+qaDkJvj99xx11NconZMliT
   W74/ysJlebdtTQvaRxXFkOhHh4D+qmGW7+Oe1d6WMskuokIjJoW1b0IcM
   RenTtHDy1lKQQR6lYpRNcScRE0GTSZjf/BnA2BN7ygyGaMBtURoLDFKrQ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="270841714"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="270841714"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 11:17:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="624579288"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jan 2022 11:17:16 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCRJb-000KKm-Cv; Tue, 25 Jan 2022 19:17:15 +0000
Date:   Wed, 26 Jan 2022 03:17:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:queue/5.10 6915/9999]
 arch/powerpc/kernel/smp.c:1380:14: error: variable 'ret' set but not used
Message-ID: <202201260117.e6cluOFD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srikar,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/5.10
head:   054d91ed4eb6d38a05b14f7aaf558b8f68b6754b
commit: e91077cf1780108dc586cedf1d19f65b44fa3870 [6915/9999] powerpc/smp: Update cpu_core_map on all PowerPc systems
config: powerpc64-randconfig-r036-20220124 (https://download.01.org/0day-ci/archive/20220126/202201260117.e6cluOFD-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=e91077cf1780108dc586cedf1d19f65b44fa3870
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/5.10
        git checkout e91077cf1780108dc586cedf1d19f65b44fa3870
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/powerpc/kernel/smp.c:551:6: error: no previous prototype for 'tick_broadcast' [-Werror=missing-prototypes]
     551 | void tick_broadcast(const struct cpumask *mask)
         |      ^~~~~~~~~~~~~~
   arch/powerpc/kernel/smp.c:561:6: error: no previous prototype for 'debugger_ipi_callback' [-Werror=missing-prototypes]
     561 | void debugger_ipi_callback(struct pt_regs *regs)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/kernel/smp.c: In function 'add_cpu_to_masks':
>> arch/powerpc/kernel/smp.c:1380:14: error: variable 'ret' set but not used [-Werror=unused-but-set-variable]
    1380 |         bool ret;
         |              ^~~
   cc1: all warnings being treated as errors


vim +/ret +1380 arch/powerpc/kernel/smp.c

b8a97cb4599cda Srikar Dronamraju 2020-09-21  1373  
df52f6714071c4 Oliver O'Halloran 2017-06-29  1374  static void add_cpu_to_masks(int cpu)
df52f6714071c4 Oliver O'Halloran 2017-06-29  1375  {
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1376  	struct cpumask *(*submask_fn)(int) = cpu_sibling_mask;
df52f6714071c4 Oliver O'Halloran 2017-06-29  1377  	int first_thread = cpu_first_thread_sibling(cpu);
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1378  	int chip_id = cpu_to_chip_id(cpu);
84dbf66c634720 Srikar Dronamraju 2020-10-19  1379  	cpumask_var_t mask;
bf6476152a0a08 Srikar Dronamraju 2021-04-15 @1380  	bool ret;
df52f6714071c4 Oliver O'Halloran 2017-06-29  1381  	int i;
df52f6714071c4 Oliver O'Halloran 2017-06-29  1382  
df52f6714071c4 Oliver O'Halloran 2017-06-29  1383  	/*
df52f6714071c4 Oliver O'Halloran 2017-06-29  1384  	 * This CPU will not be in the online mask yet so we need to manually
df52f6714071c4 Oliver O'Halloran 2017-06-29  1385  	 * add it to it's own thread sibling mask.
df52f6714071c4 Oliver O'Halloran 2017-06-29  1386  	 */
df52f6714071c4 Oliver O'Halloran 2017-06-29  1387  	cpumask_set_cpu(cpu, cpu_sibling_mask(cpu));
e91077cf178010 Srikar Dronamraju 2021-08-26  1388  	cpumask_set_cpu(cpu, cpu_core_mask(cpu));
df52f6714071c4 Oliver O'Halloran 2017-06-29  1389  
df52f6714071c4 Oliver O'Halloran 2017-06-29  1390  	for (i = first_thread; i < first_thread + threads_per_core; i++)
df52f6714071c4 Oliver O'Halloran 2017-06-29  1391  		if (cpu_online(i))
df52f6714071c4 Oliver O'Halloran 2017-06-29  1392  			set_cpus_related(i, cpu, cpu_sibling_mask);
df52f6714071c4 Oliver O'Halloran 2017-06-29  1393  
425752c63b6f3f Gautham R. Shenoy 2018-10-11  1394  	add_cpu_to_smallcore_masks(cpu);
84dbf66c634720 Srikar Dronamraju 2020-10-19  1395  
84dbf66c634720 Srikar Dronamraju 2020-10-19  1396  	/* In CPU-hotplug path, hence use GFP_ATOMIC */
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1397  	ret = alloc_cpumask_var_node(&mask, GFP_ATOMIC, cpu_to_node(cpu));
84dbf66c634720 Srikar Dronamraju 2020-10-19  1398  	update_mask_by_l2(cpu, &mask);
2a636a56d2d396 Oliver O'Halloran 2017-06-29  1399  
b8a97cb4599cda Srikar Dronamraju 2020-09-21  1400  	if (has_coregroup_support())
84dbf66c634720 Srikar Dronamraju 2020-10-19  1401  		update_coregroup_mask(cpu, &mask);
84dbf66c634720 Srikar Dronamraju 2020-10-19  1402  
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1403  	if (shared_caches)
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1404  		submask_fn = cpu_l2_cache_mask;
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1405  
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1406  	/* Update core_mask with all the CPUs that are part of submask */
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1407  	or_cpumasks_related(cpu, cpu, submask_fn, cpu_core_mask);
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1408  
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1409  	/* Skip all CPUs already part of current CPU core mask */
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1410  	cpumask_andnot(mask, cpu_online_mask, cpu_core_mask(cpu));
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1411  
e91077cf178010 Srikar Dronamraju 2021-08-26  1412  	/* If chip_id is -1; limit the cpu_core_mask to within DIE*/
e91077cf178010 Srikar Dronamraju 2021-08-26  1413  	if (chip_id == -1)
e91077cf178010 Srikar Dronamraju 2021-08-26  1414  		cpumask_and(mask, mask, cpu_cpu_mask(cpu));
e91077cf178010 Srikar Dronamraju 2021-08-26  1415  
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1416  	for_each_cpu(i, mask) {
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1417  		if (chip_id == cpu_to_chip_id(i)) {
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1418  			or_cpumasks_related(cpu, i, submask_fn, cpu_core_mask);
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1419  			cpumask_andnot(mask, mask, submask_fn(i));
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1420  		} else {
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1421  			cpumask_andnot(mask, mask, cpu_core_mask(i));
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1422  		}
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1423  	}
bf6476152a0a08 Srikar Dronamraju 2021-04-15  1424  
84dbf66c634720 Srikar Dronamraju 2020-10-19  1425  	free_cpumask_var(mask);
a8a5356cd511db Paul Mackerras    2013-08-12  1426  }
a8a5356cd511db Paul Mackerras    2013-08-12  1427  

:::::: The code at line 1380 was first introduced by commit
:::::: bf6476152a0a084038b12b9d770e32717f54a6ab powerpc/smp: Reintroduce cpu_core_mask

:::::: TO: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
