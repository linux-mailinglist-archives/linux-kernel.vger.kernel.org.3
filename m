Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157464DD7B2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbiCRKKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbiCRKKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:10:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170D81FAA35
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647598162; x=1679134162;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=m/eQcFrpbCOuyJXwX+M3RqbhevfZRYc4a3xFNpq3x0M=;
  b=UaJpzR363I3uG5lClFqIvmemnrVzadrOQsaWFV3+fRZyXfk8dTqpwJEI
   80yBqSQBclbtkZ3j/qU1e7lAnKx9SyPpmsK3ezgGTyXsJgDeaUp37W1nQ
   5ncgrl8jsuFJAYLrN5sYugshNNrED7RPqTMzLyXG7zeb2ix20HRXjYor6
   kO6ZmVnJg+TR5C9RXL7Jqe15TmnWedR+Nun5TJo35jxuUP0JvTDYXSXCH
   n7zjprrtsel7IzCbcpK/6rsiZVq3282qUASbbC4VbJ6TYzYOmvTJLKgfu
   1DGhjz7uGefvjr4X6JFHbaAo0X9Kww9DGOo/zlo+YjPdpRxhONRO8k99D
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="255933604"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="255933604"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 03:09:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="715409557"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 18 Mar 2022 03:09:19 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nV9Xq-000EeD-R9; Fri, 18 Mar 2022 10:09:18 +0000
Date:   Fri, 18 Mar 2022 18:08:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 1788/2335] lib/memcat_p.c:10:8: warning: no
 previous prototype for function '__memcat_p'
Message-ID: <202203181728.i1dteMPk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: f4a35864aeccc248d3c2122bf0a8f2ba77ea8c2f [1788/2335] headers/deps: smp: Optimize <linux/smp.h> dependencies, remove <linux/smp_api.h> inclusion
config: x86_64-randconfig-a001 (https://download.01.org/0day-ci/archive/20220318/202203181728.i1dteMPk-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6ec1e3d798f8eab43fb3a91028c6ab04e115fcb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=f4a35864aeccc248d3c2122bf0a8f2ba77ea8c2f
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout f4a35864aeccc248d3c2122bf0a8f2ba77ea8c2f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> lib/memcat_p.c:10:8: warning: no previous prototype for function '__memcat_p' [-Wmissing-prototypes]
   void **__memcat_p(void **a, void **b)
          ^
   lib/memcat_p.c:10:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void **__memcat_p(void **a, void **b)
   ^
   static 
   1 warning generated.


vim +/__memcat_p +10 lib/memcat_p.c

93048c0944150b3 Alexander Shishkin 2018-10-16   4  
93048c0944150b3 Alexander Shishkin 2018-10-16   5  /*
93048c0944150b3 Alexander Shishkin 2018-10-16   6   * Merge two NULL-terminated pointer arrays into a newly allocated
93048c0944150b3 Alexander Shishkin 2018-10-16   7   * array, which is also NULL-terminated. Nomenclature is inspired by
93048c0944150b3 Alexander Shishkin 2018-10-16   8   * memset_p() and memcat() found elsewhere in the kernel source tree.
93048c0944150b3 Alexander Shishkin 2018-10-16   9   */
93048c0944150b3 Alexander Shishkin 2018-10-16 @10  void **__memcat_p(void **a, void **b)

:::::: The code at line 10 was first introduced by commit
:::::: 93048c0944150b316a15f92c41a4d626c8df37fd lib: Fix ia64 bootloader linkage

:::::: TO: Alexander Shishkin <alexander.shishkin@linux.intel.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
