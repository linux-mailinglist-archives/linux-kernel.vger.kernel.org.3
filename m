Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3C04C21B3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 03:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiBXCXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 21:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiBXCW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 21:22:56 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C5D15470E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 18:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645669347; x=1677205347;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Di4sYsIfYkEu4+Giu8XAfuqNF/SxuIf7a75nt55VWVU=;
  b=ArjxQ+hetaN9CDnRbPV1U2F1XDzcx3RECSRpgyQRONXs5ahERxd9lYVn
   xGvzYlKQAr5xNQA8m4V91CuHoJjv9cyWfR2NGA2rAQ08ySafbnstBZMtO
   AZ+lxBMytOxSf0BzZqG+PZcPtQHW9kR84webh/hbKsUC9AaZd17zb30Ct
   GSHi5/Hbdp5W0awpT2FnvD2fT8vaSTMpPjwZsy93/lJnRjC7Ja8RVAjVj
   HsOqBgca5YXPjkusHSWogIwL9JLThOMNXzZ8i2sZYhGCVG39+1ecjajDf
   4Qjo2sW62qkgFbrF0L5N64vDNEfGrlzy7LoBwwu3IqOzOFp2pxJcHeWuQ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="250957639"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="250957639"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 17:58:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="491426831"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 Feb 2022 17:58:57 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN3PE-000266-OV; Thu, 24 Feb 2022 01:58:56 +0000
Date:   Thu, 24 Feb 2022 09:58:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [hnaz-mm:master 209/343] page_alloc.c:undefined reference to
 `node_data'
Message-ID: <202202240938.3y49V1yT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/hnaz/linux-mm master
head:   8857950589bc3b4920d69c3e0b2c06d33f445d21
commit: 76fea45fe1651bb00c2b6ec34341fb3e130dd1b0 [209/343] mm: handle uninitialized numa nodes gracefully
config: mips-randconfig-c004-20220223 (https://download.01.org/0day-ci/archive/20220224/202202240938.3y49V1yT-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/hnaz/linux-mm/commit/76fea45fe1651bb00c2b6ec34341fb3e130dd1b0
        git remote add hnaz-mm https://github.com/hnaz/linux-mm
        git fetch --no-tags hnaz-mm master
        git checkout 76fea45fe1651bb00c2b6ec34341fb3e130dd1b0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mips64el-linux-ld: mm/page_alloc.o: in function `free_area_init':
>> page_alloc.c:(.init.text+0x1f3c): undefined reference to `node_data'
>> mips64el-linux-ld: page_alloc.c:(.init.text+0x1f54): undefined reference to `node_data'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
