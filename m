Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FE64C1F41
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 00:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244691AbiBWXDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 18:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbiBWXDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:03:21 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5135714E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 15:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645657373; x=1677193373;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cA/iBK1zv2TL2d3+yePnyMO9t24T6zwT8uyJGvJ28EM=;
  b=CJWC1p8lgdq9WTPa4dPIvgyyX6nWht5PKqoIzSVX6szSvAUMjs5fQSg0
   ROSe1UvaCOkcIkkzZDnLIfjiweeFVAzqUXKPPNjbUeyZf/V4gmP9PK8xX
   tgc2uDvVIODItzDOYsl1h9gUnY1o0OdPK3A90hU1E4JXXraqS6Da8bp06
   FlbUS5Gqb3pdSGwbrCf6j9E5ZQEgqFFDu0mOodIQvSPvPatHGArdC2rOE
   sd6nIeX8qwiIJ3RQ7TqeZIYAkNH4ZrQTpYsDGsgZrRWodN+yz6qJiTPwv
   OmWgUmdtVMM4zyqD7/uIvsKsX0AmZsob2kGnVG8OgRZxoz6Bd5HWe+LiE
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="250930679"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="250930679"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 15:02:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="637609511"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 23 Feb 2022 15:02:51 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN0eo-0001vE-QR; Wed, 23 Feb 2022 23:02:50 +0000
Date:   Thu, 24 Feb 2022 07:01:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1426/2340] fs/xfs/xfs_aops.c:185:3: error:
 implicit declaration of function 'cond_resched'
