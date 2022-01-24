Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E876497A91
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbiAXIqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:46:30 -0500
Received: from mga11.intel.com ([192.55.52.93]:17302 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbiAXIq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:46:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643013986; x=1674549986;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IFbDN5o21Hrgob4AQsQv6ZkSaoHI+B93zH8oPVzDdJI=;
  b=E9lyxC/cawJTnhStoK2s5AahCTI4Wu1vFDeVByXC/p3yDXLkHPpsDhYn
   nZyGqSzrro/Kyx6e8Oyg6jyJgozLX2K1UcCtwXVTZBsnAwEls/thzrhu4
   xPcBS1Bqla6U/8bDFBTu7tCm9S/yAbkkKHunQZYpfDyb++8/eQiEyN0Er
   ahTYuoeZ9KYPIaJv8QVk1MK0uEEOp2uQmnyDqdKNSZbwBlrJjvZDII1hy
   ZkYdpJHqfdcIJHOYCF46giHTECvPL4R03NE082M+PvvaM+MGDXd63V3Vs
   IEhhiZVuwBwdwWkBpKa8Ps4gHLuLbJvWJ5Wrct+11Snojc85eC6tAL060
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="243593919"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="243593919"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 00:46:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627418592"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 00:46:24 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBuzY-000I2q-2C; Mon, 24 Jan 2022 08:46:24 +0000
Date:   Mon, 24 Jan 2022 16:46:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Allison Henderson <allison.henderson@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [allisonhenderson-xfs-work:delayed_attrs_v26_extended 28/30]
 fs/xfs/libxfs/xfs_parent.c:38:1: warning: no previous prototype for
 'xfs_init_parent_ptr'
Message-ID: <202201241656.OiYKqrlS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/allisonhenderson/xfs_work.git delayed_attrs_v26_extended
head:   19459f5cfa422b0a6a9cd3898892e43ecb49f8f3
commit: 38f492d29e0c25066170d87572b7ade7bf2af72b [28/30] xfs: Add parent pointer ioctl
config: nds32-randconfig-r024-20220124 (https://download.01.org/0day-ci/archive/20220124/202201241656.OiYKqrlS-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/allisonhenderson/xfs_work/commit/38f492d29e0c25066170d87572b7ade7bf2af72b
        git remote add allisonhenderson-xfs-work https://github.com/allisonhenderson/xfs_work.git
        git fetch --no-tags allisonhenderson-xfs-work delayed_attrs_v26_extended
        git checkout 38f492d29e0c25066170d87572b7ade7bf2af72b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/xfs/libxfs/xfs_parent.c:38:1: warning: no previous prototype for 'xfs_init_parent_ptr' [-Wmissing-prototypes]
      38 | xfs_init_parent_ptr(struct xfs_parent_ptr               *xpp,
         | ^~~~~~~~~~~~~~~~~~~
   fs/xfs/libxfs/xfs_parent.c:65:1: warning: no previous prototype for 'xfs_init_parent_name_rec' [-Wmissing-prototypes]
      65 | xfs_init_parent_name_rec(
         | ^~~~~~~~~~~~~~~~~~~~~~~~
   fs/xfs/libxfs/xfs_parent.c:80:1: warning: no previous prototype for 'xfs_init_parent_name_irec' [-Wmissing-prototypes]
      80 | xfs_init_parent_name_irec(
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
--
>> fs/xfs/xfs_parent_utils.c:42:1: warning: no previous prototype for 'xfs_attr_get_parent_pointer' [-Wmissing-prototypes]
      42 | xfs_attr_get_parent_pointer(struct xfs_inode            *ip,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/xfs_init_parent_ptr +38 fs/xfs/libxfs/xfs_parent.c

    35	
    36	/* Initializes a xfs_parent_ptr from an xfs_parent_name_rec */
    37	void
  > 38	xfs_init_parent_ptr(struct xfs_parent_ptr		*xpp,
    39			     struct xfs_parent_name_rec	*rec)
    40	{
    41		xpp->xpp_ino = be64_to_cpu(rec->p_ino);
    42		xpp->xpp_gen = be32_to_cpu(rec->p_gen);
    43		xpp->xpp_diroffset = be32_to_cpu(rec->p_diroffset);
    44	}
    45	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
