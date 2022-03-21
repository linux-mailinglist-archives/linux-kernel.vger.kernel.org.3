Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E954E2251
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345336AbiCUIkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245345AbiCUIks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:40:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA552CE26
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647851964; x=1679387964;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HB/vZMUvPhTjNC0m1ZXaoTqOu/2wu23OUlCr4eJMhP4=;
  b=jMPkbCyiKkTJ1beaT7csY5mehxWt/a5IM+J3l6Li38Px8kKehjuotiM4
   v0PoW+1o3R5DLR+/04lnbvVmjKMTnMvuqoOKu18K/vJqZzOe9Asha5xtJ
   9W4NET1gCJNai8JiMOOgxgShl5ZYwRezhHbGp1UaGUMLi7q8m1JOsAfPx
   dZKL2GAiuK3Gf5IL6/zV2CuwQchSMNbKXaKfyITJpIXJJLZ+mvgaDMqpo
   EM8iglNDZHFKQDkhlBXJ8l4KMF3neBW/b1dq9lljj/fnH9n+v0GT/5l4P
   V6ylOVFf+5u/BajBQDwFiKpNGVFbG+oVKUwUUUr7nimO/mxxz6Y4uVTud
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="257448381"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="257448381"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 01:39:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="716417894"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 21 Mar 2022 01:39:22 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWDZR-000Her-QU; Mon, 21 Mar 2022 08:39:21 +0000
Date:   Mon, 21 Mar 2022 16:38:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 1896/2335] ./usr/include/linux/rtnetlink.h:5:10:
 fatal error: 'uapi/linux/types.h' file not found
Message-ID: <202203211625.3a7oYbCY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: e04eea06973aee3a517cb39f8e9f54176e2a2aae [1896/2335] headers/deps: net: Optimize <uapi/linux/rtnetlink.h> dependencies
config: i386-randconfig-a012-20220314 (https://download.01.org/0day-ci/archive/20220321/202203211625.3a7oYbCY-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6ec1e3d798f8eab43fb3a91028c6ab04e115fcb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=e04eea06973aee3a517cb39f8e9f54176e2a2aae
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout e04eea06973aee3a517cb39f8e9f54176e2a2aae
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/linux/rtnetlink.h:5:10: fatal error: 'uapi/linux/types.h' file not found
   #include <uapi/linux/types.h>
            ^~~~~~~~~~~~~~~~~~~~
   1 error generated.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
