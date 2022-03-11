Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFF64D6255
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 14:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240564AbiCKNYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 08:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiCKNYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 08:24:11 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D38C75E59
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 05:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647004987; x=1678540987;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fmmfOEuPSCivCd3V6SdzAigo3Bao/+X4L4gBOdq0JNE=;
  b=gOw2FKPYTTdvdsGyjb59aJCx0/8OTLIVel3qS1+8yK+88vCkeQNgHqe4
   IX+k1RP1NV41Ruu+GkcQLpqGjLRUS3YezpB40cIdfySAdihFYCY2nj4hL
   w4mXJ/TePp83Az7q9QjvJQ8mdQXuFDU1SGCLGBihfbZO/c6KeFjZTY+xD
   h0lfcYXj9waYk9nVos6Ks2Rz+Dc3rHDKwfmPGXfKreFDoeh1aCMWY5vmb
   TEEcK4NLtxaNEd8bU/hTQN2OJ7odCOl3C5uE2kAYHSdL9fB55M8IN/dOD
   IQsP4JJ1EpuZP3LQzpX/XFHqGiU1XOtE+bmS102kM/cEVVZwAlZ2ObVlI
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="254398551"
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="254398551"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 05:23:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="612153662"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 11 Mar 2022 05:23:05 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSfEX-0006Sk-1X; Fri, 11 Mar 2022 13:23:05 +0000
Date:   Fri, 11 Mar 2022 21:22:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Gow <davidgow@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: lib/list-test.c:662:45: warning: variable 'head' set but not used
Message-ID: <202203112152.zpAjsGQF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20220311-151720/Xiaomeng-Tong/list_for_each_entry-make-iterator-invisiable-outside-the-loop/20220301-160113
head:   54ae283053c127aac4b946dffa0f31f9885dbb77
commit: 32c7dc1050a5376225f79589948ac5a63cb75e5a list: test: Add a test for list_traverse
date:   6 hours ago
config: arc-randconfig-r043-20220310 (https://download.01.org/0day-ci/archive/20220311/202203112152.zpAjsGQF-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/32c7dc1050a5376225f79589948ac5a63cb75e5a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20220311-151720/Xiaomeng-Tong/list_for_each_entry-make-iterator-invisiable-outside-the-loop/20220301-160113
        git checkout 32c7dc1050a5376225f79589948ac5a63cb75e5a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash kernel/ lib/ mm/ net/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   lib/list-test.c:15:9: error: expected specifier-qualifier-list before 'list_traversal_head'
      15 |         list_traversal_head(struct list_test_struct, head, list);
         |         ^~~~~~~~~~~~~~~~~~~
   lib/list-test.c: In function 'list_test_list_traverse':
   lib/list-test.c:665:29: error: 'struct list_test_struct' has no member named 'head'
     665 |         INIT_LIST_HEAD(&head.head);
         |                             ^
   lib/list-test.c:669:54: error: 'struct list_test_struct' has no member named 'head'
     669 |                 list_add_tail(&entries[i].list, &head.head);
         |                                                      ^
   lib/list-test.c:674:9: error: implicit declaration of function 'list_traverse' [-Werror=implicit-function-declaration]
     674 |         list_traverse(cur, &head.head, list) {
         |         ^~~~~~~~~~~~~
   lib/list-test.c:674:23: error: 'cur' undeclared (first use in this function)
     674 |         list_traverse(cur, &head.head, list) {
         |                       ^~~
   lib/list-test.c:674:23: note: each undeclared identifier is reported only once for each function it appears in
   lib/list-test.c:674:33: error: 'struct list_test_struct' has no member named 'head'
     674 |         list_traverse(cur, &head.head, list) {
         |                                 ^
   lib/list-test.c:674:40: error: 'list' undeclared (first use in this function)
     674 |         list_traverse(cur, &head.head, list) {
         |                                        ^~~~
   lib/list-test.c:674:45: error: expected ';' before '{' token
     674 |         list_traverse(cur, &head.head, list) {
         |                                             ^~
         |                                             ;
>> lib/list-test.c:662:45: warning: variable 'head' set but not used [-Wunused-but-set-variable]
     662 |         struct list_test_struct entries[5], head;
         |                                             ^~~~
   cc1: some warnings being treated as errors


vim +/head +662 lib/list-test.c

   659	
   660	static void list_test_list_traverse(struct kunit *test)
   661	{
 > 662		struct list_test_struct entries[5], head;
   663		int i = 0;
   664	
   665		INIT_LIST_HEAD(&head.head);
   666	
   667		for (i = 0; i < 5; ++i) {
   668			entries[i].data = i;
   669			list_add_tail(&entries[i].list, &head.head);
   670		}
   671	
   672		i = 0;
   673	
   674		list_traverse(cur, &head.head, list) {
   675			KUNIT_EXPECT_EQ(test, cur->data, i);
   676			i++;
   677		}
   678	
   679		KUNIT_EXPECT_EQ(test, i, 5);
   680	}
   681	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
