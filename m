Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306C34DE969
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 17:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243649AbiCSQwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 12:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240827AbiCSQwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 12:52:49 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDED3BA63
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 09:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647708688; x=1679244688;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=r0ZwQnSdIn2k/wpsSTH6D3HhFK1ygdakQNibeXWBKKw=;
  b=cL16xFM2Yz7zF94y6thhgG4UeMWx91UWDjCjcfXkHNi72jyycYNsovD5
   9MarG4O42wKpJUOKGIKT+PRdmdKyjfoJuPwa8a/4mrxcJBqVvPDCG/7NT
   ue3ylRoMOqJNWQzRcXIEoi9RMQWbe236+ukFQ17D+ZFd1ux9PLdWZ2Cwt
   kMHvQ3K1o3CxjBO8GPdRnBLfwMyA0KuxdRwxuyy4PqQYArXNjXfIImMe9
   57tLK4OPHlld44Obp02DqXP+YJoFrp4wncvnR9sJEkEPnZff2XuHgTPSA
   UG2w7/CX88/JJWfZ0EGbrl7EJPHTkmbpfNNvhIScnAQmNicKPQBzZaD+y
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="237920834"
X-IronPort-AV: E=Sophos;i="5.90,194,1643702400"; 
   d="scan'208";a="237920834"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 09:51:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,194,1643702400"; 
   d="scan'208";a="582329374"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 19 Mar 2022 09:51:26 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVcIX-000G87-Rv; Sat, 19 Mar 2022 16:51:25 +0000
Date:   Sun, 20 Mar 2022 00:50:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jlayton:ceph-sparse-read 14/15] net/ceph/osd_client.c:5848:28:
 sparse: sparse: cast to restricted __le64
Message-ID: <202203200056.t5z11wVh-lkp@intel.com>
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
head:   24b6ede729dbd3c2675c762b74efb51eaa450576
commit: 26663dc52a5f3f90709beab073943d5d542c14fe [14/15] libceph: add sparse read support to OSD client
config: powerpc64-randconfig-s031-20220319 (https://download.01.org/0day-ci/archive/20220320/202203200056.t5z11wVh-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/commit/?id=26663dc52a5f3f90709beab073943d5d542c14fe
        git remote add jlayton https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
        git fetch --no-tags jlayton ceph-sparse-read
        git checkout 26663dc52a5f3f90709beab073943d5d542c14fe
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash net/ceph/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> net/ceph/osd_client.c:5848:28: sparse: sparse: cast to restricted __le64
>> net/ceph/osd_client.c:5848:28: sparse: sparse: cast from restricted __le32
   net/ceph/osd_client.c:5849:28: sparse: sparse: cast to restricted __le64
   net/ceph/osd_client.c:5849:28: sparse: sparse: cast from restricted __le32

vim +5848 net/ceph/osd_client.c

  5839	
  5840	#ifdef __BIG_ENDIAN
  5841	static inline void convert_extent_map(struct ceph_sparse_read *sr)
  5842	{
  5843		int i;
  5844	
  5845		for (i = 0; i < sr->sr_count; i++) {
  5846			struct ceph_sparse_extent *ext = &sr->sr_extent[i];
  5847	
> 5848			ext->off = le64_to_cpu((__force __le32)ext->off);
  5849			ext->len = le64_to_cpu((__force __le32)ext->len);
  5850		}
  5851	}
  5852	#else
  5853	static inline void convert_extent_map(struct ceph_sparse_read *sr)
  5854	{
  5855	}
  5856	#endif
  5857	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
