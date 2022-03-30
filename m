Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D064EB842
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 04:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241769AbiC3CS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 22:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiC3CSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 22:18:24 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53198217C6B
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 19:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648606600; x=1680142600;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=A6QC8MjjgpND1r7D4JwXhogTe2+CIKA4+PtJmMkZLDo=;
  b=SgFFqiNiI4gm2Nx28UfFZW3CyefDYo3n557rhkG2ZWmcNgyrXMWLqu2P
   PiQB1D6uDioZJYuk3yAAmzPxlm3qyx1vE4tSikyMKXQLAGF9SQHG0odON
   DKS46qGv0qJB2IzA+gdUjU9SADihCvgpuUTjYvEglHeK78Fkg/O09bRqH
   bclAQh0EOVrRYN6wN/4i8RGKixSa2DKEHl6pM2S7Q0kQpNMANoVhTOSOx
   IXWKMqvp1KT9GsYCs8Gdl4/9ym+shB7GgNGsoT4WnrMew4Bev9gssD6qT
   OenHLZ3zkzlidGdV6pO4Wau+Sdc00fpSiArcpAV32J/NGVM04xTvqEnJZ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="257004759"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="257004759"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 19:16:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="719789554"
Received: from lkp-server01.sh.intel.com (HELO 3965e2759b93) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 29 Mar 2022 19:16:38 -0700
Received: from kbuild by 3965e2759b93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZNsz-0000ta-Aq; Wed, 30 Mar 2022 02:16:37 +0000
Date:   Wed, 30 Mar 2022 10:16:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Georgi Djakov <quic_c_gdjako@quicinc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-trusty-5.10
 5839/5872] kernel/sched/psi.c:538:3: error: implicit declaration of function
 'trace_android_vh_psi_event'
Message-ID: <202203301037.L3FMfBJj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Georgi,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-trusty-5.10
head:   07055bfd3d810d41a38354693dfaa55a6f8c0025
commit: b79d1815c400c3929bb78a209b6e51a38d6ffcb2 [5839/5872] ANDROID: psi: Add vendor hooks for PSI tracing
config: i386-randconfig-a006 (https://download.01.org/0day-ci/archive/20220330/202203301037.L3FMfBJj-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/b79d1815c400c3929bb78a209b6e51a38d6ffcb2
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-trusty-5.10
        git checkout b79d1815c400c3929bb78a209b6e51a38d6ffcb2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/sched/psi.c:538:3: error: implicit declaration of function 'trace_android_vh_psi_event' [-Werror,-Wimplicit-function-declaration]
                   trace_android_vh_psi_event(t);
                   ^
>> kernel/sched/psi.c:546:2: error: implicit declaration of function 'trace_android_vh_psi_group' [-Werror,-Wimplicit-function-declaration]
           trace_android_vh_psi_group(group);
           ^
   2 errors generated.


vim +/trace_android_vh_psi_event +538 kernel/sched/psi.c

   503	
   504	static u64 update_triggers(struct psi_group *group, u64 now)
   505	{
   506		struct psi_trigger *t;
   507		bool new_stall = false;
   508		u64 *total = group->total[PSI_POLL];
   509	
   510		/*
   511		 * On subsequent updates, calculate growth deltas and let
   512		 * watchers know when their specified thresholds are exceeded.
   513		 */
   514		list_for_each_entry(t, &group->triggers, node) {
   515			u64 growth;
   516	
   517			/* Check for stall activity */
   518			if (group->polling_total[t->state] == total[t->state])
   519				continue;
   520	
   521			/*
   522			 * Multiple triggers might be looking at the same state,
   523			 * remember to update group->polling_total[] once we've
   524			 * been through all of them. Also remember to extend the
   525			 * polling time if we see new stall activity.
   526			 */
   527			new_stall = true;
   528	
   529			/* Calculate growth since last update */
   530			growth = window_update(&t->win, now, total[t->state]);
   531			if (growth < t->threshold)
   532				continue;
   533	
   534			/* Limit event signaling to once per window */
   535			if (now < t->last_event_time + t->win.size)
   536				continue;
   537	
 > 538			trace_android_vh_psi_event(t);
   539	
   540			/* Generate an event */
   541			if (cmpxchg(&t->event, 0, 1) == 0)
   542				wake_up_interruptible(&t->event_wait);
   543			t->last_event_time = now;
   544		}
   545	
 > 546		trace_android_vh_psi_group(group);
   547	
   548		if (new_stall)
   549			memcpy(group->polling_total, total,
   550					sizeof(group->polling_total));
   551	
   552		return now + group->poll_min_period;
   553	}
   554	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
