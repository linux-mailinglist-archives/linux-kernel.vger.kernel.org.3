Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9BE576FF0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 17:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbiGPPka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 11:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPPk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 11:40:28 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842F51DA51
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 08:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657986027; x=1689522027;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3+Q56tLKJMFDFsOu0GDE7jbsgW+WfJ3G0g1FA/kUqFg=;
  b=QF0LihRBenbLuk/aA+0T7xu/5tdPUw9QVgA/uZHCq+v1vMBl2FshATp5
   zxFYGbCL9UYvDWQzMpH6k1abaoD6eppETFxODnll1gqrr64Um9fLl9isi
   KRZsB6yesAoJjKazMOjBI13zRSnTe2WqPi0hPtzT7tFMc1Tt8SruWHIsd
   nRrsYElNw3+Ex+CiG1tmr+i8r6l7CAxbDu9X4AtFyWwZFZbAsF1YxPn+f
   BA0+ccJIU+Qj3kwUGCJ0+IFXbiFXFGmdoSpKGj1aod/EM2Ng+oSQWNXkj
   3TLOVIq6cP94G4WUbUNx4MFCEzG54bw4jfWO38hNC6wEe9M1VbtLq052v
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="286008142"
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="286008142"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 08:40:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="699536895"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 16 Jul 2022 08:40:25 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCjtz-0001k9-Ki;
        Sat, 16 Jul 2022 15:40:19 +0000
Date:   Sat, 16 Jul 2022 23:40:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: [ammarfaizi2-block:axboe/linux-block/for-next 91/112]
 include/trace/events/nilfs2.h:191:1: sparse: sparse: cast to restricted
 blk_opf_t
Message-ID: <202207162314.Jz305X9h-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/for-next
head:   b1fc9e8ad3d2d294d15e87d57af00890cd23cfc4
commit: ed4512590bd5839f8ea9eef1626b0f4db626b1d1 [91/112] fs/nilfs2: Use the enum req_op and blk_opf_t types
config: mips-randconfig-s033-20220715 (https://download.01.org/0day-ci/archive/20220716/202207162314.Jz305X9h-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/ed4512590bd5839f8ea9eef1626b0f4db626b1d1
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/for-next
        git checkout ed4512590bd5839f8ea9eef1626b0f4db626b1d1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash fs/nilfs2/ fs/zonefs/./

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
