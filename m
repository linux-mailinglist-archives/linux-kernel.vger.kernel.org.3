Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4803590049
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbiHKPkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236318AbiHKPjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:39:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ED598A46
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660232097; x=1691768097;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8VA7b9zvWGpYUuv1kaUcIR4ik9uw7iIaoAG3SVmlK2k=;
  b=LNifRE8/Z9Q2V0NM63sGbIOyWgLhLLvMboZvv+gHFp0wo+803xVpcBkQ
   cMeXGqUOC9CbXiA1TM1zHFzLAGChbANSbghjaJ1brMGELFdP9VD3L0Jrk
   lwGN/J2ra9Jtutsu70ZVRr3LbKQmBOzTQjdd2XoESlK2AzIxc+5G417fc
   65wXSOCFb7Q24WEweGR/Zwvo+V163mBz3my3Diveoc+O/kLOBnRovyWCF
   6Db0fxDpWIZ2p46xup2hVQJ+QQ86+ALirTmM3eA8EC+Qg+RXJQuAuN+DD
   V/jmBHIDyIO21G7yrF7oIEMbFVw7ZZs90d3M6xBYRCFLdwrLPG/e5KFSd
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="271155794"
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="271155794"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 08:34:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="581715898"
Received: from lkp-server02.sh.intel.com (HELO cfab306db114) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 11 Aug 2022 08:34:55 -0700
Received: from kbuild by cfab306db114 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMAD0-0000Lz-2C;
        Thu, 11 Aug 2022 15:34:54 +0000
Date:   Thu, 11 Aug 2022 23:34:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe de Dinechin <dinechin@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [stable:linux-4.19.y 2814/3442] include/linux/nodemask.h:380:20:
 error: comparison of unsigned expression in '>= 0' is always true
Message-ID: <202208112328.09GkLSzy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
head:   5c7ccbe1aade74e854fb7f9fa001dc1110a0030e
commit: 8d8681d07fc82557d09d9cdc177f9ed529d9a4d8 [2814/3442] nodemask.h: fix compilation error with GCC12
config: alpha-randconfig-r001-20220811 (https://download.01.org/0day-ci/archive/20220811/202208112328.09GkLSzy-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=8d8681d07fc82557d09d9cdc177f9ed529d9a4d8
        git remote add stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
        git fetch --no-tags stable linux-4.19.y
        git checkout 8d8681d07fc82557d09d9cdc177f9ed529d9a4d8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

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
   arch/alpha/mm/numa.c:305:9: note: in expansion of macro 'for_each_online_node'
     305 |         for_each_online_node(nid) {
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
