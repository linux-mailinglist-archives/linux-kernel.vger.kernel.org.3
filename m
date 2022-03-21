Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297ED4E1EE7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 02:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344097AbiCUBwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 21:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242733AbiCUBwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 21:52:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B7912A8F6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 18:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647827487; x=1679363487;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fzt41KSKa4/2XvYlMa4CvDxRgn/3MOkiGKzHbYxHBb8=;
  b=AhDWAqWQskebQw4kIjgKIeR4svdhHAzmGEH6pxiMYwY0KyztBDypuBFu
   MblreZ8mF+ekNo7CID5yf02Uw1IccYZPOa+BRc76KHkMp8vN3m6DRtqIH
   mpq/f2XYlFlXe6+u62QTwKiOiPRarFEVyYnUOARPQ00XdgqPAmjApS5L2
   Krp8kQLG/VatgyJQA5/DU1l1N2SyuaPveHJJlwRboKWL22zlFY2t1zL6B
   NirGXztDSYGSLikx8WWxO1KDgSbXQcEH7OPZeB8IVXh0JK5nw/+12cBeX
   62BqPj2YK7Ytsc9/+8LfCqstcovWFhdXzHEdgo/l2NBf2uP2zvsAOueRW
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="257640298"
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; 
   d="scan'208";a="257640298"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 18:51:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; 
   d="scan'208";a="518244257"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 20 Mar 2022 18:51:24 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nW7Ce-000HN3-9j; Mon, 21 Mar 2022 01:51:24 +0000
Date:   Mon, 21 Mar 2022 09:51:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 1894/2335] ./usr/include/linux/if_addr.h:5:10:
 fatal error: 'uapi/linux/types.h' file not found
Message-ID: <202203210958.W2be4Wwn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: d7d9f2ea99cbf84ff17c9ece920e5fe9102a6892 [1894/2335] headers/deps: net: Optimize <uapi/linux/if_addr.h> dependencies
config: i386-randconfig-a012-20220314 (https://download.01.org/0day-ci/archive/20220321/202203210958.W2be4Wwn-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6ec1e3d798f8eab43fb3a91028c6ab04e115fcb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=d7d9f2ea99cbf84ff17c9ece920e5fe9102a6892
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout d7d9f2ea99cbf84ff17c9ece920e5fe9102a6892
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/linux/if_addr.h:5:10: fatal error: 'uapi/linux/types.h' file not found
   #include <uapi/linux/types.h>
            ^~~~~~~~~~~~~~~~~~~~
   1 error generated.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
