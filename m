Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1D74E52AF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 13:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240409AbiCWNAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 09:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243951AbiCWNAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:00:05 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9447B2657F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 05:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648040315; x=1679576315;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=w0fD6UOHayE6atiMi0tgX/+OIrvXP49abIMEUIRrwPo=;
  b=jVf8z/VEzzviJZv2UaZpTu956iNVD4kzIRpAmdhlmwaUOswQ48JoYB/R
   z1UHprJzgBMj5adwwoJermee3Smmn9obrr+7OXgqBanI7Huy5cun3CiXt
   OQYacdfRWFKulzsu1ul8PcZDaXIVwBiSlUcMo/f/qwrMcZpvTZVDL45NA
   6ULUD1bgOAqyqZeoDVohWTSGm0kfv84JOexIuKrNyaB1zGqTV9MDz5Ami
   l60FMGgZgg+1PvvRW5ieFDssfoeKy6LAFYA7PW1DA0IvEoIh5kyc8FTto
   na1lZ4cVARDT8CqaxdyRwRWepMkyTjnLuigfQLIvRDZd/xs14FejjaDaB
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="258290754"
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="258290754"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 05:58:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="500989773"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 23 Mar 2022 05:58:30 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nX0ZJ-000K48-EQ; Wed, 23 Mar 2022 12:58:29 +0000
Date:   Wed, 23 Mar 2022 20:58:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: undefined reference to `node_data'
Message-ID: <202203232042.AS9SV1zv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6b1f86f8e9c7f9de7ca1cb987b2cf25e99b1ae3a
commit: 09f49dca570a917a8c6bccd7e8c61f5141534e3a mm: handle uninitialized numa nodes gracefully
date:   14 hours ago
config: mips-buildonly-randconfig-r004-20220323 (https://download.01.org/0day-ci/archive/20220323/202203232042.AS9SV1zv-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=09f49dca570a917a8c6bccd7e8c61f5141534e3a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 09f49dca570a917a8c6bccd7e8c61f5141534e3a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mips64-linux-ld: mm/page_alloc.o: in function `free_area_init':
>> (.init.text+0x1680): undefined reference to `node_data'
   mips64-linux-ld: (.init.text+0x1690): undefined reference to `node_data'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
