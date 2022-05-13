Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEE25269B9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 20:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383499AbiEMS6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 14:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383481AbiEMS6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 14:58:03 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C88C6B7E3
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 11:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652468282; x=1684004282;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Z+vEbge9pIhNAti5Pe/Yg9ZNvfIkr24jyYx7aMjAK24=;
  b=nphL9vQExLc/rfFIB6DmYrAMhT0Gyo6JQ/8nCs9iJmURdV4/ZK538aAG
   +wE8wa4pqiTbDGvjc4VHuCj4vsYwPSCdbrcFKW/s/YHAaEv69IvoyKKTl
   L7pQC7aUdZA69z9A8Dc/EgR12S8D8Wcle2ka/cWRNZHc4VwySvgJr75FS
   UhZMcQAKu6cGWiFJcFb90t2jp8RSlb0G/qacyr3Q1Oe+CZmVjBYQZYjsH
   VUK369OcS3o+DCaGmaFL3Fgpo6Ug4CaqCfxfAVWE1+sStOcqhqWdbPV7I
   bYXoTnQiF6cqmTQkzeeVTkpWK7vb0fKkI11gjdZ+kRiid/uzhnT8StMjI
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="252431787"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="252431787"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 11:58:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="567322498"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 13 May 2022 11:58:00 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npaUB-000M1s-UX;
        Fri, 13 May 2022 18:57:59 +0000
Date:   Sat, 14 May 2022 02:57:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/rxrpc-ringless 24/29]
 net/rxrpc/output.c:23:19: warning: unused variable 'sa'
Message-ID: <202205140208.yDJeqbHV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/rxrpc-ringless
head:   48069f411991d171a7d5f1b963e86b737f43e046
commit: e990934c7b43d158004ce640db9f1d3259cbdc3a [24/29] rxrpc: Call udp_sendmsg() directly
config: i386-randconfig-a006 (https://download.01.org/0day-ci/archive/20220514/202205140208.yDJeqbHV-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 38189438b69ca27b4c6ce707c52dbd217583d046)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/e990934c7b43d158004ce640db9f1d3259cbdc3a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/rxrpc-ringless
        git checkout e990934c7b43d158004ce640db9f1d3259cbdc3a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/rxrpc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/rxrpc/output.c:23:19: warning: unused variable 'sa' [-Wunused-variable]
           struct sockaddr *sa = msg->msg_name;
                            ^
   1 warning generated.


vim +/sa +23 net/rxrpc/output.c

    20	
    21	static ssize_t do_udp_sendmsg(struct socket *sk, struct msghdr *msg, size_t len)
    22	{
  > 23		struct sockaddr *sa = msg->msg_name;
    24	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
