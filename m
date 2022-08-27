Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BA45A377E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 13:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbiH0Luw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 07:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiH0Luu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 07:50:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579AA67C85
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 04:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661601049; x=1693137049;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J5D0JGh/ASn8ZWqxyRBZ2wLpp2gAknfaMqOXbqr9VRA=;
  b=j77WkvOJ5R6X0YCT6Xr2j5zsJ5Tg5TV1Db2D1iXSeShgvTLYgbdOSnKH
   fk68db3XN9/pcw5n/ID1x/91Nk8wUuDpXB/Q+hiXH1+cg6S8SzO+0RPjG
   1wfVuZKi853Cegt4tW0DFPozAS9Nk8OPkGYo5gtHj/mx0wpOoFsb6ED2a
   NbqBqbtj1VUi46i6knaZEbldNjrlmDsLfHzsli310c87wZLQlMENJT7hh
   e7iW1pJg39ZtNK3WyDIRTDY7fWZtcoDGOqXms/PWEiQOjIQQghAJeWB8o
   s1M0CmfdQE51BYtUSjrOkQlzE6WhI3zf1YBTJozf8Rj7nTdCyj/8FQ2fq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="292235802"
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="292235802"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 04:50:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="640376968"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 27 Aug 2022 04:50:47 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRuKs-00008p-1q;
        Sat, 27 Aug 2022 11:50:46 +0000
Date:   Sat, 27 Aug 2022 19:49:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: [ammarfaizi2-block:tj/cgroup/for-6.1 4/6] mm/memcontrol.c:5114:10:
 error: incompatible integer to pointer conversion returning 'long' from a
 function with result type 'struct mem_cgroup *'
Message-ID: <202208271911.8wz6JKoa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: hexagon-randconfig-r041-20220827 (https://download.01.org/0day-ci/archive/20220827/202208271911.8wz6JKoa-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project a2100daf12fb980a29fd1a9c85ccf8eaaaf79730)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/fa7e439cf90ba23ea473d0b7d85efd02ae6ccf94
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tj/cgroup/for-6.1
        git checkout fa7e439cf90ba23ea473d0b7d85efd02ae6ccf94
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> mm/memcontrol.c:5114:10: error: incompatible integer to pointer conversion returning 'long' from a function with result type 'struct mem_cgroup *' [-Wint-conversion]
                   return PTR_ERR(cgrp);
                          ^~~~~~~~~~~~~
   1 error generated.


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
