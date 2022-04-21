Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567A150987F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385318AbiDUGrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385187AbiDUGp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:45:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E6615817
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523372; x=1682059372;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5x/GaOdy39Ig7Apy9+wqMzr77VRml13pyAZosPYaShY=;
  b=bm3AYcplvp7fVD/US08gz5+atk6IVpgywLflo9XFzCIoQIYQ6pT9RIiW
   UCzhXpQYirdsx1n1rTTp0I+ni6pVMIfHgYPzhkH1Esp6CKF0zVHdzQs4w
   lq8FiOSMi1tpvql81ImReOOcYEs90fSHqC9k8yRjPJ6e7zWYs0xpwSpYD
   F5evbzMtXgCGrMc0JNFUADVGoPWRAzfwkx4VQG+d1jaePAJpoOLSP2OWP
   hAf26htd5lCUmCJ6LEbB5wRHtX3Prt8ET5PzhDY6vcFEpzbLVXxU8Qj8y
   l/U9lLhPea7i2KjtDe/OlcZjU1NucUyVRGZxng7vsGn/0BUL5AmL5FcxL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="264429184"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="264429184"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:42:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="530131476"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 20 Apr 2022 23:42:50 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQWg-0007zZ-9h;
        Thu, 21 Apr 2022 06:42:50 +0000
Date:   Thu, 21 Apr 2022 14:42:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1760/2579] fs/ceph/cache.h:130:16: error:
 implicit declaration of function 'filemap_dirty_folio'; did you mean
 'filemap_get_folio'?
Message-ID: <202204210519.7NXwmnKd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: 5906052f724ace8783a32193d743f4db58a3bfee [1760/2579] headers/deps: writeback: Remove the <linux/writeback_api.h> header from <linux/writeback.h>
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220421/202204210519.7NXwmnKd-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=5906052f724ace8783a32193d743f4db58a3bfee
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 5906052f724ace8783a32193d743f4db58a3bfee
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/ fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from fs/ceph/super.c:31:
   fs/ceph/cache.h: In function 'ceph_fscache_dirty_folio':
>> fs/ceph/cache.h:130:16: error: implicit declaration of function 'filemap_dirty_folio'; did you mean 'filemap_get_folio'? [-Werror=implicit-function-declaration]
     130 |         return filemap_dirty_folio(mapping, folio);
         |                ^~~~~~~~~~~~~~~~~~~
         |                filemap_get_folio
   cc1: some warnings being treated as errors
--
   In file included from include/net/sock.h:49,
                    from fs/afs/internal.h:29,
                    from fs/afs/file.c:31:
   include/linux/netdevice.h:171:9: error: unknown type name 'local_t'
     171 |         local_t         rx_dropped;
         |         ^~~~~~~
   include/linux/netdevice.h:172:9: error: unknown type name 'local_t'
     172 |         local_t         tx_dropped;
         |         ^~~~~~~
   include/linux/netdevice.h:173:9: error: unknown type name 'local_t'
     173 |         local_t         rx_nohandler;
         |         ^~~~~~~
   In file included from include/linux/compiler_types.h:73,
                    from <command-line>:
   include/linux/netdevice.h:174:24: error: 'local_t' undeclared here (not in a function)
     174 | } __aligned(4 * sizeof(local_t));
         |                        ^~~~~~~
   include/linux/compiler_attributes.h:33:68: note: in definition of macro '__aligned'
      33 | #define __aligned(x)                    __attribute__((__aligned__(x)))
         |                                                                    ^
   In file included from include/net/neighbour.h:7,
                    from include/net/dst.h:21,
                    from include/net/sock.h:66,
                    from fs/afs/internal.h:29,
                    from fs/afs/file.c:31:
   include/linux/netdevice_api.h: In function 'dev_core_stats_rx_dropped_inc':
   include/linux/netdevice_api.h:1807:17: error: implicit declaration of function 'local_inc'; did you mean 'local_lock'? [-Werror=implicit-function-declaration]
    1807 |                 local_inc(&p->FIELD);                                           \
         |                 ^~~~~~~~~
   include/linux/netdevice_api.h:1810:1: note: in expansion of macro 'DEV_CORE_STATS_INC'
    1810 | DEV_CORE_STATS_INC(rx_dropped)
         | ^~~~~~~~~~~~~~~~~~
   In file included from fs/afs/file.c:31:
   fs/afs/file.c: At top level:
>> fs/afs/internal.h:1540:25: error: 'filemap_dirty_folio' undeclared here (not in a function); did you mean 'filemap_get_folio'?
    1540 | #define afs_dirty_folio filemap_dirty_folio
         |                         ^~~~~~~~~~~~~~~~~~~
   fs/afs/file.c:67:27: note: in expansion of macro 'afs_dirty_folio'
      67 |         .dirty_folio    = afs_dirty_folio,
         |                           ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +130 fs/ceph/cache.h

400e1286c0ec3f Jeff Layton             2021-12-07  126  
8fb72b4a76933a Matthew Wilcox (Oracle  2022-02-09  127) static inline int ceph_fscache_dirty_folio(struct address_space *mapping,
8fb72b4a76933a Matthew Wilcox (Oracle  2022-02-09  128) 		struct folio *folio)
400e1286c0ec3f Jeff Layton             2021-12-07  129  {
8fb72b4a76933a Matthew Wilcox (Oracle  2022-02-09 @130) 	return filemap_dirty_folio(mapping, folio);
400e1286c0ec3f Jeff Layton             2021-12-07  131  }
400e1286c0ec3f Jeff Layton             2021-12-07  132  

:::::: The code at line 130 was first introduced by commit
:::::: 8fb72b4a76933ae6f86725cc8e4a8190ba84d755 fscache: Convert fscache_set_page_dirty() to fscache_dirty_folio()

:::::: TO: Matthew Wilcox (Oracle) <willy@infradead.org>
:::::: CC: Matthew Wilcox (Oracle) <willy@infradead.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
