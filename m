Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10084B1E6E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 07:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344170AbiBKGOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 01:14:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345814AbiBKGNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:13:52 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA4D5F9C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 22:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644560013; x=1676096013;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PmHqyQPi2g+O0hYtOvmp0RaWuS5vyYozzAUJzLC6fcU=;
  b=ZDhoueLz1yn0T3oXKISIUg3utSKNK52TyRPv35p2HNQ8dG2jnDyxZECP
   SCZsQko1iWOT91/4V1mNaNa14qkOIYJ8Pvpex6kz/3S+dFWxmtLXV25Ge
   fzOQH/S2LXEN0FGdEQaH+rT3erFavjuLer1zdzDbY2dzdI5DQbGJUz+mC
   ILPQ1sJJJEZBA+oDEe3fYXb1yNlq2pFvyOXnTAAdahyTf5Q3DoTuZq+dc
   LZIDGO3yclKr4X16GlpmikvJZZMGw6B9EIU1muxUZjHXxb/4cgEm/u26S
   uMwS6/1kPZ1gyK27pqtAbjdfqkv7nuxKEJLoAioCIEQ3u03FTAgX6PAG6
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="312952970"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="312952970"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 22:13:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="679416565"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 10 Feb 2022 22:13:32 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIPBT-0004DE-Bt; Fri, 11 Feb 2022 06:13:31 +0000
Date:   Fri, 11 Feb 2022 14:13:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jlayton:ceph-fscrypt 55/57] net/ceph/messenger.c:1126:16: warning:
 comparison of distinct pointer types ('typeof (bytes) *' (aka 'unsigned int
 *') and 'typeof (((1UL) << (12))) *' (aka 'unsigned long *'))
Message-ID: <202202111436.oS410AKW-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git ceph-fscrypt
head:   adf69efebc954db1aa7af7b93febbc2a1b51dc6c
commit: 8647843c1c4c4ebffb864d049176b4d847ef3a4b [55/57] libceph: allow ceph_msg_data_advance to advance more than a page
config: riscv-randconfig-r016-20220211 (https://download.01.org/0day-ci/archive/20220211/202202111436.oS410AKW-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f6685f774697c85d6a352dcea013f46a99f9fe31)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/commit/?id=8647843c1c4c4ebffb864d049176b4d847ef3a4b
        git remote add jlayton https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
        git fetch --no-tags jlayton ceph-fscrypt
        git checkout 8647843c1c4c4ebffb864d049176b4d847ef3a4b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/cpuidle/ net/ceph/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   net/ceph/messenger.c:178:5: warning: format specifies type 'unsigned short' but the argument has type 'int' [-Wformat]
                            ntohs(in4->sin_port));
                            ^~~~~~~~~~~~~~~~~~~~
   include/linux/byteorder/generic.h:142:18: note: expanded from macro 'ntohs'
   #define ntohs(x) ___ntohs(x)
                    ^~~~~~~~~~~
   include/linux/byteorder/generic.h:137:21: note: expanded from macro '___ntohs'
   #define ___ntohs(x) __be16_to_cpu(x)
                       ^~~~~~~~~~~~~~~~
   include/uapi/linux/byteorder/little_endian.h:43:26: note: expanded from macro '__be16_to_cpu'
   #define __be16_to_cpu(x) __swab16((__force __u16)(__be16)(x))
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/swab.h:105:2: note: expanded from macro '__swab16'
           (__builtin_constant_p((__u16)(x)) ?     \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/ceph/messenger.c:184:5: warning: format specifies type 'unsigned short' but the argument has type 'int' [-Wformat]
                            ntohs(in6->sin6_port));
                            ^~~~~~~~~~~~~~~~~~~~~
   include/linux/byteorder/generic.h:142:18: note: expanded from macro 'ntohs'
   #define ntohs(x) ___ntohs(x)
                    ^~~~~~~~~~~
   include/linux/byteorder/generic.h:137:21: note: expanded from macro '___ntohs'
   #define ___ntohs(x) __be16_to_cpu(x)
                       ^~~~~~~~~~~~~~~~
   include/uapi/linux/byteorder/little_endian.h:43:26: note: expanded from macro '__be16_to_cpu'
   #define __be16_to_cpu(x) __swab16((__force __u16)(__be16)(x))
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/swab.h:105:2: note: expanded from macro '__swab16'
           (__builtin_constant_p((__u16)(x)) ?     \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> net/ceph/messenger.c:1126:16: warning: comparison of distinct pointer types ('typeof (bytes) *' (aka 'unsigned int *') and 'typeof (((1UL) << (12))) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
                   size_t cur = min(bytes, PAGE_SIZE);
                                ^~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:45:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   3 warnings generated.


vim +1126 net/ceph/messenger.c

  1122	
  1123	void ceph_msg_data_advance(struct ceph_msg_data_cursor *cursor, size_t bytes)
  1124	{
  1125		while (bytes) {
> 1126			size_t cur = min(bytes, PAGE_SIZE);
  1127	
  1128			__ceph_msg_data_advance(cursor, cur);
  1129			bytes -= cur;
  1130		}
  1131	}
  1132	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
