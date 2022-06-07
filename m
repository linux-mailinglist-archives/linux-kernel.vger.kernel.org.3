Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0805153F6BB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 09:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237405AbiFGHAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 03:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237375AbiFGHAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:00:15 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E463E2745
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 00:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654585213; x=1686121213;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rgN9q4DcvlmCbT8gb+DA8nQl9OhZiDebNLaZp4+lTmk=;
  b=DBEpsawR0jjc9sXpk+S/l1wjf+aIUdKQD3ttw9WpuXFqvT+mPCfXd6b/
   GCBeAVennsSyYfQBtGzZdDT4aOymWuzdlfJ0jkoTLN1C5piige9zRGjSK
   ruMhnI3aGxFT9cLhgEEvjfgkv95ZZAwYXWvCU2w4FjfHBASVBvAXKTWcX
   2aw67Xtb+Fbl6BWfj5S2JGXYHGVygRq6sBQfnANUKoIFS4tVf52maZ9Vb
   MipMgsYFdZPrIfREvBaLo4/kC2tMd6nd0OZxpz7ZgAdwtX45To9u1qLXg
   eyYSj4eZS8we8e4sptaDzoVVhDMOezag/7HvI4msrRUxLTI04mvuz55df
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="259363258"
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="259363258"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 23:59:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="669847350"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Jun 2022 23:59:45 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyTBp-000DRj-48;
        Tue, 07 Jun 2022 06:59:45 +0000
Date:   Tue, 7 Jun 2022 14:58:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:vectorized-scrub 164/367] ERROR: modpost: "__udivdi3"
 [fs/xfs/xfs.ko] undefined!
Message-ID: <202206071434.EquTnh1s-lkp@intel.com>
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
commit: ce8ec3f5e3c8baaf59687b1f077be69f86b60f75 [164/367] xfs: create deferred log items for extent swapping
config: m68k-hp300_defconfig (https://download.01.org/0day-ci/archive/20220607/202206071434.EquTnh1s-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=ce8ec3f5e3c8baaf59687b1f077be69f86b60f75
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs vectorized-scrub
        git checkout ce8ec3f5e3c8baaf59687b1f077be69f86b60f75
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__udivdi3" [fs/xfs/xfs.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
