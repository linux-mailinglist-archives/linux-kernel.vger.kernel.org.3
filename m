Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6485E53F7F1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 10:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbiFGIMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 04:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238080AbiFGILx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:11:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880A4CE5C9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 01:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654589509; x=1686125509;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JZEVs2K/v9KhGJzmJ5w/yVJ6/pRAy4+qcPit428hTjg=;
  b=DXVK30ys9ZYhV153/0nt2Jx13ZIjHVsqg3RykTc8kj68wyeLVNry529u
   FZ9xKVVB4+D2XKr9KPH5+Oq7KJBEQigr5TNpWOxcMRApMnzgXYPduQ4bi
   Fv0UgEV+WYw61LjE6w2QzaSMdGlhbGRnuxgavyhxQ1V0IHH+7KakxDLpo
   0buBbMK0KaR4jd0F9H/giAlk6xKiH2cDqAXD9l0YGl0wdHJWC8pvv+DZX
   2BBixzust1+J4Po2b7mG3aWzt+JG+NxHvAvvX9FgXVmIMGcqLw9UY7v5b
   yjvLAj296fu5CpgdvlIDdfir5Wx5BfncN7eyQNyMm5pZ4YtHFisRQBThS
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="363055602"
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="363055602"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 01:11:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="709387738"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 07 Jun 2022 01:11:47 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyUJW-000DUj-UN;
        Tue, 07 Jun 2022 08:11:46 +0000
Date:   Tue, 7 Jun 2022 16:11:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:vectorized-scrub 143/367]
 fs/xfs/libxfs/xfs_rmap.c:778:1: warning: declaration does not declare
 anything
Message-ID: <202206071624.PPgEhxOl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git vectorized-scrub
head:   879e09570c469d3320e25aa7f625ded1a2f5c24e
commit: c4da1521e40e5b2f1094f9d9cad217c773f5641c [143/367] xfs: hook live rmap operations during a repair operation
config: hexagon-buildonly-randconfig-r008-20220605 (https://download.01.org/0day-ci/archive/20220607/202206071624.PPgEhxOl-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b92436efcb7813fc481b30f2593a4907568d917a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=c4da1521e40e5b2f1094f9d9cad217c773f5641c
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs vectorized-scrub
        git checkout c4da1521e40e5b2f1094f9d9cad217c773f5641c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/xfs/libxfs/xfs_rmap.c:778:1: warning: declaration does not declare anything [-Wmissing-declarations]
   static XFS_HOOKS_SWITCH_DEFINE(xfs_rmap_hooks_switch);
   ^~~~~~
   1 warning generated.


vim +778 fs/xfs/libxfs/xfs_rmap.c

   776	
   777	#ifdef CONFIG_XFS_LIVE_HOOKS
 > 778	static XFS_HOOKS_SWITCH_DEFINE(xfs_rmap_hooks_switch);
   779	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
