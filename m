Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE70F4C1A44
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 18:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242822AbiBWRyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 12:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238904AbiBWRyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 12:54:11 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B249C1104
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 09:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645638823; x=1677174823;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fHYT0rJk61VDmMPPmyxAmM38cIqoSqWvBFRBSs/L088=;
  b=WnVhm3uRT1J/0leJMhjyAYfEYnKdHrJgnv3CVXnbEALKx6BWwxNJ/e3m
   xjEvROFDzTEtbjs5J19LwyUP0/xs3dlVawNg+4GgnsDNc2spwwLtYIHAJ
   1vmNk4dxiO92Uu9aWIwq15KcXKQYPKws3pbxjmY2OXhqCe2kE0lG+5LU9
   Rw51rhbYElAvz/nx6B2s2TLGOWCqL8LYnMLU/fXITcSf+ssOEnwLRxOcw
   cn6582xdLrEl4t+npYCYFGcyRfWlHvzYC0KaWZra3qNILPX428mbtJQXG
   zeEsY8nO/TfteyY2XX8bZuKai82YRZBB2WJStnGDCXemWGPdNnVbt/cDf
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="232661928"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="232661928"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 09:53:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="491294958"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 Feb 2022 09:53:41 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMvpc-0001fd-Mk; Wed, 23 Feb 2022 17:53:40 +0000
Date:   Thu, 24 Feb 2022 01:53:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2151/2340] net/ceph/messenger.c:537:3:
 error: implicit declaration of function '__free_page'
Message-ID: <202202240158.V9IDShLu-lkp@intel.com>
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

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   97c5eeb4de3ad324ed2a4656b46465299cfd010a
commit: d7899a3cb5a99cae76ab9cec969146e459e7deff [2151/2340] headers/deps: mm: Optimize <linux/mm_api.h> dependencies, remove <linux/gfp_api.h> inclusion
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220224/202202240158.V9IDShLu-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=d7899a3cb5a99cae76ab9cec969146e459e7deff
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout d7899a3cb5a99cae76ab9cec969146e459e7deff
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the mingo-tip/sched/headers HEAD 97c5eeb4de3ad324ed2a4656b46465299cfd010a builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   In file included from net/ceph/messenger.c:40:
   In file included from include/linux/ceph/libceph.h:16:
   include/linux/pagemap.h:362:9: error: implicit declaration of function 'folio_alloc' [-Werror,-Wimplicit-function-declaration]
           return folio_alloc(gfp, order);
                  ^
   include/linux/pagemap.h:362:9: note: did you mean 'bio_alloc'?
   include/linux/bio.h:427:27: note: 'bio_alloc' declared here
   static inline struct bio *bio_alloc(gfp_t gfp_mask, unsigned short nr_iovecs)
                             ^
   In file included from net/ceph/messenger.c:40:
   In file included from include/linux/ceph/libceph.h:16:
   include/linux/pagemap.h:362:9: warning: incompatible integer to pointer conversion returning 'int' from a function with result type 'struct folio *' [-Wint-conversion]
           return folio_alloc(gfp, order);
                  ^~~~~~~~~~~~~~~~~~~~~~~
>> net/ceph/messenger.c:537:3: error: implicit declaration of function '__free_page' [-Werror,-Wimplicit-function-declaration]
                   __free_page(con->bounce_page);
                   ^
   1 warning and 2 errors generated.


vim +/__free_page +537 net/ceph/messenger.c

31b8006e1d79e1 fs/ceph/messenger.c  Sage Weil    2009-10-06  520  
3596f4c1241d3c net/ceph/messenger.c Ilya Dryomov 2020-11-06  521  static void ceph_con_reset_protocol(struct ceph_connection *con)
3596f4c1241d3c net/ceph/messenger.c Ilya Dryomov 2020-11-06  522  {
3596f4c1241d3c net/ceph/messenger.c Ilya Dryomov 2020-11-06  523  	dout("%s con %p\n", __func__, con);
3596f4c1241d3c net/ceph/messenger.c Ilya Dryomov 2020-11-06  524  
6503e0b69c9d4d net/ceph/messenger.c Ilya Dryomov 2020-11-09  525  	ceph_con_close_socket(con);
3596f4c1241d3c net/ceph/messenger.c Ilya Dryomov 2020-11-06  526  	if (con->in_msg) {
3596f4c1241d3c net/ceph/messenger.c Ilya Dryomov 2020-11-06  527  		WARN_ON(con->in_msg->con != con);
3596f4c1241d3c net/ceph/messenger.c Ilya Dryomov 2020-11-06  528  		ceph_msg_put(con->in_msg);
3596f4c1241d3c net/ceph/messenger.c Ilya Dryomov 2020-11-06  529  		con->in_msg = NULL;
3596f4c1241d3c net/ceph/messenger.c Ilya Dryomov 2020-11-06  530  	}
3596f4c1241d3c net/ceph/messenger.c Ilya Dryomov 2020-11-06  531  	if (con->out_msg) {
3596f4c1241d3c net/ceph/messenger.c Ilya Dryomov 2020-11-06  532  		WARN_ON(con->out_msg->con != con);
3596f4c1241d3c net/ceph/messenger.c Ilya Dryomov 2020-11-06  533  		ceph_msg_put(con->out_msg);
3596f4c1241d3c net/ceph/messenger.c Ilya Dryomov 2020-11-06  534  		con->out_msg = NULL;
3596f4c1241d3c net/ceph/messenger.c Ilya Dryomov 2020-11-06  535  	}
038b8d1d1ab1cc net/ceph/messenger.c Ilya Dryomov 2021-12-30  536  	if (con->bounce_page) {
038b8d1d1ab1cc net/ceph/messenger.c Ilya Dryomov 2021-12-30 @537  		__free_page(con->bounce_page);
038b8d1d1ab1cc net/ceph/messenger.c Ilya Dryomov 2021-12-30  538  		con->bounce_page = NULL;
038b8d1d1ab1cc net/ceph/messenger.c Ilya Dryomov 2021-12-30  539  	}
3596f4c1241d3c net/ceph/messenger.c Ilya Dryomov 2020-11-06  540  
cd1a677cad9940 net/ceph/messenger.c Ilya Dryomov 2020-11-19  541  	if (ceph_msgr2(from_msgr(con->msgr)))
cd1a677cad9940 net/ceph/messenger.c Ilya Dryomov 2020-11-19  542  		ceph_con_v2_reset_protocol(con);
cd1a677cad9940 net/ceph/messenger.c Ilya Dryomov 2020-11-19  543  	else
566050e17e53db net/ceph/messenger.c Ilya Dryomov 2020-11-12  544  		ceph_con_v1_reset_protocol(con);
3596f4c1241d3c net/ceph/messenger.c Ilya Dryomov 2020-11-06  545  }
3596f4c1241d3c net/ceph/messenger.c Ilya Dryomov 2020-11-06  546  

:::::: The code at line 537 was first introduced by commit
:::::: 038b8d1d1ab1cce11a158d30bf080ff41a2cfd15 libceph: optionally use bounce buffer on recv path in crc mode

:::::: TO: Ilya Dryomov <idryomov@gmail.com>
:::::: CC: Ilya Dryomov <idryomov@gmail.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
