Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AB058B812
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 21:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbiHFT7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 15:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbiHFT7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 15:59:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9741E261E
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 12:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659815949; x=1691351949;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=w5GY8CwInFXHmEYdXYfEg/5ag7UdS10Qg7uRwbGFNKw=;
  b=WKTTFBXYwiXR/DrQE9wsEiHIB1uRGOvxvns5FBymmT2EO6jbDY6eCqpC
   jsHsRcF0b+h9Sql6Fztu+HWTax8Mg+8ZdXsOU7lXJYYcPJQfVDFb1gYh9
   QZxXHy50vuNcpvjZ0v77bBISQQy1FkRbG97jG3hdOlzjz0vqWZQDjPfDT
   sUQewL82pKNcgzn689tN/uHfeyOo8EB2fI1VJ8jkt9WEjxFyFxbCq4yuK
   TigwXnxFP1TVrwWqoY+nXeIc4nSOTkb6Yb2Quy1skCFmRzx7OnmYZxWH8
   eyNVUKqjm1y+RaXE3w3zCAIYd/ClFBMEA6IE4oT0sMOes63lfYzcrfS0U
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="290397083"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="290397083"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 12:59:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="780070424"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 06 Aug 2022 12:59:07 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKPww-000KdV-1u;
        Sat, 06 Aug 2022 19:59:06 +0000
Date:   Sun, 7 Aug 2022 03:58:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.10.y 499/7421]
 arch/powerpc/kernel/smp.c:1380:7: error: variable 'ret' set but not used
Message-ID: <202208070359.y2vvIVNR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srikar,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
head:   4fd9cb57a3f5e611efde7772643134385de3a5a6
commit: e91077cf1780108dc586cedf1d19f65b44fa3870 [499/7421] powerpc/smp: Update cpu_core_map on all PowerPc systems
config: powerpc-randconfig-r002-20220807 (https://download.01.org/0day-ci/archive/20220807/202208070359.y2vvIVNR-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=e91077cf1780108dc586cedf1d19f65b44fa3870
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.10.y
        git checkout e91077cf1780108dc586cedf1d19f65b44fa3870
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/powerpc/kernel/smp.c:1380:7: error: variable 'ret' set but not used [-Werror,-Wunused-but-set-variable]
           bool ret;
                ^
   1 error generated.


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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
