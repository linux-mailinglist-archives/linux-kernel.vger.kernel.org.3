Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9D2577D96
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 10:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiGRIgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 04:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiGRIf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:35:59 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E531054A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658133357; x=1689669357;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GdLaTDQF8UkYjfdEbu8j85QpeOewdjprSW3Iifpqtyc=;
  b=nRGW+kKTIQ3dSi7QuKL87f+cFYd0XzS4xS0kVW//QLvnnnDnVSYJvwWd
   86CL8fdnw+RMYS+7NQc5COqmZC8klI62TLKP6sAFOcAzw4UOg0dV0QmxL
   Qd6XyviUV9UsZGi0/1j0136nfreq7urB8MWvNlI9RyrLYdHYUKuviiz3O
   HoD7+bS1ogIJhFW83JMUOeXdyzpo6PHr6B1vK3/eFcixTfslb2gGVhBBv
   GhmavUG5Y0rAfxH5lwayZLiHJzfG0/rKoa00zNnR4DrAOdfJqbEVbel0T
   ZRsPPGsCFad6+l0kgrwKJFnFcBmIRghMpRBG4ad4kKKPYNM4NWD7q8N7N
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="269190770"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="269190770"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 01:35:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="624634330"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 18 Jul 2022 01:35:55 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDMEN-0004CE-6Q;
        Mon, 18 Jul 2022 08:35:55 +0000
Date:   Mon, 18 Jul 2022 16:35:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [bvanassche:f2fs 4/4] fs/f2fs/segment.c:4070:36: sparse: sparse:
 incompatible types in comparison expression (different type sizes):
