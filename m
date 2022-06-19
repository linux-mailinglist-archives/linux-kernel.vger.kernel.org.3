Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9200055097D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 11:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbiFSJVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 05:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbiFSJUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 05:20:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FC0D109
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 02:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655630454; x=1687166454;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ml93bxgkrwm2yQs4iS9LeKWBAtTuGjmv80Ue9mAv0Tw=;
  b=X9DSIP1v1WaSagVi7W0voscDHgpKA2GlkkmX3LMFEaQlnEQv7Yqhvdwr
   HWPG8r3IaLd/6P61blO8F31XfMFIDMqnHXncy8O5NpRi0HNWpTLGFY1j9
   lxJGtKPs5AGQ1Ar9djpwYNR1rpXSSMeElHSVS2zCCwiLGoakWW3xrTkIs
   Ldnbt1czpfGem3M8r/0d9cwTqK9g0+DJ/D8e3jQUdls0z6LrfAQs4AGTg
   Tmw4TvzDGePFdL3WJccTFHdXgRM88E75zRjyji2PazycwaYx2kCJrGB9e
   LdF5IMd0VAeLqIq+Xrb6UTRTdJHsoTYpPR+JvVl+FAkrqNSVYH1bUTQPB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="260144894"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="260144894"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 02:20:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="832677689"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 19 Jun 2022 02:20:52 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2r6y-000R47-3A;
        Sun, 19 Jun 2022 09:20:52 +0000
Date:   Sun, 19 Jun 2022 17:20:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Yury Norov <yury.norov@gmail.com>
Subject: [alobakin:bitops 3/7] block/elevator.c:222:9: sparse: sparse: cast
 from restricted req_flags_t
