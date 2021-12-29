Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3910F481009
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 06:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbhL2F0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 00:26:52 -0500
Received: from mga01.intel.com ([192.55.52.88]:4375 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229774AbhL2F0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 00:26:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640755612; x=1672291612;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=geEu2Mq/T8QLUvIdcz0mqWzDhnB6h9uFaEGt4RnRpVE=;
  b=CCIeqwdAJTBE/PleodCR9sqDHHVs7RP8GOroPV/ivp8JM5GU5+d6rxKL
   2vaOHorVqemaSAtUXovmGFoTZgz5QuagmtJQePATccrPRx91UIFrsp570
   aCPIdG7fw45rUony5AeaHXTkdEeMklLA9AOemHmamfIXmI6R/m5AxU1nQ
   eGNQ75nwB32TkGWUL5ZUyC5T7byIBbHFsinqMEkVL+pBFoSkgaw5+q5Gq
   jUtIWPv2PaEJ5rAVRaJKf3RCr/7NN461uGOu8y7j/+4+Ml7tkRXURzMCN
   vC0SoFWfNDPgA19VZo1B5IDcpp20aauKSArnmtTZ3fkwacfe8XfHppwVy
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="265699434"
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="265699434"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 21:26:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="510389759"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 28 Dec 2021 21:26:47 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2RU6-0008Zi-Ll; Wed, 29 Dec 2021 05:26:46 +0000
Date:   Wed, 29 Dec 2021 13:25:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:vectorized-scrub 100/326] fs/xfs/scrub/trace.c:48:31:
 error: invalid use of undefined type 'struct xfbtree'
Message-ID: <202112291340.SZbi6GKb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git vectorized-scrub
head:   f736db09eb704761df6d6534ed9730f38bf136d1
commit: 9bcb3cf01fbbfe96671d56248b516b0a68c5c022 [100/326] xfs: connect in-memory btrees to xfiles
config: alpha-randconfig-r015-20211228 (https://download.01.org/0day-ci/archive/20211229/202112291340.SZbi6GKb-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=9bcb3cf01fbbfe96671d56248b516b0a68c5c022
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs vectorized-scrub
        git checkout 9bcb3cf01fbbfe96671d56248b516b0a68c5c022
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/xfs/scrub/trace.c: In function 'xfbtree_ino':
>> fs/xfs/scrub/trace.c:48:31: error: invalid use of undefined type 'struct xfbtree'
      48 |         return file_inode(xfbt->target->bt_xfile->file)->i_ino;
         |                               ^~


vim +48 fs/xfs/scrub/trace.c

    43	
    44	static inline unsigned long
    45	xfbtree_ino(
    46		struct xfbtree		*xfbt)
    47	{
  > 48		return file_inode(xfbt->target->bt_xfile->file)->i_ino;
    49	}
    50	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