Message-ID: <202207181628.I3aB3uS6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux f2fs
head:   787811ac4178b6f0a77923aa25c58b4041a52f05
commit: 787811ac4178b6f0a77923aa25c58b4041a52f05 [4/4] f
config: nios2-randconfig-s031-20220717 (https://download.01.org/0day-ci/archive/20220718/202207181628.I3aB3uS6-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/bvanassche/linux/commit/787811ac4178b6f0a77923aa25c58b4041a52f05
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche f2fs
        git checkout 787811ac4178b6f0a77923aa25c58b4041a52f05
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=nios2 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/f2fs/segment.c:4070:36: sparse: sparse: incompatible types in comparison expression (different type sizes):
>> fs/f2fs/segment.c:4070:36: sparse:    unsigned int *
>> fs/f2fs/segment.c:4070:36: sparse:    unsigned long *
   fs/f2fs/segment.c: note: in included file:
>> fs/f2fs/segment.h:417:28: sparse: sparse: incompatible types in comparison expression (different type sizes):
>> fs/f2fs/segment.h:417:28: sparse:    unsigned int *
>> fs/f2fs/segment.h:417:28: sparse:    unsigned long *

vim +4070 fs/f2fs/segment.c

351df4b2011573 Jaegeuk Kim   2012-11-02  4025  
0a8165d7c2cf13 Jaegeuk Kim   2012-11-29  4026  /*
351df4b2011573 Jaegeuk Kim   2012-11-02  4027   * CP calls this function, which flushes SIT entries including sit_journal,
351df4b2011573 Jaegeuk Kim   2012-11-02  4028   * and moves prefree segs to free segs.
351df4b2011573 Jaegeuk Kim   2012-11-02  4029   */
4d57b86dd86404 Chao Yu       2018-05-30  4030  void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
351df4b2011573 Jaegeuk Kim   2012-11-02  4031  {
351df4b2011573 Jaegeuk Kim   2012-11-02  4032  	struct sit_info *sit_i = SIT_I(sbi);
351df4b2011573 Jaegeuk Kim   2012-11-02  4033  	unsigned long *bitmap = sit_i->dirty_sentries_bitmap;
351df4b2011573 Jaegeuk Kim   2012-11-02  4034  	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_COLD_DATA);
b7ad7512b84b26 Chao Yu       2016-02-19  4035  	struct f2fs_journal *journal = curseg->journal;
184a5cd2ce281f Chao Yu       2014-09-04  4036  	struct sit_entry_set *ses, *tmp;
184a5cd2ce281f Chao Yu       2014-09-04  4037  	struct list_head *head = &SM_I(sbi)->sit_entry_set;
04f0b2eaa3b3ee Qiuyang Sun   2019-06-05  4038  	bool to_journal = !is_sbi_flag_set(sbi, SBI_IS_RESIZEFS);
4b2fecc8465505 Jaegeuk Kim   2014-09-20  4039  	struct seg_entry *se;
351df4b2011573 Jaegeuk Kim   2012-11-02  4040  
3d26fa6be3c487 Chao Yu       2017-10-30  4041  	down_write(&sit_i->sentry_lock);
351df4b2011573 Jaegeuk Kim   2012-11-02  4042  
2b11a74b21b040 Wanpeng Li    2015-02-27  4043  	if (!sit_i->dirty_sentries)
2b11a74b21b040 Wanpeng Li    2015-02-27  4044  		goto out;
2b11a74b21b040 Wanpeng Li    2015-02-27  4045  
351df4b2011573 Jaegeuk Kim   2012-11-02  4046  	/*
184a5cd2ce281f Chao Yu       2014-09-04  4047  	 * add and account sit entries of dirty bitmap in sit entry
184a5cd2ce281f Chao Yu       2014-09-04  4048  	 * set temporarily
351df4b2011573 Jaegeuk Kim   2012-11-02  4049  	 */
184a5cd2ce281f Chao Yu       2014-09-04  4050  	add_sits_in_set(sbi);
351df4b2011573 Jaegeuk Kim   2012-11-02  4051  
184a5cd2ce281f Chao Yu       2014-09-04  4052  	/*
184a5cd2ce281f Chao Yu       2014-09-04  4053  	 * if there are no enough space in journal to store dirty sit
184a5cd2ce281f Chao Yu       2014-09-04  4054  	 * entries, remove all entries from journal and add and account
184a5cd2ce281f Chao Yu       2014-09-04  4055  	 * them in sit entry set.
184a5cd2ce281f Chao Yu       2014-09-04  4056  	 */
04f0b2eaa3b3ee Qiuyang Sun   2019-06-05  4057  	if (!__has_cursum_space(journal, sit_i->dirty_sentries, SIT_JOURNAL) ||
04f0b2eaa3b3ee Qiuyang Sun   2019-06-05  4058  								!to_journal)
184a5cd2ce281f Chao Yu       2014-09-04  4059  		remove_sits_in_journal(sbi);
351df4b2011573 Jaegeuk Kim   2012-11-02  4060  
184a5cd2ce281f Chao Yu       2014-09-04  4061  	/*
184a5cd2ce281f Chao Yu       2014-09-04  4062  	 * there are two steps to flush sit entries:
184a5cd2ce281f Chao Yu       2014-09-04  4063  	 * #1, flush sit entries to journal in current cold data summary block.
184a5cd2ce281f Chao Yu       2014-09-04  4064  	 * #2, flush sit entries to sit page.
184a5cd2ce281f Chao Yu       2014-09-04  4065  	 */
184a5cd2ce281f Chao Yu       2014-09-04  4066  	list_for_each_entry_safe(ses, tmp, head, set_list) {
4a257ed677cb68 Jaegeuk Kim   2014-10-16  4067  		struct page *page = NULL;
184a5cd2ce281f Chao Yu       2014-09-04  4068  		struct f2fs_sit_block *raw_sit = NULL;
184a5cd2ce281f Chao Yu       2014-09-04  4069  		unsigned int start_segno = ses->start_segno;
184a5cd2ce281f Chao Yu       2014-09-04 @4070  		unsigned int end = min(start_segno + SIT_ENTRY_PER_BLOCK,
7cd8558baa4e45 Jaegeuk Kim   2014-09-23  4071  						(unsigned long)MAIN_SEGS(sbi));
184a5cd2ce281f Chao Yu       2014-09-04  4072  		unsigned int segno = start_segno;
b29555505d81e4 Jaegeuk Kim   2013-11-12  4073  
184a5cd2ce281f Chao Yu       2014-09-04  4074  		if (to_journal &&
dfc08a12e49a64 Chao Yu       2016-02-14  4075  			!__has_cursum_space(journal, ses->entry_cnt, SIT_JOURNAL))
184a5cd2ce281f Chao Yu       2014-09-04  4076  			to_journal = false;
351df4b2011573 Jaegeuk Kim   2012-11-02  4077  
b7ad7512b84b26 Chao Yu       2016-02-19  4078  		if (to_journal) {
b7ad7512b84b26 Chao Yu       2016-02-19  4079  			down_write(&curseg->journal_rwsem);
b7ad7512b84b26 Chao Yu       2016-02-19  4080  		} else {
184a5cd2ce281f Chao Yu       2014-09-04  4081  			page = get_next_sit_page(sbi, start_segno);
184a5cd2ce281f Chao Yu       2014-09-04  4082  			raw_sit = page_address(page);
351df4b2011573 Jaegeuk Kim   2012-11-02  4083  		}
351df4b2011573 Jaegeuk Kim   2012-11-02  4084  
184a5cd2ce281f Chao Yu       2014-09-04  4085  		/* flush dirty sit entries in region of current sit set */
184a5cd2ce281f Chao Yu       2014-09-04  4086  		for_each_set_bit_from(segno, bitmap, end) {
184a5cd2ce281f Chao Yu       2014-09-04  4087  			int offset, sit_offset;
4b2fecc8465505 Jaegeuk Kim   2014-09-20  4088  
4b2fecc8465505 Jaegeuk Kim   2014-09-20  4089  			se = get_seg_entry(sbi, segno);
56b07e7e65503c Zhikang Zhang 2018-04-09  4090  #ifdef CONFIG_F2FS_CHECK_FS
56b07e7e65503c Zhikang Zhang 2018-04-09  4091  			if (memcmp(se->cur_valid_map, se->cur_valid_map_mir,
56b07e7e65503c Zhikang Zhang 2018-04-09  4092  						SIT_VBLOCK_MAP_SIZE))
56b07e7e65503c Zhikang Zhang 2018-04-09  4093  				f2fs_bug_on(sbi, 1);
56b07e7e65503c Zhikang Zhang 2018-04-09  4094  #endif
351df4b2011573 Jaegeuk Kim   2012-11-02  4095  
184a5cd2ce281f Chao Yu       2014-09-04  4096  			/* add discard candidates */
c473f1a9658b6c Chao Yu       2017-04-27  4097  			if (!(cpc->reason & CP_DISCARD)) {
4b2fecc8465505 Jaegeuk Kim   2014-09-20  4098  				cpc->trim_start = segno;
25290fa5591d81 Jaegeuk Kim   2016-12-29  4099  				add_discard_addrs(sbi, cpc, false);
4b2fecc8465505 Jaegeuk Kim   2014-09-20  4100  			}
184a5cd2ce281f Chao Yu       2014-09-04  4101  
184a5cd2ce281f Chao Yu       2014-09-04  4102  			if (to_journal) {
4d57b86dd86404 Chao Yu       2018-05-30  4103  				offset = f2fs_lookup_journal_in_cursum(journal,
184a5cd2ce281f Chao Yu       2014-09-04  4104  							SIT_JOURNAL, segno, 1);
184a5cd2ce281f Chao Yu       2014-09-04  4105  				f2fs_bug_on(sbi, offset < 0);
dfc08a12e49a64 Chao Yu       2016-02-14  4106  				segno_in_journal(journal, offset) =
184a5cd2ce281f Chao Yu       2014-09-04  4107  							cpu_to_le32(segno);
184a5cd2ce281f Chao Yu       2014-09-04  4108  				seg_info_to_raw_sit(se,
dfc08a12e49a64 Chao Yu       2016-02-14  4109  					&sit_in_journal(journal, offset));
56b07e7e65503c Zhikang Zhang 2018-04-09  4110  				check_block_count(sbi, segno,
56b07e7e65503c Zhikang Zhang 2018-04-09  4111  					&sit_in_journal(journal, offset));
184a5cd2ce281f Chao Yu       2014-09-04  4112  			} else {
184a5cd2ce281f Chao Yu       2014-09-04  4113  				sit_offset = SIT_ENTRY_OFFSET(sit_i, segno);
184a5cd2ce281f Chao Yu       2014-09-04  4114  				seg_info_to_raw_sit(se,
184a5cd2ce281f Chao Yu       2014-09-04  4115  						&raw_sit->entries[sit_offset]);
56b07e7e65503c Zhikang Zhang 2018-04-09  4116  				check_block_count(sbi, segno,
56b07e7e65503c Zhikang Zhang 2018-04-09  4117  						&raw_sit->entries[sit_offset]);
351df4b2011573 Jaegeuk Kim   2012-11-02  4118  			}
351df4b2011573 Jaegeuk Kim   2012-11-02  4119  
351df4b2011573 Jaegeuk Kim   2012-11-02  4120  			__clear_bit(segno, bitmap);
351df4b2011573 Jaegeuk Kim   2012-11-02  4121  			sit_i->dirty_sentries--;
184a5cd2ce281f Chao Yu       2014-09-04  4122  			ses->entry_cnt--;
351df4b2011573 Jaegeuk Kim   2012-11-02  4123  		}
351df4b2011573 Jaegeuk Kim   2012-11-02  4124  
b7ad7512b84b26 Chao Yu       2016-02-19  4125  		if (to_journal)
b7ad7512b84b26 Chao Yu       2016-02-19  4126  			up_write(&curseg->journal_rwsem);
b7ad7512b84b26 Chao Yu       2016-02-19  4127  		else
351df4b2011573 Jaegeuk Kim   2012-11-02  4128  			f2fs_put_page(page, 1);
351df4b2011573 Jaegeuk Kim   2012-11-02  4129  
184a5cd2ce281f Chao Yu       2014-09-04  4130  		f2fs_bug_on(sbi, ses->entry_cnt);
184a5cd2ce281f Chao Yu       2014-09-04  4131  		release_sit_entry_set(ses);
184a5cd2ce281f Chao Yu       2014-09-04  4132  	}
184a5cd2ce281f Chao Yu       2014-09-04  4133  
184a5cd2ce281f Chao Yu       2014-09-04  4134  	f2fs_bug_on(sbi, !list_empty(head));
184a5cd2ce281f Chao Yu       2014-09-04  4135  	f2fs_bug_on(sbi, sit_i->dirty_sentries);
184a5cd2ce281f Chao Yu       2014-09-04  4136  out:
c473f1a9658b6c Chao Yu       2017-04-27  4137  	if (cpc->reason & CP_DISCARD) {
650d3c4e56e1e9 Yunlei He     2016-12-22  4138  		__u64 trim_start = cpc->trim_start;
650d3c4e56e1e9 Yunlei He     2016-12-22  4139  
4b2fecc8465505 Jaegeuk Kim   2014-09-20  4140  		for (; cpc->trim_start <= cpc->trim_end; cpc->trim_start++)
25290fa5591d81 Jaegeuk Kim   2016-12-29  4141  			add_discard_addrs(sbi, cpc, false);
650d3c4e56e1e9 Yunlei He     2016-12-22  4142  
650d3c4e56e1e9 Yunlei He     2016-12-22  4143  		cpc->trim_start = trim_start;
4b2fecc8465505 Jaegeuk Kim   2014-09-20  4144  	}
3d26fa6be3c487 Chao Yu       2017-10-30  4145  	up_write(&sit_i->sentry_lock);
184a5cd2ce281f Chao Yu       2014-09-04  4146  
351df4b2011573 Jaegeuk Kim   2012-11-02  4147  	set_prefree_as_free_segments(sbi);
351df4b2011573 Jaegeuk Kim   2012-11-02  4148  }
351df4b2011573 Jaegeuk Kim   2012-11-02  4149  

:::::: The code at line 4070 was first introduced by commit
:::::: 184a5cd2ce281f1207d72adb9ae18e416ca371db f2fs: refactor flush_sit_entries codes for reducing SIT writes

:::::: TO: Chao Yu <chao2.yu@samsung.com>
:::::: CC: Jaegeuk Kim <jaegeuk@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
