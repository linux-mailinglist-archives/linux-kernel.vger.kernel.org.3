Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6153458A49B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 04:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbiHECDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 22:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiHECDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 22:03:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CEC326E2
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 19:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659664988; x=1691200988;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Dxb72Pqg+YY01TS4F8rIDqgbCx3wH4ueD+vQr0MQFlw=;
  b=V9vA2pjS5o7po2vf2CLvJoED5Fd7yrgnmCU6ZBsvAgsGyJgGK2MOEsWx
   +8zc/Xk+DZJAAbnS6da67/G01XvEwaTFp/4Pn30lyAOWsCvpG1tGh7nrK
   ICoKEw0TSWYKe5J6az5ZqbSAYZFaAFBq9gtOSlHpVjUzyc4H2gArDsk7E
   +PnbYWdmLHfUMISh4sVCxYYReSTw9jNz1LsxvMgyPKBGf2Bge0dtquibc
   uhc/O2iaEG1/xHae0BKL+t3x5vYsZovZikJbu/MrBjy1Iy+vjRxo7xCLq
   hwrRTLp3BQeXNU6HuLJFnKqZyEc+8211WFFUKm9rjXvlZa3dvJjltsF0r
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="270482098"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="270482098"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 19:03:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="849183045"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 04 Aug 2022 19:03:07 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJmg6-000J3L-1K;
        Fri, 05 Aug 2022 02:03:06 +0000
Date:   Fri, 5 Aug 2022 10:03:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: include/trace/events/nilfs2.h:191:1: sparse: sparse: cast to
 restricted blk_opf_t
Message-ID: <202208051050.mUx9O9G8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c040862bfbd9c5f3cb64e1df1c623e20e38fe656
commit: ed4512590bd5839f8ea9eef1626b0f4db626b1d1 fs/nilfs2: Use the enum req_op and blk_opf_t types
date:   3 weeks ago
config: x86_64-randconfig-s023 (https://download.01.org/0day-ci/archive/20220805/202208051050.mUx9O9G8-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ed4512590bd5839f8ea9eef1626b0f4db626b1d1
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ed4512590bd5839f8ea9eef1626b0f4db626b1d1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/nilfs2/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   fs/nilfs2/segment.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/nilfs2.h):
>> include/trace/events/nilfs2.h:191:1: sparse: sparse: cast to restricted blk_opf_t
>> include/trace/events/nilfs2.h:191:1: sparse: sparse: cast to restricted blk_opf_t
>> include/trace/events/nilfs2.h:191:1: sparse: sparse: restricted blk_opf_t degrades to integer
>> include/trace/events/nilfs2.h:191:1: sparse: sparse: restricted blk_opf_t degrades to integer

vim +191 include/trace/events/nilfs2.h

a9cd207c23ca4f Hitoshi Mitake  2015-11-06  190  
a9cd207c23ca4f Hitoshi Mitake  2015-11-06 @191  TRACE_EVENT(nilfs2_mdt_submit_block,
a9cd207c23ca4f Hitoshi Mitake  2015-11-06  192  	    TP_PROTO(struct inode *inode,
a9cd207c23ca4f Hitoshi Mitake  2015-11-06  193  		     unsigned long ino,
a9cd207c23ca4f Hitoshi Mitake  2015-11-06  194  		     unsigned long blkoff,
ed4512590bd583 Bart Van Assche 2022-07-14  195  		     enum req_op mode),
a9cd207c23ca4f Hitoshi Mitake  2015-11-06  196  
a9cd207c23ca4f Hitoshi Mitake  2015-11-06  197  	    TP_ARGS(inode, ino, blkoff, mode),
a9cd207c23ca4f Hitoshi Mitake  2015-11-06  198  
a9cd207c23ca4f Hitoshi Mitake  2015-11-06  199  	    TP_STRUCT__entry(
a9cd207c23ca4f Hitoshi Mitake  2015-11-06  200  		    __field(struct inode *, inode)
a9cd207c23ca4f Hitoshi Mitake  2015-11-06  201  		    __field(unsigned long, ino)
a9cd207c23ca4f Hitoshi Mitake  2015-11-06  202  		    __field(unsigned long, blkoff)
ed4512590bd583 Bart Van Assche 2022-07-14  203  		    __field(enum req_op, mode)
a9cd207c23ca4f Hitoshi Mitake  2015-11-06  204  	    ),
a9cd207c23ca4f Hitoshi Mitake  2015-11-06  205  
a9cd207c23ca4f Hitoshi Mitake  2015-11-06  206  	    TP_fast_assign(
a9cd207c23ca4f Hitoshi Mitake  2015-11-06  207  		    __entry->inode = inode;
a9cd207c23ca4f Hitoshi Mitake  2015-11-06  208  		    __entry->ino = ino;
a9cd207c23ca4f Hitoshi Mitake  2015-11-06  209  		    __entry->blkoff = blkoff;
a9cd207c23ca4f Hitoshi Mitake  2015-11-06  210  		    __entry->mode = mode;
a9cd207c23ca4f Hitoshi Mitake  2015-11-06  211  		    ),
a9cd207c23ca4f Hitoshi Mitake  2015-11-06  212  
a9cd207c23ca4f Hitoshi Mitake  2015-11-06  213  	    TP_printk("inode = %p ino = %lu blkoff = %lu mode = %x",
a9cd207c23ca4f Hitoshi Mitake  2015-11-06  214  		      __entry->inode,
a9cd207c23ca4f Hitoshi Mitake  2015-11-06  215  		      __entry->ino,
a9cd207c23ca4f Hitoshi Mitake  2015-11-06  216  		      __entry->blkoff,
a9cd207c23ca4f Hitoshi Mitake  2015-11-06  217  		      __entry->mode)
a9cd207c23ca4f Hitoshi Mitake  2015-11-06  218  );
a9cd207c23ca4f Hitoshi Mitake  2015-11-06  219  

:::::: The code at line 191 was first introduced by commit
:::::: a9cd207c23ca4fa5bd5f1092e867e87542e349a3 nilfs2: add tracepoints for analyzing reading and writing metadata files

:::::: TO: Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
