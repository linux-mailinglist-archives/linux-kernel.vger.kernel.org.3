Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD5D53F5EA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 08:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236928AbiFGGNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 02:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiFGGNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 02:13:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110C1B8BC2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 23:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654582427; x=1686118427;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/lNGiOirqyxfSIVNfASwxTvKyu0dbn1yeWn5GN/yU7M=;
  b=OuJ1JJyOa22jMUqIEen6k9Bje7zK7j/rqCIbhv4/75w4uMLGiyk7Okdd
   PvacGFETBCpsDmpc8zyDBsprDv9GPKUXjKcGxBvMM1OFlbS733YwMNoLD
   jrsds0JV3w78cxorwrx3V9q8fm1+qdDWO548tCWezwL4ZDs+/dZOqTPr5
   BprxIh+IPmVvC5UoA7X/E5n6y9hTXEPnyVLxBrblhHHQeNph6qGp8WTdp
   Oi3bu+Nw31/Ye/ovl6pmZFg+w7GcAxkpOtMnyX5Fyu02PtSQf6/lmLmXt
   D2IQT1KSbfJpu1lEIakINxeX0LCovdVNb1z4PGTforZ6E8yjSpVEJQtRz
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="259347261"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="259347261"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 23:13:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="709352705"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 06 Jun 2022 23:13:44 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nySTI-000DQ7-26;
        Tue, 07 Jun 2022 06:13:44 +0000
Date:   Tue, 7 Jun 2022 14:13:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:vectorized-scrub 109/367]
 fs/xfs/xfs_trans_dquot.c:125:1: warning: useless storage class specifier in
 empty declaration
Message-ID: <202206071421.f4Lllet7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git vectorized-scrub
head:   879e09570c469d3320e25aa7f625ded1a2f5c24e
commit: 1cbf9e08546faaae7fcfad46d0d24707c55ced16 [109/367] xfs: track quota updates during live quotacheck
config: alpha-buildonly-randconfig-r010-20220605 (https://download.01.org/0day-ci/archive/20220607/202206071421.f4Lllet7-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=1cbf9e08546faaae7fcfad46d0d24707c55ced16
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs vectorized-scrub
        git checkout 1cbf9e08546faaae7fcfad46d0d24707c55ced16
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/xfs/xfs_trans_dquot.c:125:1: warning: useless storage class specifier in empty declaration
     125 | static XFS_HOOKS_SWITCH_DEFINE(xfs_dqtrx_hooks_switch);
         | ^~~~~~
>> fs/xfs/xfs_trans_dquot.c:125:1: warning: empty declaration


vim +125 fs/xfs/xfs_trans_dquot.c

   123	
   124	#ifdef CONFIG_XFS_LIVE_HOOKS
 > 125	static XFS_HOOKS_SWITCH_DEFINE(xfs_dqtrx_hooks_switch);
   126	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
