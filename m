Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052DE57729A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 02:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiGQAxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 20:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGQAxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 20:53:05 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4290218E08
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 17:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658019183; x=1689555183;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wiZhrOtazGpsqdVmYsiuI6bg1gcYqRpUhyNHjaDvr0A=;
  b=mb4RLSxexk8VT7wr3nq023JOzuahgL28a4zks9v+s1596z7HTnp2H/Wh
   DQXHT7BshSE240lHTmTyYa3+fdy0M37DFVpIUEeowy08LPBOk4gx7t9yG
   f/cd0/Q+qqbzGLwspyyDwDqZ9oc0IbrEJSaWypsxpFIm9UyKAHPJzRbli
   q7PbPhTV2SHK8xpBd21Hd8azU7+0iClayCIKaDF2Et2QjDrqRtqEpucmZ
   EPxq4jSlqfjf3/Etm+erqxY9/SuUYgyfSbDu2ajMDXGQy4NNGM0quqPVi
   tDnRCNX7vvEGUhZWoB0O0MrodX8eGsUTDQFCp8yKui9aBy3ri2r7QYyrs
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="347705320"
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="347705320"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 17:53:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="594102344"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 16 Jul 2022 17:53:01 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCsWq-0002Nf-Ca;
        Sun, 17 Jul 2022 00:53:00 +0000
Date:   Sun, 17 Jul 2022 08:52:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [ammarfaizi2-block:axboe/linux-block/for-next 85/112]
 include/trace/events/f2fs.h:1027:1: sparse: sparse: cast to restricted
 blk_opf_t
Message-ID: <202207170807.bkhAD4Nr-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/for-next
head:   b1fc9e8ad3d2d294d15e87d57af00890cd23cfc4
commit: 7649c873c16a384d447f7dbf9b153e333159f914 [85/112] fs/f2fs: Use the enum req_op and blk_opf_t types
config: csky-randconfig-s053-20220715 (https://download.01.org/0day-ci/archive/20220717/202207170807.bkhAD4Nr-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/7649c873c16a384d447f7dbf9b153e333159f914
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/for-next
        git checkout 7649c873c16a384d447f7dbf9b153e333159f914
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=csky SHELL=/bin/bash fs/f2fs/ fs/jbd2/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   fs/f2fs/super.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/f2fs.h):
>> include/trace/events/f2fs.h:1027:1: sparse: sparse: cast to restricted blk_opf_t
>> include/trace/events/f2fs.h:1027:1: sparse: sparse: cast to restricted blk_opf_t
   include/trace/events/f2fs.h:1027:1: sparse: sparse: restricted blk_opf_t degrades to integer
   include/trace/events/f2fs.h:1027:1: sparse: sparse: restricted blk_opf_t degrades to integer
>> include/trace/events/f2fs.h:1027:1: sparse: sparse: cast to restricted blk_opf_t
>> include/trace/events/f2fs.h:1027:1: sparse: sparse: cast to restricted blk_opf_t
   include/trace/events/f2fs.h:1027:1: sparse: sparse: restricted blk_opf_t degrades to integer
   include/trace/events/f2fs.h:1027:1: sparse: sparse: restricted blk_opf_t degrades to integer
   include/trace/events/f2fs.h:1086:1: sparse: sparse: cast to restricted blk_opf_t
   include/trace/events/f2fs.h:1086:1: sparse: sparse: cast to restricted blk_opf_t
   include/trace/events/f2fs.h:1086:1: sparse: sparse: restricted blk_opf_t degrades to integer
   include/trace/events/f2fs.h:1086:1: sparse: sparse: restricted blk_opf_t degrades to integer
   include/trace/events/f2fs.h:1086:1: sparse: sparse: cast to restricted blk_opf_t
   include/trace/events/f2fs.h:1086:1: sparse: sparse: cast to restricted blk_opf_t
   include/trace/events/f2fs.h:1086:1: sparse: sparse: restricted blk_opf_t degrades to integer
   include/trace/events/f2fs.h:1086:1: sparse: sparse: restricted blk_opf_t degrades to integer
   fs/f2fs/super.c: note: in included file (through arch/csky/include/asm/atomic.h, include/linux/atomic.h, include/asm-generic/bitops/lock.h, ...):
   include/asm-generic/atomic.h:105:1: sparse: sparse: context imbalance in 'f2fs_drop_inode' - unexpected unlock

vim +1027 include/trace/events/f2fs.h

