Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03065A3822
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 16:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbiH0OeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 10:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiH0Od7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 10:33:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905D26CD2D
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 07:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661610838; x=1693146838;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kYDDlWP4nvB/iCOJ5qDCkN3Q7jP20eyVvBMKpBzI4Cc=;
  b=gCXuS8ztSKvT/ns18eb/G7ydXv5flLKpWxDJotPfzNPGYsso4pQ2EHW8
   ugSyPOqXfBLW52zIb/Fq3PbADEkAdMyEW1bpDhQ1LgxfPmsYtBGO3P2Z+
   meKmQBVNn0yOSMZaRA3c2g4kZS1AZ9UuMeg56BF8Wn4yhCOCH3JusNgtt
   X6wIZMFb171Mt1GS63q9kGNcQiOUTnq+N5P91rV9H5eQPDIrI+CYnsYwX
   WZfozPHJrgUtwA6EbNEcLaz6SkcD5HhGLiCcs5ZJJcI8N112Rz5Zpn/Kf
   t5KyCL29T54zts4xa4xtESeko7hmPY3DsngWz1j+MA7wnKr5u74MGJbFL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10452"; a="294675856"
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="294675856"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 07:33:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="753166219"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 27 Aug 2022 07:33:56 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRwsm-0000E3-0M;
        Sat, 27 Aug 2022 14:33:56 +0000
Date:   Sat, 27 Aug 2022 22:33:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: [ammarfaizi2-block:tj/cgroup/for-6.1 4/6] mm/memcontrol.c:5114:31:
 sparse: sparse: incorrect type in return expression (different base types)
Message-ID: <202208272208.Gxm0hb5p-lkp@intel.com>
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
config: s390-randconfig-s041-20220827 (https://download.01.org/0day-ci/archive/20220827/202208272208.Gxm0hb5p-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/fa7e439cf90ba23ea473d0b7d85efd02ae6ccf94
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tj/cgroup/for-6.1
        git checkout fa7e439cf90ba23ea473d0b7d85efd02ae6ccf94
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   mm/memcontrol.c:4116:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   mm/memcontrol.c:4116:21: sparse:    struct mem_cgroup_threshold_ary [noderef] __rcu *
   mm/memcontrol.c:4116:21: sparse:    struct mem_cgroup_threshold_ary *
   mm/memcontrol.c:4118:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   mm/memcontrol.c:4118:21: sparse:    struct mem_cgroup_threshold_ary [noderef] __rcu *
   mm/memcontrol.c:4118:21: sparse:    struct mem_cgroup_threshold_ary *
   mm/memcontrol.c:4274:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   mm/memcontrol.c:4274:9: sparse:    struct mem_cgroup_threshold_ary [noderef] __rcu *
   mm/memcontrol.c:4274:9: sparse:    struct mem_cgroup_threshold_ary *
   mm/memcontrol.c:4368:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   mm/memcontrol.c:4368:9: sparse:    struct mem_cgroup_threshold_ary [noderef] __rcu *
   mm/memcontrol.c:4368:9: sparse:    struct mem_cgroup_threshold_ary *
>> mm/memcontrol.c:5114:31: sparse: sparse: incorrect type in return expression (different base types) @@     expected struct mem_cgroup * @@     got long @@
   mm/memcontrol.c:5998:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   mm/memcontrol.c:5998:23: sparse:    struct task_struct [noderef] __rcu *
   mm/memcontrol.c:5998:23: sparse:    struct task_struct *
   mm/memcontrol.c: note: in included file:
   include/linux/memcontrol.h:754:9: sparse: sparse: context imbalance in 'folio_lruvec_lock' - wrong count at exit
   include/linux/memcontrol.h:754:9: sparse: sparse: context imbalance in 'folio_lruvec_lock_irq' - wrong count at exit
   include/linux/memcontrol.h:754:9: sparse: sparse: context imbalance in 'folio_lruvec_lock_irqsave' - wrong count at exit
   mm/memcontrol.c:2034:6: sparse: sparse: context imbalance in 'folio_memcg_lock' - wrong count at exit
   mm/memcontrol.c:2086:17: sparse: sparse: context imbalance in '__folio_memcg_unlock' - unexpected unlock

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
