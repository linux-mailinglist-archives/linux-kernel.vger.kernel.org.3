Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946664C5E65
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 20:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiB0TVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 14:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiB0TVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 14:21:21 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AA25AA43
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 11:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645989644; x=1677525644;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wOpQGDOoeeRi9x8/iidQ/5+FrEWvn/u4BMIfslCUPIs=;
  b=FK5ixWLIjd6jXFbJTynNS95tjJwaCnWMLxpIM1a98YMEcEPTqIra0pE/
   MzwZWwCHjfMD5U5JK05UPDMbH4YeEmhj5RawxV7onzc7Bq7jJxIsAehWW
   JIoVM+9AbIDz/6pqPUSeOOyCq/I+CRnviSqXNxjjicwjyj+qom7LBjsTW
   1J0M/qCRG9WvXYdFyWiKuyCxrRmJnGO92otxASnX7WbTAkDDX951+OLfd
   mdwMHjOjfhZXIoWcD8kk69yM+/5FPuocukIcoq531Spa0OOGsvJ+Yc5od
   guD402Fy7LqJA1yBFg2bZWq72rpMO0a/0RgVt3oXAwOWFkjbcoQe1mPdx
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10271"; a="232730186"
X-IronPort-AV: E=Sophos;i="5.90,141,1643702400"; 
   d="scan'208";a="232730186"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2022 11:20:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,141,1643702400"; 
   d="scan'208";a="708414952"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 Feb 2022 11:20:42 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOP61-0006kM-7v; Sun, 27 Feb 2022 19:20:41 +0000
Date:   Mon, 28 Feb 2022 03:19:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [ammarfaizi2-block:next/linux-next/master 210/370] undefined
 reference to `node_data'
Message-ID: <202202280318.MgRzHCNb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block next/linux-next/master
head:   06aeb1495c39c86ccfaf1adadc1d2200179f16eb
commit: e2ad74daf436b686b3c8456ea277bfdc94188c8e [210/370] mm: handle uninitialized numa nodes gracefully
config: mips-randconfig-r011-20220227 (https://download.01.org/0day-ci/archive/20220228/202202280318.MgRzHCNb-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/e2ad74daf436b686b3c8456ea277bfdc94188c8e
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block next/linux-next/master
        git checkout e2ad74daf436b686b3c8456ea277bfdc94188c8e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mips64-linux-ld: mm/page_alloc.o: in function `free_area_init':
>> (.init.text+0x1d94): undefined reference to `node_data'
   mips64-linux-ld: (.init.text+0x1dac): undefined reference to `node_data'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
