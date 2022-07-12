Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101A35726D2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 21:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbiGLT5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 15:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbiGLT5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 15:57:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8731F5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 12:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657655854; x=1689191854;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=weYhL7mXGolypLI6MFAnMEdso0OSTkULOCoioOEIrmQ=;
  b=S92Kk3kn21w+SmuNNHVOY+sXi6Xl+BFdeLb/meSZ7Y0SC2teAcKUGuFi
   rXLlhEprmSTcOHaxwruoCM1avVaui1RpDSMzifUgn/5sGYPxkAlozQ+rm
   AHigcaAU/CyBPBLpCSA+nbS3W0fcxu/bLfz3QakS4JLcu6wQ93lXvLCwa
   gcNo+E6lEFR8HPL2T1ZnagtBYf9HBrfCV7s27Qbq7NOjAv5QzXL0C6oVC
   L9klsin122BC1oLVGgV2sMiqfMUEOQwAjAHtKsl/n5XX30IuA0WNFDU+N
   8tb9xcQCkPqfAQ3rpYYz4tVtuBri/eWppONh/DhuaVN/+KBoWwGhsKnv8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="349003812"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="349003812"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 12:57:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="841500824"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 12 Jul 2022 12:57:31 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBM0h-0002dx-9l;
        Tue, 12 Jul 2022 19:57:31 +0000
Date:   Wed, 13 Jul 2022 03:57:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Ben Hutchings <bwh@kernel.org>
Subject: [linux-stable-rc:linux-5.10.y 7079/7120] /tmp/cc8UozNw.s:21:
 Warning: .space repeat count is zero, ignored
Message-ID: <202207130324.hVWIQn1H-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
head:   ba398a0e54049bb6a1c102245ae84103f103ff2c
commit: 98283b6c9a65841c1b572861b81ef04f33121454 [7079/7120] x86/kvm: Fix SETcc emulation for return thunks
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220713/202207130324.hVWIQn1H-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=98283b6c9a65841c1b572861b81ef04f33121454
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.10.y
        git checkout 98283b6c9a65841c1b572861b81ef04f33121454
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   /tmp/cc8UozNw.s: Assembler messages:
>> /tmp/cc8UozNw.s:21: Warning: .space repeat count is zero, ignored
   /tmp/cc8UozNw.s:28: Warning: .space repeat count is zero, ignored
   /tmp/cc8UozNw.s:35: Warning: .space repeat count is zero, ignored
   /tmp/cc8UozNw.s:42: Warning: .space repeat count is zero, ignored
   /tmp/cc8UozNw.s:49: Warning: .space repeat count is zero, ignored
   /tmp/cc8UozNw.s:56: Warning: .space repeat count is zero, ignored
   /tmp/cc8UozNw.s:63: Warning: .space repeat count is zero, ignored
   /tmp/cc8UozNw.s:70: Warning: .space repeat count is zero, ignored
   /tmp/cc8UozNw.s:77: Warning: .space repeat count is zero, ignored
   /tmp/cc8UozNw.s:84: Warning: .space repeat count is zero, ignored
   /tmp/cc8UozNw.s:91: Warning: .space repeat count is zero, ignored
   /tmp/cc8UozNw.s:98: Warning: .space repeat count is zero, ignored
   /tmp/cc8UozNw.s:105: Warning: .space repeat count is zero, ignored
   /tmp/cc8UozNw.s:112: Warning: .space repeat count is zero, ignored
   /tmp/cc8UozNw.s:119: Warning: .space repeat count is zero, ignored
   /tmp/cc8UozNw.s:126: Warning: .space repeat count is zero, ignored

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