Message-ID: <202206191726.wq70mbMK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/alobakin/linux bitops
head:   9bd39b17ce49d350eed93a031e0da6389067013e
commit: 521611f961a7dda92eefa26e1afd3914c06af64e [3/7] bitops: unify non-atomic bitops prototypes across architectures
config: mips-randconfig-s031-20220619 (https://download.01.org/0day-ci/archive/20220619/202206191726.wq70mbMK-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-30-g92122700-dirty
        # https://github.com/alobakin/linux/commit/521611f961a7dda92eefa26e1afd3914c06af64e
        git remote add alobakin https://github.com/alobakin/linux
        git fetch --no-tags alobakin bitops
        git checkout 521611f961a7dda92eefa26e1afd3914c06af64e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   block/elevator.c: note: in included file (through include/linux/bitops.h, include/linux/kernel.h):
   include/asm-generic/bitops/generic-non-atomic.h:29:9: sparse: sparse: unreplaced symbol 'mask'
   include/asm-generic/bitops/generic-non-atomic.h:30:9: sparse: sparse: unreplaced symbol 'p'
   include/asm-generic/bitops/generic-non-atomic.h:32:10: sparse: sparse: unreplaced symbol 'p'
   include/asm-generic/bitops/generic-non-atomic.h:32:16: sparse: sparse: unreplaced symbol 'mask'
   include/asm-generic/bitops/generic-non-atomic.h:27:1: sparse: sparse: unreplaced symbol 'return'
   include/asm-generic/bitops/generic-non-atomic.h:38:9: sparse: sparse: unreplaced symbol 'mask'
   include/asm-generic/bitops/generic-non-atomic.h:39:9: sparse: sparse: unreplaced symbol 'p'
   include/asm-generic/bitops/generic-non-atomic.h:41:10: sparse: sparse: unreplaced symbol 'p'
   include/asm-generic/bitops/generic-non-atomic.h:41:16: sparse: sparse: unreplaced symbol 'mask'
   include/asm-generic/bitops/generic-non-atomic.h:36:1: sparse: sparse: unreplaced symbol 'return'
   include/asm-generic/bitops/generic-non-atomic.h:56:9: sparse: sparse: unreplaced symbol 'mask'
   include/asm-generic/bitops/generic-non-atomic.h:57:9: sparse: sparse: unreplaced symbol 'p'
   include/asm-generic/bitops/generic-non-atomic.h:59:10: sparse: sparse: unreplaced symbol 'p'
   include/asm-generic/bitops/generic-non-atomic.h:59:15: sparse: sparse: unreplaced symbol 'mask'
   include/asm-generic/bitops/generic-non-atomic.h:54:1: sparse: sparse: unreplaced symbol 'return'
   include/asm-generic/bitops/generic-non-atomic.h:74:9: sparse: sparse: unreplaced symbol 'mask'
   include/asm-generic/bitops/generic-non-atomic.h:75:9: sparse: sparse: unreplaced symbol 'p'
   include/asm-generic/bitops/generic-non-atomic.h:76:9: sparse: sparse: unreplaced symbol 'old'
   include/asm-generic/bitops/generic-non-atomic.h:78:10: sparse: sparse: unreplaced symbol 'p'
   include/asm-generic/bitops/generic-non-atomic.h:78:14: sparse: sparse: unreplaced symbol 'old'
   include/asm-generic/bitops/generic-non-atomic.h:78:20: sparse: sparse: unreplaced symbol 'mask'
   include/asm-generic/bitops/generic-non-atomic.h:79:17: sparse: sparse: unreplaced symbol 'old'
   include/asm-generic/bitops/generic-non-atomic.h:79:23: sparse: sparse: unreplaced symbol 'mask'
   include/asm-generic/bitops/generic-non-atomic.h:79:9: sparse: sparse: unreplaced symbol 'return'
   include/asm-generic/bitops/generic-non-atomic.h:72:1: sparse: sparse: unreplaced symbol 'return'
   include/asm-generic/bitops/generic-non-atomic.h:94:9: sparse: sparse: unreplaced symbol 'mask'
   include/asm-generic/bitops/generic-non-atomic.h:95:9: sparse: sparse: unreplaced symbol 'p'
   include/asm-generic/bitops/generic-non-atomic.h:96:9: sparse: sparse: unreplaced symbol 'old'
   include/asm-generic/bitops/generic-non-atomic.h:98:10: sparse: sparse: unreplaced symbol 'p'
   include/asm-generic/bitops/generic-non-atomic.h:98:14: sparse: sparse: unreplaced symbol 'old'
   include/asm-generic/bitops/generic-non-atomic.h:98:21: sparse: sparse: unreplaced symbol 'mask'
   include/asm-generic/bitops/generic-non-atomic.h:99:17: sparse: sparse: unreplaced symbol 'old'
   include/asm-generic/bitops/generic-non-atomic.h:99:23: sparse: sparse: unreplaced symbol 'mask'
   include/asm-generic/bitops/generic-non-atomic.h:99:9: sparse: sparse: unreplaced symbol 'return'
   include/asm-generic/bitops/generic-non-atomic.h:92:1: sparse: sparse: unreplaced symbol 'return'
   include/asm-generic/bitops/generic-non-atomic.h:106:9: sparse: sparse: unreplaced symbol 'mask'
   include/asm-generic/bitops/generic-non-atomic.h:107:9: sparse: sparse: unreplaced symbol 'p'
   include/asm-generic/bitops/generic-non-atomic.h:108:9: sparse: sparse: unreplaced symbol 'old'
   include/asm-generic/bitops/generic-non-atomic.h:110:10: sparse: sparse: unreplaced symbol 'p'
   include/asm-generic/bitops/generic-non-atomic.h:110:14: sparse: sparse: unreplaced symbol 'old'
   include/asm-generic/bitops/generic-non-atomic.h:110:20: sparse: sparse: unreplaced symbol 'mask'
   include/asm-generic/bitops/generic-non-atomic.h:111:17: sparse: sparse: unreplaced symbol 'old'
   include/asm-generic/bitops/generic-non-atomic.h:111:23: sparse: sparse: unreplaced symbol 'mask'
   include/asm-generic/bitops/generic-non-atomic.h:111:9: sparse: sparse: unreplaced symbol 'return'
   include/asm-generic/bitops/generic-non-atomic.h:104:1: sparse: sparse: unreplaced symbol 'return'
   include/asm-generic/bitops/generic-non-atomic.h:127:9: sparse: sparse: unreplaced symbol 'return'
   include/asm-generic/bitops/generic-non-atomic.h:120:1: sparse: sparse: unreplaced symbol 'return'
>> block/elevator.c:222:9: sparse: sparse: cast from restricted req_flags_t

vim +222 block/elevator.c

9817064b68fef7 Jens Axboe        2006-07-28  217  
70b3ea056f3074 Jens Axboe        2016-12-07  218  void elv_rqhash_add(struct request_queue *q, struct request *rq)
9817064b68fef7 Jens Axboe        2006-07-28  219  {
b374d18a4bfce7 Jens Axboe        2008-10-31  220  	struct elevator_queue *e = q->elevator;
9817064b68fef7 Jens Axboe        2006-07-28  221  
9817064b68fef7 Jens Axboe        2006-07-28 @222  	BUG_ON(ELV_ON_HASH(rq));
242d98f077ac0a Sasha Levin       2012-12-17  223  	hash_add(e->hash, &rq->hash, rq_hash_key(rq));
e806402130c9c4 Christoph Hellwig 2016-10-20  224  	rq->rq_flags |= RQF_HASHED;
9817064b68fef7 Jens Axboe        2006-07-28  225  }
bd166ef183c263 Jens Axboe        2017-01-17  226  EXPORT_SYMBOL_GPL(elv_rqhash_add);
9817064b68fef7 Jens Axboe        2006-07-28  227  

:::::: The code at line 222 was first introduced by commit
:::::: 9817064b68fef7e4580c6df1ea597e106b9ff88b [PATCH] elevator: move the backmerging logic into the elevator core

:::::: TO: Jens Axboe <axboe@suse.de>
:::::: CC: Jens Axboe <axboe@nelson.home.kernel.dk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
