Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D317B55530A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 20:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377249AbiFVSMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 14:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358337AbiFVSMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 14:12:48 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882773B024
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 11:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655921567; x=1687457567;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ruEQ1sYPEmnsnegKdO1heCJGAKA+yF4yNjK475gQS3Y=;
  b=AwDmcBKHAEa+j80sVz/v9v1LSlwO7il8wxhAJ9Mm717vAVjOoO60nNCV
   3UtW+EVYcXB34lnCH+YeABepuHNyH23I4KlOToZe6nAqkQzgCfb7lUQlh
   cNI48rr+Hyt/G0MqJTXdvJuya5Y2sKbteEMlikwe74vY9V1lt92q4GTOP
   6o1N0ldYd1b95k//Dr5Wvo31S+T0tuf6l1BKBZVUithd1taVCmgluJ6qI
   QsGYwKSKuqO+wyBlHV/oRRUF+aXdeJv+hPB1GG+id/H+9BsLq50F6oKtP
   vmnDxvF6hKoh7URh8UDAU7GpPCJwa9HmWWuBySocbCp9CEKagKAWJr7/7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="279265147"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="279265147"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 10:47:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="644312402"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jun 2022 10:47:56 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o44SJ-0001XV-CQ;
        Wed, 22 Jun 2022 17:47:55 +0000
Date:   Thu, 23 Jun 2022 01:46:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [stable:linux-5.10.y 499/6724] arch/powerpc/kernel/smp.c:1380:7:
 error: variable 'ret' set but not used
Message-ID: <202206230132.l8PRlnsA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srikar,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
head:   4f3fee72a74c88c9039ce0405a715f6221791d06
commit: e91077cf1780108dc586cedf1d19f65b44fa3870 [499/6724] powerpc/smp: Update cpu_core_map on all PowerPc systems
config: powerpc-randconfig-r026-20220622 (https://download.01.org/0day-ci/archive/20220623/202206230132.l8PRlnsA-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8b8d126598ce7bd5243da7f94f69fa1104288bee)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=e91077cf1780108dc586cedf1d19f65b44fa3870
        git remote add stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
        git fetch --no-tags stable linux-5.10.y
        git checkout e91077cf1780108dc586cedf1d19f65b44fa3870
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/powerpc/kernel/smp.c:1380:7: error: variable 'ret' set but not used [-Werror,-Wunused-but-set-variable]
           bool ret;
                ^
   1 error generated.


vim +/ret +1380 arch/powerpc/kernel/smp.c

b8a97cb4599cda2 Srikar Dronamraju 2020-09-21  1373  
df52f6714071c49 Oliver O'Halloran 2017-06-29  1374  static void add_cpu_to_masks(int cpu)
df52f6714071c49 Oliver O'Halloran 2017-06-29  1375  {
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1376  	struct cpumask *(*submask_fn)(int) = cpu_sibling_mask;
df52f6714071c49 Oliver O'Halloran 2017-06-29  1377  	int first_thread = cpu_first_thread_sibling(cpu);
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1378  	int chip_id = cpu_to_chip_id(cpu);
84dbf66c6347206 Srikar Dronamraju 2020-10-19  1379  	cpumask_var_t mask;
bf6476152a0a084 Srikar Dronamraju 2021-04-15 @1380  	bool ret;
df52f6714071c49 Oliver O'Halloran 2017-06-29  1381  	int i;
df52f6714071c49 Oliver O'Halloran 2017-06-29  1382  
df52f6714071c49 Oliver O'Halloran 2017-06-29  1383  	/*
df52f6714071c49 Oliver O'Halloran 2017-06-29  1384  	 * This CPU will not be in the online mask yet so we need to manually
df52f6714071c49 Oliver O'Halloran 2017-06-29  1385  	 * add it to it's own thread sibling mask.
df52f6714071c49 Oliver O'Halloran 2017-06-29  1386  	 */
df52f6714071c49 Oliver O'Halloran 2017-06-29  1387  	cpumask_set_cpu(cpu, cpu_sibling_mask(cpu));
e91077cf1780108 Srikar Dronamraju 2021-08-26  1388  	cpumask_set_cpu(cpu, cpu_core_mask(cpu));
df52f6714071c49 Oliver O'Halloran 2017-06-29  1389  
df52f6714071c49 Oliver O'Halloran 2017-06-29  1390  	for (i = first_thread; i < first_thread + threads_per_core; i++)
df52f6714071c49 Oliver O'Halloran 2017-06-29  1391  		if (cpu_online(i))
df52f6714071c49 Oliver O'Halloran 2017-06-29  1392  			set_cpus_related(i, cpu, cpu_sibling_mask);
df52f6714071c49 Oliver O'Halloran 2017-06-29  1393  
425752c63b6f3fe Gautham R. Shenoy 2018-10-11  1394  	add_cpu_to_smallcore_masks(cpu);
84dbf66c6347206 Srikar Dronamraju 2020-10-19  1395  
84dbf66c6347206 Srikar Dronamraju 2020-10-19  1396  	/* In CPU-hotplug path, hence use GFP_ATOMIC */
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1397  	ret = alloc_cpumask_var_node(&mask, GFP_ATOMIC, cpu_to_node(cpu));
84dbf66c6347206 Srikar Dronamraju 2020-10-19  1398  	update_mask_by_l2(cpu, &mask);
2a636a56d2d3967 Oliver O'Halloran 2017-06-29  1399  
b8a97cb4599cda2 Srikar Dronamraju 2020-09-21  1400  	if (has_coregroup_support())
84dbf66c6347206 Srikar Dronamraju 2020-10-19  1401  		update_coregroup_mask(cpu, &mask);
84dbf66c6347206 Srikar Dronamraju 2020-10-19  1402  
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1403  	if (shared_caches)
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1404  		submask_fn = cpu_l2_cache_mask;
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1405  
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1406  	/* Update core_mask with all the CPUs that are part of submask */
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1407  	or_cpumasks_related(cpu, cpu, submask_fn, cpu_core_mask);
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1408  
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1409  	/* Skip all CPUs already part of current CPU core mask */
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1410  	cpumask_andnot(mask, cpu_online_mask, cpu_core_mask(cpu));
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1411  
e91077cf1780108 Srikar Dronamraju 2021-08-26  1412  	/* If chip_id is -1; limit the cpu_core_mask to within DIE*/
e91077cf1780108 Srikar Dronamraju 2021-08-26  1413  	if (chip_id == -1)
e91077cf1780108 Srikar Dronamraju 2021-08-26  1414  		cpumask_and(mask, mask, cpu_cpu_mask(cpu));
e91077cf1780108 Srikar Dronamraju 2021-08-26  1415  
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1416  	for_each_cpu(i, mask) {
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1417  		if (chip_id == cpu_to_chip_id(i)) {
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1418  			or_cpumasks_related(cpu, i, submask_fn, cpu_core_mask);
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1419  			cpumask_andnot(mask, mask, submask_fn(i));
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1420  		} else {
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1421  			cpumask_andnot(mask, mask, cpu_core_mask(i));
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1422  		}
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1423  	}
bf6476152a0a084 Srikar Dronamraju 2021-04-15  1424  
84dbf66c6347206 Srikar Dronamraju 2020-10-19  1425  	free_cpumask_var(mask);
a8a5356cd511db2 Paul Mackerras    2013-08-12  1426  }
a8a5356cd511db2 Paul Mackerras    2013-08-12  1427  

:::::: The code at line 1380 was first introduced by commit
:::::: bf6476152a0a084038b12b9d770e32717f54a6ab powerpc/smp: Reintroduce cpu_core_mask

:::::: TO: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
