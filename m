Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC77569D8F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbiGGIiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbiGGIh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:37:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB57B4F188
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657183076; x=1688719076;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lE+7lVnYaOfF8hmxGHZOQGam9sWX96ea4lWMzMEYDmc=;
  b=lsQAs/ErGgRU2I5NFzac9cAhp3Hs9M/KFcP2qITYF0yvjrRGQFwlJ1iS
   Mm/1wbSXlLC+XoAeBjjzBKGpbNc0zx3ZgaM/zvXfKt7jetwBTLFTE0OFo
   H1PMmYIxE2Qo2VxEb/zZhTwtQIc+twW8DUhnKiLlMMydN1Evc7eTdxgF7
   2LMPKzbPU2yC8O5yJlVVX6vVUeI7RgbyTZnmQdmUd7DU6qRKSve+4sXod
   BvJs90vdprIKyydoRox0MZSfw1tgczVHM5ZPESpFRdjjldPW+8D7zWlsU
   CQ4mrI+ujjsnvlg/BKOegPShO0k8xX2rMbUCxamNawrHnqnIII7/fHLhS
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="272761958"
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="272761958"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 01:37:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="920509223"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 07 Jul 2022 01:37:33 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9N0u-000LlG-DC;
        Thu, 07 Jul 2022 08:37:32 +0000
Date:   Thu, 7 Jul 2022 16:37:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tramp_22 7/21] kernel/trace/ftrace_test.c:7:6:
 warning: no previous prototype for function 'ftrace_test_0'
Message-ID: <202207071637.MKFUUllN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tramp_22
head:   1d891c46bb689a24985cea58f4eddb053d6b1331
commit: d2304746483fe3d68537522df1f8e63993bdd732 [7/21] ftrace: Add test functions
config: hexagon-randconfig-r016-20220707 (https://download.01.org/0day-ci/archive/20220707/202207071637.MKFUUllN-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 66ae1d60bb278793fd651cece264699d522bab84)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=d2304746483fe3d68537522df1f8e63993bdd732
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tramp_22
        git checkout d2304746483fe3d68537522df1f8e63993bdd732
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/trace/ftrace_test.c:7:6: warning: no previous prototype for function 'ftrace_test_0' [-Wmissing-prototypes]
   FUNC(ftrace_test_0)
        ^
   kernel/trace/ftrace_test.c:7:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   FUNC(ftrace_test_0)
   ^
   static 
   kernel/trace/ftrace_test.c:3:23: note: expanded from macro 'FUNC'
   #define FUNC(__name)            \
                                   ^
>> kernel/trace/ftrace_test.c:8:6: warning: no previous prototype for function 'ftrace_test_1' [-Wmissing-prototypes]
   FUNC(ftrace_test_1)
        ^
   kernel/trace/ftrace_test.c:8:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   FUNC(ftrace_test_1)
   ^
   static 
   kernel/trace/ftrace_test.c:3:23: note: expanded from macro 'FUNC'
   #define FUNC(__name)            \
                                   ^
>> kernel/trace/ftrace_test.c:9:6: warning: no previous prototype for function 'ftrace_test_2' [-Wmissing-prototypes]
   FUNC(ftrace_test_2)
        ^
   kernel/trace/ftrace_test.c:9:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   FUNC(ftrace_test_2)
   ^
   static 
   kernel/trace/ftrace_test.c:3:23: note: expanded from macro 'FUNC'
   #define FUNC(__name)            \
                                   ^
>> kernel/trace/ftrace_test.c:10:6: warning: no previous prototype for function 'ftrace_test_3' [-Wmissing-prototypes]
   FUNC(ftrace_test_3)
        ^
   kernel/trace/ftrace_test.c:10:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   FUNC(ftrace_test_3)
   ^
   static 
   kernel/trace/ftrace_test.c:3:23: note: expanded from macro 'FUNC'
   #define FUNC(__name)            \
                                   ^
>> kernel/trace/ftrace_test.c:11:6: warning: no previous prototype for function 'ftrace_test_4' [-Wmissing-prototypes]
   FUNC(ftrace_test_4)
        ^
   kernel/trace/ftrace_test.c:11:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   FUNC(ftrace_test_4)
   ^
   static 
   kernel/trace/ftrace_test.c:3:23: note: expanded from macro 'FUNC'
   #define FUNC(__name)            \
                                   ^
>> kernel/trace/ftrace_test.c:12:6: warning: no previous prototype for function 'ftrace_test_5' [-Wmissing-prototypes]
   FUNC(ftrace_test_5)
        ^
   kernel/trace/ftrace_test.c:12:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   FUNC(ftrace_test_5)
   ^
   static 
   kernel/trace/ftrace_test.c:3:23: note: expanded from macro 'FUNC'
   #define FUNC(__name)            \
                                   ^
>> kernel/trace/ftrace_test.c:13:6: warning: no previous prototype for function 'ftrace_test_6' [-Wmissing-prototypes]
   FUNC(ftrace_test_6)
        ^
   kernel/trace/ftrace_test.c:13:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   FUNC(ftrace_test_6)
   ^
   static 
   kernel/trace/ftrace_test.c:3:23: note: expanded from macro 'FUNC'
   #define FUNC(__name)            \
                                   ^
>> kernel/trace/ftrace_test.c:14:6: warning: no previous prototype for function 'ftrace_test_7' [-Wmissing-prototypes]
   FUNC(ftrace_test_7)
        ^
   kernel/trace/ftrace_test.c:14:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   FUNC(ftrace_test_7)
   ^
   static 
   kernel/trace/ftrace_test.c:3:23: note: expanded from macro 'FUNC'
   #define FUNC(__name)            \
                                   ^
>> kernel/trace/ftrace_test.c:15:6: warning: no previous prototype for function 'ftrace_test_8' [-Wmissing-prototypes]
   FUNC(ftrace_test_8)
        ^
   kernel/trace/ftrace_test.c:15:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   FUNC(ftrace_test_8)
   ^
   static 
   kernel/trace/ftrace_test.c:3:23: note: expanded from macro 'FUNC'
   #define FUNC(__name)            \
                                   ^
>> kernel/trace/ftrace_test.c:16:6: warning: no previous prototype for function 'ftrace_test_9' [-Wmissing-prototypes]
   FUNC(ftrace_test_9)
        ^
   kernel/trace/ftrace_test.c:16:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   FUNC(ftrace_test_9)
   ^
   static 
   kernel/trace/ftrace_test.c:3:23: note: expanded from macro 'FUNC'
   #define FUNC(__name)            \
                                   ^
   10 warnings generated.


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
