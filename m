Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15891578DCE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 00:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbiGRW5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbiGRW5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:57:03 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9D2FD2C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658185022; x=1689721022;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ml1h021urNtM6ApLrsoiTrOFu2QX5pbc9JozxFSocEQ=;
  b=BebFrAov1wW/SW5FYt2BSl91LlLqgq0E/fETjr/FZQVwr6uxAGbGH9sH
   13f9ho5hp7qT5YMfV0nP0O4R8CNVZIpZ3I+R6M8lSYwaX+vHr29siCf0b
   iy5IZwukne0uyxMZIRqCnK8gT+3OeYOItQsRhpsiT65AGjdRP6nFV2ksm
   Tm1t+EkuQZBNi5+OHSeHUZD2ykcxo1b40rpBhstCpO9XOAFU2ZO12SOMu
   K+jaXAU5PBsFV4r05nC4GqvFNWmbENeZNoNVHzaFyZUt61Kt8xnUF2Tjn
   6xVwTDzvVQW4yov0/7gZp/48H84fSKKhtKpZM1UZ/5sKeYI/2uw7JtMY/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="287080605"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="287080605"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 15:57:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="572600184"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 18 Jul 2022 15:57:00 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDZfg-0004pu-12;
        Mon, 18 Jul 2022 22:57:00 +0000
Date:   Tue, 19 Jul 2022 06:56:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Subject: vmlinux.o: warning: objtool: entry_SYSCALL_compat+0x0:
 ANNOTATE_NOENDBR on ENDBR
Message-ID: <202207190623.QZI6dG5x-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   80e19f34c2887a8881084b7bb7480e9544d56b91
commit: f43b9876e857c739d407bc56df288b0ebe1a9164 x86/retbleed: Add fine grained Kconfig knobs
date:   3 weeks ago
config: x86_64-randconfig-r021-20220718 (https://download.01.org/0day-ci/archive/20220719/202207190623.QZI6dG5x-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f43b9876e857c739d407bc56df288b0ebe1a9164
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f43b9876e857c739d407bc56df288b0ebe1a9164
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: entry_SYSCALL_compat+0x0: ANNOTATE_NOENDBR on ENDBR

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
