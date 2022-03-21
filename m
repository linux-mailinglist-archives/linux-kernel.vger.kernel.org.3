Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A6F4E1FD3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 06:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344287AbiCUFR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 01:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbiCUFR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 01:17:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976B92BB03
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 22:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647839762; x=1679375762;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=szmX5mQ1irZlur5g+LvTvMsi9E1E7QaV9jSuI6zk0wU=;
  b=XkGSigN0pDkOyvlrgN7OcZVGTXSmTs+ybUImesAuf8quMHNFqQU2h0Aj
   JCj93cPO/AEqQSHy/G8YtObbK+8zJ22ImeS7ngFRSBLU8z6r/wK1yJP1e
   xFbfW8cEnWHWxChXtul3rI6Exthveq9H7cy472HZjqfh6WfRYKDKC1ihq
   dd50UO+jb2mCOqswrwujyMKCJrn/D6FGBmRVlKtLUHt+OCnbP/Ya4haeh
   ANdxEJ1mb5C8tY0xz/qGP3i84dO8Rzh6Quo1xLUwqJm/jgONGtGv9KUjG
   Pdct+3lVvKAgtKG23xrqHJn/ZEf6PRkK9QXKKkpwNoDO2xQU5q/3PFK3g
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="257189097"
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; 
   d="scan'208";a="257189097"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 22:16:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; 
   d="scan'208";a="500042968"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 20 Mar 2022 22:16:00 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWAOd-000HVJ-Qv; Mon, 21 Mar 2022 05:15:59 +0000
Date:   Mon, 21 Mar 2022 13:15:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 1895/2335] ./usr/include/linux/neighbour.h:5:10:
 fatal error: 'uapi/linux/types.h' file not found
Message-ID: <202203211317.61fjNukZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: 8941ec82b6cca439dcb9fafcc1955ebf70746139 [1895/2335] headers/deps: net: Optimize <uapi/linux/neighbour.h> dependencies
config: i386-randconfig-a012-20220314 (https://download.01.org/0day-ci/archive/20220321/202203211317.61fjNukZ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6ec1e3d798f8eab43fb3a91028c6ab04e115fcb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=8941ec82b6cca439dcb9fafcc1955ebf70746139
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 8941ec82b6cca439dcb9fafcc1955ebf70746139
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/linux/neighbour.h:5:10: fatal error: 'uapi/linux/types.h' file not found
   #include <uapi/linux/types.h>
            ^~~~~~~~~~~~~~~~~~~~
   1 error generated.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
