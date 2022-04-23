Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BF350CC4B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 18:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbiDWQdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 12:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbiDWQdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 12:33:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B405A1AF31
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 09:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650731410; x=1682267410;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=erq/J6IugNqFBPl/JfID0tI97ob10byjp/0rK7jZ9Qw=;
  b=DTUiHbB9ALjsRZrf9GA4B9C+lAt/gg8LlpZ3bfRVOz3PyY6pMB8lSZWc
   Kkstx2HfbZqYeFOHnlDIxUa+5HqZowkzNO6qVb40QHjqnvjtw3P5rkZJK
   VgM7v6/bm7g6wVU3jfB5wJlspZX4Qivgz0Vx5XKGkGr7ao+gLy5SRO4Uc
   10Pou64RRqmLb5EQAk+UTGbtQR02U0tY9eylBdywuNYCuB2DaT41WULG8
   awHqZETnT3ZPfkIOSDH6Ln3XOnyUN71eDmesPeTyY9KHRmv/QNg12XLbt
   zPDMaffGUbfRNTAPxT++e68qhnrsnFYvQ1JfLpPY6MibcO7AMBghcR5C8
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="252251517"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="252251517"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 09:30:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="531346832"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 23 Apr 2022 09:30:09 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niIe8-0000Dz-DQ;
        Sat, 23 Apr 2022 16:30:08 +0000
Date:   Sun, 24 Apr 2022 00:29:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1760/2579] fs/ceph/cache.h:130:9: error:
 call to undeclared function 'filemap_dirty_folio'; ISO C99 and later do not
 support implicit function declarations
Message-ID: <202204240008.JDntM9cU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: 5906052f724ace8783a32193d743f4db58a3bfee [1760/2579] headers/deps: writeback: Remove the <linux/writeback_api.h> header from <linux/writeback.h>
config: x86_64-randconfig-c007 (https://download.01.org/0day-ci/archive/20220424/202204240008.JDntM9cU-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=5906052f724ace8783a32193d743f4db58a3bfee
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 5906052f724ace8783a32193d743f4db58a3bfee
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from fs/ceph/caps.c:33:
>> fs/ceph/cache.h:130:9: error: call to undeclared function 'filemap_dirty_folio'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           return filemap_dirty_folio(mapping, folio);
                  ^
   fs/ceph/cache.h:130:9: note: did you mean 'filemap_get_folio'?
   include/linux/pagemap.h:525:29: note: 'filemap_get_folio' declared here
   static inline struct folio *filemap_get_folio(struct address_space *mapping,
                               ^
   1 error generated.


vim +/filemap_dirty_folio +130 fs/ceph/cache.h

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
