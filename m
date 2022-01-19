Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5913049340B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 05:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239155AbiASEdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 23:33:21 -0500
Received: from mga01.intel.com ([192.55.52.88]:57540 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239102AbiASEdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 23:33:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642566800; x=1674102800;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mU9AD4yF2StIiA114LVwMmC9ZD8I31kN9olxx7jsFwY=;
  b=ZvQGi5JSP1JlY0BmPV5pLDfbJVhjJah7XrhP0VVAVRCrLGFei6FKq6Ld
   caXAFRgjyXZX+TtmcpYBn5YdNnNqFBPiKryN6jdzQcYYXC8/4cy8ULgHt
   JrS6ffJxA8LUHn68IqCdEcDVXfoQwinUWVlOZUZhC3C7y+8XOn9tARCgD
   LY/8qqnxoyDdRLDKoZgmkelsXUjx6Mf+vQXXTOJ/ckZTj+o1XhsXEkSSC
   i1SZoCY7rDPA7cKWB6GxLV6uNjqRf93nwGPlAtRT61m5HrHrOl1WYdXq2
   MlaLPOaOKKTDG/r71rWQ46IBlwf+27hwb1nuWT6jZmEBd5rD/0OHMfYn7
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="269367588"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="269367588"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 20:33:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="625747001"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 18 Jan 2022 20:33:18 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nA2es-000DFk-7Z; Wed, 19 Jan 2022 04:33:18 +0000
Date:   Wed, 19 Jan 2022 12:32:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Connor O'Brien <connoro@google.com>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Subject: [ammarfaizi2-block:google/android/kernel/common/android13-5.10
 9989/9999] main.c:118:5: warning: no previous prototype for 'eprintf'
Message-ID: <202201191239.XKS6Ud9B-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android13-5.10
head:   976a28295a01db618903406bd67cae53a4c29832
commit: 44b9bfcd4cdbc57889a0fecf79a6d30237f21bed [9989/9999] FROMGIT: tools/resolve_btfids: Build with host flags
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220119/202201191239.XKS6Ud9B-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/44b9bfcd4cdbc57889a0fecf79a6d30237f21bed
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android13-5.10
        git checkout 44b9bfcd4cdbc57889a0fecf79a6d30237f21bed
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> main.c:118:5: warning: no previous prototype for 'eprintf' [-Wmissing-prototypes]
     118 | int eprintf(int level, int var, const char *fmt, ...)
         |     ^~~~~~~
   main.c: In function 'symbols_collect':
   main.c:407:7: warning: unused variable 'err' [-Wunused-variable]
     407 |   int err = -1;
         |       ^~~
   main.c:404:9: warning: unused variable 'tmp' [-Wunused-variable]
     404 |   char *tmp, *prefix;
         |         ^~~
   main.c: In function 'eprintf':
>> main.c:128:9: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
     128 |  return ret;
         |         ^~~

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
