Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661BE5ABB94
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 02:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiICANp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 20:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiICANm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 20:13:42 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5FAE726B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 17:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662164014; x=1693700014;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=72/WkZh44x271usWu2tdKgvUpZAOEpvaKjYt39Jf9lY=;
  b=E+D/eJCQ0QSOxfmgpwe1fglwW0Rc9rV9KxIWRVT16IJdiC7tJMbpDzff
   inieGbuc0FWjvtAfoAkSAygB3kdkwzps/fp6ZAYx/r7TgDTAvYRvXYf+4
   oP8jJXui2XOEImka883HRsuPHMpQHtEp++hSfhCP+hHw8XSULX8vs46q5
   c89u4KGL5VVNmPTtR9Tg5A1f9/M3/Sd9xcEpqx4NXX5zxbgjqrEdJ8vuF
   z4QPA/MamGYVSYlNc6pkgB5tjyBoG71a8TF10AfmULmrVXU+Xevc9L0k1
   ocU2lw2HQFVvD7so2S6LnCeU4GMBlHsSxzSCw/NBfbFkT+7/CGRN/xAET
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="294852083"
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="294852083"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 17:13:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="646291714"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 02 Sep 2022 17:13:32 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUGmx-0000lj-1d;
        Sat, 03 Sep 2022 00:13:31 +0000
Date:   Sat, 3 Sep 2022 08:12:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     kbuild-all@lists.01.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Subject: [driver-core:driver-core-linus 9/9]
 drivers/base/arch_topology.c:727:24: warning: returning 'int' from a
 function with return type 'const struct cpumask *' makes pointer from
 integer without a cast
Message-ID: <202209030824.SouwDV5M-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git driver-core-linus
head:   6b66ca0bac1b9cee7608d7c4dc59b699458b4cb8
commit: 6b66ca0bac1b9cee7608d7c4dc59b699458b4cb8 [9/9] arch_topology: Make cluster topology span at least SMT CPUs
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20220903/202209030824.SouwDV5M-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?id=6b66ca0bac1b9cee7608d7c4dc59b699458b4cb8
        git remote add driver-core https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
        git fetch --no-tags driver-core driver-core-linus
        git checkout 6b66ca0bac1b9cee7608d7c4dc59b699458b4cb8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/base/arch_topology.c: In function 'cpu_clustergroup_mask':
   drivers/base/arch_topology.c:727:24: error: implicit declaration of function 'cpu_smt_mask'; did you mean 'cpu_cpu_mask'? [-Werror=implicit-function-declaration]
     727 |                 return cpu_smt_mask(cpu);
         |                        ^~~~~~~~~~~~
         |                        cpu_cpu_mask
>> drivers/base/arch_topology.c:727:24: warning: returning 'int' from a function with return type 'const struct cpumask *' makes pointer from integer without a cast [-Wint-conversion]
     727 |                 return cpu_smt_mask(cpu);
         |                        ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +727 drivers/base/arch_topology.c

   718	
   719	const struct cpumask *cpu_clustergroup_mask(int cpu)
   720	{
   721		/*
   722		 * Forbid cpu_clustergroup_mask() to span more or the same CPUs as
   723		 * cpu_coregroup_mask().
   724		 */
   725		if (cpumask_subset(cpu_coregroup_mask(cpu),
   726				   &cpu_topology[cpu].cluster_sibling))
 > 727			return cpu_smt_mask(cpu);
   728	
   729		return &cpu_topology[cpu].cluster_sibling;
   730	}
   731	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
