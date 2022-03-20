Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239134E1E1C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 23:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238543AbiCTWJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 18:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbiCTWJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 18:09:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1119E25592
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 15:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647814093; x=1679350093;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Plh/FqiSM376f1OJmM+nWafMP+leQzo16Fclp08fSR4=;
  b=Ae0qNuyvx+vgSTI9QZrc/vCXm8zetwlj342I48INknQOVGv/KeJBB5DF
   85MCm/ck/D22ozRP0InlhgykIfU0EwNMB3lrEHfAccTOmrq0kDH2YFBCm
   ov7aiJw7FrpQMYKv44JD4ktkSXhA6fWj7ecDv916uPpMVdnBlEjZQD2iR
   H3EHJIx9BhLTwcMIhsKWMdO9sfxxgzJ1ByqFq1oiCzVIVUJ1mnQEuc3hZ
   6SOJD/sxF8YvRQn/zJkby/LBs1lt6V+E5lBkld0idhnqm0UC7FHuhE1J4
   wxWGCM4MSf52NmbA16gtG0+aQEKHHYldQBcHSlw3TcWokY6qwRBKdP6aZ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="237375517"
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; 
   d="scan'208";a="237375517"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 15:08:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; 
   d="scan'208";a="691989109"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 20 Mar 2022 15:08:11 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nW3id-000HGX-4c; Sun, 20 Mar 2022 22:08:11 +0000
Date:   Mon, 21 Mar 2022 06:07:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 1565/2335] ./usr/include/linux/netlink.h:5:10:
 fatal error: 'uapi/linux/types.h' file not found
Message-ID: <202203210621.FuQPmWFx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: a2b0e0550eec5116e11bfda2877f58a8082b0909 [1565/2335] headers/deps: net: Optimize <uapi/linux/netlink.h>
config: i386-randconfig-a012-20220314 (https://download.01.org/0day-ci/archive/20220321/202203210621.FuQPmWFx-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6ec1e3d798f8eab43fb3a91028c6ab04e115fcb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=a2b0e0550eec5116e11bfda2877f58a8082b0909
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout a2b0e0550eec5116e11bfda2877f58a8082b0909
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/linux/netlink.h:5:10: fatal error: 'uapi/linux/types.h' file not found
   #include <uapi/linux/types.h>
            ^~~~~~~~~~~~~~~~~~~~
   1 error generated.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
