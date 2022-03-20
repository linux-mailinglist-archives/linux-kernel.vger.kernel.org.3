Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B464E1C44
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 16:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245362AbiCTPXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 11:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238221AbiCTPXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 11:23:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA6C1AEC90
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 08:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647789749; x=1679325749;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7h7VKqjqREY/mBDGPxzGzD0dmkyuCZT5dWmwIMhSAlE=;
  b=d1JlAMa9seKbXggxc8nDUAmD1KxcaC9bqtcsjjWIjl3w/SVsM6fBFXgP
   KgjVh639+7jt80rll9IeMyHpNUwizgQu0iMzjsRZvS+CLvkL11JB92XCY
   YBSM7L2s1+9kHQqOACIdlsaZTX7w1GYOhLrC7XBc03Ivil2VGt0te+cK8
   U4rDmWJr5Jj739ykAWZCCu9wsJxaKlUF8ahIqJ1NgBnLQ3H/82OBqxiil
   8Xprfyf17ZIZWuSCvlEV6HNE1W1VjuMfTvvK7dCNzvqlUCnypHlsFh/dU
   8aymG7rE6WHevfdU4FacopJSA9v0jLkG2Ls6DTciwRfXn1iRJfgNOW5Hw
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="343836269"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="343836269"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 08:22:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="716193914"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 20 Mar 2022 08:22:27 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVxNz-000H1I-3G; Sun, 20 Mar 2022 15:22:27 +0000
Date:   Sun, 20 Mar 2022 23:22:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 1563/2335] ./usr/include/linux/if_link.h:5:10:
 fatal error: 'uapi/linux/netlink.h' file not found
Message-ID: <202203202314.QNWyvGYM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: f9feb19bd4ff82d90e72d9471ed90de86b38aeb5 [1563/2335] headers/deps: net: Optimize <uapi/linux/if_link.h>
config: i386-randconfig-a012-20220314 (https://download.01.org/0day-ci/archive/20220320/202203202314.QNWyvGYM-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6ec1e3d798f8eab43fb3a91028c6ab04e115fcb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=f9feb19bd4ff82d90e72d9471ed90de86b38aeb5
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout f9feb19bd4ff82d90e72d9471ed90de86b38aeb5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/linux/if_link.h:5:10: fatal error: 'uapi/linux/netlink.h' file not found
   #include <uapi/linux/netlink.h>
            ^~~~~~~~~~~~~~~~~~~~~~
   1 error generated.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
