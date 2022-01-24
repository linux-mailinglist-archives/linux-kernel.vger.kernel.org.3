Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4FA497A0D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242064AbiAXIQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:16:08 -0500
Received: from mga02.intel.com ([134.134.136.20]:22170 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242060AbiAXIPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:15:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643012123; x=1674548123;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PZ03S5WLvrnyR1cFQZpyhVAI7MHzfl8ffKZ0Qvrf9pk=;
  b=MWDCR5dB3LT+6pS3GcNB/pugEHoSPk7g2K5HTOVxNOW5iOUKGpXQJg0E
   XcrKXeLqVeg0FOqVEWd0FAXMk50R8+SfyYKx+NXRaNLrdYbNuTHK8Z0lX
   uzYNfVQ5CksuFPcYh5ySfDzKyyznB370v3vMabsOT1YlrWqEWSaec7riJ
   PwmgoVElJe5T1RZChOTH5CNiuGiGG6yndReQlQ6U6rdIag4hguJw1ykpv
   3t4PCbwO6JcfRBHMqU4zQnpjIYTxlxzOWUwY1RobU60XdQaIJh4+OVe5P
   umWAKKTH5xyXc2ctvHWfGEWZU4x104M8QsNaaNXjfxf4Z174Ektx+PAim
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="233351563"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="233351563"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 00:15:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627408142"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 00:15:22 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBuVV-000Hxp-Lf; Mon, 24 Jan 2022 08:15:21 +0000
Date:   Mon, 24 Jan 2022 16:14:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Allison Henderson <allison.henderson@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>
Subject: [allisonhenderson-xfs-work:delayed_attrs_v26_extended 21/30]
 fs/xfs/libxfs/xfs_parent.c:55:1: warning: no previous prototype for
 'xfs_init_parent_name_rec'
Message-ID: <202201241644.gmgcv562-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/allisonhenderson/xfs_work.git delayed_attrs_v26_extended
head:   19459f5cfa422b0a6a9cd3898892e43ecb49f8f3
commit: 71c74c8dbb3644ba2a05927c016261b776cf17c8 [21/30] xfs: parent pointer attribute creation
config: nds32-randconfig-r024-20220124 (https://download.01.org/0day-ci/archive/20220124/202201241644.gmgcv562-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/allisonhenderson/xfs_work/commit/71c74c8dbb3644ba2a05927c016261b776cf17c8
        git remote add allisonhenderson-xfs-work https://github.com/allisonhenderson/xfs_work.git
        git fetch --no-tags allisonhenderson-xfs-work delayed_attrs_v26_extended
        git checkout 71c74c8dbb3644ba2a05927c016261b776cf17c8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/xfs/libxfs/xfs_parent.c:55:1: warning: no previous prototype for 'xfs_init_parent_name_rec' [-Wmissing-prototypes]
      55 | xfs_init_parent_name_rec(
         | ^~~~~~~~~~~~~~~~~~~~~~~~
>> fs/xfs/libxfs/xfs_parent.c:70:1: warning: no previous prototype for 'xfs_init_parent_name_irec' [-Wmissing-prototypes]
      70 | xfs_init_parent_name_irec(
         | ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/xfs_init_parent_name_rec +55 fs/xfs/libxfs/xfs_parent.c

    35	
    36	/*
    37	 * Parent pointer attribute handling.
    38	 *
    39	 * Because the attribute value is a filename component, it will never be longer
    40	 * than 255 bytes. This means the attribute will always be a local format
    41	 * attribute as it is xfs_attr_leaf_entsize_local_max() for v5 filesystems will
    42	 * always be larger than this (max is 75% of block size).
    43	 *
    44	 * Creating a new parent attribute will always create a new attribute - there
    45	 * should never, ever be an existing attribute in the tree for a new inode.
    46	 * ENOSPC behavior is problematic - creating the inode without the parent
    47	 * pointer is effectively a corruption, so we allow parent attribute creation
    48	 * to dip into the reserve block pool to avoid unexpected ENOSPC errors from
    49	 * occurring.
    50	 */
    51	
    52	
    53	/* Initializes a xfs_parent_name_rec to be stored as an attribute name */
    54	void
  > 55	xfs_init_parent_name_rec(
    56		struct xfs_parent_name_rec	*rec,
    57		struct xfs_inode		*ip,
    58		uint32_t			p_diroffset)
    59	{
    60		xfs_ino_t			p_ino = ip->i_ino;
    61		uint32_t			p_gen = VFS_I(ip)->i_generation;
    62	
    63		rec->p_ino = cpu_to_be64(p_ino);
    64		rec->p_gen = cpu_to_be32(p_gen);
    65		rec->p_diroffset = cpu_to_be32(p_diroffset);
    66	}
    67	
    68	/* Initializes a xfs_parent_name_irec from an xfs_parent_name_rec */
    69	void
  > 70	xfs_init_parent_name_irec(

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
