Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0EC853D8D5
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 01:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242447AbiFDXaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 19:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239285AbiFDXaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 19:30:19 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0D636160
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 16:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654385418; x=1685921418;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ou//OEztOkJ2jsZ97LvUy6qaVpQz87MdVOYnT15DKnQ=;
  b=ByuDfZ374SxaWcWGdYii291L2A/rm6iZiow0wtlhTFqiKib5ANCOTUoq
   VOzZi7qy1l8Lpj1WSbsRPkH6iWrvlGvPQZqfyE8BFgv2jgchAwfWyX69B
   p5U5OO5M+7SVf+3n8HCWrn8BvYMrVsQBtxy25WM2s8Hjs9LxJcWzFFW3D
   SaypPlPEmts9hRP+vGOHSB6hra3DL/uo2b5BK9HenlpViY3oELJGUea5I
   JFMKFWikQKAw6+hrrGLJLWmKASus7ugmoisZ0V1UeNIw5D6tVOVzApjHV
   ImOgOCLQlms940QF1uqOoA4KNmKnMl15gACn75cpo/MnU9IKhYXdXCy1f
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="256963429"
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="256963429"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 16:30:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="668963028"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Jun 2022 16:30:17 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxdDk-000BH1-Fj;
        Sat, 04 Jun 2022 23:30:16 +0000
Date:   Sun, 5 Jun 2022 07:30:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:vectorized-scrub 177/401]
 fs/xfs/libxfs/xfs_rmap.c:778:1: sparse: sparse: symbol
 'xfs_rmap_hooks_switch' was not declared. Should it be static?
Message-ID: <202206050747.Rps0Thmj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git vectorized-scrub
head:   1fcd9cea011a657d62ee332d161966c1ec92ffd5
commit: 016ce1fe7984026d32cf6388359a57175b609a11 [177/401] xfs: hook live rmap operations during a repair operation
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20220605/202206050747.Rps0Thmj-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=016ce1fe7984026d32cf6388359a57175b609a11
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs vectorized-scrub
        git checkout 016ce1fe7984026d32cf6388359a57175b609a11
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/xfs/libxfs/xfs_rmap.c:778:1: sparse: sparse: symbol 'xfs_rmap_hooks_switch' was not declared. Should it be static?

Please review and possibly fold the followup patch.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
