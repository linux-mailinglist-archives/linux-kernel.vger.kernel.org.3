Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF23554DC74
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359611AbiFPIH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359554AbiFPIHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:07:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406F119C3A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 01:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655366874; x=1686902874;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PJ6GmqZ9PT2Awp3dplYnHTw/TGRHqjdNrF02ItrKOV4=;
  b=NOmR4R5NwjfGcYGIWhKRtruT56da/JxY/wKX/NvVqX2f8BaCIiTLjykM
   F+Xx4s53Cho2sg4iPl6m6aaDum32cXEAydU1ajKt/NJIvNN/Vz0J5mh0/
   xoukta334PLw8q3pr3h2Tjw2vKvW/ia9uS58aaLfkgC9qk9ZTFT1IDlch
   Yn1i/d8snRydnD05PoTga3ELh/tKaJJd1JzSBmZdJ2/4EqlrO5QOv9x+B
   icT0wqJDKOM2t2P/0zBgo2nmuVa4oInP/jJB40Lh5VjVsJyj80dumuCLW
   bZKW8urATSJPRwB0ocQ264uXXLMSmX7ai49KSjU+0P8ft3NU9NMUWXUS/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="259657916"
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="259657916"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 01:07:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="713276247"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 16 Jun 2022 01:07:52 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1kXf-000OCL-IE;
        Thu, 16 Jun 2022 08:07:51 +0000
Date:   Thu, 16 Jun 2022 16:07:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/rxrpc-ringless-2 15/24]
 net/rxrpc/output.c:23:19: warning: unused variable 'sa'
Message-ID: <202206161534.tpQzkyUT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/rxrpc-ringless-2
head:   3f41f1279858b9676cd6724d54e4323696e1ac07
commit: 4d6e89b6fafafd93ba38b1d86b8adbaa4401802c [15/24] rxrpc: Call udp_sendmsg() directly
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220616/202206161534.tpQzkyUT-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f0e608de27b3d568000046eebf3712ab542979d6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/4d6e89b6fafafd93ba38b1d86b8adbaa4401802c
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/rxrpc-ringless-2
        git checkout 4d6e89b6fafafd93ba38b1d86b8adbaa4401802c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/rxrpc/

If you fix the issue, kindly add following tag where applicable
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
