Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC26257732D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiGQC0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGQC0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:26:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF4B17062
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658024769; x=1689560769;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OfZVs6tnnKYTqfCiXmldWBlSCXTOlycktTvOT3RYf7E=;
  b=gJuFNcocchnTieymFAXUV/JmaQ3peOBAAQ0tiADmDrH9O4eH30dSlUXp
   7ZTAsaMe+/dw5HKtHff7VcJWF6gSwXica/zaVMLHQ3OqQlnN74xI0ftE5
   ZXZyIR2aBxA1Wbg044A1r5PRh7Niut3optAHyCpGPYey47Zb5AZCle0Yl
   ykf+wohITbZJ1lRiT1Hyc3KpJLzzvlpj6hdhWQpKpKrEWsjfA9jG3hbfN
   +rmTqsPHeGK1lHThq0rMgL5j6NZZ/6IXho1T2Bn0Du0KQbZrrfU+9p4tX
   qs3vLh1ekueIuEyPj8/8vaduZXyz7HwcHp0qZZNGlWbGlIezASZErnS49
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="347709491"
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="347709491"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 19:26:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="547083850"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 16 Jul 2022 19:26:06 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCtyv-0002XG-B3;
        Sun, 17 Jul 2022 02:26:05 +0000
Date:   Sun, 17 Jul 2022 10:25:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [ammarfaizi2-block:axboe/linux-block/for-next 89/112]
 include/trace/events/jbd2.h:356:1: sparse: sparse: cast to restricted
 blk_opf_t
Message-ID: <202207171031.j4kTzo1K-lkp@intel.com>
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
commit: 6669797b0dd41ced457760b6e1014fdda8ce19ce [89/112] fs/jbd2: Fix the documentation of the jbd2_write_superblock() callers
config: csky-randconfig-s053-20220715 (https://download.01.org/0day-ci/archive/20220717/202207171031.j4kTzo1K-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/6669797b0dd41ced457760b6e1014fdda8ce19ce
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/for-next
        git checkout 6669797b0dd41ced457760b6e1014fdda8ce19ce
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=csky SHELL=/bin/bash fs/jbd2/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   fs/jbd2/journal.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/jbd2.h):
>> include/trace/events/jbd2.h:356:1: sparse: sparse: cast to restricted blk_opf_t
>> include/trace/events/jbd2.h:356:1: sparse: sparse: cast to restricted blk_opf_t
>> include/trace/events/jbd2.h:356:1: sparse: sparse: restricted blk_opf_t degrades to integer
>> include/trace/events/jbd2.h:356:1: sparse: sparse: restricted blk_opf_t degrades to integer

vim +356 include/trace/events/jbd2.h

71f2be213a00090 Theodore Ts'o   2009-12-23  355  
24bcc89c7e7c649 Jan Kara        2012-03-13 @356  TRACE_EVENT(jbd2_write_superblock,
2201c590dd6e802 Seiji Aguchi    2012-02-20  357  
6669797b0dd41ce Bart Van Assche 2022-07-14  358  	TP_PROTO(journal_t *journal, blk_opf_t write_flags),
2201c590dd6e802 Seiji Aguchi    2012-02-20  359  
6669797b0dd41ce Bart Van Assche 2022-07-14  360  	TP_ARGS(journal, write_flags),
2201c590dd6e802 Seiji Aguchi    2012-02-20  361  
2201c590dd6e802 Seiji Aguchi    2012-02-20  362  	TP_STRUCT__entry(
2201c590dd6e802 Seiji Aguchi    2012-02-20  363  		__field(	dev_t,  dev			)
6669797b0dd41ce Bart Van Assche 2022-07-14  364  		__field(    blk_opf_t,  write_flags		)
2201c590dd6e802 Seiji Aguchi    2012-02-20  365  	),
2201c590dd6e802 Seiji Aguchi    2012-02-20  366  
2201c590dd6e802 Seiji Aguchi    2012-02-20  367  	TP_fast_assign(
2201c590dd6e802 Seiji Aguchi    2012-02-20  368  		__entry->dev		= journal->j_fs_dev->bd_dev;
6669797b0dd41ce Bart Van Assche 2022-07-14  369  		__entry->write_flags	= write_flags;
2201c590dd6e802 Seiji Aguchi    2012-02-20  370  	),
2201c590dd6e802 Seiji Aguchi    2012-02-20  371  
6669797b0dd41ce Bart Van Assche 2022-07-14  372  	TP_printk("dev %d,%d write_flags %x", MAJOR(__entry->dev),
6669797b0dd41ce Bart Van Assche 2022-07-14  373  		  MINOR(__entry->dev), (__force u32)__entry->write_flags)
2201c590dd6e802 Seiji Aguchi    2012-02-20  374  );
2201c590dd6e802 Seiji Aguchi    2012-02-20  375  

:::::: The code at line 356 was first introduced by commit
:::::: 24bcc89c7e7c64982e6192b4952a0a92379fc341 jbd2: split updating of journal superblock and marking journal empty

:::::: TO: Jan Kara <jack@suse.cz>
:::::: CC: Theodore Ts'o <tytso@mit.edu>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
