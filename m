Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32D55A3719
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 12:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240828AbiH0Ksu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 06:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiH0Kss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 06:48:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DBF786DB
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 03:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661597326; x=1693133326;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0Y7t+HB58tCKdr3mdRNCSjjQ2ogTt37LTo5xysOqJSk=;
  b=gfNcmbRfQXJMV6J3PuOzeVMehBq3FGYtVCsSc5inrQTd0D5tiaSC2j6P
   OZZmspDbRBbIaljl+xS9mAzpUHYfpTh7Mquom9EsCf99cvu6F8xjE4ad8
   L+8/JtYzdi7hl1YjtHGWJag9OiNrwvsbNk37DOQxUX1m9iQSkFOwmBSnU
   dOn+wbs/JBBzHicFDzAt5yacmyafVkmS2p5yehIprko1nI9F3bMdOVVDa
   LtgcYPzVsnbo8+zZ2RHKVGIoNfW7PjlgaE5TzV2ktJzz5a2kyX+/+erYv
   OsFJn5tjqYOKnN/aGh2fXE1UiuzzSdEoIAyWwZ0p/fezLPm2oW2pXKtRT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="295925153"
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="295925153"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 03:48:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="561710646"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 27 Aug 2022 03:48:44 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRtMq-00006T-04;
        Sat, 27 Aug 2022 10:48:44 +0000
Date:   Sat, 27 Aug 2022 18:47:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: [ammarfaizi2-block:tj/cgroup/for-6.1 4/6] mm/memcontrol.c:5114:24:
 warning: returning 'long int' from a function with return type 'struct
 mem_cgroup *' makes pointer from integer without a cast
Message-ID: <202208271857.Dh4yH7Ka-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block tj/cgroup/for-6.1
head:   075b593f54f0f3883532cb750081cae6917bc8fe
commit: fa7e439cf90ba23ea473d0b7d85efd02ae6ccf94 [4/6] cgroup: Homogenize cgroup_get_from_id() return value
config: arc-randconfig-r043-20220827 (https://download.01.org/0day-ci/archive/20220827/202208271857.Dh4yH7Ka-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/fa7e439cf90ba23ea473d0b7d85efd02ae6ccf94
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tj/cgroup/for-6.1
        git checkout fa7e439cf90ba23ea473d0b7d85efd02ae6ccf94
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   mm/memcontrol.c: In function 'mem_cgroup_get_from_ino':
>> mm/memcontrol.c:5114:24: warning: returning 'long int' from a function with return type 'struct mem_cgroup *' makes pointer from integer without a cast [-Wint-conversion]
    5114 |                 return PTR_ERR(cgrp);
         |                        ^~~~~~~~~~~~~


vim +5114 mm/memcontrol.c

  5104	
  5105	#ifdef CONFIG_SHRINKER_DEBUG
  5106	struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
  5107	{
  5108		struct cgroup *cgrp;
  5109		struct cgroup_subsys_state *css;
  5110		struct mem_cgroup *memcg;
  5111	
  5112		cgrp = cgroup_get_from_id(ino);
  5113		if (IS_ERR(cgrp))
> 5114			return PTR_ERR(cgrp);
  5115	
  5116		css = cgroup_get_e_css(cgrp, &memory_cgrp_subsys);
  5117		if (css)
  5118			memcg = container_of(css, struct mem_cgroup, css);
  5119		else
  5120			memcg = ERR_PTR(-ENOENT);
  5121	
  5122		cgroup_put(cgrp);
  5123	
  5124		return memcg;
  5125	}
  5126	#endif
  5127	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
