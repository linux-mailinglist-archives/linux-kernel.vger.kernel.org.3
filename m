Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36495097F4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385058AbiDUGpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385060AbiDUGoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:44:46 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD2513FB8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523313; x=1682059313;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=T/AbSWd/WNZ+QCcuX7Hwn4M60OrqtSdcxcCHeWjiw8M=;
  b=kw3D3Ae/dqeJ7OJrrtmxCzQaggq3bbjzTcFF84kKI0Xpa19A+nHCYxCa
   DlTFLW3MKMoxRixRo5O/A5is9fR13G6DkT81ldiEGPIqPWf1iUbdNlsHI
   K1820tNvCWH0tE5LOCEROpW/PYzhr1HhCNMiWGyCl1hd4pca4/PrbX7zc
   jRTuv5VXVuAIDkMG4FvjmUtu/y+YIKCCSVMpfCqV4O7We7GZAY3U8WxVz
   Pbg/5NF8C0E0oRRfGTF71k07mdOZUSn1ar2ZnxuBv+ef8q6ytsiz7+pci
   djToXRq/UwQKNdoS55oY/o4kjcG91byBaeEXS09yMYomuwSgNidmgQe5d
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="251569921"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="251569921"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:41:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="614756923"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 20 Apr 2022 23:41:50 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQVi-0007yv-2Z;
        Thu, 21 Apr 2022 06:41:50 +0000
Date:   Thu, 21 Apr 2022 14:41:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1760/2579] fs/afs/file.c:67:17: error: use
 of undeclared identifier 'filemap_dirty_folio'; did you mean
 'filemap_get_folio'?
Message-ID: <202204210054.xNeXuMQd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: 5906052f724ace8783a32193d743f4db58a3bfee [1760/2579] headers/deps: writeback: Remove the <linux/writeback_api.h> header from <linux/writeback.h>
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220421/202204210054.xNeXuMQd-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=5906052f724ace8783a32193d743f4db58a3bfee
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 5906052f724ace8783a32193d743f4db58a3bfee
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/ fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from fs/afs/file.c:31:
   In file included from fs/afs/internal.h:29:
   In file included from include/net/sock.h:49:
   include/linux/netdevice.h:171:2: error: unknown type name 'local_t'
           local_t         rx_dropped;
           ^
   include/linux/netdevice.h:172:2: error: unknown type name 'local_t'
           local_t         tx_dropped;
           ^
   include/linux/netdevice.h:173:2: error: unknown type name 'local_t'
           local_t         rx_nohandler;
           ^
   include/linux/netdevice.h:174:24: error: use of undeclared identifier 'local_t'
   } __aligned(4 * sizeof(local_t));
                          ^
   In file included from fs/afs/file.c:31:
   In file included from fs/afs/internal.h:29:
   In file included from include/net/sock.h:66:
   In file included from include/net/dst.h:21:
   In file included from include/net/neighbour.h:7:
   include/linux/netdevice_api.h:1810:1: error: implicit declaration of function 'local_inc' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
   DEV_CORE_STATS_INC(rx_dropped)
   ^
   include/linux/netdevice_api.h:1807:3: note: expanded from macro 'DEV_CORE_STATS_INC'
                   local_inc(&p->FIELD);                                           \
                   ^
   include/linux/netdevice_api.h:1811:1: error: implicit declaration of function 'local_inc' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
   DEV_CORE_STATS_INC(tx_dropped)
   ^
   include/linux/netdevice_api.h:1807:3: note: expanded from macro 'DEV_CORE_STATS_INC'
                   local_inc(&p->FIELD);                                           \
                   ^
   include/linux/netdevice_api.h:1812:1: error: implicit declaration of function 'local_inc' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
   DEV_CORE_STATS_INC(rx_nohandler)
   ^
   include/linux/netdevice_api.h:1807:3: note: expanded from macro 'DEV_CORE_STATS_INC'
                   local_inc(&p->FIELD);                                           \
                   ^
>> fs/afs/file.c:67:17: error: use of undeclared identifier 'filemap_dirty_folio'; did you mean 'filemap_get_folio'?
           .dirty_folio    = afs_dirty_folio,
                             ^~~~~~~~~~~~~~~
                             filemap_get_folio
   fs/afs/internal.h:1540:25: note: expanded from macro 'afs_dirty_folio'
   #define afs_dirty_folio filemap_dirty_folio
                           ^
   include/linux/pagemap.h:525:29: note: 'filemap_get_folio' declared here
   static inline struct folio *filemap_get_folio(struct address_space *mapping,
                               ^
>> fs/afs/file.c:67:17: error: incompatible function pointer types initializing 'bool (*)(struct address_space *, struct folio *)' (aka '_Bool (*)(struct address_space *, struct folio *)') with an expression of type 'struct folio *(struct address_space *, unsigned long)' [-Werror,-Wincompatible-function-pointer-types]
           .dirty_folio    = afs_dirty_folio,
                             ^~~~~~~~~~~~~~~
   fs/afs/internal.h:1540:25: note: expanded from macro 'afs_dirty_folio'
   #define afs_dirty_folio filemap_dirty_folio
                           ^~~~~~~~~~~~~~~~~~~
   9 errors generated.


vim +67 fs/afs/file.c

^1da177e4c3f41 Linus Torvalds          2005-04-16  63  
75bd228d5637b5 David Howells           2021-06-29  64  const struct address_space_operations afs_file_aops = {
bc899ee1c898e5 David Howells           2021-06-29  65  	.readpage	= netfs_readpage,
bc899ee1c898e5 David Howells           2021-06-29  66  	.readahead	= netfs_readahead,
8fb72b4a76933a Matthew Wilcox (Oracle  2022-02-09 @67) 	.dirty_folio	= afs_dirty_folio,
a42442dd736941 Matthew Wilcox (Oracle  2022-02-09  68) 	.launder_folio	= afs_launder_folio,
416351f28d2b31 David Howells           2007-05-09  69  	.releasepage	= afs_releasepage,
fcf227daed82a2 Matthew Wilcox (Oracle  2022-02-09  70) 	.invalidate_folio = afs_invalidate_folio,
15b4650e55e06d Nicholas Piggin         2008-10-15  71  	.write_begin	= afs_write_begin,
15b4650e55e06d Nicholas Piggin         2008-10-15  72  	.write_end	= afs_write_end,
31143d5d515ece David Howells           2007-05-09  73  	.writepage	= afs_writepage,
31143d5d515ece David Howells           2007-05-09  74  	.writepages	= afs_writepages,
^1da177e4c3f41 Linus Torvalds          2005-04-16  75  };
^1da177e4c3f41 Linus Torvalds          2005-04-16  76  

:::::: The code at line 67 was first introduced by commit
:::::: 8fb72b4a76933ae6f86725cc8e4a8190ba84d755 fscache: Convert fscache_set_page_dirty() to fscache_dirty_folio()

:::::: TO: Matthew Wilcox (Oracle) <willy@infradead.org>
:::::: CC: Matthew Wilcox (Oracle) <willy@infradead.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
