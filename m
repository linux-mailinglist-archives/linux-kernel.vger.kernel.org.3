Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C7451551A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380511AbiD2UGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380499AbiD2UGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:06:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4070DBCB4F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651262603; x=1682798603;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XZ0PrUxzCFaOl1UipzwO12nOk6Fba4jYhM0ssBWlnhc=;
  b=DBvpPSWlQp24mb4An81QYmAO3wlCZk+xuf+Ww7LyWXx1Oh8p1dRzvI9r
   /rC030jCG0K3qYRCn9spYG5RlDtgtzJ7bjvTEp5L5w2gW+uBVNvUJwitV
   pI9q4iweWYxfD2zOQSAiOcu1RjIFv5AbBCtJBn8BjSKdCFj3k8Ild4nzT
   rU5+joC3MjSCUE6Iw6nBl04AdeXcPV4UK3N6P5Gs0ZTOz4+90Hb0rSw3a
   wr7LVFayhO26CTQYwvSqLTQqHGmjQ/sN0RjSem9sQ8nEBAiPKos4gpSTI
   geglrVK24PewjPo1KuFPtc9u0p8WzEDVh82asGBFTWNCqkrV/8gs9UIu2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="248689421"
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="248689421"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 13:03:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="597504562"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 29 Apr 2022 13:03:21 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkWpk-0006an-V4;
        Fri, 29 Apr 2022 20:03:20 +0000
Date:   Sat, 30 Apr 2022 04:02:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/rxrpc-ringless 19/24]
 net/rxrpc/output.c:26: undefined reference to `udpv6_sendmsg'
Message-ID: <202204300328.igesKwMU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/rxrpc-ringless
head:   14d1ef9d0da567ca88d30b4c79706079cc997e9f
commit: fdcaaadfeb4a8eec32fe3855be0e5e3c3add5592 [19/24] rxrpc: Call udp_sendmsg() directly
config: arc-randconfig-r043-20220428 (https://download.01.org/0day-ci/archive/20220430/202204300328.igesKwMU-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/fdcaaadfeb4a8eec32fe3855be0e5e3c3add5592
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/rxrpc-ringless
        git checkout fdcaaadfeb4a8eec32fe3855be0e5e3c3add5592
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arceb-elf-ld: net/rxrpc/output.o: in function `do_udp_sendmsg':
>> net/rxrpc/output.c:26: undefined reference to `udpv6_sendmsg'
>> arceb-elf-ld: net/rxrpc/output.c:26: undefined reference to `udpv6_sendmsg'
>> arceb-elf-ld: net/rxrpc/output.c:26: undefined reference to `udpv6_sendmsg'
>> arceb-elf-ld: net/rxrpc/output.c:26: undefined reference to `udpv6_sendmsg'
>> arceb-elf-ld: net/rxrpc/output.c:26: undefined reference to `udpv6_sendmsg'
   arceb-elf-ld: net/rxrpc/output.o:net/rxrpc/output.c:26: more undefined references to `udpv6_sendmsg' follow
   pahole: .tmp_vmlinux.btf: No such file or directory
   .btf.vmlinux.bin.o: file not recognized: file format not recognized


vim +26 net/rxrpc/output.c

    20	
    21	static ssize_t do_udp_sendmsg(struct socket *sk, struct msghdr *msg, size_t len)
    22	{
    23		struct sockaddr *sa = msg->msg_name;
    24	
    25		if (sa->sa_family == AF_INET6)
  > 26			return udpv6_sendmsg(sk->sk, msg, len);
    27		return udp_sendmsg(sk->sk, msg, len);
    28	}
    29	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
