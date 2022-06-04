Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00B153D8B6
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 00:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242228AbiFDWLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 18:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237737AbiFDWK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 18:10:57 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0653054C
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 15:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654380656; x=1685916656;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MqouEqSwl2aK+wPn57215dEuTo1DsHIy7rSUfMgWs8w=;
  b=E19OQHXniHVXSCTITnTdHqBWgCo/1ZTE7cXu7yhnx4JZw8LBF+Zle5Bl
   6lL5Xb0gUioHeIV5mVnGystlwOhZ56lZxAK8vTUQ47vJN9sH7X7g+hYlh
   Noin+0t1CiPm1dBmzC8WdeHiquQgZ/RuB3C1J2uV15/qTh6smJcFt0EI8
   82vQlwwWi1usLOzO1RHpR0edbotowtyEYgEUXF7/fAV/eZ4uqRmoYToJR
   TOlkF9LooT8iWn1zhsx/8qqfW+scIdgp8UieTAn76AC696ISJZOn3Gaja
   XILt2/3HZkfCRbkAWMGtgsy3bGfb2a8vVbDPs5ouP+Svn+158CZ7irFrL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="258576016"
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="258576016"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 15:10:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="646955402"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jun 2022 15:10:54 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxbyv-000BFO-OL;
        Sat, 04 Jun 2022 22:10:53 +0000
Date:   Sun, 5 Jun 2022 06:10:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:vectorized-scrub 149/401] fs/xfs/xfs_inode.c:953:1:
 sparse: sparse: symbol 'xfs_nlinks_hooks_switch' was not declared. Should it
 be static?
Message-ID: <202206050637.Fo3Yr6Kj-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git vectorized-scrub
head:   1fcd9cea011a657d62ee332d161966c1ec92ffd5
commit: 2067c1659a49ddc24cac9124f142ea9a7d71e7c3 [149/401] xfs: track file link count updates during live nlinks fsck
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20220605/202206050637.Fo3Yr6Kj-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=2067c1659a49ddc24cac9124f142ea9a7d71e7c3
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs vectorized-scrub
        git checkout 2067c1659a49ddc24cac9124f142ea9a7d71e7c3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/xfs/xfs_inode.c:953:1: sparse: sparse: symbol 'xfs_nlinks_hooks_switch' was not declared. Should it be static?

Please review and possibly fold the followup patch.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
