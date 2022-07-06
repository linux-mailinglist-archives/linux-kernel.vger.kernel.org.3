Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431DA567B19
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 02:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiGFAYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 20:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiGFAYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 20:24:05 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D32DFE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 17:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657067045; x=1688603045;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=M0xhOJPVCeN91aku9bU9ecvcw/a4Vgk7oNkQ12/Y7SA=;
  b=aTqWBWsP1zwjaRmVAcbvIL3m9uCfYYnljkCzlRCh6UeA364JzT0MMy3s
   0+ig+S1cstkJB8iGfa6WitvTjpEhf1VfphpOSKUz7P0BAeEt2MvshAZ/2
   /ITqDOo93ysWvs3nUEhO8D3qXjBmyQUFQUGh4zyaQ5TUEhyGBIKSnF4J3
   tSZCagNhfMgDW6qoGkQycMT7mUOEBJg0tmBCryGrG3Z301e7BzteW2I7M
   XKqFG9jBqTOhup3tQAevHm8xLlKxSIC9ONm2ninj/vmIpAgTjn9CjhSbD
   tJsBM+fdJxe+V3URBptmq0HfS3wYF6GzNCFxVDiQwYFSNjr0v3u0fcvN4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="345277247"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="345277247"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 17:24:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="695866288"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 05 Jul 2022 17:24:02 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8spm-000Jk5-7s;
        Wed, 06 Jul 2022 00:24:02 +0000
Date:   Wed, 6 Jul 2022 08:23:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tramp_22 7/21] kernel/trace/ftrace_test.c:7:6:
 warning: no previous prototype for 'ftrace_test_0'
Message-ID: <202207060857.oxde1BCA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tramp_22
head:   1d891c46bb689a24985cea58f4eddb053d6b1331
commit: d2304746483fe3d68537522df1f8e63993bdd732 [7/21] ftrace: Add test functions
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220706/202207060857.oxde1BCA-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=d2304746483fe3d68537522df1f8e63993bdd732
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tramp_22
        git checkout d2304746483fe3d68537522df1f8e63993bdd732
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/trace/ftrace_test.c:7:6: warning: no previous prototype for 'ftrace_test_0' [-Wmissing-prototypes]
       7 | FUNC(ftrace_test_0)
         |      ^~~~~~~~~~~~~
   kernel/trace/ftrace_test.c:4:5: note: in definition of macro 'FUNC'
       4 | int __name(void) { return 0; }  \
         |     ^~~~~~
>> kernel/trace/ftrace_test.c:8:6: warning: no previous prototype for 'ftrace_test_1' [-Wmissing-prototypes]
       8 | FUNC(ftrace_test_1)
         |      ^~~~~~~~~~~~~
   kernel/trace/ftrace_test.c:4:5: note: in definition of macro 'FUNC'
       4 | int __name(void) { return 0; }  \
         |     ^~~~~~
>> kernel/trace/ftrace_test.c:9:6: warning: no previous prototype for 'ftrace_test_2' [-Wmissing-prototypes]
       9 | FUNC(ftrace_test_2)
         |      ^~~~~~~~~~~~~
   kernel/trace/ftrace_test.c:4:5: note: in definition of macro 'FUNC'
       4 | int __name(void) { return 0; }  \
         |     ^~~~~~
>> kernel/trace/ftrace_test.c:10:6: warning: no previous prototype for 'ftrace_test_3' [-Wmissing-prototypes]
      10 | FUNC(ftrace_test_3)
         |      ^~~~~~~~~~~~~
   kernel/trace/ftrace_test.c:4:5: note: in definition of macro 'FUNC'
       4 | int __name(void) { return 0; }  \
         |     ^~~~~~
>> kernel/trace/ftrace_test.c:11:6: warning: no previous prototype for 'ftrace_test_4' [-Wmissing-prototypes]
      11 | FUNC(ftrace_test_4)
         |      ^~~~~~~~~~~~~
   kernel/trace/ftrace_test.c:4:5: note: in definition of macro 'FUNC'
       4 | int __name(void) { return 0; }  \
         |     ^~~~~~
>> kernel/trace/ftrace_test.c:12:6: warning: no previous prototype for 'ftrace_test_5' [-Wmissing-prototypes]
      12 | FUNC(ftrace_test_5)
         |      ^~~~~~~~~~~~~
   kernel/trace/ftrace_test.c:4:5: note: in definition of macro 'FUNC'
       4 | int __name(void) { return 0; }  \
         |     ^~~~~~
>> kernel/trace/ftrace_test.c:13:6: warning: no previous prototype for 'ftrace_test_6' [-Wmissing-prototypes]
      13 | FUNC(ftrace_test_6)
         |      ^~~~~~~~~~~~~
   kernel/trace/ftrace_test.c:4:5: note: in definition of macro 'FUNC'
       4 | int __name(void) { return 0; }  \
         |     ^~~~~~
>> kernel/trace/ftrace_test.c:14:6: warning: no previous prototype for 'ftrace_test_7' [-Wmissing-prototypes]
      14 | FUNC(ftrace_test_7)
         |      ^~~~~~~~~~~~~
   kernel/trace/ftrace_test.c:4:5: note: in definition of macro 'FUNC'
       4 | int __name(void) { return 0; }  \
         |     ^~~~~~
>> kernel/trace/ftrace_test.c:15:6: warning: no previous prototype for 'ftrace_test_8' [-Wmissing-prototypes]
      15 | FUNC(ftrace_test_8)
         |      ^~~~~~~~~~~~~
   kernel/trace/ftrace_test.c:4:5: note: in definition of macro 'FUNC'
       4 | int __name(void) { return 0; }  \
         |     ^~~~~~
>> kernel/trace/ftrace_test.c:16:6: warning: no previous prototype for 'ftrace_test_9' [-Wmissing-prototypes]
      16 | FUNC(ftrace_test_9)
         |      ^~~~~~~~~~~~~
   kernel/trace/ftrace_test.c:4:5: note: in definition of macro 'FUNC'
       4 | int __name(void) { return 0; }  \
         |     ^~~~~~


vim +/ftrace_test_0 +7 kernel/trace/ftrace_test.c

     6	
   > 7	FUNC(ftrace_test_0)
   > 8	FUNC(ftrace_test_1)
   > 9	FUNC(ftrace_test_2)
  > 10	FUNC(ftrace_test_3)
  > 11	FUNC(ftrace_test_4)
  > 12	FUNC(ftrace_test_5)
  > 13	FUNC(ftrace_test_6)
  > 14	FUNC(ftrace_test_7)
  > 15	FUNC(ftrace_test_8)
  > 16	FUNC(ftrace_test_9)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
