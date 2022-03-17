Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E4B4DBD88
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 04:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiCQD1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 23:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiCQD1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 23:27:11 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23A134B82
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 20:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647487553; x=1679023553;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2ziISYT6xVHbZvUhFwjhuQNk9ghSVawk9WAqQqRKfz4=;
  b=eqmAVp2gmSurP12b2l7DUyf+QHCQtkRvVKIlCmUDNnTbNeF3/gXfbisb
   q2/MEHvtI3PdEhEtdAhleYSk9yZEs9A/RVyPBrB+c5a5ifo26tq+eFMrh
   uef8ZHsfkAZ29KNJQQMn5p93SPC3p8N2h4yD8RLuBuemaSuQGam/QLaRO
   Ns7yGqhi55iTzM0X5dmOXaDSL0wCYgdBurXweLT86QccW4fJ3PkE7W76k
   PXftnYtZaatEGt+YjgzfNHWEcohulyeltl5zs/3ddwvwga3R0TXCiKBs3
   6xbuS7lupFAlNJpHB38zgBbiKHuvmcGB5E4PE2+64GIRW+oL3hlnXHhlE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="254328811"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="254328811"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 20:25:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="581153489"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 16 Mar 2022 20:25:51 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUglq-000DFQ-BU; Thu, 17 Mar 2022 03:25:50 +0000
Date:   Thu, 17 Mar 2022 11:25:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     kbuild-all@lists.01.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [gfs2:for-next 11/11] fs/gfs2/file.c:796:24: sparse: sparse:
 incompatible types in comparison expression (different type sizes):
Message-ID: <202203171137.AU0RE6e4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git for-next
head:   a20050c14edf19add5a9588cb196bb00aa410650
commit: a20050c14edf19add5a9588cb196bb00aa410650 [11/11] gfs2: Add read/write page 'fault_stats'
config: sh-randconfig-s032-20220313 (https://download.01.org/0day-ci/archive/20220317/202203171137.AU0RE6e4-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/commit/?id=a20050c14edf19add5a9588cb196bb00aa410650
        git remote add gfs2 https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
        git fetch --no-tags gfs2 for-next
        git checkout a20050c14edf19add5a9588cb196bb00aa410650
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sh SHELL=/bin/bash fs/gfs2/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/gfs2/file.c:796:24: sparse: sparse: incompatible types in comparison expression (different type sizes):
   fs/gfs2/file.c:796:24: sparse:    unsigned int *
>> fs/gfs2/file.c:796:24: sparse:    unsigned long *
   fs/gfs2/file.c:796:24: sparse: sparse: cannot size expression

vim +796 fs/gfs2/file.c

   772	
   773	static inline bool should_fault_in_pages(ssize_t ret, struct iov_iter *i,
   774						 size_t *prev_count,
   775						 size_t *window_size)
   776	{
   777		size_t count = iov_iter_count(i);
   778		size_t size, offs;
   779	
   780		if (likely(!count))
   781			return false;
   782		if (ret <= 0 && ret != -EFAULT)
   783			return false;
   784		if (!iter_is_iovec(i))
   785			return false;
   786	
   787		size = PAGE_SIZE;
   788		offs = offset_in_page(i->iov[0].iov_base + i->iov_offset);
   789		if (*prev_count != count || !*window_size) {
   790			int nr_dirtied;
   791	
   792			size = ALIGN(offs + count, PAGE_SIZE);
   793			size = min_t(size_t, size, SZ_1M);
   794			nr_dirtied = max(current->nr_dirtied_pause -
   795					 current->nr_dirtied, 8);
 > 796			size = min(size, nr_dirtied * PAGE_SIZE);
   797		}
   798	
   799		*prev_count = count;
   800		*window_size = size - offs;
   801		return true;
   802	}
   803	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
