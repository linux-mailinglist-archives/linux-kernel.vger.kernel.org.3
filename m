Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9D652FFD3
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 01:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347080AbiEUXg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 19:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiEUXg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 19:36:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0F34E3BC
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 16:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653176217; x=1684712217;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JWCKsa8fFcpBzEkrAi2QFhljrev4c0SjMkndIj93e/4=;
  b=dTeN13CDDg+5NDl6xLm3Wz88mNiOE4erGTT2r7yHdS6asLtHhMhUc4vF
   w5yH8zEPS8z9UQRHabLroEpJR8PjRclGSOcUEoKwjDprg1tuqjShd09cC
   wm5iXOlpOaE2UhJf5R4m/Lvk5aSONhjcJqXFoG3PHzz1Cj+UTE2WEj0Vf
   A5azaKC+RxiJnmP3XOSAff7u+mF7l99ZJjAVi7TXcZy2X9XCBVP9lfyOJ
   MC5aKhzAHFLtAItE9YItMINqC3u818oag7jHg9z8h8MgY9bdpoYdcfQdv
   UJWnc65xnPh529/4EAVw1aLRlffXheiDheFjbHzCpbO3ovmIlWXwJIhDz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10354"; a="270497739"
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="270497739"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 16:36:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="525247316"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 21 May 2022 16:36:55 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsYeU-0006iK-Ku;
        Sat, 21 May 2022 23:36:54 +0000
Date:   Sun, 22 May 2022 07:36:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [congwang:sch_bpf 2/3] filter.c:undefined reference to
 `bpf_skb_map_push_proto'
Message-ID: <202205220725.7XenbmeH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/congwang/linux.git sch_bpf
head:   9f6c12a2c218c56af7d37feeaf21c5b62a8192a0
commit: 87b07af86004ccc8db9ee11e670f947e4178cd89 [2/3] net_sched: introduce eBPF based Qdisc
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220522/202205220725.7XenbmeH-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/congwang/linux/commit/87b07af86004ccc8db9ee11e670f947e4178cd89
        git remote add congwang https://github.com/congwang/linux.git
        git fetch --no-tags congwang sch_bpf
        git checkout 87b07af86004ccc8db9ee11e670f947e4178cd89
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   /usr/bin/ld: net/core/filter.o: in function `tc_qdisc_func_proto':
>> filter.c:(.text+0x6748): undefined reference to `bpf_skb_map_push_proto'
>> /usr/bin/ld: filter.c:(.text+0x674e): undefined reference to `bpf_skb_map_pop_proto'
   collect2: error: ld returned 1 exit status

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
