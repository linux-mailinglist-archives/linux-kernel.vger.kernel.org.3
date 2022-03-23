Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145EE4E5B0B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 23:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345117AbiCWWIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 18:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343945AbiCWWIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 18:08:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3915260A93
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 15:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648073215; x=1679609215;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gjpECOL8hz2YgIzcvxE0a2MSg8tX7NN+YKikt6HZKiQ=;
  b=VWNWBYgcivx4cwYlyxVjOtDNh6lETz5Zfo+hpy0bBHwI07vIihlecnvj
   R3r1Vqye5mVCoaHGeG7E8KEQiQcenXi6d82niQPthWLkHhtIyLuWtzSck
   o7aR0z8RtElzQ+8HG69rKr1nZsRi2vv79SmO72e0GQJIu0EVHvW7F9bkE
   wCyxc3agoYNhO6M5v1J+dvAGIpKZdtgnwC3jt1zlVGXAPBJ370BcWKUdO
   nAUXab/JyQbqPGbfLu4PC/k01n29A92X1dBqTEdVVi7Ma2lXaVH3tyBZt
   AopjPK1uAL7Yn71sAHR5wVj1a/M0lHyJ2V6djThFllLvMWkl1kHI8MxMr
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="258190636"
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="258190636"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 15:06:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="519537889"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 23 Mar 2022 15:06:52 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nX980-000KPH-6s; Wed, 23 Mar 2022 22:06:52 +0000
Date:   Thu, 24 Mar 2022 06:06:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Allison Henderson <allison.henderson@oracle.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: [allisonhenderson-xfs-work:delayed_attrs_v29_extended 24/31]
 fs/xfs/libxfs/xfs_parent.c:55:1: warning: no previous prototype for function
 'xfs_init_parent_name_rec'
Message-ID: <202203240536.uAHhjNEb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/allisonhenderson/xfs_work.git delayed_attrs_v29_extended
head:   3106ffcd07787b3bed3ee019d3706c480477ee9c
commit: 7db6d10716e92d4f101981304d1619b77acd569c [24/31] xfs: parent pointer attribute creation
config: riscv-randconfig-r033-20220323 (https://download.01.org/0day-ci/archive/20220324/202203240536.uAHhjNEb-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 902f4708fe1d03b0de7e5315ef875006a6adc319)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/allisonhenderson/xfs_work/commit/7db6d10716e92d4f101981304d1619b77acd569c
        git remote add allisonhenderson-xfs-work https://github.com/allisonhenderson/xfs_work.git
        git fetch --no-tags allisonhenderson-xfs-work delayed_attrs_v29_extended
        git checkout 7db6d10716e92d4f101981304d1619b77acd569c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/xfs/libxfs/xfs_parent.c:55:1: warning: no previous prototype for function 'xfs_init_parent_name_rec' [-Wmissing-prototypes]
   xfs_init_parent_name_rec(
   ^
   fs/xfs/libxfs/xfs_parent.c:54:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void
   ^
   static 
>> fs/xfs/libxfs/xfs_parent.c:70:1: warning: no previous prototype for function 'xfs_init_parent_name_irec' [-Wmissing-prototypes]
   xfs_init_parent_name_irec(
   ^
   fs/xfs/libxfs/xfs_parent.c:69:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void
   ^
   static 
   2 warnings generated.


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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
