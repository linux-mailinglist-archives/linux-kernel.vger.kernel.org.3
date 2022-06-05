Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DE853D918
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 03:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242738AbiFEBha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 21:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbiFEBh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 21:37:26 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A831CB2F
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 18:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654393045; x=1685929045;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NcPyKo2zdIckSnoM5N1cfv7Llri3JUoJLOjx4t6iZ44=;
  b=PPVrYxQ8qYDxGtMYMlm58F0v2l3xtMjCCI4EuG+TxiSKzzi/oy4q7scy
   j9+ltqbAPInauH5E0bPjr+yy8ZumZTh5boXrXXQGxQVCOESbzg7KY8oqP
   nNkWoPYUizP/msE7x7N1Nsl97e7ALz9E6yzul4m8DDzT4STi8rk+Jj5le
   MqiZvhSf2RO5AKEF2uCDKYLPGpHNPbHukFJiw+Kuc1nffZ8pwfME8hvmZ
   sI44vkLCiuIk5v/muJsfEIB6uGDYBSDZD1A8Wn1RW3p9ydFPjoUVOwN//
   FJPugt7b1EfhJCS8m/nlBv/Y97VsX7B66dYt0uUHzbubH8XPWfNqr9Z8S
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="264178653"
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="264178653"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 18:37:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="583112584"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 04 Jun 2022 18:37:23 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxfCk-000BMB-QJ;
        Sun, 05 Jun 2022 01:37:22 +0000
Date:   Sun, 5 Jun 2022 09:37:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:vectorized-scrub 143/401]
 fs/xfs/xfs_trans_dquot.c:125:1: sparse: sparse: symbol
 'xfs_dqtrx_hooks_switch' was not declared. Should it be static?
Message-ID: <202206050931.IOQgQ2Bg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git vectorized-scrub
head:   1fcd9cea011a657d62ee332d161966c1ec92ffd5
commit: 93392176549e8b2278339fa745d91885c96e7947 [143/401] xfs: track quota updates during live quotacheck
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220605/202206050931.IOQgQ2Bg-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=93392176549e8b2278339fa745d91885c96e7947
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs vectorized-scrub
        git checkout 93392176549e8b2278339fa745d91885c96e7947
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/xfs/xfs_trans_dquot.c:125:1: sparse: sparse: symbol 'xfs_dqtrx_hooks_switch' was not declared. Should it be static?

Please review and possibly fold the followup patch.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
