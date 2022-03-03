Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D8D4CB3C9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 01:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiCCAOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 19:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiCCAOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:14:48 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE7575C25
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 16:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646266444; x=1677802444;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Hmz3BXrASPM4rj/Ag7uj0PGIQr6Iu+Afl0jy4NilYKc=;
  b=ghmcBoTRX9vJDxMdqNq22nspOc98osXQk6/Ca7ZEAi/wTQyo4vvXRQfa
   S4mjZF1uZwlitfj7VK/W1ufuGfNT27YtN7646koikeKYbrKRYmGKZFjaI
   f3UhbFGDeBjQ8rvaavh25n9aMyDiEBvH5JNJRljiCF9TpcPauLDQR5NZK
   kfCaWUFTe/b2alEq+uRYlWpt/lEAXxClmJwkLQSAdHsKStr/RDuHjxQ4w
   oOa5Ze22orzmZGXa/vyWLXmNFuh9T+gPRODnrjIm+6lIo0GUS+Vb5hicq
   TQHSl3f5Nrm5QzbHlX0y2hN/7U1krSP81CXquaft91n3S9FQYkRBHVewT
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="233503210"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="233503210"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 16:14:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="511200012"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 02 Mar 2022 16:14:02 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPZ6X-00027m-GR; Thu, 03 Mar 2022 00:14:01 +0000
Date:   Thu, 3 Mar 2022 08:13:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-lib 25/27]
 fs/fscache/stats.c:100: undefined reference to `netfs_stats_show'
Message-ID: <202203030853.jADpk5H8-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-lib
head:   b295237bb1a924ca0723d728bb5ff30e6461ad2b
commit: 4b3ff38b2fe2b2e490f513a7b71763ae3473cafa [25/27] netfs, fscache: Make netfslib depend on fscache
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220303/202203030853.jADpk5H8-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/4b3ff38b2fe2b2e490f513a7b71763ae3473cafa
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-lib
        git checkout 4b3ff38b2fe2b2e490f513a7b71763ae3473cafa
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: fs/fscache/stats.o: in function `fscache_stats_show':
>> fs/fscache/stats.c:100: undefined reference to `netfs_stats_show'


vim +100 fs/fscache/stats.c

8e7a867bb7309fb David Howells 2021-10-20   51  
1e1236b841166f1 David Howells 2021-10-20   52  /*
1e1236b841166f1 David Howells 2021-10-20   53   * display the general statistics
1e1236b841166f1 David Howells 2021-10-20   54   */
1e1236b841166f1 David Howells 2021-10-20   55  int fscache_stats_show(struct seq_file *m, void *v)
1e1236b841166f1 David Howells 2021-10-20   56  {
1e1236b841166f1 David Howells 2021-10-20   57  	seq_puts(m, "FS-Cache statistics\n");
7f3283aba39a0f3 David Howells 2021-10-20   58  	seq_printf(m, "Cookies: n=%d v=%d vcol=%u voom=%u\n",
7f3283aba39a0f3 David Howells 2021-10-20   59  		   atomic_read(&fscache_n_cookies),
62ab63352350e88 David Howells 2021-10-20   60  		   atomic_read(&fscache_n_volumes),
62ab63352350e88 David Howells 2021-10-20   61  		   atomic_read(&fscache_n_volumes_collision),
62ab63352350e88 David Howells 2021-10-20   62  		   atomic_read(&fscache_n_volumes_nomem)
62ab63352350e88 David Howells 2021-10-20   63  		   );
1e1236b841166f1 David Howells 2021-10-20   64  
7f3283aba39a0f3 David Howells 2021-10-20   65  	seq_printf(m, "Acquire: n=%u ok=%u oom=%u\n",
7f3283aba39a0f3 David Howells 2021-10-20   66  		   atomic_read(&fscache_n_acquires),
7f3283aba39a0f3 David Howells 2021-10-20   67  		   atomic_read(&fscache_n_acquires_ok),
7f3283aba39a0f3 David Howells 2021-10-20   68  		   atomic_read(&fscache_n_acquires_oom));
7f3283aba39a0f3 David Howells 2021-10-20   69  
12bb21a29c19aae David Howells 2021-10-20   70  	seq_printf(m, "LRU    : n=%u exp=%u rmv=%u drp=%u at=%ld\n",
12bb21a29c19aae David Howells 2021-10-20   71  		   atomic_read(&fscache_n_cookies_lru),
12bb21a29c19aae David Howells 2021-10-20   72  		   atomic_read(&fscache_n_cookies_lru_expired),
12bb21a29c19aae David Howells 2021-10-20   73  		   atomic_read(&fscache_n_cookies_lru_removed),
12bb21a29c19aae David Howells 2021-10-20   74  		   atomic_read(&fscache_n_cookies_lru_dropped),
12bb21a29c19aae David Howells 2021-10-20   75  		   timer_pending(&fscache_cookie_lru_timer) ?
12bb21a29c19aae David Howells 2021-10-20   76  		   fscache_cookie_lru_timer.expires - jiffies : 0);
12bb21a29c19aae David Howells 2021-10-20   77  
d24af13e2e2358a David Howells 2021-10-20   78  	seq_printf(m, "Invals : n=%u\n",
d24af13e2e2358a David Howells 2021-10-20   79  		   atomic_read(&fscache_n_invalidates));
d24af13e2e2358a David Howells 2021-10-20   80  
16a96bdf92d5af0 David Howells 2021-10-20   81  	seq_printf(m, "Updates: n=%u rsz=%u rsn=%u\n",
16a96bdf92d5af0 David Howells 2021-10-20   82  		   atomic_read(&fscache_n_updates),
16a96bdf92d5af0 David Howells 2021-10-20   83  		   atomic_read(&fscache_n_resizes),
16a96bdf92d5af0 David Howells 2021-10-20   84  		   atomic_read(&fscache_n_resizes_null));
7f3283aba39a0f3 David Howells 2021-10-20   85  
7f3283aba39a0f3 David Howells 2021-10-20   86  	seq_printf(m, "Relinqs: n=%u rtr=%u drop=%u\n",
7f3283aba39a0f3 David Howells 2021-10-20   87  		   atomic_read(&fscache_n_relinquishes),
7f3283aba39a0f3 David Howells 2021-10-20   88  		   atomic_read(&fscache_n_relinquishes_retire),
7f3283aba39a0f3 David Howells 2021-10-20   89  		   atomic_read(&fscache_n_relinquishes_dropped));
7f3283aba39a0f3 David Howells 2021-10-20   90  
9f08ebc3438baaa David Howells 2021-10-22   91  	seq_printf(m, "NoSpace: nwr=%u ncr=%u cull=%u\n",
3929eca769b5a23 David Howells 2021-10-21   92  		   atomic_read(&fscache_n_no_write_space),
9f08ebc3438baaa David Howells 2021-10-22   93  		   atomic_read(&fscache_n_no_create_space),
9f08ebc3438baaa David Howells 2021-10-22   94  		   atomic_read(&fscache_n_culled));
3929eca769b5a23 David Howells 2021-10-21   95  
8e7a867bb7309fb David Howells 2021-10-20   96  	seq_printf(m, "IO     : rd=%u wr=%u\n",
8e7a867bb7309fb David Howells 2021-10-20   97  		   atomic_read(&fscache_n_read),
8e7a867bb7309fb David Howells 2021-10-20   98  		   atomic_read(&fscache_n_write));
8e7a867bb7309fb David Howells 2021-10-20   99  
1e1236b841166f1 David Howells 2021-10-20 @100  	netfs_stats_show(m);

:::::: The code at line 100 was first introduced by commit
:::::: 1e1236b841166f1d2daf36fdf6bb3e656bc5f5ca fscache: Introduce new driver

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: David Howells <dhowells@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
