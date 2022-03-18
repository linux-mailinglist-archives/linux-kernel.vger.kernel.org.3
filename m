Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB2E4DE24E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 21:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240516AbiCRUUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 16:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240356AbiCRUUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 16:20:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D790435271
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 13:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647634729; x=1679170729;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UTTL7SuR/mDVFiM3OSqgbi+QSiHjVLxzF7HcuMj4pFU=;
  b=EzjxGbPdhitPpzblRTWN3B/DUTrPi6ScCif4TX6sJsGOAc/tERzmncqw
   gOVsKQVTRJnB60dyKvQnmIHyUhvVr4jmI97wdOBY8frMSrT7p4ORYs0u2
   y6u+jQT0r4y4NlXv0KM0+zr9O9qRKrhXr1ROiw2DGzUigBgdSXSh8nkSp
   cxrBZb/lv+lofIoQJL3Gqssd21xKtPWni+yqx7c345S4OOdqaaJ98Pzrh
   vMGB5Il6rPRsf4PcQ5LXYDpIAld9opgto/rdC8aSiU9d+D5D8+hcchSsy
   qjB188i+xr71Mi8GjmwN1JXPcChKadv8F5qstTl78BRU3YHsR1yZJG89J
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="343652576"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="343652576"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 13:18:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="581870814"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 18 Mar 2022 13:18:48 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVJ3f-000F7j-MM; Fri, 18 Mar 2022 20:18:47 +0000
Date:   Sat, 19 Mar 2022 04:18:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jlayton:ceph-sparse-read 14/15] net/ceph/osd_client.c:5847:50:
 error: incompatible types when initializing type 'struct ceph_sparse_extent
 *' using type 'struct ceph_sparse_extent'
Message-ID: <202203190457.rN00jXWd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git ceph-sparse-read
head:   dd42d5af0df78fdd04a5a93c0488211435bd32e6
commit: 555a255575736e3b39f6b2c70574422439b765b6 [14/15] libceph: add sparse read support to OSD client
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220319/202203190457.rN00jXWd-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/commit/?id=555a255575736e3b39f6b2c70574422439b765b6
        git remote add jlayton https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
        git fetch --no-tags jlayton ceph-sparse-read
        git checkout 555a255575736e3b39f6b2c70574422439b765b6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   net/ceph/osd_client.c: In function 'convert_extent_map':
>> net/ceph/osd_client.c:5847:50: error: incompatible types when initializing type 'struct ceph_sparse_extent *' using type 'struct ceph_sparse_extent'
    5847 |                 struct ceph_sparse_extent *ext = sr->sr_extent[i];
         |                                                  ^~


vim +5847 net/ceph/osd_client.c

  5840	
  5841	#ifdef __BIG_ENDIAN
  5842	static inline void convert_extent_map(struct ceph_sparse_read *sr)
  5843	{
  5844		int i;
  5845	
  5846		for (i = 0; i < sr->sr_count; i++) {
> 5847			struct ceph_sparse_extent *ext = sr->sr_extent[i];
  5848	
  5849			ext->off = le64_to_cpu((__force __le32)ext->off);
  5850			ext->len = le64_to_cpu((__force __le32)ext->len);
  5851		}
  5852	}
  5853	#else
  5854	static inline void convert_extent_map(struct ceph_sparse_read *sr)
  5855	{
  5856	}
  5857	#endif
  5858	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
