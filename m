Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BD84B1EFD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 08:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347577AbiBKHGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 02:06:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347546AbiBKHGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 02:06:35 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D61F57
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 23:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644563195; x=1676099195;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hb5Uz21x+Y9J3Is4I39S6PpyISoEizRR0UppMTjTlXU=;
  b=HxOdRx4iH3KD+f8PzoElbrBfs42oEiIHbOMcf3TBTcKfEF2Jnpy5gC2o
   2LS0+99fnGDHp0of4JjfeedwU/jfSx96z5ct6FNsn6BAJ2pCF6c35NDyz
   n46j4Fh0d2k6zz04vJwgRkFu6H2b12xR0kTZpBLlER8wNZETUv95EqlId
   J0k/8PpuVIXHVXnKGzXec6XjMPpGaq22NLQurXUtoqEh/gKnUMS6PV0yx
   +AisTtKLnojTy9pqzdx/1KcvtEXA1/veubxyrmOjEx5IHExj5foyLFsM8
   Fj/LwstLnvejtn2EIUllI5jeZNX/QVIdr9zYV6fEVsH82jZcpP+mYe/1g
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="310412862"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="310412862"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 23:06:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="500682684"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 10 Feb 2022 23:06:33 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIQ0m-0004GI-Qk; Fri, 11 Feb 2022 07:06:32 +0000
Date:   Fri, 11 Feb 2022 15:06:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 25/35]
 fs/fs-writeback.c:2789:9: error: implicit declaration of function
 'wbc_attach_unlock_fdatawrite_inode'; did you mean
 'wbc_attach_fdatawrite_inode'?
Message-ID: <202202111544.8rMkF0G8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   429e2bb6fb190f390ed23afc0d2308e877c43be5
commit: 9c1befbc079fcef04228d2b67e931f9635d58591 [25/35] vfs: Take I_SYNC whilst performing fsync() and similar
config: arc-defconfig (https://download.01.org/0day-ci/archive/20220211/202202111544.8rMkF0G8-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/9c1befbc079fcef04228d2b67e931f9635d58591
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout 9c1befbc079fcef04228d2b67e931f9635d58591
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/fs-writeback.c: In function 'filemap_fdatawrite_wbc':
>> fs/fs-writeback.c:2789:9: error: implicit declaration of function 'wbc_attach_unlock_fdatawrite_inode'; did you mean 'wbc_attach_fdatawrite_inode'? [-Werror=implicit-function-declaration]
    2789 |         wbc_attach_unlock_fdatawrite_inode(wbc, inode);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         wbc_attach_fdatawrite_inode
   cc1: some warnings being treated as errors


vim +2789 fs/fs-writeback.c

  2762	
  2763	/**
  2764	 * filemap_fdatawrite_wbc - start writeback on mapping dirty pages in range
  2765	 * @mapping:	address space structure to write
  2766	 * @wbc:	the writeback_control controlling the writeout
  2767	 *
  2768	 * Call writepages on the mapping using the provided wbc to control the
  2769	 * writeout.
  2770	 *
  2771	 * Return: %0 on success, negative error code otherwise.
  2772	 */
  2773	int filemap_fdatawrite_wbc(struct address_space *mapping,
  2774				   struct writeback_control *wbc)
  2775	{
  2776		struct inode *inode = mapping->host;
  2777		int ret;
  2778	
  2779		if (!mapping_can_writeback(mapping) ||
  2780		    !mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
  2781			return 0;
  2782	
  2783		spin_lock(&inode->i_lock);
  2784		if (inode->i_state & I_SYNC) {
  2785			__inode_wait_for_writeback(inode);
  2786			WARN_ON(inode->i_state & I_SYNC);
  2787		}
  2788	
> 2789		wbc_attach_unlock_fdatawrite_inode(wbc, inode);

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