Message-ID: <202202240635.yBLA03nm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   97c5eeb4de3ad324ed2a4656b46465299cfd010a
commit: 696f8f602b998e5e83e2f71d3dd79e06dbb4e4ea [1426/2340] headers/deps: block/ioprio: Remove the <linux/sched.h> dependency from <linux/ioprio.h>
config: i386-randconfig-a011 (https://download.01.org/0day-ci/archive/20220224/202202240635.yBLA03nm-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=696f8f602b998e5e83e2f71d3dd79e06dbb4e4ea
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 696f8f602b998e5e83e2f71d3dd79e06dbb4e4ea
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the mingo-tip/sched/headers HEAD 97c5eeb4de3ad324ed2a4656b46465299cfd010a builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

>> fs/xfs/xfs_aops.c:185:3: error: implicit declaration of function 'cond_resched' [-Werror,-Wimplicit-function-declaration]
                   cond_resched();
                   ^
   fs/xfs/xfs_aops.c:185:3: note: did you mean '__cond_resched'?
   include/linux/kernel.h:95:12: note: '__cond_resched' declared here
   extern int __cond_resched(void);
              ^
   1 error generated.
--
>> fs/btrfs/ioctl.c:1655:3: error: implicit declaration of function 'cond_resched' [-Werror,-Wimplicit-function-declaration]
                   cond_resched();
                   ^
   fs/btrfs/ioctl.c:1655:3: note: did you mean '__cond_resched'?
   include/linux/kernel.h:95:12: note: '__cond_resched' declared here
   extern int __cond_resched(void);
              ^
   1 error generated.


vim +/cond_resched +185 fs/xfs/xfs_aops.c

3994fc48957520 Darrick J. Wong   2019-04-15  150  
ebb7fb1557b1d0 Dave Chinner      2022-01-26  151  /*
ebb7fb1557b1d0 Dave Chinner      2022-01-26  152   * Finish all pending IO completions that require transactional modifications.
ebb7fb1557b1d0 Dave Chinner      2022-01-26  153   *
ebb7fb1557b1d0 Dave Chinner      2022-01-26  154   * We try to merge physical and logically contiguous ioends before completion to
ebb7fb1557b1d0 Dave Chinner      2022-01-26  155   * minimise the number of transactions we need to perform during IO completion.
ebb7fb1557b1d0 Dave Chinner      2022-01-26  156   * Both unwritten extent conversion and COW remapping need to iterate and modify
ebb7fb1557b1d0 Dave Chinner      2022-01-26  157   * one physical extent at a time, so we gain nothing by merging physically
ebb7fb1557b1d0 Dave Chinner      2022-01-26  158   * discontiguous extents here.
ebb7fb1557b1d0 Dave Chinner      2022-01-26  159   *
ebb7fb1557b1d0 Dave Chinner      2022-01-26  160   * The ioend chain length that we can be processing here is largely unbound in
ebb7fb1557b1d0 Dave Chinner      2022-01-26  161   * length and we may have to perform significant amounts of work on each ioend
ebb7fb1557b1d0 Dave Chinner      2022-01-26  162   * to complete it. Hence we have to be careful about holding the CPU for too
ebb7fb1557b1d0 Dave Chinner      2022-01-26  163   * long in this loop.
ebb7fb1557b1d0 Dave Chinner      2022-01-26  164   */
cb357bf3d105f6 Darrick J. Wong   2019-04-15  165  void
cb357bf3d105f6 Darrick J. Wong   2019-04-15  166  xfs_end_io(
cb357bf3d105f6 Darrick J. Wong   2019-04-15  167  	struct work_struct	*work)
cb357bf3d105f6 Darrick J. Wong   2019-04-15  168  {
433dad94ec5d6b Christoph Hellwig 2019-10-17  169  	struct xfs_inode	*ip =
433dad94ec5d6b Christoph Hellwig 2019-10-17  170  		container_of(work, struct xfs_inode, i_ioend_work);
598ecfbaa742ac Christoph Hellwig 2019-10-17  171  	struct iomap_ioend	*ioend;
433dad94ec5d6b Christoph Hellwig 2019-10-17  172  	struct list_head	tmp;
cb357bf3d105f6 Darrick J. Wong   2019-04-15  173  	unsigned long		flags;
cb357bf3d105f6 Darrick J. Wong   2019-04-15  174  
cb357bf3d105f6 Darrick J. Wong   2019-04-15  175  	spin_lock_irqsave(&ip->i_ioend_lock, flags);
433dad94ec5d6b Christoph Hellwig 2019-10-17  176  	list_replace_init(&ip->i_ioend_list, &tmp);
cb357bf3d105f6 Darrick J. Wong   2019-04-15  177  	spin_unlock_irqrestore(&ip->i_ioend_lock, flags);
cb357bf3d105f6 Darrick J. Wong   2019-04-15  178  
598ecfbaa742ac Christoph Hellwig 2019-10-17  179  	iomap_sort_ioends(&tmp);
598ecfbaa742ac Christoph Hellwig 2019-10-17  180  	while ((ioend = list_first_entry_or_null(&tmp, struct iomap_ioend,
433dad94ec5d6b Christoph Hellwig 2019-10-17  181  			io_list))) {
cb357bf3d105f6 Darrick J. Wong   2019-04-15  182  		list_del_init(&ioend->io_list);
6e552494fb90ac Brian Foster      2021-05-04  183  		iomap_ioend_try_merge(ioend, &tmp);
cb357bf3d105f6 Darrick J. Wong   2019-04-15  184  		xfs_end_ioend(ioend);
ebb7fb1557b1d0 Dave Chinner      2022-01-26 @185  		cond_resched();
cb357bf3d105f6 Darrick J. Wong   2019-04-15  186  	}
cb357bf3d105f6 Darrick J. Wong   2019-04-15  187  }
cb357bf3d105f6 Darrick J. Wong   2019-04-15  188  

:::::: The code at line 185 was first introduced by commit
:::::: ebb7fb1557b1d03b906b668aa2164b51e6b7d19a xfs, iomap: limit individual ioend chain lengths in writeback

:::::: TO: Dave Chinner <dchinner@redhat.com>
:::::: CC: Darrick J. Wong <djwong@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