c01e285324793a8 Namjae Jeon     2013-04-23  1026  
3e1c8f125eeea0f Chao Yu         2014-12-23 @1027  DECLARE_EVENT_CLASS(f2fs__submit_page_bio,
3e1c8f125eeea0f Chao Yu         2014-12-23  1028  
2ace38e00e54f5c Chao Yu         2014-12-24  1029  	TP_PROTO(struct page *page, struct f2fs_io_info *fio),
3e1c8f125eeea0f Chao Yu         2014-12-23  1030  
2ace38e00e54f5c Chao Yu         2014-12-24  1031  	TP_ARGS(page, fio),
3e1c8f125eeea0f Chao Yu         2014-12-23  1032  
3e1c8f125eeea0f Chao Yu         2014-12-23  1033  	TP_STRUCT__entry(
3e1c8f125eeea0f Chao Yu         2014-12-23  1034  		__field(dev_t, dev)
3e1c8f125eeea0f Chao Yu         2014-12-23  1035  		__field(ino_t, ino)
3e1c8f125eeea0f Chao Yu         2014-12-23  1036  		__field(pgoff_t, index)
7a9d75481b85d59 Chao Yu         2016-02-22  1037  		__field(block_t, old_blkaddr)
7a9d75481b85d59 Chao Yu         2016-02-22  1038  		__field(block_t, new_blkaddr)
7649c873c16a384 Bart Van Assche 2022-07-14  1039  		__field(enum req_op, op)
7649c873c16a384 Bart Van Assche 2022-07-14  1040  		__field(blk_opf_t, op_flags)
a912b54d3aaa011 Jaegeuk Kim     2017-05-10  1041  		__field(int, temp)
3e1c8f125eeea0f Chao Yu         2014-12-23  1042  		__field(int, type)
3e1c8f125eeea0f Chao Yu         2014-12-23  1043  	),
3e1c8f125eeea0f Chao Yu         2014-12-23  1044  
3e1c8f125eeea0f Chao Yu         2014-12-23  1045  	TP_fast_assign(
4969c06a0d83c9c Jaegeuk Kim     2019-07-01  1046  		__entry->dev		= page_file_mapping(page)->host->i_sb->s_dev;
4969c06a0d83c9c Jaegeuk Kim     2019-07-01  1047  		__entry->ino		= page_file_mapping(page)->host->i_ino;
3e1c8f125eeea0f Chao Yu         2014-12-23  1048  		__entry->index		= page->index;
7a9d75481b85d59 Chao Yu         2016-02-22  1049  		__entry->old_blkaddr	= fio->old_blkaddr;
7a9d75481b85d59 Chao Yu         2016-02-22  1050  		__entry->new_blkaddr	= fio->new_blkaddr;
04d328defd06257 Mike Christie   2016-06-05  1051  		__entry->op		= fio->op;
04d328defd06257 Mike Christie   2016-06-05  1052  		__entry->op_flags	= fio->op_flags;
a912b54d3aaa011 Jaegeuk Kim     2017-05-10  1053  		__entry->temp		= fio->temp;
2ace38e00e54f5c Chao Yu         2014-12-24  1054  		__entry->type		= fio->type;
3e1c8f125eeea0f Chao Yu         2014-12-23  1055  	),
3e1c8f125eeea0f Chao Yu         2014-12-23  1056  
3e1c8f125eeea0f Chao Yu         2014-12-23  1057  	TP_printk("dev = (%d,%d), ino = %lu, page_index = 0x%lx, "
a912b54d3aaa011 Jaegeuk Kim     2017-05-10  1058  		"oldaddr = 0x%llx, newaddr = 0x%llx, rw = %s(%s), type = %s_%s",
3e1c8f125eeea0f Chao Yu         2014-12-23  1059  		show_dev_ino(__entry),
3e1c8f125eeea0f Chao Yu         2014-12-23  1060  		(unsigned long)__entry->index,
7a9d75481b85d59 Chao Yu         2016-02-22  1061  		(unsigned long long)__entry->old_blkaddr,
7a9d75481b85d59 Chao Yu         2016-02-22  1062  		(unsigned long long)__entry->new_blkaddr,
d621e6b3707f4c3 Jaegeuk Kim     2016-12-21  1063  		show_bio_type(__entry->op, __entry->op_flags),
a912b54d3aaa011 Jaegeuk Kim     2017-05-10  1064  		show_block_temp(__entry->temp),
3e1c8f125eeea0f Chao Yu         2014-12-23  1065  		show_block_type(__entry->type))
3e1c8f125eeea0f Chao Yu         2014-12-23  1066  );
3e1c8f125eeea0f Chao Yu         2014-12-23  1067  

:::::: The code at line 1027 was first introduced by commit
:::::: 3e1c8f125eeea0f8111e2b9131162bfba32c6381 f2fs: cleanup trace event of f2fs_submit_page_{m,}bio with DECLARE_EVENT_CLASS

:::::: TO: Chao Yu <chao2.yu@samsung.com>
:::::: CC: Jaegeuk Kim <jaegeuk@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
