Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97DC4CC395
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbiCCRUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbiCCRUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:20:53 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57266DF488
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 09:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646328007; x=1677864007;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fbVrSJxP8DSmvUKJgJwdIu0rAwAK3p/ezIwgsKqBtb0=;
  b=aIZGbOxJiz9z+RmvpJPuwET81No6nPQqTc2hBI4sl/l14iK+FYdpV6qx
   ECaFuTcD7jSNfi9o+hRiFGlIzf2GUzJbBlZmdBpvleDGM17SoEKld0OO1
   BqmIlJ1Ov5eJQr4ANqExm3+4vCePEl0W5mkUgyGTFLFxP7IRixilKGsjo
   7gITaV933Z5/eC460QoeUbf0naadyC7JbcT4r7JfvV6d8ZXbjNMcQo/3q
   RP1i0UNccd+x3oBUY+4mA/A6mYqwP/AGpGHiRXdH7PUrz4gH+H2c12OgK
   NqO5drkkwVoUYwaOFjxoWvI+Ekb1UtHdRx8P80i0riXD3hPXOk/Gnoagw
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="252565112"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="252565112"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 09:20:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="642189971"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 03 Mar 2022 09:20:04 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPp7U-0000lp-2b; Thu, 03 Mar 2022 17:20:04 +0000
Date:   Fri, 4 Mar 2022 01:19:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Mark Salyzyn <salyzyn@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/deprecated/android-4.4-p-release
 6165/9922] kernel/time/timekeeping.c:952:17: error: 'struct timekeeper' has
 no member named 'raw_time'; did you mean 'raw_sec'?
Message-ID: <202203040104.HsDLJzbD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/deprecated/android-4.4-p-release
head:   c159ade87311501e4e4b40eb2f35aa5607732957
commit: 1d35c0438678c7ad4c367135082685d5754eed20 [6165/9922] BACKPORT: time: Clean up CLOCK_MONOTONIC_RAW time handling
config: i386-randconfig-c021-20211123 (https://download.01.org/0day-ci/archive/20220304/202203040104.HsDLJzbD-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/1d35c0438678c7ad4c367135082685d5754eed20
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/deprecated/android-4.4-p-release
        git checkout 1d35c0438678c7ad4c367135082685d5754eed20
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/time/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/time/timekeeping.c:17:0:
   include/linux/sched.h:1210:1: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
    const struct sched_group_energy * const(*sched_domain_energy_f)(int cpu);
    ^~~~~
   kernel/time/timekeeping.c: In function 'ktime_get_raw_and_real_ts64':
>> kernel/time/timekeeping.c:952:17: error: 'struct timekeeper' has no member named 'raw_time'; did you mean 'raw_sec'?
      *ts_raw = tk->raw_time;
                    ^~~~~~~~
                    raw_sec


vim +952 kernel/time/timekeeping.c

e2c18e49a0d4f82 Alexander Gordeev 2011-01-12  931  
e2c18e49a0d4f82 Alexander Gordeev 2011-01-12  932  /**
071eee45b1650d5 Arnd Bergmann     2015-09-28  933   * ktime_get_raw_and_real_ts64 - get day and raw monotonic time in timespec format
e2c18e49a0d4f82 Alexander Gordeev 2011-01-12  934   * @ts_raw:	pointer to the timespec to be set to raw monotonic time
e2c18e49a0d4f82 Alexander Gordeev 2011-01-12  935   * @ts_real:	pointer to the timespec to be set to the time of day
e2c18e49a0d4f82 Alexander Gordeev 2011-01-12  936   *
e2c18e49a0d4f82 Alexander Gordeev 2011-01-12  937   * This function reads both the time of day and raw monotonic time at the
e2c18e49a0d4f82 Alexander Gordeev 2011-01-12  938   * same time atomically and stores the resulting timestamps in timespec
e2c18e49a0d4f82 Alexander Gordeev 2011-01-12  939   * format.
e2c18e49a0d4f82 Alexander Gordeev 2011-01-12  940   */
071eee45b1650d5 Arnd Bergmann     2015-09-28  941  void ktime_get_raw_and_real_ts64(struct timespec64 *ts_raw, struct timespec64 *ts_real)
e2c18e49a0d4f82 Alexander Gordeev 2011-01-12  942  {
3fdb14fd1df7032 Thomas Gleixner   2014-07-16  943  	struct timekeeper *tk = &tk_core.timekeeper;
e2c18e49a0d4f82 Alexander Gordeev 2011-01-12  944  	unsigned long seq;
e2c18e49a0d4f82 Alexander Gordeev 2011-01-12  945  	s64 nsecs_raw, nsecs_real;
e2c18e49a0d4f82 Alexander Gordeev 2011-01-12  946  
e2c18e49a0d4f82 Alexander Gordeev 2011-01-12  947  	WARN_ON_ONCE(timekeeping_suspended);
e2c18e49a0d4f82 Alexander Gordeev 2011-01-12  948  
e2c18e49a0d4f82 Alexander Gordeev 2011-01-12  949  	do {
3fdb14fd1df7032 Thomas Gleixner   2014-07-16  950  		seq = read_seqcount_begin(&tk_core.seq);
e2c18e49a0d4f82 Alexander Gordeev 2011-01-12  951  
071eee45b1650d5 Arnd Bergmann     2015-09-28 @952  		*ts_raw = tk->raw_time;
4e250fdde9be505 John Stultz       2012-07-27  953  		ts_real->tv_sec = tk->xtime_sec;
1e75fa8be9fb61e John Stultz       2012-07-13  954  		ts_real->tv_nsec = 0;
e2c18e49a0d4f82 Alexander Gordeev 2011-01-12  955  
4a4ad80d32cea69 Peter Zijlstra    2015-03-19  956  		nsecs_raw  = timekeeping_get_ns(&tk->tkr_raw);
876e78818def298 Peter Zijlstra    2015-03-19  957  		nsecs_real = timekeeping_get_ns(&tk->tkr_mono);
e2c18e49a0d4f82 Alexander Gordeev 2011-01-12  958  
3fdb14fd1df7032 Thomas Gleixner   2014-07-16  959  	} while (read_seqcount_retry(&tk_core.seq, seq));
e2c18e49a0d4f82 Alexander Gordeev 2011-01-12  960  
071eee45b1650d5 Arnd Bergmann     2015-09-28  961  	timespec64_add_ns(ts_raw, nsecs_raw);
071eee45b1650d5 Arnd Bergmann     2015-09-28  962  	timespec64_add_ns(ts_real, nsecs_real);
e2c18e49a0d4f82 Alexander Gordeev 2011-01-12  963  }
071eee45b1650d5 Arnd Bergmann     2015-09-28  964  EXPORT_SYMBOL(ktime_get_raw_and_real_ts64);
e2c18e49a0d4f82 Alexander Gordeev 2011-01-12  965  

:::::: The code at line 952 was first introduced by commit
:::::: 071eee45b1650d53d21c636d344bdcebd4577ed2 ntp/pps: replace getnstime_raw_and_real with 64-bit version

:::::: TO: Arnd Bergmann <arnd@arndb.de>
:::::: CC: John Stultz <john.stultz@linaro.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
