Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7025059F1DE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 05:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiHXDL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 23:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbiHXDL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 23:11:27 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6675E25EB
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 20:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661310498; x=1692846498;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1s31HwL/qmJsMfnUscxTRniE2iLAsgyMyxJVWjB7mM8=;
  b=L+vci15K9LC/WkC12ZyUpkUMqBUAg6oi91tfCGz+sZjJcqX7GY39gR+m
   ncAfBn1jFxwFvRpbGDqDS1QSHkXNrpAOGZl+oCCCj7f5Pqv85Hx1GmRGe
   9Q2e/O6TkkMcRz4uOR26480mhKRKTnuHtdTQCm9U/FSe9U9ZHLehoowWx
   MMJ3hTGF4PAXgQ81+N8TqxiQcUHREzzHZH38fyqNdIQUWdnTsDnAVOBwx
   riZ5vcNi67OBKw0sVPWkImtnOFUS/8+jCtY+YU1zKkKYGiWXVtj78DwDj
   +KRyzCiKIGpsoW9EGZUuape6KPobcmbwEYvuEf5KmUfDi2Dqf6jfgIpoK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="380143927"
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="380143927"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 20:08:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="609589787"
Received: from lkp-server02.sh.intel.com (HELO 9bbcefcddf9f) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 23 Aug 2022 20:08:16 -0700
Received: from kbuild by 9bbcefcddf9f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQgkZ-0000u4-1g;
        Wed, 24 Aug 2022 03:08:15 +0000
Date:   Wed, 24 Aug 2022 11:07:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe de Dinechin <dinechin@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-stable-rc:linux-5.4.y 3985/5188]
 include/linux/nodemask.h:380:20: error: comparison of unsigned expression in
 '>= 0' is always true
Message-ID: <202208241143.v714cX1Y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
head:   1cece69eaa889a27cf3e9f2051fcc57eda957271
commit: 73bdb2359dbc260364141c83dd1e1a5497f29d3d [3985/5188] nodemask.h: fix compilation error with GCC12
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220824/202208241143.v714cX1Y-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=73bdb2359dbc260364141c83dd1e1a5497f29d3d
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.4.y
        git checkout 73bdb2359dbc260364141c83dd1e1a5497f29d3d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/alpha/mm/numa.c:162:1: error: no previous prototype for 'setup_memory' [-Werror=missing-prototypes]
     162 | setup_memory(void *kernel_end)
         | ^~~~~~~~~~~~
   In file included from include/linux/mmzone.h:17,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:10,
                    from arch/alpha/mm/numa.c:12:
   arch/alpha/mm/numa.c: In function 'paging_init':
>> include/linux/nodemask.h:380:20: error: comparison of unsigned expression in '>= 0' is always true [-Werror=type-limits]
     380 |              (node >= 0) && (node) < MAX_NUMNODES;                  \
         |                    ^~
   include/linux/nodemask.h:433:9: note: in expansion of macro 'for_each_node_mask'
     433 |         for_each_node_mask((__node), node_states[__state])
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/nodemask.h:513:36: note: in expansion of macro 'for_each_node_state'
     513 | #define for_each_online_node(node) for_each_node_state(node, N_ONLINE)
         |                                    ^~~~~~~~~~~~~~~~~~~
   arch/alpha/mm/numa.c:218:9: note: in expansion of macro 'for_each_online_node'
     218 |         for_each_online_node(nid) {
         |         ^~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +380 include/linux/nodemask.h

   376	
   377	#if MAX_NUMNODES > 1
   378	#define for_each_node_mask(node, mask)				    \
   379		for ((node) = first_node(mask);				    \
 > 380		     (node >= 0) && (node) < MAX_NUMNODES;		    \
   381		     (node) = next_node((node), (mask)))
   382	#else /* MAX_NUMNODES == 1 */
   383	#define for_each_node_mask(node, mask)                                  \
   384		for ((node) = 0; (node) < 1 && !nodes_empty(mask); (node)++)
   385	#endif /* MAX_NUMNODES */
   386	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
