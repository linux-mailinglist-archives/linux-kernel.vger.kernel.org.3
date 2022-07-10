Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE8456CC1D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 02:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiGJAwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 20:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJAwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 20:52:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DA613DC1;
        Sat,  9 Jul 2022 17:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657414351; x=1688950351;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wsHA4c51RxzkUCE1NRkYTGBilCE4XRq7RWUHAqgsvfg=;
  b=SK/ndou0bx0VZd1VvogNol86Y9NfLQeKzgar8wbB/yz6aPk14DZE4kOD
   uOV/x3ksECjBFFbsqBDtCmsu9zWe9hIxqRk17chJht47PHpvD8bgphoAg
   klGWxmeOCiKxN9xTwLPupIj5XxtXxphJ0O4nA/TDzt/Wg5ptaFgM7q9ht
   PGbMoZRh+u2X+HhMJda0+anVVpywS0Lu9ma4l/2PRRNsI7BwnzaJRDWAC
   PqVFL3DtIeUFw5vXrnVaLOkQoff/H0v0AJK2ggcroBTvZZubRAwMsg0Tq
   5Eyl5ChHuDLnRi5my0EAcS7rFcXflhS9ITxgdFAPCOZIKzDA0M3WPo+n1
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="310065166"
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="310065166"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 17:52:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="721243583"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 09 Jul 2022 17:52:29 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oALBP-000PKa-9S;
        Sun, 10 Jul 2022 00:52:23 +0000
Date:   Sun, 10 Jul 2022 08:52:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [djwong-xfs:vectorized-scrub 14/368] htmldocs:
 Documentation/filesystems/xfs-online-fsck-design.rst:822: WARNING: Duplicate
 explicit target name: "inode".
Message-ID: <202207100833.M6QSi3IA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git vectorized-scrub
head:   569bd1ce4bb5c53a1b892fbe6d99693bf637063b
commit: 4dda10b2ba91b4d387f520a27cbd909d1d56374e [14/368] xfs: document technical aspects of kernel space file repair code
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/filesystems/xfs-online-fsck-design.rst:822: WARNING: Duplicate explicit target name: "inode".

vim +/inode +822 Documentation/filesystems/xfs-online-fsck-design.rst

08025a5b429713 Darrick J. Wong 2022-06-10  820  
08025a5b429713 Darrick J. Wong 2022-06-10  821  Kernel Algorithms and Data Structures
08025a5b429713 Darrick J. Wong 2022-06-10 @822  =====================================
08025a5b429713 Darrick J. Wong 2022-06-10  823  

:::::: The code at line 822 was first introduced by commit
:::::: 08025a5b429713a0fbbbe9747c496d3de200d0ce xfs: document technical aspects of kernel space metadata repair code

:::::: TO: Darrick J. Wong <djwong@kernel.org>
:::::: CC: Darrick J. Wong <djwong@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
