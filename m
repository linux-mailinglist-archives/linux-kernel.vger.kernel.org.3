Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702F659B024
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 22:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiHTT6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 15:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiHTT6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 15:58:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CA263AD
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 12:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661025493; x=1692561493;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mEGJOnlrWM+qdJiVXY+MnU5Q5AxMrkreAQVc7ANNKic=;
  b=NO1WOkoC8Ww6B40LKZAf57BkPLiuEVO7FraZ2pRQu/ezKelrOOyKshwT
   sbbiIdzTRIqzuj9IzG2aIkzQxLJdUTr5s8DU3E6iTkkdJMhxcX+nGzcTZ
   FYztzvTP9Nk+IPe7D3zHooTm5Rjsx6WNS9SRCGYXwsRFk2JbcBaQkbGJ/
   ua7nIBxLFcazesMO9FfZ2KW/pwcVpjcyFqsg5N/bKwR0q9VT+7SBDPmIM
   aum4imV0dzASykj97zdkc0VrQJ5iVsHM4OFSzBjgQTyVolWTqIultgMvL
   YPeuXwKlbVjL4Aqus8O2XkAMKJmvcbd6OTobvqn/mJIWYAGMmX+mwlJ9I
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10445"; a="280163813"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="280163813"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 12:58:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="668999286"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 20 Aug 2022 12:58:12 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPUbj-000387-1a;
        Sat, 20 Aug 2022 19:58:11 +0000
Date:   Sun, 21 Aug 2022 03:57:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: kernel/trace/rv/monitors/wip/wip.c:20:1: sparse: sparse: symbol
 'da_mon_wip' was not declared. Should it be static?
Message-ID: <202208210332.gtHXje45-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   50cd95ac46548429e5bba7ca75cc97d11a697947
commit: 10bde81c74863472047f31304064018c40f488ee rv/monitor: Add the wip monitor
date:   3 weeks ago
config: arm64-randconfig-s032-20220820 (https://download.01.org/0day-ci/archive/20220821/202208210332.gtHXje45-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=10bde81c74863472047f31304064018c40f488ee
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 10bde81c74863472047f31304064018c40f488ee
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash kernel/trace/rv/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   kernel/trace/rv/monitors/wip/wip.c: note: in included file:
   kernel/trace/rv/monitors/wip/wip.h:30:22: sparse: sparse: symbol 'automaton_wip' was not declared. Should it be static?

vim +/da_mon_wip +20 kernel/trace/rv/monitors/wip/wip.c

8812d21219b9c6 Daniel Bristot de Oliveira 2022-07-29  18  
8812d21219b9c6 Daniel Bristot de Oliveira 2022-07-29  19  struct rv_monitor rv_wip;
8812d21219b9c6 Daniel Bristot de Oliveira 2022-07-29 @20  DECLARE_DA_MON_PER_CPU(wip, unsigned char);
8812d21219b9c6 Daniel Bristot de Oliveira 2022-07-29  21  

:::::: The code at line 20 was first introduced by commit
:::::: 8812d21219b9c649dd25eb93915e00939944aeb7 rv/monitor: Add the wip monitor skeleton created by dot2k

:::::: TO: Daniel Bristot de Oliveira <bristot@kernel.org>
:::::: CC: Steven Rostedt (Google) <rostedt@goodmis.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
